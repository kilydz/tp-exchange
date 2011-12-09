//$$---- Form CPP ----
//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ulibra_test1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "IBDatabase"
#pragma link "IBSQL"
#pragma resource "*.dfm"

#include <stdio.h>

TForm3 *Form3;


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

HINSTANCE h_dll;
HANDLE h_device;
HANDLE h_win;

int nResult;

//---------------------------------------------------------------------------
__fastcall TForm3::TForm3(TComponent* Owner)
	: TForm(Owner)
{
	h_dll = LoadLibrary("X:\\KERNEL\\SRC\\LIBRA_TEST\\wip.dll");

	Wip_CreateDevice = (Tfunc_Wip_CreateDevice)GetProcAddress(h_dll, "Wip_CreateDevice");
	Wip_DestroyDevice = (Tfunc_Wip_DestroyDevice)GetProcAddress(h_dll, "Wip_DestroyDevice");
	Wip_Setup = (Tfunc_Wip_Setup)GetProcAddress(h_dll, "Wip_Setup");
	Wip_Connect = (Tfunc_Wip_Connect)GetProcAddress(h_dll, "Wip_Connect");
	Wip_Disconnect = (Tfunc_Wip_Disconnect)GetProcAddress(h_dll, "Wip_Disconnect");
	Wip_SendPLU = (Tfunc_Wip_SendPLU)GetProcAddress(h_dll, "Wip_SendPLU");
	Wip_SendFile = (Tfunc_Wip_SendFile)GetProcAddress(h_dll, "Wip_SendFile");
	Wip_GetFile = (Tfunc_Wip_GetFile)GetProcAddress(h_dll, "Wip_GetFile");
	Wip_GetStatus = (Tfunc_Wip_GetStatus)GetProcAddress(h_dll, "Wip_GetStatus");

}
//---------------------------------------------------------------------------
void __fastcall TForm3::FormDestroy(TObject *Sender)
{
 	FreeLibrary(h_dll);
}
//---------------------------------------------------------------------------
void __fastcall TForm3::Button2Click(TObject *Sender)
{
	h_device = Wip_CreateDevice();
	if (NULL == h_device)
	{
 //		MessageBox("Критическая ошибка библиотеки: ошибка создания экземпляра класса!", "Ошибка", MB_ICONERROR | MB_OK);
		return;
	}

	h_win = this->Handle;

	char conn_prm[256];

	nResult = Wip_Setup(h_device, "LAN:TCP", "CONNECT:192.168.0.131:5001");
	ed_log->Lines->Add("Wip_Setup " + IntToStr(nResult));

	nResult = Wip_Connect(h_device, h_win, WM_WIP_CONNECTED);
	ed_log->Lines->Add("Wip_Connect " +IntToStr(nResult));

	Sleep(1000);
 /*
	nResult = Wip_GetFile(h_device,
"c:\\products.dat", 1, h_win, WM_WIP_GETFILE);
	ed_log->Lines->Add("Wip_GetFile" + IntToStr(nResult)); */
}
//---------------------------------------------------------------------------



void __fastcall TForm3::Button3Click(TObject *Sender)
{                  //  1234
	FILE* fp = fopen("c:\\products_out.dat", "wb");
	fclose(fp);

	if(fp != NULL)
	{
		XLibraTovar tovar(280002, "hello", 35.50, "30.09.2011", 30);
		ProgrammingTovar(tovar);
		XLibraTovar tovar1(280003, "ravlik12345", 3.23, "30.09.2011", 30);
		ProgrammingTovar(tovar1);
		XLibraTovar tovar2(280004, "sender_good", 23.45, "30.09.2011", 30);
		ProgrammingTovar(tovar2);
		nResult = Wip_SendFile(h_device,
			"c:\\products_out.dat", 1, h_win, WM_WIP_SENDFILE);
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button4Click(TObject *Sender)
{
   //
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button5Click(TObject *Sender)
{
nResult = Wip_GetFile(h_device,
"c:\\products.dat", 1, h_win, WM_WIP_GETFILE);
	ed_log->Lines->Add("Wip_GetFile" + IntToStr(nResult));
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button6Click(TObject *Sender)
{
	Wip_Disconnect(h_device, h_win, WM_WIP_DISCONNECTED);
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button7Click(TObject *Sender)
{
	Wip_DestroyDevice(h_device);
}
//---------------------------------------------------------------------------

void __fastcall TForm3::Button8Click(TObject *Sender)
{
	Wip_GetStatus(h_device, h_win, WM_WIP_GETSTATUS);
}
//---------------------------------------------------------------------------
  
struct
{
	BYTE nPLU[4];    //	4
	WORD nSize;    //	2
	WORD nStatus;  //	2
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
   /*
void _Word_(BYTE *b)
{
	BYTE b0 = b[1], b1 = b[0];
	b[0] = b0;
	b[1] = b1;
}

DWORD _DWord_(DWORD inp)
{
	BYTE *bb;
	bb = (char *)&inp;
	bb[0] = bb[1];
	bb[1] = bb[2];
	bb[2] = bb[3];
	bb[3] = 0x00;

	DWORD *tmp = (unsigned long *)bb;
	return *tmp;
}
		   
WORD CRC16(WORD crc, SHORT *buf, WORD len)
{
  WORD bits, k;
  WORD accumulator, temp;

  for( k = 0; k<len; k++ )
  {
	accumulator = 0;
	temp = (crc>>8)<<8;
	for( bits = 0; bits < 8; bits++ )
	{
	  if( (temp ^ accumulator) & 0x8000 )
		accumulator = (accumulator << 1) ^ 0x1021;
	  else
		accumulator <<= 1;
	  temp <<= 1;
	}
	crc = accumulator^(crc<<8)^(buf[k]&0xff);
  }
  return crc;
}
              */
long Around_0(double p)
{
    double pp(p);
    long int ipp((long int)pp);
    double rest(pp - ipp);
    if (rest >= 0.5)
        ipp = ipp + 1;
    else
        ipp = ipp;
    return ipp;
}



int TForm3::ProgrammingTovar(XLibraTovar tovar)
{
	long nomen_num = tovar.nomen_num -
	  28 * 10000;  //	((XEithernetConnection *)connection_descriptor)->prefix * 10000;
	long nomen_num_int = nomen_num;

	if (nomen_num > 9999)
	{
	  //	sprintf(result.text, "Для %d код товару %d перевищує 9999", tovar.nomen_num, nomen_num);
	  //  SaveToLog(result.text);
	  //	result.critical = 0;
		return -1;//	return LIBRA_ERROR_PARAM;
	}

 //   _recPLU.cc = 0x55;
	memcpy(_recPLU.nPLU, &nomen_num, 4);
  //	_DWord_((char *)(&_recPLU.nPLU));
//_recPLU.nSize = 43;
	_recPLU.nStatus = 0x0000;
	_recPLU.nFormatLabel = 0x01;
	_recPLU.nFormatBarcode = 1; 	// 1
	_recPLU.nPrefixBarcode = 28; //((XEithernetConnection *)connection_descriptor)->prefix; 	// 1 22/28
	long price = Around_0(tovar.price * 100.0);
	memcpy(_recPLU.nPrice100, &price, 4);		// 4 Ціна в копійках
   //	_recPLU.nPrice100 = _DWord_(_recPLU.nPrice100);
  //	_DWord_((char *)&_recPLU.nPrice100);
	memset(_recPLU.nTara, 0, 4);
  //	_DWord_((char *)&_recPLU.nTara);
  //	_recPLU.nCode = nomen_num;
	memcpy(_recPLU.nCode, &nomen_num, 4);
  //	_DWord_((char *)&_recPLU.nCode);
	memset(_recPLU.nDate0, 0, 6); 	//	6
	memset(_recPLU.nDate1, 0, 6);	//	6
	memset(_recPLU.nSertCode, ' ', 4);	//	4
	_recPLU.nSertCode[3] = '0';
	memset(_recPLU.nMainGroup, 0, 2);
	memset(_recPLU.nReserv, 0, 2);
	_recPLU.pData[0] = 0x01;
	BYTE len = strlen(tovar.name);
	_recPLU.pData[1] = len;
	memcpy(&(_recPLU.pData[2]), tovar.name, len);
	_recPLU.pData[len + 2] = 0x0d;
	char *data_tmp = &(_recPLU.pData[len + 3]);
	data_tmp[0] = 0x00;		data_tmp[1] = 0x00;		data_tmp[2] = 0x0d;
	data_tmp = &(data_tmp[3]);
	data_tmp[0] = 0x00;		data_tmp[1] = 0x00;		data_tmp[2] = 0x0d;
	_recPLU.nSize = 37+len+3+3+3+1;
	int ll = 43+len+3+3+3;
 //	WORD crc = CRC16(0, (SHORT *)&_recPLU, ll);
	WORD crc = 0;
	BYTE *B = (BYTE *)&_recPLU;

	for(int i(0); i < ll; i++)
	{
		if (B[i] != 0)
			crc = crc + B[i];
	}
	BYTE bcrc = crc; //>> 8;
	data_tmp[3] = bcrc;
   //	memcpy(&data_tmp[3], &crc, 2);
  //	_Word_((char *)&_recPLU.nSize);
  //	_recPLU.pData[(*len) + 4] = CRC16(0, (SHORT *)&_recPLU, (BYTE)_recPLU.nSize + 6);

   //	int nResult = Wip_SendPLU(h_device, (char*)&_recPLU, ll+1);
	FILE* fp = fopen("c:\\products_out.dat", "ab");
	fwrite((char*)&_recPLU, ll+1, 1, fp);
	fclose(fp);
   //	ShowMessage(IntToStr(nResult));
	return 0;
}

//-------------------------------------------------------------------------------
//  КЛАС ТОВАРІВ
//-------------------------------------------------------------------------------
XLibraTovar::XLibraTovar()
{
	nomen_num = 0;
	name[0] = '\0';
	price = 0.00;
	std::strcpy(date, "01.01.2012");
}

XLibraTovar::XLibraTovar(int inomen_num, char *iname, double iprice, char *idate, int itermin)
{
	nomen_num = inomen_num;
	strncpy(name, iname, 128);
	price = iprice;
	strncpy(date, idate, 16);
    termin = itermin;
}

XLibraTovar::~XLibraTovar()
{

}

