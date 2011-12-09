unit uexport_excel_xml;

interface
const
XML_VER = '<?xml version="1.0"?>                   ' +#13#10+
          '<?mso-application progid="Excel.Sheet"?>';
WORKBOOK_BEGIN =
  '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" ' +#13#10+
  ' xmlns:o="urn:schemas-microsoft-com:office:office"             ' +#13#10+
  ' xmlns:x="urn:schemas-microsoft-com:office:excel"              ' +#13#10+
  ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"       ' +#13#10+
  ' xmlns:html="http://www.w3.org/TR/REC-html40">                 ';
BEGIN_DATA =
  ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">         '+#13#10+
  '  <Author>Григорій Собіборець</Author>                                        '+#13#10+
  '  <LastAuthor>User name</LastAuthor>                                          '+#13#10+
  '  <Created>2008-08-28T08:38:51Z</Created>                                     '+#13#10+
  '  <Version>11.9999</Version>                                                  '+#13#10+
  ' </DocumentProperties>                                                        '+#13#10+
  ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">               '+#13#10+
  '  <WindowHeight>10005</WindowHeight>                                          '+#13#10+
  '  <WindowWidth>10005</WindowWidth>                                            '+#13#10+
  '  <WindowTopX>120</WindowTopX>                                                '+#13#10+
  '  <WindowTopY>135</WindowTopY>                                                '+#13#10+
  '  <ProtectStructure>False</ProtectStructure>                                  '+#13#10+
  '  <ProtectWindows>False</ProtectWindows>                                      '+#13#10+
  ' </ExcelWorkbook>                                                             '+#13#10+
  '  <Styles>                                                                 '+#13#10+
  '<Style ss:ID="Default" ss:Name="Normal">                                   '+#13#10+
  ' <Alignment ss:Vertical="Bottom"/>                                         '+#13#10+
  ' <Borders/>                                                                '+#13#10+
  ' <Font Z:CharSet="204"/>                                                   '+#13#10+
  ' <Interior/>                                                               '+#13#10+
  ' <NumberFormat/>                                                           '+#13#10+
  ' <Protection/>                                                             '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s28">                                                        '+#13#10+
  ' <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>                    '+#13#10+
  ' <Font Z:CharSet="204" Z:Family="Swiss" ss:Bold="1"/>                      '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s29">                                                        '+#13#10+
  ' <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>                    '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s30">                                                        '+#13#10+
  ' <Font Z:CharSet="204" Z:Family="Swiss" ss:Bold="1"/>                      '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s35">                                                        '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  ' </Borders>                                                                '+#13#10+
  '   <NumberFormat ss:Format="Fixed"/>                                       '+#13#10+
  '  </Style>                                                                 '+#13#10+
  '  <Style ss:ID="s37">                                                      '+#13#10+
  '    <NumberFormat ss:Format="Currency"/>                                   '+#13#10+
  '  </Style>                                                                 '+#13#10+
  '  <Style ss:ID="s39">                                                      '+#13#10+
  '<Borders/>                                                                 '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s44">                                                        '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
//  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  ' </Borders>                                                                '+#13#10+
  '   <NumberFormat ss:Format="Fixed"/>                                       '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s49">                                                        '+#13#10+
  ' <Borders/>                                                                '+#13#10+
  ' <NumberFormat ss:Format="Fixed"/>                                         '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s62">                                                        '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  ' </Borders>                                                                '+#13#10+
  ' <NumberFormat ss:Format="Fixed"/>                                         '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s64">                                                        '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  ' </Borders>                                                                '+#13#10+
  ' <NumberFormat ss:Format="0"/>                                             '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s65">                                                        '+#13#10+
  ' <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>                   '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  ' </Borders>                                                                '+#13#10+
  '<Font Z:CharSet="204" ss:Size="11"/>                                       '+#13#10+
  ' <NumberFormat ss:Format="0"/>                                             '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s66">                                                        '+#13#10+
  '<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>                    '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  ' </Borders>                                                                '+#13#10+
  ' <Font Z:CharSet="204" ss:Size="11"/>                                      '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s67">                                                        '+#13#10+
  ' <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>                   '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  '</Borders>                                                                 '+#13#10+
  ' <Font Z:CharSet="204" ss:Size="11"/>                                      '+#13#10+
  ' <NumberFormat/>                                                           '+#13#10+
  '</Style>                                                                   '+#13#10+
  '<Style ss:ID="s68">                                                        '+#13#10+
  '<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>                    '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>     '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  ' </Borders>                                                                '+#13#10+
  ' <Font Z:CharSet="204" ss:Size="11"/>                                      '+#13#10+
  ' <NumberFormat/>                                                           '+#13#10+
  '</Style>                                                                   '+#13#10+
  '  <Style ss:ID="s69">                                                      '+#13#10+
  ' <Borders>                                                                 '+#13#10+
  '  <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>   '+#13#10+
  '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>    '+#13#10+
  '  <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  '  <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>      '+#13#10+
  ' </Borders>                                                                '+#13#10+
  ' <NumberFormat ss:Format="Currency"/>                                      '+#13#10+
  '</Style>                                                                   '+#13#10+
  '</Styles>';
WORKSHEET_BEGIN =
  ' <Worksheet ss:Name="Дані накладної">                                          '+#13#10+
  '  <Table ss:ExpandedColumnCount="14" ss:ExpandedRowCount="999" Z:FullColumns="1"'+#13#10+
  ' Z:FullRows="1">                                                               '+#13#10+
  '      <Column ss:Index="3" ss:Width="145.25"/>                                 '+#13#10+
  '      <Column ss:Width="60.25"/>                                               '+#13#10+
  '      <Column ss:Index="6" ss:Width="90.25"/>                                  '+#13#10+
  '      <Column ss:Width="60.25"/>                                                  ';
WORKSHEET_END =
'   </Table>                                                                 '+#13#10+
'  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">         '+#13#10+
'   <Print>                                                                  '+#13#10+
'    <ValidPrinterInfo/>                                                     '+#13#10+
'    <PaperSizeIndex>9</PaperSizeIndex>                                      '+#13#10+
'    <HorizontalResolution>-3</HorizontalResolution>                         '+#13#10+
'    <VerticalResolution>0</VerticalResolution>                              '+#13#10+
'   </Print>                                                                 '+#13#10+
'   <ProtectObjects>False</ProtectObjects>                                   '+#13#10+
'   <ProtectScenarios>False</ProtectScenarios>                               '+#13#10+
'  </WorksheetOptions>                                                       '+#13#10+
' </Worksheet>                                                               ';
WORKBOOK_END = '</Workbook>';
ROWS_TITLE =
'   <Row ss:Index="11" ss:AutoFitHeight="0" ss:Height="13.5">                                               '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">№</Data></Cell>                     '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Код</Data></Cell>                   '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Назва товару</Data></Cell>          '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Кількість</Data></Cell>  '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Ціна без ПДВ</Data></Cell>             '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Ціна з ПДВ</Data></Cell>          '+#13#10+
'    <Cell ss:StyleID="s64"><Data ss:Type="String">Сума з ПДВ</Data></Cell>          '+#13#10+
'   </Row>';

function GenTitleData(doc_num,
                      doc_mark,
                      doc_date,
                      name_s,
                      name_d,
                      adr_s,
                      adr_d,
                      adr_dost,
                      tel_d,
                      oplata_type:string):string;
function GenRowData(line_no,
                    nomen_code,
                    nomen_name,
                    kilk,
                    price,
                    price_pdv,
                    sum:string):string;
function GenResultData(doc_sum_pdv,
                       staff_name,
                       disc_percent,
                       user_name,
                       doc_sum,
                       doc_pdv:string):string;

implementation
function CommaToPoint(str:string):string;
var i:integer;
begin
  for I := 1 to Length(str) do
    if str[i]=',' then str[i]:='.';
  Result := str;
end;

function GenTitleData(doc_num,
                      doc_mark,
                      doc_date,
                      name_s,
                      name_d,
                      adr_s,
                      adr_d,
                      adr_dost,
                      tel_d,
                      oplata_type:string):string;
begin
Result := xml_VER +#13#10+
          WORKBOOK_BEGIN +#13#10+
          BEGIN_DATA +#13#10+
          WORKSHEET_BEGIN +#13#10+
  ' <Row ss:AutoFitHeight="0" ss:Height="15.75">                                                                                        '+#13#10+
  '  <Cell ss:Index="2" ss:MergeAcross="2" ss:StyleID="s29"><Data ss:Type="String">Розхідна накладна</Data></Cell> '+#13#10+
  '  <Cell ss:StyleID="s39"><Data ss:Type="String">'+
doc_num  +
  ' / '+
doc_mark +
  ' </Data></Cell>                                                                                                '+#13#10+
  '      <Cell ss:StyleID="s39"/>     '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>         '+#13#10+
  '  <Cell ss:StyleID="s39"/>                                                                                      '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell ss:Index="3"><Data ss:Type="String">створена</Data></Cell>                                              '+#13#10+
  '  <Cell ss:MergeAcross="1" ss:StyleID="s28"><Data ss:Type="String">'+
doc_date +
  '</Data></Cell>                                                                                                '+#13#10+
  '    <Cell ss:StyleID="s39"/>               '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  ' </Row>                                    '+#13#10+
  ' <Row>                                     '+#13#10+
  '  <Cell ss:Index="6" ss:StyleID="s39"/>    '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  '  <Cell ss:StyleID="s39"/>                 '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                             '+#13#10+
  '  <Cell ss:MergeAcross="1" ss:StyleID="s28"><Data ss:Type="String">ПРОДАВЕЦЬ</Data></Cell>                      '+#13#10+
  '  <Cell ss:Index="6" ss:MergeAcross="1" ss:StyleID="s28"><Data ss:Type="String">ПОКУПЕЦЬ</Data></Cell>          '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell ss:StyleID="s29"><Data ss:Type="String">'+
name_s +
  '</Data></Cell>                                                                                                '+#13#10+
  '  <Cell ss:StyleID="s29"/>                                                                                      '+#13#10+
  '  <Cell ss:Index="6" ss:StyleID="s29"><Data ss:Type="String">'+
name_d +
  '</Data></Cell>                                                                                                 '+#13#10+
  '  <Cell ss:StyleID="s30"/>                                                                                      '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell><Data ss:Type="String">Адреса</Data></Cell>                                                             '+#13#10+
  '  <Cell><Data ss:Type="String">'+
adr_s +
  '</Data></Cell>                                                                                                '+#13#10+
  '  <Cell ss:Index="6" ss:StyleID="s39"><Data ss:Type="String">Адреса</Data></Cell>                               '+#13#10+
  '  <Cell ss:StyleID="s39"><Data ss:Type="String">'+
adr_d +
  '</Data></Cell>                                                                                                 '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell ss:Index="6" ss:StyleID="s39"><Data ss:Type="String">Доставка</Data></Cell>                             '+#13#10+
  '  <Cell ss:StyleID="s39"><Data ss:Type="String">'+
adr_dost +
  '</Data></Cell>                                                                                                '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell><Data ss:Type="String">Телефон</Data></Cell>                                                            '+#13#10+
  '  <Cell><Data ss:Type="String">'+
tel_d +
  '</Data></Cell>                                                                                                 '+#13#10+
  ' </Row>                                                                                                         '+#13#10+
  ' <Row>                                                                                                          '+#13#10+
  '  <Cell ss:Index="6" ss:StyleID="s39"><Data ss:Type="String">Форма розрахунку</Data></Cell>                     '+#13#10+
  '  <Cell ss:StyleID="s39"><Data ss:Type="String">'+
oplata_type +
  '</Data></Cell>                                                                                                 '+#13#10+
  ' </Row>                                                                                                         ';
end;

function GenRowData(line_no,
                    nomen_code,
                    nomen_name,
                    kilk,
                    price,
                    price_pdv,
                    sum:string):string;
begin
Result :=
    ' <Row ss:Height="14.25">                                             '+#13#10+
    '  <Cell ss:StyleID="s65"><Data ss:Type="Number">'+line_no+'</Data></Cell>                                 '+#13#10+
    '  <Cell ss:StyleID="s66"><Data ss:Type="String">'+
nomen_code+'</Data></Cell>                              '+#13#10+
    '  <Cell ss:StyleID="s66"><Data ss:Type="String">'+
nomen_name+'</Data></Cell>                              '+#13#10+
    '  <Cell ss:StyleID="s66"><Data ss:Type="String">'+
kilk+'</Data></Cell>                         '+#13#10+
    '  <Cell ss:StyleID="s69"><Data ss:Type="Number">'+
CommaToPoint(price)+'</Data></Cell>                                    '+#13#10+
    '  <Cell ss:StyleID="s69"><Data ss:Type="Number">'+CommaToPoint(price_pdv)+'</Data></Cell>                                   '+#13#10+
    '  <Cell ss:StyleID="s69"><Data ss:Type="Number">'+CommaToPoint(sum)+'</Data></Cell>                                     '+#13#10+
    ' </Row>                                            ';
end;

function GenResultData(doc_sum_pdv,
                       staff_name,
                       disc_percent,
                       user_name,
                       doc_sum,
                       doc_pdv:string):string;
begin
Result :=
  '   <Row ss:AutoFitHeight="0" ss:Height="15">                                   '+#13#10+
  '  <Cell ss:StyleID="s49"/>                                                                      '+#13#10+
  '  <Cell ss:StyleID="s62"/>                                                                      '+#13#10+
  '  <Cell ss:StyleID="s35"><Data ss:Type="String">Всього</Data></Cell>                            '+#13#10+
  '  <Cell ss:StyleID="s35"/>                                                                      '+#13#10+
  '  <Cell ss:StyleID="s35"/>                                                                      '+#13#10+
  '  <Cell ss:StyleID="s44"/>                                                                      '+#13#10+
  '  <Cell ss:StyleID="s69"><Data ss:Type="Number">'+
CommaToPoint(doc_sum_pdv)+'</Data></Cell>                   '+#13#10+
  ' </Row>                                                                                         '+#13#10+
  ' <Row>                                                                            '+#13#10+
  '  <Cell><Data ss:Type="String">Відповідальний</Data></Cell>                                     '+#13#10+
  '  <Cell ss:Index="3"><Data ss:Type="String">'+
staff_name+'</Data></Cell>                '+#13#10+
  ' </Row>                                                                                         '+#13#10+
  ' <Row>                                                                            '+#13#10+
  '  <Cell><Data ss:Type="String">Знижка:</Data></Cell>                                            '+#13#10+
  '  <Cell ss:Index="3"><Data ss:Type="String">'+
disc_percent+' %</Data></Cell>'+#13#10+
  '  <Cell ss:Index="6"><Data ss:Type="String">Виписав:__________</Data></Cell>                    '+#13#10+
  '  <Cell><Data ss:Type="String">'+
user_name+'</Data></Cell>                   '+#13#10+
  ' </Row>                                                                                         '+#13#10+
  ' <Row>                                                                                          '+#13#10+
  '  <Cell><Data ss:Type="String">Товарів на суму:</Data></Cell>                                   '+#13#10+
  '  <Cell ss:Index="3" ss:StyleID="s37"><Data ss:Type="Number">'+
CommaToPoint(doc_sum)+'</Data></Cell>'+#13#10+
  ' </Row>                                                                                         '+#13#10+
  ' <Row>                                                                                          '+#13#10+
  '  <Cell><Data ss:Type="String">Сума ПДВ:</Data></Cell>                                          '+#13#10+
  '  <Cell ss:Index="3" ss:StyleID="s37"><Data ss:Type="Number">'+
CommaToPoint(doc_pdv)+'</Data></Cell>'+#13#10+
  ' </Row>                                                                                         '+#13#10+
  ' <Row>                                                                                          '+#13#10+
  '  <Cell><Data ss:Type="String">Сума до сплати:</Data></Cell>                                    '+#13#10+
  '  <Cell ss:Index="3" ss:StyleID="s37"><Data ss:Type="Number">'+
CommaToPoint(doc_sum_pdv)+'</Data></Cell>'+#13#10+
  ' </Row> '+#13#10+
  WORKSHEET_END +#13#10+
  WORKBOOK_END; 
end;

end.
