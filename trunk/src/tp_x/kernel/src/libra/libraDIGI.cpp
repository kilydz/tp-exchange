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
//  ���� ����������� ��� ��� DIGI SM
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
	sprintf(buf, "== ����: DIGI SM #%s ==", ((XEithernetConnection *)connection_descriptor)->ip);
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
// ����� ���������� �������� �������,
// ��������� �����������, ���� ���� �������.
XLibraResult* XLibraDIGI_SM::GetResult()
{
	return &result;
}

// ��i������� �i����i�i �i� ����
int XLibraDIGI_SM::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;

    return ret.error;
}

struct
{
	BYTE nPLU[2*4];      // BCD
	BYTE nSize[2*2];     //  HEX
	BYTE nStatus1[2*2];     // BIN  PLU ������ 1 (2) 54 00
	BYTE nStatus2[2*3];     // BIN  PLU ������ 2 (3) 0D 26 01

	BYTE nPrice100[2*4];		// BCD ֳ�� � �������
	BYTE nFet1[2*1];     // HEX � ������� 1-� ��������  11
	//BYTE nFet2[2*1];	// HEX � ������� 2-� ��������
	BYTE nFbCode[2*1];  // HEX � ������� ��������� 09
	BYTE nBCode[2*7];	// BCD ��� ���������  22|28 + IntToBCD(nomen_No, 2) + '00000000'
	//BYTE nGrpNum[2*2];	// BCD ����� ������� �����
	BYTE nTerminDSell[2*2];	// BCD 0+����� ������� � ����
	//BYTE nTerminTSell[2*2];	// BCD ����� ������� � ���/�� (0000)
	//BYTE nTerminDUse[2*2];	// BCD 0+����� ������������ � ����
	//BYTE nTerminDPack[2*2];	// BCD 0+����� ��������� � ����
	//BYTE nTerminTPack[2*2];	// BCD ����� ��������� � ���/�� (0000)
	//BYTE nInPrice100[2*4];		// BCD ���������� � �������
	//BYTE nMassaTara[2*2];	// BCD ���� ����		2		BCD
	//BYTE nKilkInPack[2*2];	// BCD �-�� � ���� ��������		2		BCD
	//BYTE nKilkType[2*1];	// BCD ��� ������� �-�    00
	BYTE nMsgNum[2*1];	// BCD ����� ����. �����������  01
	BYTE nIngradientNum[2*1];	// BCD ����� �����䳺��� 01
	//BYTE nTerminTPack[1];	// HEX ����� ���� ���������		1
	//BYTE nTerminTPack[10*2*2];	// BCD  ����� 1-�� ��������		1		BCD
	//BYTE nNumVAT[2*1];	// BCD  ����� �������		1		BCD

   //	BYTE nDiscount[2*30];		// BCD	������ (��������� �����)  ������ ������
   /*
	������ ����		1
	������� ����		2
	������ ����������		4
	����������� ����		4
	������ ���������		4
	�������� ������		1 - 412		ASCII
	����� ����������� � PLU �����������		1 - 1545		ASCII
	����� ����������� � PLU ����. ���������		1 - 824		ASCII
	����������� ������		1		HEX		2 �����
	*/
	BYTE nName[512]; // ����� ������ + ���������� ���� 00
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
		sprintf(result.text, "��� %d ��� ������ %d �������� 9999", tovar.nomen_num, nomen_num);
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
	memcpy(_recPLU.nPrice100, buf, 8);	len+=8;	// 4 ֳ�� � �������
	memcpy(_recPLU.nFet1, "11", 2); len+=2; // HEX � ������� 1-� ��������  11
	memcpy(_recPLU.nFbCode, "09", 2); len+=2; // HEX � ������� ��������� 09
	sprintf(buf, "%02d%04d00000000", ((XEithernetConnection *)connection_descriptor)->prefix,
						   nomen_num);
	memcpy(_recPLU.nBCode, buf, 14); len+=14; // BCD ��� ���������  22|28 + IntToBCD(nomen_No, 2) + '00000000'
	sprintf(buf, "%04d", tovar.termin);
	memcpy(_recPLU.nTerminDSell, buf, 4);  len+=4; // BCD 0+����� ������� � ����
	memcpy(_recPLU.nMsgNum, "01", 2);  len+=2; // BCD ����� ����. �����������  01
	memcpy(_recPLU.nIngradientNum, "01", 2);  len+=2; // BCD ����� �����䳺��� 01
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
		SaveToLog("�������� ����� ������� ������");
		return 0;
	}

	switch (n_ret)
	{
		case OPEN_FILE_ERR:
		  SaveToLog("������� �������� ����� (OPEN_LILE_ERR)");
		 break;
		case READ_FILE_ERR:
		  SaveToLog("������� ������� ����� (READ_FILE_ERR)");
		 break;
		case WRITE_FILE_ERR:
		  SaveToLog("������� ������ � ���� (WRITE_FILE_ERR)");
		 break;
		case NETWORK_OPEN_ERR:
		  SaveToLog("������� �'������� � ����� (NETWORK_OPEN_ERR)");
		 break;
		case NETWORK_READ_ERROR:
		  SaveToLog("������� ��������� ����� � ���� (NETWORK_READ_ERROR)");
		 break;
		case NETWORK_WRITE_ERR:
		  SaveToLog("������� ��������� ����� �� ���� (NETWORK_WRITE_ERR)");
		 break;
		case MACHINE_READ_ERR:
		  SaveToLog("�������: ���� ������� ��� ������� ������� (MACHINE_READ_ERR)");
		 break;
		case MACHINE_WRITE_ERR:
		  SaveToLog("�������: ���� ������� ��� ������� ������ (MACHINE_WRITE_ERR)");
		 break;
		case MACHINE_NOREC_ERR:
		  SaveToLog("�������: ���� ������� ��� ������� '���� ������' (MACHINE_NOREC_ERR)");
		 break;
		case MACHINE_SPASE_ERR:
		  SaveToLog("�������: ���� ������� ��� ������� '���� ������� ����' (MACHINE_SPASE_ERR)");
		 break;
		case MACHINE_UNDEF_ERR:
		  SaveToLog("�������: ���� ������� ��� ������� ������� (MACHINE_UNDEF_ERR)");
		 break;
		default:
			SaveToLog("�������: �������� ��������� ��������� ���������");
	};
	return -1;
}


