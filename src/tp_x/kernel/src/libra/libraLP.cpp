#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <math.h>
#include <io.h>
#include <sys\stat.h>

#ifdef __MSW__
#include <iostream>
#include <windows.h>
#include <windowsx.h>
#endif

#ifdef __UNIX__
#include <errno.h>
#include <termios.h>
#include <unistd.h>
#endif

#include "libra.h"

//-------------------------------------------------------------------------------
//  КЛАС ПРИЗНАЧЕНИЙ ДЛЯ ВАГ LP-06(R), LP-15(R), LP-30(R)
//-------------------------------------------------------------------------------
XLibraLP::XLibraLP(XLibraCallBack icall_finc, const XLibraConnectionString *iconnection_strings): XLibra(LIBRA_LT_LP, icall_finc, iconnection_strings)
{
    code_page = 2;
    std::strcpy(log_name, "XLibraLP.log");
}

XLibraLP::~XLibraLP()
{
}

//-------------------------------------------------------------------------------
int XLibraLP::Connect()
{
    XLibra::Connect();

  if (connection_type == CONN_COM)
  {
	DCB options;
    COMMTIMEOUTS timeouts;

    timeouts.ReadIntervalTimeout=0;
    timeouts.ReadTotalTimeoutMultiplier=0;
    timeouts.ReadTotalTimeoutConstant=1000;
    timeouts.WriteTotalTimeoutMultiplier=0;
    timeouts.WriteTotalTimeoutConstant=0;

    GetCommState(fd, &old_options);
    options = old_options;
	options.BaudRate = PORT_SPEED_9600;
	options.ByteSize = 8;
	options.Parity = NOPARITY;
	options.StopBits = ONESTOPBIT;
	SetCommState(fd, &options);
	int err = SetCommTimeouts(fd, &timeouts);
	if (err < 0)
	    return -1;
    PurgeComm(fd, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR);

	Sleep(1);
  }
  else if (connection_type == CONN_Eithernet) {

  }
	return 0;
}

int XLibraLP::Disconnect()
{
	XLibra::Disconnect();
    return 0;
}

//-------------------------------------------------------------------------------
// Аналіз результату останньої команди з датекса,
// виведення повідомлення, якщо була помилка.
XLibraResult* XLibraLP::GetResult()
{
    result.critical = 0;
    result.error = ret.error;
    *result.text = '\0';

	if (result.error & LIBRA_ERROR_TIMEOUT)
    {
        strcat(result.text, "Таймаут пристрою. Можливо вага не підключена, або не в режимі програмування.\n");
        result.critical = 2;
    }
	else if (result.error & LIBRA_ERROR_PROT)
    {
        strcat(result.text, "Помилка протоколу\n");
        result.critical = 2;
    }

    if ((result.critical >= critical_level) && (*result.text != '\0'))
	{
#ifdef __MSW__
        MessageBox(NULL, result.text, "Увага", MB_OK | MB_TASKMODAL | MB_SYSTEMMODAL);
#endif

#ifdef __UNIX__
		printf(result.text);
#endif
	}
    return &result;
}

// Виконааня команди cmd з параметрами params
int XLibraLP::DoCmd(unsigned char cmd, char *params)
{
    SendLibraNum();

    Write(&cmd, 1);

    switch (cmd)
    {
        case 0x82:
            Write(params, 83);
         break;
        case 0x8a:
            Write(params, 9);
         break;
        case 0x8d:
            Write(params, 4);
         break;
        case 0x81:
            Write(params, 4);
            unsigned char ch;
            for (int i(0); i < 100; i++)
                Read(&ch, 1);
         break;
    };

    Listen();

    return GetResult()->error;
}

// Очiкування вiдповiдi вiд датекса
int XLibraLP::Listen()
{
	ret.error = LIBRA_ERROR_CLEAR;
 try
 {
    unsigned char ch;
	if (Read(&ch, 1) != 1)
		throw LIBRA_ERROR_TIMEOUT;

    switch (ch)
    {
	    case 0xee:  // error
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

int XLibraLP::SendLibraNum()
{
  if (connection_type == CONN_COM)
  {
	Write(&(((XCOMConnection *)connection_descriptor)->number), 1);
	unsigned char ch;
	if (Read(&ch, 1) == 0)
	{
		MessageBox(NULL, "Таймаут пристрою. Можливо вага не підключена, або не в режимі програмування.", "Увага", MB_OK | MB_TASKMODAL | MB_SYSTEMMODAL);
		return LIBRA_ERROR_TIMEOUT;
	}
  }
    return 0;
}

int XLibraLP::ProgrammingTovar(XLibraTovar tovar)
{
    unsigned char cmd[512];
    unsigned char *lp_cmd = cmd;

	memcpy(lp_cmd, &(tovar.nomen_num), 4);
    lp_cmd += 4;
	tovar.nomen_num = tovar.nomen_num * 100;
    for (int i(0); i < 6; i++)
    {
		*lp_cmd = tovar.nomen_num % 10;
		tovar.nomen_num = tovar.nomen_num / 10;
        ++lp_cmd;
    }
    memset(lp_cmd, 0x00, 56);
	ConvertText(lp_cmd, tovar.name, 56);
    lp_cmd += 56;
    int price_i = Around_0(tovar.price * 100);
    memcpy(lp_cmd, &price_i, 4);
    lp_cmd += 4;
    memset(lp_cmd, 0x00, 13);
    lp_cmd += 13;

    return DoCmd(0x82, cmd);
}

int XLibraLP::ClearTovar(int nomen_num)
{
    unsigned char cmd[512];

    memcpy(cmd, &nomen_num, 4);

    return DoCmd(0x8d, cmd);
}

int XLibraLP::SWAdaptor()
{
    unsigned char cmd[512];
    unsigned char *lp_cmd = cmd;
    int libra_num_tmp = ((XCOMConnection *)connection_descriptor)->number;
    short word_tmp;

    for (int i(0); i < 3; i++)
    {
        *lp_cmd = libra_num_tmp % 10;
        libra_num_tmp = libra_num_tmp / 10;
        ++lp_cmd;
    }
    *lp_cmd = 43;   ++lp_cmd;
    *lp_cmd = 8;    ++lp_cmd;
    *lp_cmd = 9;    ++lp_cmd;
    *lp_cmd = 0x30; ++lp_cmd;
    word_tmp = 700;
    memcpy(lp_cmd, &word_tmp, 2);
    return DoCmd(0x8a, cmd);
}


