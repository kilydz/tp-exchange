unit pricelist_h;

interface
uses Forms, kernel_h;



procedure Prices(id_list: AnsiString; prm: ZVelesInfoRec);
   external 'pricelist.dll' name 'Prices';

procedure PricesBySQL(sql: string; prm: ZVelesInfoRec);
   external 'pricelist.dll' name 'PricesBySQL';

{procedure Pereocinka(prm: TParamCin);
   external 'Cinnik_m.dll' name 'Pereocinka';

procedure PricesByDoc(prm: TParamCinByDoc);
   external 'Cinnik_m.dll' name 'PricesByDoc';
 }
implementation

end.
