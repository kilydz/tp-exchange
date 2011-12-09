//$$---- Form HDR ----
//---------------------------------------------------------------------------

#ifndef ulibra_test1H
#define ulibra_test1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "IBDatabase.hpp"
#include "IBSQL.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------


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



class TForm3 : public TForm
{
__published:	// IDE-managed Components
	TIBDatabase *base;
	TIBTransaction *trR;
	TIBSQL *qR;
	TMemo *ed_log;
	TButton *Button1;
	TButton *Button2;
	TButton *Button5;
	TButton *Button6;
	TButton *Button7;
	TButton *Button8;
	TButton *Button3;
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Button4Click(TObject *Sender);
	void __fastcall Button5Click(TObject *Sender);
	void __fastcall Button6Click(TObject *Sender);
	void __fastcall Button7Click(TObject *Sender);
	void __fastcall Button8Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm3(TComponent* Owner);

	int ProgrammingTovar(XLibraTovar tovar)  ;
};
//---------------------------------------------------------------------------
extern PACKAGE TForm3 *Form3;
//---------------------------------------------------------------------------
#endif
