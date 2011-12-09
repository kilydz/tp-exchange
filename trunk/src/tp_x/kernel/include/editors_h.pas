unit editors_h;

interface

uses kernel_h, markup_h, revision_h;

function MarkupRecordsEditor(resulted: lpZMarkupDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'markup.dll' name 'MarkupRecordsEditor';

{function RevisionRecordsEditor(var resulted: ZRevisionDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'editors.dll' name 'RevisionRecordsEditor'; }
implementation

end.
