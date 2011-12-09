library editors;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  FastShareMem,
  SysUtils,
  Classes,
  nomenlist in 'nomenlist.pas' {fnomenlist},
  edmarkup in 'edmarkup.pas' {fedmarkup},
  etalon_ed in '..\..\lib\etalons\etalon_ed.pas' {fetalon_ed};

{$R *.res}

exports MarkupRecordsEditor;
begin
end.
