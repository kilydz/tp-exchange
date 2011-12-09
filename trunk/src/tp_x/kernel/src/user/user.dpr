library user;
//  Name: user.dpr
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 15.12.05
//  Description: діалог для додавання або редагування користувача в довіднику Користувачі
//  з програми CRM 2.1 (файл проекта - динамічної бібліотеки)

uses
  FastShareMem,
  SysUtils,
  Classes,
  uuser in 'uuser.pas' {fuser},
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg};

{$R *.res}

exports
    UserDialog;

begin
end.
 