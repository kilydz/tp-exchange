//$$---- Form CPP ----
//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ulibra_test.h"
#include <IniFiles.hpp>
#include "..\libra\libra.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "IBDatabase"
#pragma link "IBSQL"
#pragma resource "*.dfm"

TForm1 *Form1;
void *libra_handle;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
	InitInfo();
}

void log_func(char *str)
{
	Form1->ed_log->Lines->Add(str);
}

void TForm1::InitInfo()
{
    ed_log->Lines->Clear();

	app_path = ExtractFilePath(Application->ExeName);
	TIniFile *f;
	f = new TIniFile(app_path + "libra.ini");
	ed_port->ItemIndex 		= f->ReadInteger("Libra", "port", 0);
	ed_num->ItemIndex 		= f->ReadInteger("Libra", "num", 0);
	ed_zero_prog->Checked	= f->ReadInteger("Libra", "zero_prog", 0);

	base->DatabaseName = f->ReadString("Base", "base_way", "127.0.0.1:D:\\BASE\\KRAJ.GDB");
	base->Params->Clear();
	base->Params->Add("user_name=SYSDBA");
	base->Params->Add("password=" + f->ReadString("Base", "password", "masterkey"));
	base->Params->Add("lc_ctype=WIN1251");

	delete f;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
    PageControl1->ActivePage = TabSheet2;

	unsigned char libra_nums[] = {22, 28};
	XLibraConnectionString conn_lines[8];
  /*	strncpy(conn_lines[0], "connection=Eithernet", 256);
	std::sprintf(conn_lines[1], "number=%d", 101);
	std::sprintf(conn_lines[2], "ip=%s", "192.168.1.207");
	std::sprintf(conn_lines[3], "port=%d", 3001);
	std::sprintf(conn_lines[4], "mod=%d", 1);
	std::sprintf(conn_lines[5], "prefix=%d", 22);
	conn_lines[6][0] = '\0';      */
	strncpy(conn_lines[0], "connection=Eithernet", 256);
	std::sprintf(conn_lines[1], "number=%d", 101);
	std::sprintf(conn_lines[2], "ip=%s", "192.168.1.131");
	std::sprintf(conn_lines[3], "port=%d", 5001);
	std::sprintf(conn_lines[4], "mod=%d", 1);
	std::sprintf(conn_lines[5], "prefix=%d", 22);
	conn_lines[6][0] = '\0';

	LibraConnect(this->Handle, &libra_handle, "X:\\KERNEL\\SRC\\LIBRA_TEST\\", LIBRA_LT_MASSA_K_VPM, log_func, conn_lines);
  try
  {
	log_func("  заповненн€ списку товар≥в");
 /*	base->Connected = true;

	if (trR->InTransaction) trR->Commit();
	trR->StartTransaction();
	 qR->SQL->Text = "select onomen_id,  onomen_code, onomen_name, oout_price, \
 odate, otermin from PS_NOMENS_LIBRA(:iadd_pure_rest, :ilibra_num)";  // PS_SCALE_NOMENS
	 qR->ParamByName("iadd_pure_rest")->AsInteger = 1;
	 qR->ParamByName("ilibra_num")->AsString = libra_nums[ed_num->ItemIndex];
	 qR->ExecQuery();
	 while (!(qR->Eof))
	 {
		LibraTovarAdd(&libra_handle, qR->FieldByName("onomen_code")->AsInteger,
			"qwert", //qR->FieldByName("onomen_name")->AsString.c_str(),
			qR->FieldByName("oout_price")->AsFloat,
			qR->FieldByName("odate")->AsString.c_str(),
			qR->FieldByName("otermin")->AsInteger);
		qR->Next();
	 }
	if (trR->InTransaction) trR->Commit();   */
  }
  catch ( EIBError &eException )
  {
	if (trR->InTransaction) trR->Rollback();
	log_func(AnsiString("«б≥й: " + eException.Message).c_str());
  }
 //	LibraProgrammingAllTovar(&libra_handle);
	LibraDisconnect(&libra_handle);
	base->Connected = false;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
	Close();	
}

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
	TIniFile *f;
	f = new TIniFile(app_path + "libra.ini");
	f->WriteInteger("Libra", "port", ed_port->ItemIndex);
	f->WriteInteger("Libra", "num", ed_num->ItemIndex);
	f->WriteInteger("Libra", "zero_prog", ed_zero_prog->Checked);
	delete f;
}
//---------------------------------------------------------------------------

