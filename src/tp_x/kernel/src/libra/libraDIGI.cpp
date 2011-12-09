#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <math.h>
#include <io.h>
#include <sys\stat.h>

#include <iostream>
#include <windows.h>
#include <windowsx.h>

#include <vector.h>
#include <Dialogs.hpp>

#include "libra.h"

//-------------------------------------------------------------------------------
//  КЛАС ПРИЗНАЧЕНИЙ ДЛЯ ВАГ DIGI SM
//-------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////
enum XOperation {	UPLOAD, DOWNLOAD, ERASEPLULIST, ERASEOBJECT	};
enum XOperationResult
		{	NON_ERROR, OPEN_FILE_ERR, READ_FILE_ERR, WRITE_FILE_ERR,
			NETWORK_OPEN_ERR, NETWORK_READ_ERROR, NETWORK_WRITE_ERR,
			MACHINE_READ_ERR, MACHINE_WRITE_ERR, MACHINE_NOREC_ERR,
			MACHINE_SPASE_ERR, MACHINE_UNDEF_ERR	};

//: ;  execute(XOperation, AScaleIP: PChar; AFileName: PChar; ACommand: BYTE);

typedef XOperationResult WINAPI (*Tfunc_DIGIExecute)(XOperation oper, char *ip, char *fname, BYTE com);

Tfunc_DIGIExecute		DIGIExecute;

XLibraDIGI_SM::XLibraDIGI_SM(const char *iprog_way,
			 XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings) :
						XLibra(LIBRA_LT_DIGI_SM, icall_finc, iconnection_strings)
{
	char buf[256];
	sprintf(buf, "== Вага: DIGI SM #%s ==", ((XEithernetConnection *)connection_descriptor)->ip);
	SaveToLog(buf);
 
	char *way_format = "%sscale\\digi\\sm\\%s";
	sprintf(dll_way, way_format, iprog_way, "digiTCPdrv.dll");
	sprintf(tovar_name, way_format, iprog_way, "tovar.dat");
	sprintf(label_name, way_format, iprog_way, "label.dat");

	code_page = 0;
	std::sprintf(log_name, way_format, iprog_way, "XLibraDIGI_SM.log");
}

XLibraDIGI_SM::~XLibraDIGI_SM()
{
	Disconnect();
}

//-------------------------------------------------------------------------------
int XLibraDIGI_SM::Connect()
{
	return 0;
}

int XLibraDIGI_SM::Disconnect()
{
    FreeLibrary(h_dll);
	return 0;
}

//-------------------------------------------------------------------------------
// Аналіз результату останньої команди,
// виведення повідомлення, якщо була помилка.
XLibraResult* XLibraDIGI_SM::GetResult()
{
	return &result;
}

// Очiкування вiдповiдi вiд ваги
int XLibraDIGI_SM::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;

    return ret.error;
}

struct
{
	BYTE nPLU[2*4];      // BCD
	BYTE nSize[2*2];     //  HEX
	BYTE nStatus1[2*2];     // BIN  PLU Статус 1 (2) 54 00
	BYTE nStatus2[2*3];     // BIN  PLU Статус 2 (3) 0D 26 01

	BYTE nPrice100[2*4];		// BCD Ціна в копійках
	BYTE nFet1[2*1];     // HEX № формату 1-ї етикетки  11
	//BYTE nFet2[2*1];	// HEX № формату 2-ї етикетки
	BYTE nFbCode[2*1];  // HEX № формату штрихкоду 09
	BYTE nBCode[2*7];	// BCD Дані штрихкоду  22|28 + IntToBCD(nomen_No, 2) + '00000000'
	//BYTE nGrpNum[2*2];	// BCD Номер основної групи
	BYTE nTerminDSell[2*2];	// BCD 0+Строк продажу в днях
	//BYTE nTerminTSell[2*2];	// BCD Строк продажу в год/хв (0000)
	//BYTE nTerminDUse[2*2];	// BCD 0+Строк використання в днях
	//BYTE nTerminDPack[2*2];	// BCD 0+Строк пакування в днях
	//BYTE nTerminTPack[2*2];	// BCD Строк пакування в год/хв (0000)
	//BYTE nInPrice100[2*4];		// BCD Собівартість в копійках
	//BYTE nMassaTara[2*2];	// BCD Вага тари		2		BCD
	//BYTE nKilkInPack[2*2];	// BCD К-ть в одній упаковці		2		BCD
	//BYTE nKilkType[2*1];	// BCD Тип символу к-ті    00
	BYTE nMsgNum[2*1];	// BCD Номер спец. повідомлення  01
	BYTE nIngradientNum[2*1];	// BCD Номер інградієнту 01
	//BYTE nTerminTPack[1];	// HEX Номер місця зберігання		1
	//BYTE nTerminTPack[10*2*2];	// BCD  Номер 1-ти картинок		1		BCD
	//BYTE nNumVAT[2*1];	// BCD  Номер податку		1		BCD

   //	BYTE nDiscount[2*30];		// BCD	Знижка (Структура даних)  нулями забити
   /*
	Пустое поле		1
	Процент тары		2
	Скидка покупателя		4
	Ресторанная цена		4
	Скидка персонала		4
	Название товара		1 - 412		ASCII
	Текст встроенного в PLU ингредиента		1 - 1545		ASCII
	Текст встроенного в PLU спец. сообщения		1 - 824		ASCII
	Контрольный разряд		1		HEX		2 цифры
	*/
	BYTE nName[512]; // Назва товару + контрольна сума 00
} _recPLU;

void XLibraDIGI_SM::StrFormat(BYTE *buf, char *name)
{
	BYTE *inp_buf[256];
	BYTE *lp_name = name;
	BYTE *lp_buf = buf;

	int len = strlen(name);
	int len0 = min(len, 20);
	int len1 = max(len - len0, 0);
	BYTE *font_sz;
	if (len1 > 0)
		font_sz = "04";
	else
		font_sz = "08";
	sprintf(lp_buf, "%s%02X", font_sz, len0);
	lp_buf += 4;
	while (*lp_name)
	{
		if ((lp_name - name) == 20)
		{
			sprintf(lp_buf, "0D%s%02X", font_sz, len1);
			lp_buf += 6;
		}
		BYTE chr = *lp_name; //ConvertChar();
		sprintf(lp_buf, "%02X", chr);
		lp_buf += 2;
		++lp_name;
	}
	sprintf(lp_buf, "0C00");
	lp_buf += 4;
	*lp_buf = '\0';
}

int XLibraDIGI_SM::ProgrammingTovar(XLibraTovar tovar)
{
	long nomen_num = tovar.nomen_num -
		((XEithernetConnection *)connection_descriptor)->prefix * 10000;
	long nomen_num_int = nomen_num;

	if (nomen_num > 9999)
	{
		sprintf(result.text, "Для %d код товару %d перевищує 9999", tovar.nomen_num, nomen_num);
		SaveToLog(result.text);
		result.critical = 0;
		return LIBRA_ERROR_PARAM;
	}

	++tovar_pos;

	BYTE buf[1024];
	int len(0);
	sprintf(buf, "%08d", nomen_num);
	memcpy(_recPLU.nPLU, buf, 8);   len+=8;

	//BYTE nSize[2];     //  HEX      len+=2;

	memcpy(_recPLU.nStatus1, "5400", 4);  len+=4;
	memcpy(_recPLU.nStatus2, "0D2601", 6);    len+=6;
	long price = Around_0(tovar.price * 100.0);
	sprintf(buf, "%08d", price);
	memcpy(_recPLU.nPrice100, buf, 8);	len+=8;	// 4 Ціна в копійках
	memcpy(_recPLU.nFet1, "11", 2); len+=2; // HEX № формату 1-ї етикетки  11
	memcpy(_recPLU.nFbCode, "09", 2); len+=2; // HEX № формату штрихкоду 09
	sprintf(buf, "%02d%04d00000000", ((XEithernetConnection *)connection_descriptor)->prefix,
						   nomen_num);
	memcpy(_recPLU.nBCode, buf, 14); len+=14; // BCD Дані штрихкоду  22|28 + IntToBCD(nomen_No, 2) + '00000000'
	sprintf(buf, "%04d", tovar.termin);
	memcpy(_recPLU.nTerminDSell, buf, 4);  len+=4; // BCD 0+Строк продажу в днях
	memcpy(_recPLU.nMsgNum, "01", 2);  len+=2; // BCD Номер спец. повідомлення  01
	memcpy(_recPLU.nIngradientNum, "01", 2);  len+=2; // BCD Номер інградієнту 01
	StrFormat(_recPLU.nName, tovar.name);
	int len_name = strlen(_recPLU.nName);
	len+=len_name + 4;

	sprintf(buf, "%04X", (int)(len)/2);
	memcpy(_recPLU.nSize, buf, 4);

	FILE* fp = fopen(tovar_name, "ab");
	fwrite((char*)&_recPLU, len, 1, fp);
	fclose(fp);

	return 0;
}

int XLibraDIGI_SM::ClearTovar(int nomen_num)
{
	return 0;
}

int XLibraDIGI_SM::SWAdaptor()
{
	return 0;
}

int XLibraDIGI_SM::ProgrammingAllTovar()
{
	FILE* fp = fopen(tovar_name, "wb");
	fclose(fp);
	tovar_pos = 0;

	XLibra::ProgrammingAllTovar();

	h_dll = LoadLibrary(dll_way);

	DIGIExecute = NULL;
	DIGIExecute = (Tfunc_DIGIExecute)GetProcAddress(h_dll, "Execute");

	DIGIExecute(ERASEOBJECT, (char *)((XEithernetConnection *)connection_descriptor)->ip,
			"", 0x88);
	Sleep(3000);
	DIGIExecute(UPLOAD, (char *)((XEithernetConnection *)connection_descriptor)->ip,
			label_name, 0x34);
	XOperationResult n_ret =
		 DIGIExecute(UPLOAD, (char *)((XEithernetConnection *)connection_descriptor)->ip,
			tovar_name, 37);

	if (n_ret == NON_ERROR)
	{
		SaveToLog("Передача файлу пройшла успішно");
		return 0;
	}

	switch (n_ret)
	{
		case OPEN_FILE_ERR:
		  SaveToLog("ПОМИЛКА відкриття файлу (OPEN_LILE_ERR)");
		 break;
		case READ_FILE_ERR:
		  SaveToLog("ПОМИЛКА читання файлу (READ_FILE_ERR)");
		 break;
		case WRITE_FILE_ERR:
		  SaveToLog("ПОМИЛКА запису в файл (WRITE_FILE_ERR)");
		 break;
		case NETWORK_OPEN_ERR:
		  SaveToLog("ПОМИЛКА з'єднання з вагою (NETWORK_OPEN_ERR)");
		 break;
		case NETWORK_READ_ERROR:
		  SaveToLog("ПОМИЛКА прийняття даних з ваги (NETWORK_READ_ERROR)");
		 break;
		case NETWORK_WRITE_ERR:
		  SaveToLog("ПОМИЛКА посилання даних на вагу (NETWORK_WRITE_ERR)");
		 break;
		case MACHINE_READ_ERR:
		  SaveToLog("ПОМИЛКА: Вага вернула код помилки читання (MACHINE_READ_ERR)");
		 break;
		case MACHINE_WRITE_ERR:
		  SaveToLog("ПОМИЛКА: Вага вернула код помилки запису (MACHINE_WRITE_ERR)");
		 break;
		case MACHINE_NOREC_ERR:
		  SaveToLog("ПОМИЛКА: Вага вернула код помилки 'Немає запису' (MACHINE_NOREC_ERR)");
		 break;
		case MACHINE_SPASE_ERR:
		  SaveToLog("ПОМИЛКА: Вага вернула код помилки 'Немає вільного місця' (MACHINE_SPASE_ERR)");
		 break;
		case MACHINE_UNDEF_ERR:
		  SaveToLog("ПОМИЛКА: Вага вернула код невідомої помилки (MACHINE_UNDEF_ERR)");
		 break;
		default:
			SaveToLog("ПОМИЛКА: Невідомий результат виконання процедури");
	};
	return -1;
}


