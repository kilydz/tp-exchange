unit uAlgoritm;

interface
uses IdHashMessageDigest, SysUtils, windows;

function GetHDDInfo :string;

function MD5(const texto :string) :string;

function AD_(const texto :string) :string;
function DEL_(const texto :string) :string;
function DEL_dot(const texto :string) :string;

function WiginerCript(const textto :string) :string;
function WiginerUnCript(const textto :string) :string;

implementation
//---------------------------------------------------------------------------
function GetHDDInfo :string;
var
	_VolumeName,_FileSystemName:array [0..MAX_PATH-1] of Char;
	_VolumeSerialNo,_MaxComponentLength,_FileSystemFlags:LongWord;
begin
  Result := '328509';
  if (GetVolumeInformation(PChar('C:\'),_VolumeName,MAX_PATH,@_VolumeSerialNo,
	   _MaxComponentLength,_FileSystemFlags,_FileSystemName,MAX_PATH)) then
  begin
    Result := IntToStr(_VolumeSerialNo);
  end;
end;
//---------------------------------------------------------------------------
function MD5(const texto :string) :string;
var idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  Result := idmd5.AsHex(idmd5.HashValue(texto));
end;
//---------------------------------------------------------------------------
function AD_(const texto :string) :string;
var res :string;
begin
	res := texto;
  Insert('-', res, 5);
  Insert('-', res, 10);
  Insert('-', res, 15);
  Insert('-', res, 20);
  Insert('-', res, 25);
  Insert('-', res, 30);
  Insert('-', res, 35);
	res := Copy(res, 1, 24);
	Result := res;
end;
//---------------------------------------------------------------------------
function DEL_(const texto :string) :string;
var res :string;
begin
	res := texto;
	Delete(res, 35, 1);
	Delete(res, 30, 1);
	Delete(res, 25, 1);
	Delete(res, 20, 1);
	Delete(res, 15, 1);
	Delete(res, 10, 1);
	Delete(res, 5, 1);
	Result := res;
end;
//---------------------------------------------------------------------------
function DEL_dot(const texto :string) :string;
var res :string;
begin
	res := texto;
  Delete(res, 6, 1);
  Delete(res, 3, 1);
	Result := res;
end;
//---------------------------------------------------------------------------
function WiginerCript(const textto :string) :string;
const MaxLength = 40;
var  a :array[0..2,0..MaxLength-1] of integer;
    i, j, TextLength, Length2, MinSinbolNo, MaxSimbolNo, SymbolCount :Integer;
    CriptText, Key  :string;
begin
  Key := 'HG823ERLNSDCUYG4Y3B2NDVEKRTGRGY4';

	for i := 0 to MaxLength - 1 do
  begin
		a[0, i] := 0;
		a[1, i] := 0;
		a[2, i] := 0;
	end;

	TextLength := Length(textto);
	if (TextLength > MaxLength) then TextLength := MaxLength;

	CriptText := textto;
	MinSinbolNo := 47;
	MaxSimbolNo := 91;
	SymbolCount := 35;

	for i := 0 to TextLength - 1 do
  begin
		if ((Ord(CriptText[i+1]) > MinSinbolNo)and((Ord(CriptText[i+1])) < MaxSimbolNo)) then
			a[0, i] := (Ord(CriptText[i+1]) - (MinSinbolNo));
		if (a[0, i] < 11) then
			a[0, i] := a[0, i] + 7;
	end;

	Length2 := Length(Key);
	j := 0;
	for i := 0 to Length2 - 1 do
  begin
		if (((i + 1) - (j * Length2)) > Length2) then
			j := j + 1;
		a[1, i] := Ord(Key[((i + 1) - (j * Length2))]) - MinSinbolNo;
		if (a[1, i] < 11) then
			a[1, i] := a[1, i] + 7;
	end;

	CriptText := '';
	for i := 0 to TextLength -1 do
  begin
		a[2, i] := (((a[0, i] + a[1, i]) mod SymbolCount) + MinSinbolNo + 8);
		if (a[2, i] < 65) then a[2, i] := a[2, i] - 7;
		CriptText := CriptText + Chr(a[2, i]);
	end;

	Result := CriptText;
end;
//---------------------------------------------------------------------------
function WiginerUnCript(const textto :string) :string;
const MaxLength = 40;
var  a :array[0..2,0..MaxLength-1] of integer;
    i, j, TextLength, Length2, MinSinbolNo, MaxSimbolNo, SymbolCount :Integer;
    CriptText, Key  :string;
begin
  Key := 'HG823ERLNSDCUYG4Y3B2NDVEKRTGRGY4';

	for i := 0 to MaxLength - 1 do
  begin
		a[0, i] := 0;
		a[1, i] := 0;
		a[2, i] := 0;
	end;

	TextLength := Length(textto);
	if (TextLength > MaxLength) then TextLength := MaxLength;

	CriptText := textto;
	MinSinbolNo := 47;
	MaxSimbolNo := 91;
	SymbolCount := 35;

	for i := 0 to TextLength - 1 do
  begin
		if ((Ord(CriptText[i+1]) > MinSinbolNo)and((Ord(CriptText[i+1])) < MaxSimbolNo)) then
			a[0, i] := (Ord(CriptText[i+1]) - MinSinbolNo);
		if (a[0, i] < 11) then
			a[0, i] := a[0, i] + 7;
	end;

	Length2 := Length(Key);
	j := 0;
	for i := 0 to Length2 - 1 do
  begin
		if (((i + 1) - (j * Length2)) > Length2) then
			j := j + 1;
		a[1, i] := Ord(Key[((i + 1) - (j * Length2))]) - MinSinbolNo;
		if (a[1, i] < 11) then
			a[1, i] := a[1, i] + 7;
	end;

	CriptText := '';

	for i := 0 to TextLength - 1 do
  begin
		a[2, i] := (a[0, i] - a[1, i]);
		if (a[2, i] < 1) then a[2, i] := a[2, i] + SymbolCount;
		a[2, i] := a[2, i] + MinSinbolNo - 8;
		if (a[2, i] < 65) then a[2, i] := a[2, i] - 7;
		CriptText := CriptText + Chr(a[2, i]);
	end;

	Result := CriptText;
end;

end.
