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
//  КЛАС ПРИЗНАЧЕНИЙ ДЛЯ ВАГ МАССА-К (ВП)
//-------------------------------------------------------------------------------
XLibraMassaK_VP::XLibraMassaK_VP(XLibraCallBack icall_finc, const XLibraConnectionString *iconnection_strings) : XLibra(LIBRA_LT_MASSA_K_VP, icall_finc, iconnection_strings)
{
	char buf[256];
	sprintf(buf, "== Вага: МАССА-К (ВП) #%d ==", ((XCOMConnection *)connection_descriptor)->number);
	SaveToLog(buf);
	code_page = 2;
	std::strcpy(log_name, "XLibraMassaK_VP.log");
}

XLibraMassaK_VP::~XLibraMassaK_VP()
{
}

//-------------------------------------------------------------------------------
int XLibraMassaK_VP::Connect()
{
	XLibra::Connect();

	DCB options;
	COMMTIMEOUTS timeouts;

	timeouts.ReadIntervalTimeout=0;
	timeouts.ReadTotalTimeoutMultiplier=0;
	timeouts.ReadTotalTimeoutConstant=2000;
	timeouts.WriteTotalTimeoutMultiplier=0;
	timeouts.WriteTotalTimeoutConstant=0;

	GetCommState(fd, &old_options);
	options = old_options;
	options.BaudRate = PORT_SPEED_9600;
	options.ByteSize = 8;
	options.Parity = MARKPARITY;
	options.StopBits = ONESTOPBIT;
	SetCommState(fd, &options);
	int err = SetCommTimeouts(fd, &timeouts);
	if (err < 0)
		return -1;
	PurgeComm(fd, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR);

	Sleep(1);

	return 0;
}

int XLibraMassaK_VP::Disconnect()
{
	XLibra::Disconnect();
    return 0;
}

//-------------------------------------------------------------------------------
// Аналіз результату останньої команди,
// виведення повідомлення, якщо була помилка.
XLibraResult* XLibraMassaK_VP::GetResult()
{
    result.critical = 0;
    result.error = ret.error;
    *result.text = '\0';

	if (result.error & LIBRA_ERROR_TIMEOUT)
    {
		strcat(result.text, "Таймаут пристрою. Можливо вага не підключена.");
		result.critical = 2;
	}
	else if (result.error & LIBRA_ERROR_PROT)
	{
		strcat(result.text, "Помилка протоколу");
		result.critical = 2;
    }

    if ((result.critical >= critical_level) && (*result.text != '\0'))
	{
		SaveToLog(result.text);
	}
    return &result;
}

// Очiкування вiдповiдi вiд ваги
int XLibraMassaK_VP::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;
 try
 {
	unsigned char ch(0);
	if (Read(&ch, 1) != 1)
		throw LIBRA_ERROR_TIMEOUT;

	switch (ch)
	{
		case 0x00:  // error
			throw LIBRA_ERROR_PROT;
		 break;
	}
 }
 catch ( XError error )
 {
	ret.error = error;
 }
    return ret.error;
}

void XLibraMassaK_VP::set9bit(bool bit)
{
	DCB options;

	GetCommState(fd, &options);
	options.Parity = (bit) ?  MARKPARITY : SPACEPARITY;
	SetCommState(fd, &options);
}

int XLibraMassaK_VP::SendLibraNum()
{
	unsigned char num = ((XCOMConnection *)connection_descriptor)->number;
	set9bit(true);
	Write(&num, 1);

    return 0;
}

int XLibraMassaK_VP::ProgrammingTovar(XLibraTovar tovar)
{
	unsigned short nomen_num = tovar.nomen_num -
		((XCOMConnection *)connection_descriptor)->number * 10000;
	int nomen_num_int = nomen_num;

	if (nomen_num > 999)
	{
		sprintf(result.text, "Для %d код товару %d перевищує 999", tovar.nomen_num, nomen_num);
        SaveToLog(result.text);
		result.critical = 0;
		return LIBRA_ERROR_PARAM;
	}

	SendLibraNum();
	if (Listen() != LIBRA_ERROR_CLEAR) return ret.error;

	unsigned char ch;
	set9bit(false);
	ch = 0x05;
	Write(&ch, 1);
	if (Listen() != LIBRA_ERROR_CLEAR) return ret.error;

	Write(&nomen_num, 2);
	ch = 0x00;
	Write(&ch, 1);
	if (Listen() != LIBRA_ERROR_CLEAR) return ret.error;

	unsigned char buf[128];
	unsigned char *lp_cmd = buf;
	memset(lp_cmd, 0x00, 128);
	++lp_cmd;
	memcpy(lp_cmd, &(nomen_num_int), 3);
	lp_cmd = lp_cmd + 3;
	int price_i = Around_0(tovar.price * 100);
	memcpy(lp_cmd, &(price_i), 3);
	lp_cmd = lp_cmd + 5;

	unsigned char y, m, d;
	char date_buf[16];
	strncpy(date_buf, tovar.date, 16);
	date_buf[2] = '\0';		date_buf[5] = '\0';
	d = atoi(date_buf);
	m = atoi(date_buf + 3);
	y = atoi(date_buf + 8);
	*lp_cmd = y;
	*(lp_cmd + 1) = m;
	*(lp_cmd + 2) = d;
	lp_cmd = lp_cmd + 3;
   //	strncpy(lp_cmd, tovar.name, 40);
	ConvertText(lp_cmd, tovar.name, 40);

	Write(buf, 60);
	if (Listen() != LIBRA_ERROR_CLEAR) return ret.error;

	return 0;
}

int XLibraMassaK_VP::ClearTovar(int nomen_num)
{
	return 0;
}

int XLibraMassaK_VP::SWAdaptor()
{
    return 0;
}

//-------------------------------------------------------------------------------
//  КЛАС ПРИЗНАЧЕНИЙ ДЛЯ ВАГ МАССА-К (ВПМ)
//-------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////
//Произвольные WM_USER+<n> константы, передаются в DLL параметрами
#define WM_WIP_FOUND         WM_USER+1 //используется в Wip_Search
#define WM_WIP_CONNECTED     WM_USER+2 //используется в Wip_Connect
#define WM_WIP_DISCONNECTED  WM_USER+3 //используется в Wip_Disconnect
#define WM_WIP_GETSTATUS     WM_USER+4 //используется в Wip_GetStatus
#define WM_WIP_RESETFILES    WM_USER+5 //используется в Wip_ResetFiles
#define WM_WIP_SENDFILE      WM_USER+6 //используется в Wip_SendFile
#define WM_WIP_GETFILE       WM_USER+7 //используется в Wip_GetFile
#define WM_WIP_ENUMCREATED   WM_USER+8 //используется в Wip_EnumCreated

//типы файлов ВИП
//[1] - PLU (товары);[2] - Форматы;[3] - Штрихкоды;[4] - Логотипы;[5] - Тексты;[6] - Функций клавиатуры;
#define WIP_FILETYPE_PLU      1
#define WIP_FILETYPE_FORMAT   2
#define WIP_FILETYPE_BARCODE  3
#define WIP_FILETYPE_LOGO     4
#define WIP_FILETYPE_TEXT     5
#define WIP_FILETYPE_KBD      6
#define WIP_FILETYPE_REPORT   7 //только чтение

//errors
#define WIP_NO_ERROR 0
#define ERROR_INVALID_ARG	-1
#define ERROR_OPEN_PORT		-2
#define ERROR_WIP_NOT_CONNECTED -3
#define ERROR_READ_WRITE -4
#define ERROR_OPEN_FILE -5
#define ERROR_FILE_FORMAT -6
#define ERROR_FILE_DENIED -7

//расширенные коды ошибок
#define ERROR_UDP_OPEN_INTERFACE -21
#define ERROR_UDP_NO_ANSWER	-22
#define ERROR_TCP_CANT_CONNECT -31
#define ERROR_TCP_NETWORK_AFTER_CONNECT -32

#define REPORT_CODE_NOMORE	0
#define REPORT_CODE_OK		1
struct _tag_WipDevice
{
	LPCSTR lpszAddress;
	WORD nWeightType; //TYPE_001 = 0x0001
	BYTE pSerialNum[20];
	DWORD nMaskFile;
};

struct _tag_Wip_FileReport
{
	int nReportCode; //+error codes
	LPCSTR lpszFilename;
	BYTE nFileType;
	WORD nTotalCount;
	WORD nCurrentNum;
};


typedef HANDLE WINAPI (*Tfunc_Wip_CreateDevice)();
typedef void WINAPI (*Tfunc_Wip_DestroyDevice)(HANDLE hWipDevice);

typedef int WINAPI 	(*Tfunc_Wip_Connect)(HANDLE hWipDevice, HWND hReportWnd, DWORD nReportMsg);
typedef int WINAPI 	(*Tfunc_Wip_Disconnect)(HANDLE hWipDevice, HWND hReportWnd, DWORD nReportMsg);
typedef BYTE WINAPI (*Tfunc_Wip_IsConnected)(HANDLE hWipDevice);
typedef BYTE WINAPI (*Tfunc_Wip_IsBusy)(HANDLE hWipDevice);
typedef void WINAPI (*Tfunc_Wip_DestroyDevice)(HANDLE hWipDevice);
typedef int WINAPI 	(*Tfunc_Wip_Setup)(HANDLE hWipDevice, LPCSTR lpszConnectionType,
						LPCSTR lpszConnectionSettings);
typedef int WINAPI 	(*Tfunc_Wip_SendPLU)(HANDLE hWipDevice, const char *pPLUData, DWORD nSize);
typedef int WINAPI  (*Tfunc_Wip_SendFile)(HANDLE hWipDevice, LPCSTR lpszFilename, BYTE nFileType,
						HWND hReportWnd, DWORD nReportMsg);
typedef int WINAPI 	(*Tfunc_Wip_GetFile)(HANDLE hWipDevice, LPCSTR lpszFilename, BYTE nFileType,
						HWND hReportWnd, DWORD nReportMsg);
typedef int WINAPI 	(*Tfunc_Wip_GetStatus)(HANDLE hWipDevice, HWND hReportWnd, DWORD nReportMsg);


Tfunc_Wip_CreateDevice		Wip_CreateDevice;
Tfunc_Wip_DestroyDevice		Wip_DestroyDevice;
Tfunc_Wip_Setup			 	Wip_Setup;
Tfunc_Wip_Connect			Wip_Connect;
Tfunc_Wip_Disconnect		Wip_Disconnect;
Tfunc_Wip_SendPLU           Wip_SendPLU;
Tfunc_Wip_SendFile          Wip_SendFile;
Tfunc_Wip_GetFile           Wip_GetFile;
Tfunc_Wip_GetStatus			Wip_GetStatus;

XLibraMassaK_VPM::XLibraMassaK_VPM(HANDLE im_hWnd, const char *iprog_way,
			 XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings) :
						XLibra(LIBRA_LT_MASSA_K_VPM, icall_finc, iconnection_strings)
{
	m_hWnd = im_hWnd;

	char buf[256];
	sprintf(buf, "== Вага: МАССА-К (ВПМ) #%s ==", ((XEithernetConnection *)connection_descriptor)->ip);
	SaveToLog(buf);
 
	char *way_format = "%sscale\\massa_k\\vpm\\%s";
   //	sprintf(prog_way, way_format, iprog_way, "wip.dll");
	sprintf(prog_way, way_format, iprog_way, "massa_k_vpm.exe");
  	sprintf(tovar_name, way_format, iprog_way, "tovar.dat");
 /*	SaveToLog("Підключення драйверу ваги:");
	SaveToLog(prog_way);
	h_dll = LoadLibrary(prog_way);

	Wip_CreateDevice = (Tfunc_Wip_CreateDevice)GetProcAddress(h_dll, "Wip_CreateDevice");
	Wip_DestroyDevice = (Tfunc_Wip_DestroyDevice)GetProcAddress(h_dll, "Wip_DestroyDevice");
	Wip_Setup = (Tfunc_Wip_Setup)GetProcAddress(h_dll, "Wip_Setup");
	Wip_Connect = (Tfunc_Wip_Connect)GetProcAddress(h_dll, "Wip_Connect");
	Wip_Disconnect = (Tfunc_Wip_Disconnect)GetProcAddress(h_dll, "Wip_Disconnect");
	Wip_SendPLU = (Tfunc_Wip_SendPLU)GetProcAddress(h_dll, "Wip_SendPLU");
	Wip_SendFile = (Tfunc_Wip_SendFile)GetProcAddress(h_dll, "Wip_SendFile");
	Wip_GetFile = (Tfunc_Wip_GetFile)GetProcAddress(h_dll, "Wip_GetFile");
	Wip_GetStatus = (Tfunc_Wip_GetStatus)GetProcAddress(h_dll, "Wip_GetStatus");

	SaveToLog("Створення пристрою");
	h_device = Wip_CreateDevice();
	if (NULL == h_device)
		return;
	*/
	code_page = 2;
	std::sprintf(log_name, way_format, iprog_way, "XLibraMassaK_VPM.log");
}

XLibraMassaK_VPM::~XLibraMassaK_VPM()
{
	Disconnect();
 //	SaveToLog("Знищення пристрою");
 //	Wip_DestroyDevice(h_device);
}

//-------------------------------------------------------------------------------
int XLibraMassaK_VPM::Connect()
{
 /*	char conn_prm[256];
	int nResult;
	sprintf(conn_prm, "CONNECT:%s:%d",
			((XEithernetConnection *)connection_descriptor)->ip,
			((XEithernetConnection *)connection_descriptor)->port);

	SaveToLog(conn_prm);
	nResult = Wip_Setup(h_device, "LAN:TCP", conn_prm);
	if (nResult == -1)
	{
		SaveToLog("Помилка: Не вірні параметри виклику Wip_Setup");
		return -1;
	}

	SaveToLog("Підключення до ваги");
	nResult = Wip_Connect(h_device, m_hWnd, WM_WIP_CONNECTED);
	if (nResult == -1)
	{
		SaveToLog("Помилка: Не вірні параметри виклику Wip_Connect");
		return -1;
	}

	Sleep(10000);
	//SaveToLog("Вдале підключення");
   */
	return 0;
}

int XLibraMassaK_VPM::Disconnect()
{
  /*	SaveToLog("Відключення ваги");
	Sleep(10000);
	Wip_Disconnect(h_device, m_hWnd, WM_USER+3);
	   */
	return 0;
}

//-------------------------------------------------------------------------------
// Аналіз результату останньої команди,
// виведення повідомлення, якщо була помилка.
XLibraResult* XLibraMassaK_VPM::GetResult()
{
	return &result;
}

// Очiкування вiдповiдi вiд ваги
int XLibraMassaK_VPM::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;

    return ret.error;
}

struct
{
	BYTE nPLU[4];    //	4
	BYTE nSize[2];    //	2
	BYTE nStatus[2];  //	2
	BYTE nFormatLabel;  	// 1
	BYTE nFormatBarcode; 	// 1
	BYTE nPrefixBarcode; 	// 1 22/28
	BYTE nPrice100[4];		// 4 Ціна в копійках
	BYTE nTara[4];   	//	4
	BYTE nCode[4];	//  4
	BYTE nDate0[6];	//	6
	BYTE nDate1[6];	//	6
	BYTE nSertCode[4];	//	4
	BYTE nMainGroup[2]; //	2
	BYTE nReserv[2];    //	2
	BYTE pData[1024];
} _recPLU;

int XLibraMassaK_VPM::ProgrammingTovar(XLibraTovar tovar)
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

	memcpy(_recPLU.nPLU, &nomen_num, 4);
	_recPLU.nStatus[0] = 0;	_recPLU.nStatus[1] = 1;
	_recPLU.nFormatLabel = 1;
	_recPLU.nFormatBarcode = 1; 	// 1
	_recPLU.nPrefixBarcode = ((XEithernetConnection *)connection_descriptor)->prefix; 	// 1 22/28
	long price = Around_0(tovar.price * 100.0);
	memcpy(_recPLU.nPrice100, &price, 4);		// 4 Ціна в копійках
	memset(_recPLU.nTara, 0, 4);
	memcpy(_recPLU.nCode, &nomen_num, 4);
	memset(_recPLU.nDate0, 0, 6); 	//	6
	long termin = tovar.termin * 1440;
	memcpy(_recPLU.nDate1, &termin, 6);	//	6
	memset(_recPLU.nSertCode, ' ', 4);	//	4
	_recPLU.nSertCode[3] = '0';
	memset(_recPLU.nMainGroup, 0, 2);
	memset(_recPLU.nReserv, 0, 2);
	_recPLU.pData[0] = 0x06;
	BYTE len = strlen(tovar.name);
	_recPLU.pData[1] = len;
	memcpy(&(_recPLU.pData[2]), tovar.name, len);
	_recPLU.pData[len + 2] = 0x0d;
	char *data_tmp = &(_recPLU.pData[len + 3]);
	data_tmp[0] = 0x00;		data_tmp[1] = 0x00;		data_tmp[2] = 0x0d;
	data_tmp = &(data_tmp[3]);
	data_tmp[0] = 0x00;		data_tmp[1] = 0x00;		data_tmp[2] = 0x0d;
	WORD struct_len = 37+len+3+3+3+1;
	memcpy(_recPLU.nSize, &struct_len, 2);
	int ll = 43+len+3+3+3;

	WORD crc = 0;
	BYTE *B = (BYTE *)&_recPLU;

	for(int i(0); i < ll; i++)
	{
		if (B[i] != 0)
			crc = crc + B[i];
	}
	BYTE bcrc = crc; //>> 8;
	data_tmp[3] = bcrc;

	FILE* fp = fopen(tovar_name, "ab");
	fwrite((char*)&_recPLU, ll+1, 1, fp);
	fclose(fp);

	return 0;
}

int XLibraMassaK_VPM::ClearTovar(int nomen_num)
{
	return 0;
}

int XLibraMassaK_VPM::SWAdaptor()
{
	return 0;
}

int XLibraMassaK_VPM::ProgrammingAllTovar()
{
	FILE* fp = fopen(tovar_name, "wb");
	fclose(fp);

	XLibra::ProgrammingAllTovar();

	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	memset(&pi, 0, sizeof(pi));
	memset(&si, 0, sizeof(si));
	si.cb = sizeof(si);
    char conn_prm[256];
	sprintf(conn_prm, "%s CONNECT:%s:%d",
			prog_way,
			((XEithernetConnection *)connection_descriptor)->ip,
			((XEithernetConnection *)connection_descriptor)->port);

	int res = CreateProcess(0, conn_prm, 0, 0, 0, 0, 0, 0, &si, &pi);
	if (res)
	{
		WaitForSingleObject(pi.hThread, INFINITE);
	  //	SetFocus();
	}

   /*
	SaveToLog("Посилка файлу:");
	SaveToLog(tovar_name);
	int nResult = Wip_SendFile(h_device,
			tovar_name, 1, m_hWnd, WM_WIP_SENDFILE);
	if (nResult < 0)
	{
		char buf[256];

		switch (nResult)
		{
			case -1:
				sprintf(buf, "-статус %d: Невірні параметри виклику (Wip_SendFile)", nResult);
			 break;
			case -3:
				sprintf(buf, "-статус %d: Відсутнє з'єднання з вагою. (Wip_SendFile)", nResult);
			 break;
			case -5:
				sprintf(buf, "-статус %d: Помилка відкриття файлу. (Wip_SendFile)", nResult);
			 break;
			default:
				sprintf(buf, "-статус %d: Невідомий стстус виконання (Wip_SendFile)", nResult);
		}
		SaveToLog(buf);
		return -1;
	}
	else
	{
		Sleep(20000);
		SaveToLog("Файл передано");
    }
		 */
	return 0;
}



