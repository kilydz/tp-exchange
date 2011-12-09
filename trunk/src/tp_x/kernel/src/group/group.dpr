library group;
//  Name: group.dpr
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 23.12.05
//  Description: діалог для додавання або редагування групи користувачів в
//  довіднику Групи користувачів з програми CRM 2.1 (файл проекта - динамічної бібліотеки)

uses
  FastShareMem,
  SysUtils,
  Classes,
  ugroup in 'ugroup.pas' {fgroup},
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg};

{$R *.res}

exports
    GroupDialog;

begin
end.
 