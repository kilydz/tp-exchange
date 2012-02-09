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

#include "libra.h"

#include <vector>

using namespace std;

//---------------------------------------------------------------------------
// ����� �������
static unsigned char table[4][256] =
{

{	// 0
0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,

0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
0xcA, 0xcA, 0xcF, 0xcF, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff
},

{	// 1
0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,

0x3f, 0x3f, 0x27, 0x3f, 0x22, 0x3a, 0xc5, 0xd8, 0x3f, 0x25, 0x3f, 0x3c, 0x3f, 0x3f, 0x3f, 0x3f,
0x3f, 0x27, 0x27, 0x22, 0x22, 0x07, 0x2d, 0x2d, 0x3f, 0x54, 0x3f, 0x3e, 0x3f, 0x3f, 0x3f, 0x3f, 
0xff, 0xf6, 0xf7, 0x3f, 0xfd, 0x3f, 0xb3, 0x15, 0xf0, 0x63, 0xf2, 0x3c, 0xbf, 0x2d, 0x52, 0xf4, 
0xf8, 0x2b, 0x49, 0x69, 0x3f, 0xe7, 0x14, 0xfa, 0xf1, 0xfc, 0xf3, 0x3e, 0x3f, 0x3f, 0x3f, 0xf5, 
0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 
0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 
0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef
},

{	// 2
0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,

0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0x85, 0xA9, 0xC0, 0xAB, 0xAC, 0xAD, 0xAE, 0xC2,
0xB0, 0xB1, 0x49, 0x69, 0xB4, 0xB5, 0xB6, 0xB7, 0xA5, 0xB9, 0xC1, 0xBB, 0xBC, 0xBD, 0xBE, 0xC3,
0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xaD, 0xaE, 0xaF,
0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xeA, 0xeB, 0xeC, 0xeD, 0xeE, 0xeF
},

{	// 3
0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,

0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
0x90, 0x43, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
0xb0, 0xb1, 0xb2, 0x69, 0xb4, 0xb5, 0xb6, 0xb7, 0xa8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xaf,
0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
0x50, 0x43, 0x54, 0x59, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
0x70, 0x63, 0x74, 0x79, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f
}

};	// end table

//XLibra *libra;

int _stdcall LibraConnect(HANDLE im_hWnd, void **handle, const char *prog_way, XLibraType ilibra_type, XLibraCallBack icall_finc,
									 const XLibraConnectionString *iconnection_strings)
{
	if (ilibra_type == LIBRA_LT_DIGI_SM)
		(*handle) = new XLibraDIGI_SM(prog_way, icall_finc, iconnection_strings);


	return ((XLibra *)(*handle))->Connect();
}

int _stdcall LibraSWAdaptor(void **handle)
{
	return ((XLibra *)(*handle))->SWAdaptor();
}

int _stdcall LibraTovarClear(void **handle)
{
	return ((XLibra *)(*handle))->LibraTovarClear();
}

int _stdcall LibraTovarAdd(void **handle, int nomen_num, char *name, double price, char *date, int termin, int art_num)
{
	return ((XLibra *)(*handle))->LibraTovarAdd(nomen_num, name, price, date, termin, art_num);
}

int _stdcall LibraProgrammingAllTovar(void **handle)
{
	int ret = 0;
	ret = ((XLibra *)(*handle))->ProgrammingAllTovar();
    return ret;
}

int _stdcall LibraDisconnect(void **handle)
{
	if ((*handle))
	{
		((XLibra *)(*handle))->Disconnect();
		delete (*handle);
		(*handle) = NULL;
	}
	return 0;
}

// ���������� �� ������
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

// ���������� �� ���� �����
double Around_2(double p)
{
    double pp(p * 100.0);
    long int ipp((long int)pp);
    double rest(pp - ipp);
    if (rest >= 0.5)
        p = ipp / 100.0 + 0.01;
    else
        p = ipp / 100.0;
    return p;
}

// ���������� �� ����� �����
double Around_3(double p)
{
    double pp(p * 1000.0);
    long int ipp((long int)pp);
    double rest(pp - ipp);
    if (rest >= 0.5)
        p = ipp / 1000.0 + 0.001;
    else
        p = ipp / 1000.0;
    return p;
}

//-------------------------------------------------------------------------------
//  ���� ����в�
//-------------------------------------------------------------------------------
XLibraTovar::XLibraTovar()
{
	nomen_num = 0;
	name[0] = '\0';
	price = 0.00;
	std::strcpy(date, "01.01.2012");
}

XLibraTovar::XLibraTovar(int inomen_num, char *iname, double iprice, char *idate, int itermin, int iart_num)
{

	strncpy(name, iname, 128);
	price = iprice;
	strncpy(date, idate, 16);
	termin = itermin;
	art_num = iart_num;
}

XLibraTovar::~XLibraTovar()
{

}

//-------------------------------------------------------------------------------
//  ������� ����
//-------------------------------------------------------------------------------
XLibra::XLibra(XLibraType ilibra_type, XLibraCallBack icall_finc,
		const XLibraConnectionString *iconnection_strings): libra_type(ilibra_type)
{
	char buf[256];
    call_finc = icall_finc;

	connection_type = CONN_ERROR;

	strncpy(buf, iconnection_strings[0], 256);
	char *lp_eq = strchr(buf, '=');
	*lp_eq = '\0';
	lp_eq++;
	if (std::strcmp(buf, "connection") == 0)
	{
		if (std::strcmp(lp_eq, "COM") == 0)
		{
			connection_type = CONN_COM;
			connection_descriptor = new XCOMConnection();
		}
		else if (std::strcmp(lp_eq, "Eithernet") == 0)
		{
			connection_type = CONN_Eithernet;
			connection_descriptor = new XEithernetConnection();
		}
	}

	int i(1);
	while (iconnection_strings[i][0] != '\0')
	{
		strncpy(buf, iconnection_strings[i], 256);
		lp_eq = strchr(buf, '=');
		*lp_eq = '\0';
		lp_eq++;
		if (connection_type == CONN_COM)
		{
			if (std::strcmp(buf, "number") == 0)
				((XCOMConnection *)connection_descriptor)->number = atoi(lp_eq);
			else if (std::strcmp(buf, "port") == 0)
				((XCOMConnection *)connection_descriptor)->port = atoi(lp_eq);
			else if (std::strcmp(buf, "mod") == 0)
				((XCOMConnection *)connection_descriptor)->mod = atoi(lp_eq);
			else if (std::strcmp(buf, "prefix") == 0)
				((XCOMConnection *)connection_descriptor)->prefix = atoi(lp_eq);
		}

		if (connection_type == CONN_Eithernet)
		{
			if (std::strcmp(buf, "port") == 0)
				((XEithernetConnection *)connection_descriptor)->port = atoi(lp_eq);
			else if (std::strcmp(buf, "mod") == 0)
				((XEithernetConnection *)connection_descriptor)->mod = atoi(lp_eq);
			else if (std::strcmp(buf, "number") == 0)
				((XEithernetConnection *)connection_descriptor)->number = atoi(lp_eq);
			else if (std::strcmp(buf, "ip") == 0)
				strncpy(((XEithernetConnection *)connection_descriptor)->ip, lp_eq, 24);
			else if (std::strcmp(buf, "prefix") == 0)
				((XEithernetConnection *)connection_descriptor)->prefix = atoi(lp_eq);
		}
		i++;
	}

	critical_level = 2;
}

XLibra::~XLibra()
{
	Disconnect();
}

void XLibra::SetCriticalLevel(int icritical_level)
{
    critical_level = icritical_level;
}

int  XLibra::GetCriticalLevel()
{
	return critical_level;
}

void XLibra::SaveToLog(char *str)
{
	 if (call_finc)
	 {
		 call_finc(str);
	 }
}

// ϳ���������� �� �����
int XLibra::Connect()
{
  SaveToLog("ϳ��������� �� ����");
  if (connection_type == CONN_COM)
  {
	char port_name[256];

    log_fd = open(log_name, O_CREAT|O_APPEND|O_BINARY|O_RDWR, S_IREAD|S_IWRITE);

	fd = NULL;
	sprintf(port_name,"\\\\.\\COM%d", ((XCOMConnection *)connection_descriptor)->port + 1);
    fd = CreateFile(port_name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, NULL, NULL);
    EscapeCommFunction(fd, SETDTR);

    SetupComm(fd, 1024, 1024);
    if (fd == NULL)
        return -1;
  }
  return 0;
}

// ³���������� �� �����
int XLibra::Disconnect()
{
	SaveToLog("³��������� �� ����");
	if (log_fd != -1)
        close(log_fd);

	if (fd)
    {
        FlushFileBuffers(fd);
        PurgeComm(fd, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR);
        CloseHandle(fd);
    }

    return 0;
}

// ����� � ����
size_t XLibra::Write(const void* ibuf, size_t isize)
{
	unsigned long ret;

  if (connection_type == CONN_COM)
  {
	if (log_fd != -1)
	{
		write(log_fd, ibuf, isize);
	}

	FlushFileBuffers(fd);
	PurgeComm(fd, PURGE_TXCLEAR | PURGE_RXCLEAR);
	WriteFile(fd, ibuf, isize, &ret, NULL);
  }
    return ret;
};

// ������ � �����
size_t XLibra::Read(void* obuf, size_t isize)
{
	unsigned long ret;

  if (connection_type == CONN_COM)
  {
	ReadFile(fd, obuf, isize, &ret, NULL);

    if (log_fd != -1)
    {
        if (ret > 0)
            write(log_fd, obuf, ret);
    }
  }

    return ret;
};

// ����������� ������ � ������� ������ ������
char *XLibra::ConvertText(char *dst, char *src, int len)
{
    unsigned char *lpsrc = (unsigned char *)src;
    unsigned char *lpdst = (unsigned char *)dst;

    if (len < 0) len = strlen(src);

    while ((*lpsrc != '\0') && (len > 0))
    {
        *lpdst = table[code_page][*lpsrc];
        ++lpsrc;
        ++lpdst;
        --len;
    }
    *lpdst = '\0';
    return dst;
}

// ����������� ������� � ������� ������ ������
char XLibra::ConvertChar(unsigned char src)
{
    return table[code_page][src];
}

XLibraResult* XLibra::GetResult()
{
	return NULL;
}





	return 0;
}




	return 0;
}


{
    return 0;
}

int XLibra::ProgrammingAllTovar()
{
	char buf[256];
	sprintf(buf, "  ����������� %d ������ � ����", l_tovar.size());
	SaveToLog(buf);
	for (unsigned int i(0); i < l_tovar.size(); i++)
	{
		XError err = ProgrammingTovar(l_tovar[i]);
		GetResult();
		if (result.critical == 2)	return err;
	}

	return 0;
}

int XLibra::ClearTovar(int nomen_num)
{
    return 0;
}

int XLibra::SWAdaptor()
{
    return 0;
}

char *XLibra::StrToSpaseStr(const char *inp_str, char *buf, int len)
{
	int inp_str_len = strlen(inp_str);
	int space_len = (len > inp_str_len) ? (len - inp_str_len) : 0;
	int new_len = 0;

	char *lp_buf = buf;
	while (space_len > 0)
	{
		*lp_buf = ' ';
		--space_len;
		++lp_buf;
		++new_len;
	}

	const char *lp_inp_str = inp_str;
	while (((*lp_inp_str) != '\0') && (new_len < len))
	{
		*lp_buf = ((*lp_inp_str) == ',') ? '.' : (*lp_inp_str);
		++lp_inp_str;
		++lp_buf;
		++new_len;
	}
	*lp_buf = '\0';

	return buf;
}

char *XLibra::IntToSpaseStr(const int i_val, char *buf, int len)
{
	sprintf(buf, "% *d", len, i_val);
	return buf;
}

char *XLibra::DoubleToSpaseStr(const double d_val, char *buf, int len)
{
	double val = d_val;
	if (val < 0.002) val = 0.00;
	if (val > 99999.99) val = 99999.99;

	sprintf(buf, "% *.2f", len, val);
	return buf;
}
