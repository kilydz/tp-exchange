unit moving_h;

interface

uses veles_h, markup_h, revision_h;

function MovingByClient(client_id: integer; var a_veles_info: ZVelesInfoRec): Longint;
    external 'moving.dll' name 'MovingByClient';

function MovingByNomen(nomen_id: integer; var a_veles_info: ZVelesInfoRec): Longint;
    external 'moving.dll' name 'MovingByNomen';

implementation

end.
