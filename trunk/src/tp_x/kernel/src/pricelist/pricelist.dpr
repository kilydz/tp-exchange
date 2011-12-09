library pricelist;

uses
  SysUtils,
  Classes,
  sql_price in 'sql_price.pas' {fsql_price},
  pricejournal in 'pricejournal.pas' {fpricejournal},
  price_print in 'price_print.pas' {fPriceDialog};

{$R *.res}

exports PricesBySQL;
exports PriceJournalShow;
exports PricesPrint;

begin
end.
