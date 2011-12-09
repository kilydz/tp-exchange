#ifndef libra_h
#define libra_h

#ifdef __UNIX__
#include <termios.h>
#define _export
#define max(a, b)	((a) > (b)) ? (a) : (b)
#endif

#define  SOKOLDLL "C" __declspec(dllexport)

#include <vector>

typedef void _stdcall (*XLibraCallBack)(char *str);

enum XSpeed
{
	PORT_SPEED_2400  = 2400,
	PORT_SPEED_4800  = 4800,
	PORT_SPEED_9600  = 9600,
	PORT_SPEED_19200 = 19200
};

enum XError
{
	LIBRA_ERROR_CLEAR   = 0x00000000,
	LIBRA_ERROR_TIMEOUT = 0x00000001,
	LIBRA_ERROR_PARAM   = 0x00000002,
	LIBRA_ERROR_PROT    = 0x00000004
};

enum XLibraType
{
	LIBRA_LT_NONE   		= 0,
	LIBRA_LT_LP		 		= 1,
	LIBRA_LT_MASSA_K_VPM	= 2,
	LIBRA_LT_MASSA_K_VP		= 3,
	LIBRA_LT_TIGER_D		= 4,
	LIBRA_LT_DIGI_SM 		= 5
};

class __declspec(dllexport) XLibraTovar
{
public:
	int nomen_num;
	char name[128];
	double price;
	char date[16];
	int termin;

	XLibraTovar();
	XLibraTovar(int inomen_num, char *iname, double iprice, char *idate, int itermin);
	~XLibraTovar();
};

typedef std::vector<XLibraTovar> XLibraTovarList;

/*------------------------------------------*/
/*	String connection format				*/
/*------------------------------------------*/
// connection: COM|Eithernet				//
// для COM								   //
// port: номер порта 0..4					  //
// number: номер ваги                       //
// mod: модифікація						   //
// prefix: 22|28							//
// для Eithernet							   //
// ip: ip-адреса ваги						  //
// port: порт з'єднання                    	//
// mod: модифікація						   //
// prefix: 22|28							//
/*------------------------------------------*/
typedef  char XLibraConnectionString[256];

typedef struct
{
	int critical;
	XError error;

	char text[1024];
	void *libra_data;
} XLibraResult;

long   Around_0(double p);
double Around_2(double p);
double Around_3(double p);

class __declspec(dllexport) XLibra
{
protected:
	XLibraTovarList l_tovar;
	XLibraCallBack call_finc;
	void SaveToLog(char *str);

	enum XConnectionType { CONN_ERROR = 0x00, CONN_COM = 0x01, CONN_Eithernet = 0x02};

	typedef struct
	{
		int number;		// libra number
		int port;		// Port number
		int mod;
		int prefix;
	} XCOMConnection;

	typedef struct
	{
		int number;
		char ip[24];
		int port;
		int mod;
		int prefix;
	} XEithernetConnection;

	XConnectionType connection_type;
	void *connection_descriptor; // XCOMConnection|XEithernetConnection

    int log_fd;
	char log_name[256];
	char tovar_name[256];
	char label_name[256];

	void *fd;

	int critical_level;
    int code_page;	// Code page for Libra
    XLibraResult result; // Статус помилки
	XLibraType libra_type;

    size_t Write(const void* ibuf, size_t isize);
	size_t Read(void* obuf, size_t isize);

    char *ConvertText(char *dst, char *src, int len = -1);
    char ConvertChar(unsigned char src);

public:
	XLibra(XLibraType ilibra_type, XLibraCallBack icall_finc, const XLibraConnectionString *iconnection_strings);
    ~XLibra();

    virtual XLibraResult* GetResult();
    void SetCriticalLevel(int icritical_level);
    int  GetCriticalLevel();

    virtual int Connect();
    virtual int Disconnect();

	int LibraTovarClear();
	int LibraTovarAdd(int nomen_num, char *name, double price, char *date, int termin);

   //	virtual
	virtual int ProgrammingAllTovar();
	virtual int ProgrammingTovar(XLibraTovar tovar);
    virtual int ClearTovar(int nomen_num);
	virtual int SWAdaptor();

	char *StrToSpaseStr(const char *inp_str, char *buf, int len);
	char *IntToSpaseStr(const int i_val, char *buf, int len);
	char *DoubleToSpaseStr(const double d_val, char *buf, int len);
};

struct XLibraLPRet {

    XError error;
};

class __declspec(dllexport) XLibraLP : public XLibra
{
protected:
	DCB old_options;

    unsigned char seq;
    XLibraLPRet ret;

    unsigned char last_cmd[512];

    void ReadAns();
    int Listen();
public:
	XLibraLP(XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings);
    ~XLibraLP();

	int DoCmd(unsigned char cmd, char *params);
    XLibraResult* GetResult();

    int Connect();
    int Disconnect();

    int SendLibraNum();

	int ProgrammingTovar(XLibraTovar tovar);
    int ClearTovar(int nomen_num);
    int SWAdaptor();
};

struct XLibraMassaKRet {

	XError error;
};

class __declspec(dllexport) XLibraMassaK_VP : public XLibra
{
protected:
	DCB old_options;

	unsigned char seq;
	XLibraMassaKRet ret;

	unsigned char last_cmd[512];

	void ReadAns();
	int Listen();
	int IsReady();
	void set9bit(bool bit);
public:
	XLibraMassaK_VP(XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings);
	~XLibraMassaK_VP();

	XLibraResult* GetResult();

	int Connect();
	int Disconnect();

	int SendLibraNum();

	int ProgrammingTovar(XLibraTovar tovar);
	int ClearTovar(int nomen_num);
	int SWAdaptor();
};

class __declspec(dllexport) XLibraMassaK_VPM : public XLibra
{
protected:
	DCB old_options;

	unsigned char seq;
	XLibraMassaKRet ret;

	unsigned char last_cmd[512];

	void ReadAns();
	int Listen();
	int IsReady();

	HINSTANCE h_dll;
	HANDLE h_device;
	HANDLE m_hWnd;
	
	char prog_way[512];
public:
	XLibraMassaK_VPM(HANDLE im_hWnd, const char *iprog_way, XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings);
	~XLibraMassaK_VPM();

	XLibraResult* GetResult();

	int Connect();
	int Disconnect();

	int SendLibraNum();

	int ProgrammingTovar(XLibraTovar tovar);
	int ProgrammingAllTovar();
	int ClearTovar(int nomen_num);
	int SWAdaptor();
};

struct XLibraDIGIRet {

	XError error;
};

class __declspec(dllexport) XLibraDIGI_SM : public XLibra
{
protected:
	DCB old_options;

	unsigned char seq;
	XLibraMassaKRet ret;

	unsigned char last_cmd[512];

	void ReadAns();
	int Listen();
	int IsReady();

	HINSTANCE h_dll;
	HANDLE h_device;

	char dll_way[512];
	long tovar_pos;
public:
	XLibraDIGI_SM(const char *iprog_way, XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings);
	~XLibraDIGI_SM();

	XLibraResult* GetResult();

	int Connect();
	int Disconnect();

	int SendLibraNum();

	void StrFormat(BYTE *buf, char *name);

	int ProgrammingTovar(XLibraTovar tovar);
	int ProgrammingAllTovar();
	int ClearTovar(int nomen_num);
	int SWAdaptor();
};

struct XLibraTigerRet {

	XError error;
};

class __declspec(dllexport) XLibraTigerD : public XLibra
{
protected:
	DCB old_options;

	unsigned char seq;
	XLibraTigerRet ret;

	unsigned char last_cmd[512];

	void ReadAns();
	int Listen();
	int IsReady();

	HINSTANCE h_dll;
	HANDLE h_device;
	char dll_way[512];
	char SCALEADDRESS_way[512];
	char transscale_way[512];
	char plu_txt_way[512];

	char back_dir[512];
	char dll_dir[512];
public:
	XLibraTigerD(const char *iprog_way, XLibraCallBack icall_finc,
			 const XLibraConnectionString *iconnection_strings);
	~XLibraTigerD();

	XLibraResult* GetResult();

	int Connect();
	int Disconnect();

	int SendLibraNum();

	int ProgrammingTovar(XLibraTovar tovar);
	int ProgrammingAllTovar();
	int ClearTovar(int nomen_num);
	int SWAdaptor();
};


extern  SOKOLDLL int __stdcall LibraConnect(HANDLE im_hWnd, void **handle, const char *prog_way, XLibraType ilibra_type, XLibraCallBack icall_finc,
									 const XLibraConnectionString *iconnection_strings);
extern  SOKOLDLL int __stdcall LibraSWAdaptor(void **handle);

extern  SOKOLDLL int __stdcall LibraTovarClear(void **handle);
extern	SOKOLDLL int __stdcall LibraTovarAdd(void **handle, int nomen_num, char *name, double price, char *date, int termin);

extern  SOKOLDLL int __stdcall LibraProgrammingAllTovar(void **handle);
extern  SOKOLDLL int __stdcall LibraDisconnect(void **handle);

#endif
