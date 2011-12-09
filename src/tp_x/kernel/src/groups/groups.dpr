library groups;
//  Name: groups.dpr
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 22.12.05
//  Description: довідник Групи користувачів з програми CRM 2.1 (файл проекта -
//  динамічної бібліотеки)

uses
  FastShareMem,
  SysUtils,
  Classes,
  ugroups in 'ugroups.pas' {fgroups},
  etalon_dic in '..\..\lib\etalons\etalon_dic.pas' {fetalon_dic};

{$R *.res}

exports
    ShowPage, FreePage;

begin
end.
 