unit group_h;
//  Name: group_h.pas
//  Copyright: SoftWest group.
//  Author: ������� ������
//  Date: 23.12.05
//  Description: ��������� ��� ������ ����� ������������ (������� ����� ������������)

interface

uses kernel_h;

type
    ZGroupDlgResulted = record
        id: Integer;
        name: string;
    end;
    lpZGroupDlgResulted = ^ZGroupDlgResulted;

    ZGroupDialogFunc = function(id: Integer; resulted: lpZGroupDlgResulted;
        var prm: ZVelesInfoRec): Integer;

implementation

end.
