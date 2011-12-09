//$$---- Form HDR ----
//---------------------------------------------------------------------------

#ifndef ulibra_testH
#define ulibra_testH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include "IBDatabase.hpp"
#include "IBSQL.hpp"
#include <DB.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TButton *Button1;
	TButton *Button2;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TTabSheet *TabSheet2;
	TLabel *Label1;
	TComboBox *ed_port;
	TLabel *Label2;
	TComboBox *ed_num;
	TMemo *ed_log;
	TCheckBox *ed_zero_prog;
	TIBDatabase *base;
	TIBSQL *qR;
	TIBTransaction *trR;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
public:		// User declarations
	AnsiString app_path;
	AnsiString password;
	__fastcall TForm1(TComponent* Owner);

	void InitInfo();


};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
