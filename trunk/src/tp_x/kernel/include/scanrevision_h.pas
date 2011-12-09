unit scanrevision_h;

interface
uses
  veles_h;


procedure ScanRevisionShow(id: integer; var prm: ZVelesInfoRec);
         external 'scanrevision.dll' name 'scanrevisionshow';
implementation


begin
end.
