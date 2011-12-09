unit uGeneralDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBHeader, ComCtrls, ExtCtrls;

type
 TParams = record
   AppHandle: THandle;
   psConfig: TpsConfig;
   Flag,
   DocId: integer;
//   AdrProc: procedure;
  end;

// ��������� -------------------------------------------------------------------
function NewDoc(var Value: TpsPrmDoc): Integer;
 external 'Doc.dll' name 'NewDoc';
procedure EditDoc(Value: TpsPrmDoc);
 external 'Doc.dll' name 'EditDoc';
function DeleteDoc(Value: TpsPrmDoc): boolean;
 external 'Doc.dll' name 'DeleteDoc';
procedure LockDoc(Value: TpsPrmDoc);
 external 'Doc.dll' name 'LockDoc';
procedure DocCinnik(Value: TpsPrmDoc);
 external 'Doc.dll' name 'DocCinnik';

// �������� --------------------------------------------------------------------
{procedure ShowStaff(prm: TParamStaff);
 external 'Staff.dll' name 'ShowStaff';

// �볺��� ---------------------------------------------------------------------
{procedure NewClient(prm: TParamClient);
 external 'Client.dll' name 'NewClient';}

// ������ ----------------------------------------------------------------------


implementation

end.
