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
//  КЛАС ПРИЗНАЧЕНИЙ ДЛЯ ВАГ METLER Tiger D
//-------------------------------------------------------------------------------

//Transfer_Ethernet("Transscale.ini")

typedef int WINAPI (*Tfunc_Transfer_Ethernet)(char *);

Tfunc_Transfer_Ethernet		Transfer_Ethernet;

XLibraTigerD::XLibraTigerD(const char *iprog_way, XLibraCallBack icall_finc, const XLibraConnectionString *iconnection_strings) : XLibra(LIBRA_LT_MASSA_K_VPM, icall_finc, iconnection_strings)
{
	char *way_format = "%sscale\\tiger\\D\\%s";

	sprintf(dll_dir, way_format, iprog_way, "");
	dll_dir[strlen(dll_dir) - 1] = '\0';
	GetCurrentDirectory(512, back_dir);
	SetCurrentDirectory(dll_dir);

	sprintf(dll_way, way_format, iprog_way, "TransferEth.dll");
	sprintf(SCALEADDRESS_way, "%s%s", iprog_way, "SCALEADDRESS.INI");
	sprintf(transscale_way, "%s%s", iprog_way, "Transscale.ini");
	sprintf(plu_txt_way, "%s%s", iprog_way, "plu.txt");



	char buf[256];
	sprintf(buf, "== Вага: METLER Tiger D #%d ==", ((XEithernetConnection *)connection_descriptor)->number);
	SaveToLog(buf);

	code_page = 2;
	std::sprintf(log_name, way_format, iprog_way, "XLibraTigerD.log");
}

XLibraTigerD::~XLibraTigerD()
{

}

//-------------------------------------------------------------------------------
int XLibraTigerD::Connect()
{
	FILE* fp = fopen(SCALEADDRESS_way, "w");
	if(fp != NULL)
	{
		fputs("[CONFIG]\n", fp);
		fputs("MEDIA=1\n", fp);
		fputs("COMPORT=1\n", fp);
		fprintf(fp, "[%d]\n", ((XEithernetConnection *)connection_descriptor)->number);
		fputs("NAME=\n", fp);
		fprintf(fp, "IP=%s\n", ((XEithernetConnection *)connection_descriptor)->ip);
		fprintf(fp, "PORT=%d\n", ((XEithernetConnection *)connection_descriptor)->port);
	}
	fclose(fp);

	//
	fp = fopen(transscale_way, "w");
	if(fp != NULL)
		fprintf(fp, "%d:%s\n", ((XEithernetConnection *)connection_descriptor)->number,
				plu_txt_way);
	fclose(fp);

	fp = fopen(plu_txt_way, "w");
	fclose(fp);


	return 0;
}

int XLibraTigerD::Disconnect()
{
    SetCurrentDirectory(back_dir);
	FreeLibrary(h_dll);
	return 0;
}

//-------------------------------------------------------------------------------
// Аналіз результату останньої команди,
// виведення повідомлення, якщо була помилка.
XLibraResult* XLibraTigerD::GetResult()
{
	return &result;
}

// Очiкування вiдповiдi вiд ваги
int XLibraTigerD::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;
	return ret.error;
}

int XLibraTigerD::ProgrammingTovar(XLibraTovar tovar)
{
	unsigned short nomen_num = tovar.nomen_num -
		((XEithernetConnection *)connection_descriptor)->prefix * 10000;
	int nomen_num_int = nomen_num;

	if (nomen_num > 9999)
	{
		sprintf(result.text, "Для %d код товару %d перевищує 9999", tovar.nomen_num, nomen_num);
        SaveToLog(result.text);
		result.critical = 0;
		return LIBRA_ERROR_PARAM;
	}

	FILE* fp = fopen(plu_txt_way, "a");
	if(fp != NULL)
	{
		char buf[1024];
		fputs(IntToSpaseStr(nomen_num, buf, 6), fp); //PLU #
		fputc(',', fp);
		fputs(IntToSpaseStr(tovar.nomen_num, buf, 13), fp);   //Артикул
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 2), fp);   //Група
		fputc(',', fp);
		fputs(DoubleToSpaseStr(tovar.price, buf, 8), fp);  //Ціна
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 2), fp);     //Tapa
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 3), fp);     //№ додаткового тексту
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 1), fp);     //PDV
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 3), fp);     //Зміщення дати
		fputc(',', fp);
		fputs(IntToSpaseStr(tovar.termin, buf, 3), fp);  //Зміщення строку придатності
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 8), fp);   //Фіксована вага
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 1), fp);   //Тип PLU (By Weight / By Count)
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 1), fp);   //Вільна ціна (No / Yes)
		fputc(',', fp);
		fputs(IntToSpaseStr(0, buf, 1), fp);   //Скидка (No / Yes)
		fputc(',', fp);
		char name_buf[512];
		ConvertText(name_buf, tovar.name, 40);
		fputs(StrToSpaseStr(name_buf, buf, 30), fp);   //Назва PLU1
		if (((XEithernetConnection *)connection_descriptor)->mod == 1)
			fputc(',', fp);    //Назва PLU2
		fputc('\n', fp);
	}
	fclose(fp);
	return 0;
}

int XLibraTigerD::ProgrammingAllTovar()
{
	XLibra::ProgrammingAllTovar();

	h_dll = LoadLibrary("TransferEth.dll");

	Transfer_Ethernet = NULL;
	Transfer_Ethernet = (Tfunc_Transfer_Ethernet)GetProcAddress(h_dll, "Transfer_Ethernet");
	Transfer_Ethernet("Transscale.ini");

	return 0;
}

int XLibraTigerD::ClearTovar(int nomen_num)
{
	return 0;
}

int XLibraTigerD::SWAdaptor()
{
    return 0;
}

