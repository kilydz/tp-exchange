INSERT INTO MAKER (MAKER_ID, MAKER_NAME, COLOR) VALUES (0, 'Не відомо', NULL);
commit work;

INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (1, 'шт');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (2, 'л');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (3, 'кг');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (4, 'м');
commit work;

INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (0, 'Звичайна група');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (1, 'Алкоголь (група В)');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (2, 'Тютюн');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (3, 'Медикаменти');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (4, 'Тара');
commit work;

INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (1, 'Не оподатковується', 0);
INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (2, 'ПДВ від націнки', 0.2);
INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (3, 'ПДВ від суми', 0.2);
commit work;

INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (1, 'Прихідна накладна');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (2, 'Розхідна накладна');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (4, 'Повернення від покупця');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (11, 'Чек');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (6, 'Розхідне внутрішнє переміщення');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (12, 'Акт переоцінки вхідних цін');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (14, 'Корегуюча накладна');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (15, 'Акт списання');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (17, 'Повернення постачальникові');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (10, 'Рахунок');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (16, 'Корегуюча по націнках');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (7, 'Прихідне внутрішнє переміщення');
commit work;

INSERT INTO T_DECR_TYPE (DECR_TYPE_ID, NAME) VALUES (0, 'Невизначена група');
commit work;

INSERT INTO T_DECREASE (DECR_ID, DECR_NAME, DECR_VALUE, DECR_TYPE_ID) VALUES (0, 'Без убутку', 0, 0);
commit work;

INSERT INTO DISCONT (DISCONT_ID, PROCENT) VALUES (0, 0);
commit work;

INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (0, '', '');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (1, 'Товариство з обмеженою відповідальністю', 'ТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (2, 'Приватний підприємець', 'ПП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (3, 'Приватне підприємство', 'ПП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (4, 'Закрите акціонерне товариство', 'ЗАТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (5, 'Відкрите акціонерне товариство', 'ВАТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (6, 'Виробнича комерційна фірма', 'ВКФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (7, 'Науково виробниче підприємство', 'НВП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (8, 'Фізична особа-підприємець', 'ФОП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (9, 'Суб''єкт підпр. діяльності-фізична особа', 'СПБ-ФО');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (10, 'Приватна фірма', 'ПФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (11, 'Торговий дім', 'ТД');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (12, 'Торгово-виробнича фірма', 'ТВФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (13, 'Дочірнє підприємство', 'ДП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (14, 'Комерційна фірма', 'КЦ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (15, 'Спільне підприємство', 'СП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (16, 'Акціонерне товариство', 'АТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (18, 'Підприємець', 'П-ць');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (17, 'Акціонерне товариство закритого типу', 'АТЗТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (19, 'Філія Товариства з обмеженою від-тю', 'Філія ТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (20, 'Cільськогосподарське приватне підприємство', 'СПП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (21, 'Приватне виробничо-торгове підприємство', 'ПВТП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (22, 'Виробничо-комерційне підприємство', 'ВКП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (23, 'Підприємство у формі ТзОВ', 'П-во');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (24, 'Фермерське господарство', 'ФГ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (25, 'СГ товариство з обмеженою відповідальністю', 'СГ ТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (26, 'Приватна комерційна фірма', 'ПКФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (27, 'Відкрите акціонерне товаристо закритого типу', 'ВАТ ЗТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (28, 'Виробничо-транспортне підприємство', 'ВТП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (29, 'Приватне виробничо-комерційне підприємство', 'ПВКП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (30, 'Закрите акціонерне с.г. підприємство', 'ЗАСГП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (31, 'Філія Дочірнього підприємства', 'ФДП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (32, 'Командитне товариство', 'КТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (33, 'Приватна виробничо-комерційна фірма', 'ПВКФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (35, 'Філія Закритого акціонерного товариства', 'Філія ЗАТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (34, 'Дочірне підприємство з іноземними інвестиціями', 'ДПІІ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (36, 'Філія Приватного підприємства', 'Філія ПП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (37, 'Філія Виробничо-торгового підприємства', 'Філія ВТП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (38, 'Іноземне підприємство', 'ІП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (39, 'Фізична особа', 'ФО');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (40, 'Приватне під-во виробничо-комерційна фірма', 'ППВКФ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (41, 'Колективне сільськогосподарське підприємство', 'КСП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (42, 'Дочірнє підприємство ТзОВ', 'ДПТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (44, 'Спільне Українсько-Польське ТзОВ', 'СПТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (43, 'Дочірнє підприємство ВАТ', 'ДПВАТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (45, 'Приватне корпоративне підприємство', 'ПКП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (46, 'Селянське (фермерське) господарство', 'СФГ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (47, 'Приватне акціонерне товариство', 'ПрАТ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (48, 'Багатогалузеве підприємство', 'БП');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (49, 'Структурний підрозділ ТзОВ', 'СПТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (50, 'Філія Спільного підприємства', 'Філія Сп');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (51, 'Сільськогосподарське товариство з обмеженою відповідальністю', 'СгТзОВ');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (52, 'Публічне акціонерне товариство', 'ПАТ');
commit work;

INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (1, 'Склад');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (2, 'Постачальник');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (3, 'Покупець');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (5, 'Внутрішній клієнт');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (4, 'Постачальник і покупець');
commit work;

INSERT INTO GRPC (GRPC_ID, GRPC_NAME, PREW_GRPC_ID, GRPC_CODE) VALUES (1, 'Службові', NULL, NULL);
commit work;

INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Діамантбанк"   ', '320854');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Експрес-Банк" ', '322959');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Енергобанк" ', '300272');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Київська Русь" ', '319092');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "КЛІРИНГОВИЙ ДІМ" ', '300647');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "ПОЛТАВА-БАНК" ', '331489');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Синтез" ', '322711');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "УКООПСПІЛКА" ', '322625');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "УкрБізнесБанк" ', '334969');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Укргазбанк" ', '320478');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "Укргазпромбанк" ', '320843');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АБ "УКРКОМУНБАНК" ', '304988');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АК "ПФБ" ', '331768');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Альянс" ', '300119');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Золоті ворота" ', '351931');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "ІНДУСТРІАЛБАНК" ', '313849');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Інтеграл-банк" ', '320735');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "НОВИЙ" ', '305062');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "ПОРТО-ФРАНКО" ', '328180');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Укрсоцбанк" ', '300023');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Фінбанк"   ', '328685');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "ЧБРР" ', '384577');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АКБ "Юнекс" ', '322539');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('Акціонерний банк "Південний" ', '328209');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "АРТЕМ-БАНК" ', '300885');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Банк "Національні інвестиції" ', '300498');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Банк "ТАВРИКА" ', '300788');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Банк "Фінанси та Кредит" ', '300131');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "БАНК БОГУСЛАВ" ', '380322');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Банк Велес" ', '322799');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "БАНК РЕНЕСАНС КАПІТАЛ" ', '380010');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "БРОКБІЗНЕСБАНК" ', '300249');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Дельта Банк" ', '380236');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Ерсте Банк" ', '380009');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ЄВРОГАЗБАНК" ', '380430');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Златобанк" ', '380612');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ІМЕКСБАНК" ', '328384');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "КБ "Володимирський" ', '337933');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "КБ "Експобанк" ', '322294');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "КБ "СОЮЗ"   ', '380515');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "КІБ" ', '322540');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "КомІнвестБанк" ', '312248');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "МетаБанк" ', '313582');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "МІСТО БАНК" ', '328760');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "НК БАНК" ', '322432');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ОКСІ БАНК" ', '325990');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ОТП Банк" ', '300528');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ПІРЕУС БАНК МКБ" ', '300658');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ПроКредит Банк" ', '320984');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Райффайзен Банк Аваль" ', '300335');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "РЕГІОН-БАНК" ', '351254');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "РОДОВІД БАНК" ', '321712');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "СБЕРБАНК РОСІЇ" ', '320627');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Сведбанк Інвест" (приватне) ', '320650');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Сведбанк" (публічне) ', '300164');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Українська фінансова група" ', '300926');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Укрбудінвестбанк" ', '380377');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Укрексімбанк"   ', '322313');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Укрінбанк" ', '300142');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "УкрСиббанк" ', '351005');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "ФІНРОСТБАНК" ', '328599');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ "Фортуна-банк" ', '300904');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ БАНК "МЕРКУРІЙ" ', '351663');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('АТ КБ "ТК КРЕДИТ" ', '322830');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('Банк "Демарк" ', '353575');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "АБ "Бізнес Стандарт" ', '339500');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "Агрокомбанк" ', '322302');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "АКБ "КАПІТАЛ" ', '334828');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "БАНК 3/4" ', '380645');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "БАНК КІПРУ" ', '320940');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "БГ БАНК" ', '320995');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "БМ Банк" ', '380913');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ВіЕйБі Банк" ', '380537');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "Дойче Банк ДБУ" ', '380731');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ЕРДЕ БАНК"   ', '380667');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ЄБРФ" ', '380292');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ЄВРОПРОМБАНК" ', '377090');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "КБ "Актив-банк" ', '300852');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "КБ "ПРОМЕКОНОМБАНК" ', '334992');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "Кредит Оптима Банк" ', '380571');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "КРЕДИТВЕСТ БАНК" ', '380441');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "Міжнародний Інвестиційний Банк" ', '380582');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "Ощадбанк" ', '300465');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ПтБ" ', '380388');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ТММ-Банк" ', '300896');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "УПБ" ', '300205');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ФІНЕКСБАНК"   ', '380311');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ "ХК БАНК" ', '307123');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ АБ "Старокиївський банк" ', '321477');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ АСТРА БАНК ', '380548');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ Банк "Олімпійська Україна" ', '322324');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ Банк "ТРАСТ" ', '380474');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ ВТБ Банк ', '321767');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ КБ "Глобус" ', '380526');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ КБ "Інтербанк" ', '300216');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ КБ "Надра" ', '320003');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ КБ "Стандарт" ', '380690');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ КБ "Хрещатик" ', '300670');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ РЕАЛ БАНК ', '351588');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ВАТ УніКредит Банк ', '303536');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('Державне казначейство України ', '820172');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('Національний Банк України ', '300001');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АБ "РАДАБАНК" ', '306500');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АБ Приватінвест" ', '353489');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "А-БАНК" ', '307770');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АВАНТ - БАНК" ', '380708');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АКБ "КИЇВ" ', '322498');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АКБ "КОНКОРД" ', '307350');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АКБ "Траст-капітал" ', '380106');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АКБ Банк" ', '331100');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АКТАБАНК" ', '307394');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АЛЬФА-БАНК" ', '300346');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "АПЕКС - БАНК" ', '380720');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "БАНК "ГРАНТ" ', '351607');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк "Український капітал" ', '320371');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк інвестицій та заощаджень" ', '380281');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк Камбіо"   ', '380399');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "БАНК КРЕДИТ ДНІПРО" ', '305749');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "БАНК НАЦІОНАЛЬНИЙ КРЕДИТ" ', '320702');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк Петрокоммерц-Україна" ', '300120');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк Руский Стандарт" ', '380418');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Банк Столиця" ', '380623');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "БАНК ФОРУМ" ', '322948');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "БТА Банк" ', '321723');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ВСЕУКРАЇНСЬКИЙ БАНК РОЗВИТКУ" ', '380719');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Д-М Банк" ', '380689');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ДОНГОРБАНК" ', '334970');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ЄКБ" ', '305987');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Західінкомбанк" ', '303484');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ЗЕМБАНК" ', '351652');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ІНГ Банк Україна" ', '300539');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ІНДЕКС-БАНК" ', '300614');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ІНПРОМБАНК" ', '351878');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "Земельний Капітал" ', '305880');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "ІНВЕСТБАНК" ', '328210');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "ПІВДЕНКОМБАНК" ', '335946');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "Преміум" ', '339555');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "СКБ" ', '388313');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "УФС" ', '377777');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КБ "ФІНАНСОВА ІНІЦІАТИВА" ', '380054');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КІБ Креді Агріколь" ', '300379');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КЛАСИКБАНК" ', '306704');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Комерційний банк "Даніель" ', '380980');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КОНВЕРСБАНК" ', '339339');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КРЕДИТ ЄВРОПА БАНК" ', '380366');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Кредитпромбанк" ', '300863');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "КРЕДОБАНК" ', '325912');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Легбанк" ', '300056');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "МЕГАБАНК" ', '351629');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "МОТОР-БАНК" ', '313009');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Перший Інвестиційний Банк" ', '300506');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Плюс Банк"   ', '336310');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ПРАЙМ - БАНК" ', '300669');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ПРОФІН БАНК" ', '334594');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "РАДИКАЛ БАНК" ', '319111');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "СИГМАБАНК" ', '307305');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Сітібанк" ', '300584');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Терра Банк" ', '380601');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "Універсал Банк" ', '322001');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ "ФОЛЬКСБАНК" ', '325213');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ АБ "СТОЛИЧНИЙ" ', '397133');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ АКБ "Аркада" ', '322335');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ АКБ "Львів" ', '325268');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ Банк "Контракт" ', '322465');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ Банк "Морський" ', '324742');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ КБ "ЄВРОБАНК"   ', '380355');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ КБ "ПРИВАТБАНК" ', '305299');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТ Промінвестбанк ', '300012');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПАТКБ "ПРАВЕКС-БАНК" ', '321983');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('Полікомбанк ', '353100');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПрАТ "ВДЦП" ', '380742');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПуАТ "КБ "Акордбанк" ', '380634');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПуАТ "СЕБ Банк" ', '300175');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ПУБЛІЧНЕ АКЦІОНЕРНЕ ТОВАРИСТВО "ПУМБ" ', '334851');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('СП БАНК ', '304706');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('ТОВ "Діалогбанк"   ', '307112');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('УДППЗ "Укрпошта" ', '380559');
commit work;

INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (1, '1000001', 'Магазин', 'Магазин', 1, '00000000', 1, '', '', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 1, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (2, '1000002', 'Резерв', 'Резерв', 1, '10001', 1, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 2, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (98, '1000098', 'Ревізія', 'Ревізія', 2, '10001', 1, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 98, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (100, '1000000', 'Покупець', 'Покупець', 3, '0', 0, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '1234', 0, 0, 0, 1, 100, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (99, '1000099', 'Дисконт', 'Дисконт', 3, '0', 0, '', '0', '', '', 1, NULL, 0, '2005-02-16', '', '', 0, '', '', 0, 0, 0, 1, 99, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (95, '1000095', 'Склад корегуючих по націнках', 'Склад корегуючих по націнках', 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2009-04-01', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, NULL, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (96, '1000096', 'Склад сировини', 'Склад сировини', 1, '10001', 0, '', '0', '', '', 1, NULL, 0, '2008-03-05', '', '', 0, '', '', 0, 0, 0, 1, 9996, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (97, '1000097', 'Кулінарний цех', 'Кулінарний цех', 1, '10001', 0, NULL, '0', '', NULL, 1, NULL, 0, '2008-03-05', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, 9997, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (94, '1000094', 'Акт списання', 'Акт списання', 1, '10001', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2009-08-30', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, 9994, 1, 1);
commit work;

INSERT INTO OBJECTS (OBJECTS_ID, OBJECTS_NAME, M_SALE, CLIENTS_ID, AROUND_PRICE_PDV)
             VALUES (1, 'Магазин', 'Y', 1, 100);
commit work;

INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (1, 'Готівка', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (2, 'Перерахунок', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (3, 'Взаємозалік', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (4, 'Мішана', 1);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (0, 'Немає', 0);
commit work;

INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_documents', 'yes', 'Чи відображати в довіднику документів колонку наявності податкових (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_general', 'yes', 'Чи відображати колонку з аналітичним відсотком націнки (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_general', 'yes', 'Чи відображати колонку з офіційним відсотком націнки (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_general', '01.01.2006', 'Нижня межа закритого періода');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_general', '01.02.2006', 'Верхня межа закритого періода');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_nomen', 'no', 'Дозволити редагувати ЦР в картці товару (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_general', 'td16', 'yes - дозволяти злиття мінусів, no - не дозволити, td16 - Створювати корегуючі накладні');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_nomens', 'yes', 'Чи виводити додаткову інформацію про товар в довідниках товарів');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_nomen', 'no', 'Чи дозволити перенесення назв при створ. подібних (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'export_1c', 'yes', 'Чи відображати суму X при експорті (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_nomen', 'yes', 'Заборонити створення аналітичної картки за замовчуванням');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'export_1c', 'no', 'Чи розбивати суми по спецгрупам');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'revision_revision_r', 'plus', 'Дія, яка виконується при імпорті даних з ЛБД (rewrite - фактична к-сть замінюється, plus - фактична к-сть з ЛБД додається до вже наявної в базі)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_nomen', 'no', 'Режим прийому номенклатури (yes/ins_only/upd_exc_name/no)   (При yes номенклатура з ЦБД потрапляє у номенклатуру магазину,   а також назви номенклатури магазину замінюються на назви з ЦБД,   при ins_only - лише потрапляють нові товари,   при upd_exc_name - потрапляють нові товари, а також змінюються всі атрибути товару крім   назви та короткої назви)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_nomen', 'no', 'Заборонити маніпуляції з товаром, крім зміни коду, ціни, та групи (Для централізації товару) (yes/without_w3_only/no)(При without_w3_only забороняються маніпуляції зі зв''язаним товаром)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_nomens', 'yes', 'Відображати пункт меню "Друк прайс-листів"');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (6, 'store_nomen', 'no', 'Чи синхронізувати додаткові властивості товару (yes/no) (crt_markup - Створювати акти переоцінки на товари в яких змінились рекомендована ціна, або націнка)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_documents', '0', 'Чи резервувати товар фіксуванням рахунка (no/к-сть днів резервування(числом))(по замовчуванню 1 день)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_documents', 'yes', 'Чи брати ОСТАННЮ ЦЗ в якості ЦЗ відносно якої відбувається націнка (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_clients', 'no', 'Заборонити маніпуляції з клієнтами типу "Покупець"(Для централізації клієнтів) (yes- Заборонити,srv-Дозволити для клієнтів із ЗКПО на 100)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_clients', 'no', 'Повна синхронізація клієнтів (yes-Табличка clients наповнюється даними)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_maker', 'no', 'Заборонити створювати/радагувати торгові марки');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_documents', 'no', 'Чи встановлювати обмеження на редагування дати, у всіх крім прихідної документах (no-ні, число -к-сть днів)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_documents', 'yes', 'Чи дозволити створювати прихідну накладну (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (400, 'store_nomen', 'no', 'Заборонити створення нових товарів і т.д. для синхронізації');
commit work;

INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (1, ' 6 7 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (2, ' 0 1 5 8 9 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (4, ' 6 7 15 16 29 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (6, ' 2 0 4');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (10, ' 0 5 8 9 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (11, ' 0 5 8 9 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (17, ' 0 5 8 9 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (15, ' 0 4 ');
INSERT INTO T_INVOICE_TYPES (TYPEDOC_ID, INVOICE_TYPES)
                     VALUES (7, ' 30');
commit work;

INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (0, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'execute procedure PS_ROLL_TAX_ADD(:DOCUMENT_ID)', 'tax*.frf', 'Податкова накладна', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (1, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'given*.frf', 'Видаткова накладна', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (2, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'movingOUT*.frf', 'Розхідне внутрішнє переміщення', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (3, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'return*.frf', 'Повернення постачальнику', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (4, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'chargeoff*.frf', 'Акт списання', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (11, 'select * from PS_MARKUP_PRINT (:DOCUMENT_ID )', 'select * from PS_MARKUP_RECORD_PRINT (:DOCUMENT_ID )', 'UPDATE T_MARKUPS SET PRINT_CNT = PRINT_CNT + 1  WHERE MARKUP_ID = :DOCUMENT_ID', 'markup*.frf', 'Акт переоцінки', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (5, 'select * from S_FAKTURA(:document_id)', 'select * from S_DOCREC_VIEW(:document_id)', NULL, 'faktura*.frf', 'Рахунок-фактура', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (6, 'SELECT * FROM S_PRN_RECEIPT(:DOCUMENT_ID)', 'SELECT * FROM S_PRN_RECEIPT_DTL(:DOCUMENT_ID, 1)', NULL, 'receiptout*.frf', 'Прихідна накладна по ЦР', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (7, 'SELECT * FROM S_PRN_RECEIPT(:DOCUMENT_ID)', 'SELECT * FROM S_PRN_RECEIPT_DTL(:DOCUMENT_ID, 1)', NULL, 'receiptin*.frf', 'Прихідна накладна по ЦЗ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (10, NULL, 'SELECT * FROM S_REV_RECORDS_VIEW(:DOCUMENT_ID)', NULL, 'datarevision*.frf', 'Бланк збору даних ревізії', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (8, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'certificate*.frf', 'Додаток до видаткової накладної (сертифікат)', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (9, 'select * from PS_SW_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by OSG_ID, NOMEN_NAME', NULL, 'akt*.frf', 'Акт виконаних робіт', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (12, 'select * from PS_LC_PACT_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'pact*.frf', 'Договір ЛЦ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (13, 'select * from PS_LC_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'lc_akt*.frf', 'Акт ЛЦ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (14, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'execute procedure PS_ROLL_TAX_ADD(:DOCUMENT_ID)', 'lc_tax*.frf', 'Податкова накладна ЛЦ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (16, 'select dh.*, dh.name_s as SRC_FULLNAME, dh.name_d as DST_FULLNAME,         dh.shortname_s as SRC_NAME, dh.shortname_d as DST_NAME,         dh.oauth_name as auth_name   from PS_DOC_HEADER_VIEW(:DOCUMENT_ID) dh', 'select dp.*, dp.p_in_sum/dp.kilk as price_in, dp.p_in_sum_vat/dp.kilk as price_in_vat,         dp.out_price as price_out, dp.out_price_pdv as price_out_vat    from ps_docrec_print(:DOCUMENT_ID) dp order by docrec_id', NULL, 'breturning*.frf', 'Повернення від покупця', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (15, 'select * from PS_LC_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'lc_in_akt*.frf', 'Акт ЛЦ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (17, 'SELECT * FROM PS_PRODUCTION_DOC_HEADER(:DOCUMENT_ID)', 'SELECT * FROM PS_PRODUCTION_DOCREC_PRINT(:DOCUMENT_ID)', NULL, 'internal_moving*.frf', 'Накладна на внутрішнє переміщення сировини', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (18, 'SELECT * FROM PS_PRODUCTION_DOC_HEADER(:DOCUMENT_ID)', 'SELECT * FROM PS_PRODUCTION_DOCREC_PRINT(:DOCUMENT_ID)', NULL, 'technological*.frf', 'Технологічна накладна', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (19, 'select * from PS_CALCULATION_HEADER(:DOCUMENT_ID)', 'select * from PS_CALCULATION_PRINT(:DOCUMENT_ID) order by onomen_name', NULL, 'calc_kard*.frf', 'Калькуляційна картка', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (20, 'select * from PS_CALCULATION_HEADER(:DOCUMENT_ID)', 'select * from PS_CALCULATION_PRINT(:DOCUMENT_ID) order by onomen_name', NULL, 'tech_kard*.frf', 'Технологічна картка', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (21, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_DEBITORKA_CLNT_FULL(:date0, :date1, :document_id)', NULL, 'clnt_deb*.frf', 'Рахунки з клієнтом', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (22, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_KREDITORKA_CLNT_FULL(:date0, :date1, :document_id)', NULL, 'clnt_cred*.frf', 'Рахунки з постачальником', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (23, 'select * from PR_RALASE_NOMEN_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_RALASE_NOMEN_PERIOD(:date0, :date1, :document_id)', NULL, 'ralase_nomen*.frf', 'Товарний звіт за період', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (24, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_INVOICE_PAYS_DEBT(:date0, :date1, :document_id)', NULL, 'inv_pays_debt*.frf', 'Проплати по накладних з клієнтом', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (25, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_INVOICE_PAYS_KRED(:date0, :date1, :document_id)', NULL, 'inv_pays_kred*.frf', 'Проплати по накладних з постачальником', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (26, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_LIST_CHARGES(:date0, :date1, :document_id)', NULL, 'lst_charges*.frf', 'Перелік видатків по складу', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (27, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_REGISTER_INVOICES_OUT(:date0, :date1, :document_id)', NULL, 'registr_invoices*.frf', 'Реєстр видаткових накладних', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (28, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by DOCREC_ID', NULL, 'returning_buy*.frf', 'Повернення від покупця', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (29, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'wsEdition*.frf', 'Корегуюча податкова', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (31, 'select * from ps_autoorder_header_view(:document_id)', 'select * from PS_AO_RECORDS_PRINT(:document_id) where oordered != 0 order by onomen_name', 'update autoorders set print_cnt = print_cnt + 1 where autoorder_id = :document_id', 'order*.frf', 'Замовлення товару', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (30, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'movingIN*.frf', 'Прихідне внутрішнє переміщення', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (32, 'select * from PR_DOCUMENTS_PERIOD_HEADER(:DOCUMENT_ID, :DATE0, :DATE1, 1)', 'select *  from PR_DOCUMENTS_PERIOD(:date0, :date1, :document_id, 1)', NULL, 'documents_period*.frf', 'Звіт в розрізі документів БЕЗ ПДВ', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (33, 'select * from PR_DOCUMENTS_PERIOD_HEADER(:DOCUMENT_ID, :DATE0, :DATE1, 3)', 'select *  from PR_DOCUMENTS_PERIOD(:date0, :date1, :document_id, 3)', NULL, 'documents_period*.frf', 'Звіт в розрізі документів З ПДВ', NULL);
commit work;

INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (1, 'Гості');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (2, 'Адміністратори');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (3, 'Касир');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (4, 'Старший касир');
commit work;

INSERT INTO T_USERS (USER_ID, USER_LOGIN, USER_KEYWORD, RIGHTS_GRP_ID, USER_SURNAME, USER_FIRST_NAME, USER_SECOND_NAME, NICK, LAST_DOC, SIGNATURE) VALUES (0, 'SYSDBA', 'masterkey', 2, 'Адміністратор БД', '', '', 'sys', 1, '1');
commit work;

INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1, 'Вхід до модуля "Склад"', -1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30000, 'Доступ до довідника "Користувачі"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30006, 'Зміна паролів', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30005, 'Деактивація користувачів', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30004, 'Активація користувачів', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30001, 'Створення нового користувача', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30002, 'Редагування користувача', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30003, 'Видалення користувача', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40000, 'Доступ до довідника "Групи користувачів"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40001, 'Створення нової групи', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40002, 'Редагування групи', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40003, 'Видалення групи', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30007, 'Експорт даних довідника "Користувачі"', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60000, 'Доступ до довідника "Звіти"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100100, 'Друк цінників по документах', 100000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100000, 'Друк', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100110, 'Друк накладних', 100000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100200, 'Довідник "Документи"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100300, 'Довідник "Товари"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100400, 'Довідник "Клієнти"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100500, 'Довідник "Акти переоцінки"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100600, 'Довідник "Дисконт"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100700, 'Довідник "Ревізії"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100800, 'Довідник "Автозамовлення"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1000000, 'Довідники', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1000001, 'Зняття блокування', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100201, 'Створення та редагування', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100202, 'Видалення документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100401, 'Створення та редагування клієнта', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100402, 'Видалення клієнта', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100203, 'Фіксування документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100204, 'Розфіксовування документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100205, 'Відвантаження документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100206, 'Зняття відвантаження', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100301, 'Створення та редагування товару', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100302, 'Видалення товару', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100207, 'Бачити неактвних відповідальних', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100310, 'Бачити націнку в довіднику', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100311, 'Бачтит ЦЗ і СЗ', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900000, 'Експорт в 1С', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900100, 'Робити кінцеву вигрузку', 900000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900110, 'Бачити довідник періодів', 900000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (120004, 'Об''єднання даних клієнтів', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60010, 'Кредиторська заборгованість', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60020, 'Дебіторська заборгованість', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60040, 'По видаленим документам', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60050, 'По документам', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100208, 'Експорт довідника', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100209, 'Експорт документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100312, 'Експорт довідника', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100710, 'Експорт документа', 100700);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100702, 'Видалення ревізії', 100700);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100810, 'Експорт документа', 100800);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800001, 'Вхід до модуля "Каса"', -1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100802, 'Видалення автозамовлення', 100800);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800100, 'Створення повернень', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800101, 'Створення чеків', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800102, 'Редагування повернень', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800103, 'Редагування чеків', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800120, 'Касовий апарат', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800104, 'Редагування розхідних', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800140, 'Бачити повернення', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800130, 'Бачити чужі документи', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800141, 'Бачити чеки', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800142, 'Бачити розхідні', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800131, 'Список документів', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100214, 'Підтвердження істиності документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100210, 'Фіксування документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100211, 'Розфіксування документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100212, 'Відвантаження документа', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100213, 'Зняття відвантаження', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100502, 'Видалення акту переоцінки', 100500);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100313, 'Бачити "невидимий" товар', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100314, 'Редагувати тип товару', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800143, 'Підтверджувати вилучення товарної позиції', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800144, 'Вилучати товарну позицію без підтвердження', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100315, 'Об''єднувати товари', 100300);
commit work;

execute procedure PA_ADMIN_RIGHTS_SET;
commit work;

INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (11, 'Звіт по типу ПДВ по групам', 'select rr.rgrp_id as rgrp_id, rr.rgrp_name as grp_name,         sum(rr.rprihod_k) as rprihod_k, sum(rr.rprihod_s) as rprihod_s,         sum(rr.rrashod_k) as rrashod_k, sum(rr.rrashod_s) as rrashod_s,         sum(rr.rrashod_s_pdv) as rrashod_s_pdv, sum(rr.rin_sum) as rin_sum,         sum(rr.rprihod_s_pdv) as rprihod_s_pdv,         sum(rr.RPDV) as pdv,         sum(rr.RNACINKA) as nacinka,         avg(rr.rper_nac) as per_nac,         avg(rr.rper_nac_ofic) as per_nac_ofic,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from PR_RALASETYPEPDV_BYGROUP(:date_begin, :date_end, 1, :grp_id) rr         left join grp g on g.grp_id = rr.rgrp_id   where rr.rtype_pdv in (:mn_typepdv)   group by rr.rgrp_id, rr.rgrp_name, g.grp_fullname   order by rr.rgrp_name', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (12, 'Звіт по видаленим документам і позицій із них', 'select * from pr_doc_del(:date_begin,:date_end)', NULL, 60040);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (19, 'Звіт по залишках товару', 'select * from pr_nomensrests(:idate)', 'Звіт, який по даті показує залишки товару та ціну реалізаці на визначену дату', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (20, 'Товар із штрихкодом для ревізії', 'select ocode, ofull_name, obarcode, orest, oprice_out, ogrp_name from pr_nomen_with_barcode(:id,0)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (21, 'Інвентаризаційна відомість з кількістю', 'select * from pr_revision_list(:idate)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (22, 'Звіт по невідвантажених документах', 'select d.document_id, d.doc_num from documents d  where d.doc_date between :idate0 and :idate1 and  d.typedoc_id !=11 and       d.doc_lock < 2', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (1, 'Звіт по документах', 'select rsd.typedoc_name, rsd.doc_date, rsd.doc_num,                         sum(rsd.sum_in) as sum_in,                          sum(rsd.sum_in_pdv) as sum_in_pdv,                         sum(rsd.sum_out) as sum_out,                         sum(rsd.sum_out_pdv) as sum_out_pdv, rsd.client_name                   from rs_documents(:date_begin, :date_end) rsd                   group by rsd.typedoc_name, rsd.doc_date, rsd.doc_num, rsd.client_name                   order by rsd.doc_num, rsd.typedoc_name, rsd.doc_date', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (23, 'Звіт по реалізації по дисконтних картках за період', 'select odocument_id, okardcode, oname, opercent, odoc_date, odoc_time, osum_out_pdv from pr_discount_ralase(:idate0, :idate1)', 'Звіт по реалізації по дисконтних картках за період', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (27, 'Звіт по товарам , що не потрапили в ревізію', 'select * from PR_NOMEN_REV (:idate0,:idate1,:igrp_id)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (28, 'Звіт по реалізації продажів', 'select rs.nomen_code, rs.nomen_name, rs.ogrp_name,         around3(sum(rs.r_k)) r_k, around3(sum(rs.r_s_out)) r_s_out,         around3(sum(rs.e_k) * pp_out.oprice) e_s_out,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from pr_ralase_sales(:date_in, :date_out, :ingrp_id, :flag0) rs         left join grp g on g.grp_id = rs.ogrp_id,         ps_price_by_date(rs.nomen_id, :date_out) pp_out   group by rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,            pp_out.oprice, g.grp_fullname', 'Звіт по реалізації продажів', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (26, 'Товарний звіт із торговими націнками', 'select rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,         around3(sum(rs.b_k)) b_k,         around3(sum(rs.e_s_in) - sum(rs.p_s_in) + sum(rs.r_s_in)) b_s_in,         around3(sum(rs.b_k) * pp_in.oprice) b_s_out,         around3(sum(rs.b_k) * pp_in.oprice - (sum(rs.e_s_in) - sum(rs.p_s_in) + sum(rs.r_s_in))) b_tn,         around3(sum(rs.p_k)) p_k, around3(sum(rs.p_s_in)) p_s_in,around3(sum(rs.p_s_out)) p_s_out, around3(sum(rs.p_s_out) - sum(rs.p_s_in)) p_tn,         around3(sum(rs.r_k)) r_k, around3(sum(rs.r_s_in)) r_s_in, around3(sum(rs.r_s_out)) r_s_out, around3(sum(rs.r_s_out) - sum(rs.r_s_in)) r_tn,         around3(sum(rs.r_s_vat)) r_s_vat,         around3(sum(rs.e_k)) e_k,         around3(sum(rs.e_s_in)) e_s_in, around3(sum(rs.e_k) * pp_out.oprice) e_s_out, around3((sum(rs.e_k) * (pp_out.oprice)) - sum(rs.e_s_in)) e_tn,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from pr_ralase_nomen_v2(:date_in, :date_out, :ingrp_id, :flag0) rs         join ps_price_by_date(rs.nomen_id, :date_in) pp_in on 1=1         join ps_price_by_date(rs.nomen_id, :date_out) pp_out  on 1=1         left join grp g on g.grp_id = rs.ogrp_id   group by rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,           pp_in.oprice, pp_out.oprice, g.grp_fullname', 'Розширений товарний звіт із торговими націнками', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (31, 'Звіт по націнках на чеки', 'select o.name, d.doc_date, d.time_cr, c.name, k.kardcode, s.procent, slashparser(g.grp_fullname,1),         g.grp_name, n.nomen_name, m.maker_name, dr.kilk, dr.price, (dr.kilk * dr.price),         calcsum((dr.kilk * dr.price), (dr.kilk * dr.price) - dr.insum_pdv, dr.typepdv_pdv, dr.typepdv_id, 0),         ((dr.kilk * dr.price)-dr.insum_pdv)/(dr.kilk * dr.price + 0.0000000001)*100, g.grp_fullname   from documents d        left join docrec dr              left join nomen n                   left join grp   g on g.grp_id = n.grp_id                   left join maker m on n.maker_id = m.maker_id               on n.nomen_id = dr.nomen_id           on d.document_id = dr.document_id        left join clients o on d.objects_id = o.clients_id        left join clients c on d.clients_id = c.clients_id        left join kards   k            left join discont s on s.discont_id = k.discont_id          on d.kards_id   = k.kards_id  where d.typedoc_id = 11 and        d.doc_date between :idate0 and :idate1', 'Звіт по націнках на чеки', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (32, 'Звіт по торгових марках', 'select omaker_name, osum_td2, osum_td2_pdv, okilk_td2, osum_td17, osum_td17_pdv,         okilk_td17, odelta_sum, odelta_sum_pdv, odelta_kilk   from pr_maker(:idate0, :idate1)', 'Звіт для нарахування ретробонусів', NULL);
commit work;

INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (11, 'DATE_BEGIN', 1, 11, 'DATE', 'Початок періоду', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (12, 'DATE_END', 2, 11, 'DATE', 'Кінець періоду', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (13, 'GRP_ID', 3, 11, 'TREE', 'По групі', NULL, NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (15, 'DATE_BEGIN', 1, 12, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (14, 'MN_TYPEPDV', 4, 11, 'IDLIST', 'Тип оподаткування', NULL, NULL, 'select t.typepdv_id as id, t.typepdv_name as name from typepdv t');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (16, 'DATE_END', 2, 12, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (17, 'DATE_BEGIN', 1, 1, 'DATE', 'Початок періоду', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (18, 'DATE_END', 2, 1, 'DATE', 'Кінець періоду', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (31, 'IDATE', 1, 19, 'DATE', 'Звіт за:', 'Звіт за:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (32, 'ID', 1, 20, 'TREE', 'Звіт по групі:', 'Звіт по групі:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname    from grp   order by grp_id');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (33, 'IDATE', 1, 21, 'DATE', 'Відомість за:', 'Відомість за:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (34, 'IDATE0', 1, 22, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (35, 'IDATE1', 2, 22, 'DATE', 'Кінець періоду:', 'Кінець періоду:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (36, 'IDATE0', 1, 23, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (37, 'IDATE1', 2, 23, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (42, 'IDATE0', 1, 27, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (43, 'IDATE1', 2, 27, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (44, 'IGRP_ID', 3, 27, 'TREE', 'По групі', 'По групі', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (46, 'INGRP_ID', 1, 28, 'TREE', 'Звіт по групі:', 'Звіт по групі:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp order by grp_id ');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (47, 'DATE_IN', 2, 28, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (48, 'DATE_OUT', 3, 28, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (49, 'FLAG0', 4, 28, 'IDLIST', 'Лише видимі товари', 'Лише видимі товари', NULL, ' select * from  ps_get_yesno');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (54, 'IDATE0', 1, 31, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (55, 'IDATE1', 2, 31, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (56, 'IDATE0', 1, 32, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (57, 'IDATE1', 2, 32, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (38, 'INGRP_ID', 1, 26, 'TREE', 'Звіт по групі:', 'Звіт по групі:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp order by grp_id ');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (39, 'DATE_IN', 2, 26, 'DATE', 'Початок періоду', 'Початок періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (40, 'DATE_OUT', 3, 26, 'DATE', 'Кінець періоду', 'Кінець періоду', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (41, 'FLAG0', 4, 26, 'IDLIST', 'Лише видимі товари', 'Лише видимі товари', NULL, ' select * from  ps_get_yesno');
commit work;

INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (69, 8, 1, 'Контрагент', 'Назва клієнта', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (21, 1, 11, 'Код', '', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (26, 6, 11, 'Розхід СР', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (22, 2, 11, 'Група', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (23, 3, 11, 'Прихід к-сть', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (24, 4, 11, 'Прихід Сума Закупки', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (27, 7, 11, 'Розхід СР(ПДВ)', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (28, 8, 11, 'Розхід СЗ', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (30, 10, 11, 'Розхід ПДВ', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (31, 11, 11, 'Націнка', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (25, 5, 11, 'Розхід к-сть', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (29, 9, 11, 'Розхід СЗ(ПДВ)', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (34, 1, 1, 'Тип док.', 'Тип документу', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (35, 2, 1, 'Дата док.', 'Дата документу', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (36, 3, 1, '№ док.', 'Номер документу', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (37, 4, 1, 'СЗ', 'Сума закупки', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (38, 5, 1, 'СЗ(з ПДВ)', 'Сума закупки з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (39, 6, 1, 'СР', 'Сума реалізації', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (40, 7, 1, 'СР (з ПДВ)', 'Сума реалізації з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (74, 1, 19, 'Внутрішній код', 'Внутрішній код', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (75, 2, 19, 'Назва товару', 'Назва товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (76, 3, 19, 'Кількість', 'Кількість по документах на дану дату', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (77, 4, 19, 'Ціна', 'Ціна на дану дату', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (78, 5, 19, 'Сума', 'Сума', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (79, 1, 20, 'Вн. код', 'Внутрішній код товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (80, 2, 20, 'Назва', 'Повна назва товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (81, 3, 20, 'Штрихкод', 'Найновіший штрихкод', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (82, 4, 20, 'Залишок', 'Залишок товару по документах', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (83, 5, 20, 'Прод. ціна', 'Ціна продажу', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (84, 6, 20, 'Група', 'Група товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (85, 1, 21, 'Код групи', 'Код групи', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (86, 2, 21, 'Назва групи', 'Назва групи', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (87, 3, 21, 'Код тов.', 'Код товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (88, 4, 21, 'Штрих-код', 'Штрих-код', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (89, 5, 21, 'Назва товару', 'Назва товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (90, 6, 21, 'Од.вим.', 'Одиниця виміру', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (91, 7, 21, 'Прог. к-сть', 'Програмна кількість', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (92, 8, 21, 'Ціна реалізації', 'Ціна реалізації', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (93, 9, 21, 'Прог. сума', 'Програмна сума', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (94, 10, 21, 'Факт. к-сть', 'Фактична кількість', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (95, 11, 21, 'Факт. сума', 'Фактична сума', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (96, 12, 21, 'Різн. к-сть', 'Різниця кількостей', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (97, 13, 21, 'Різ. сум', 'Різниця сум', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (98, 1, 23, '№ документу', '№ документу', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (99, 2, 23, 'Код картки', 'Код картки', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (100, 3, 23, 'Ім''я дисконтника', 'Ім''я дисконтника', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (101, 4, 23, 'Знижка на картці', 'Знижка на картці (на той період)', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (102, 5, 23, 'Дата документу', 'Дата документу', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (103, 6, 23, 'Час документу', 'Час документу', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (104, 7, 23, 'СР (з ПДВ)', 'Сума реалізації (з ПДВ)', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (152, 14, 11, 'Група Рівень1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (153, 15, 11, 'Група Рівень2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (154, 16, 11, 'Група Рівень3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (155, 25, 26, 'Група Рівень1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (156, 26, 26, 'Група Рівень2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (157, 27, 26, 'Група Рівень3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (158, 7, 28, 'Група Рівень1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (159, 8, 28, 'Група Рівень2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (160, 9, 28, 'Група Рівень3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (163, 1, 31, 'Магазин', 'Магазин', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (164, 2, 31, 'Дата документу', 'Дата документу', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (136, 1, 28, 'Вн. код', 'Внутрішній код товару', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (137, 2, 28, 'Назва товару', 'Назва товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (138, 3, 28, 'Назва групи', 'Назва групи', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (139, 4, 28, 'Реалізація к-сть', 'Кількість товарів, реалізованих за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (140, 5, 28, 'Реалізація ГРН з ПДВ', 'Сума реалізованого за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (141, 6, 28, 'Залишок товару ГРН', 'Залишок товару ГРН з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (165, 3, 31, 'Час створення', 'Час створення', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (161, 12, 11, '% Націнки', ' ', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (162, 13, 11, 'Офіц. % Націнки', ' ', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (166, 4, 31, 'Клієнт', 'Клієнт', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (167, 5, 31, 'Код картки', 'Код картки', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (168, 6, 31, 'Знижка на картці', 'Знижка на картці', 'avg');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (169, 7, 31, 'Група товару', 'Група товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (170, 8, 31, 'Підгрупа товару', 'Підгрупа товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (171, 9, 31, 'Товар', 'Товар', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (172, 10, 31, 'Виробник', 'Виробник', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (173, 11, 31, 'Кількість', 'Кількість', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (174, 12, 31, 'Ціна', 'Ціна', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (175, 13, 31, 'СР (з ПДВ)', 'СР (з ПДВ)', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (176, 14, 31, 'СР (без ПДВ)', 'СР (без ПДВ)', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (177, 15, 31, 'Націнка', 'Націнка', 'avg');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (178, 16, 31, 'Повний шлях', 'Повний шлях', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (179, 1, 32, 'Торгова марка', 'Торгова марка', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (181, 3, 32, 'Прихід СЗ з ПДВ, грн', 'Прихід СЗ з ПДВ, грн', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (182, 4, 32, 'Прихід к-ть', 'Прихід к-ть', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (112, 1, 26, 'ІД товару', 'Унікальний код (ІД) товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (113, 2, 26, 'Вн. код', 'Внутрішній код товару', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (114, 3, 26, 'Назва товару', 'Назва товару', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (115, 4, 26, 'Назва групи', 'Назва групи', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (116, 5, 26, 'Поч. К.', 'Поч. К.', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (117, 6, 26, 'Поч. СЗ з ПДВ', 'Поч. СЗ з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (118, 7, 26, 'Поч. СР з ПДВ', 'Поч. СР з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (119, 8, 26, 'Поч. ТН.', 'Поч. ТН.', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (123, 12, 26, 'Прих. К.', 'Кількість товарів, закуплених за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (126, 15, 26, 'Прих. ТН', 'Прих. ТН', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (127, 16, 26, 'Розх. К.', 'Кількість товарів, реалізованих за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (130, 19, 26, 'Розх. ТН', 'Розх. ТН', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (132, 21, 26, 'Кінц. К.', 'Кількість товарів на кінець звітного періоду', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (133, 22, 26, 'Кінц. СЗ з ПДВ', 'Кінц. СЗ з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (134, 23, 26, 'Кінц. СР з ПДВ', 'Кінц. СР з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (135, 24, 26, 'Кінц. ТН', 'Кінц. ТН', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (124, 13, 26, 'Прих. СЗ з ПДВ', 'Сума закупленого за звітний період товару', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (125, 14, 26, 'Прих. СР з ПДВ', 'Сума закупленого за звітний період товару', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (128, 17, 26, 'Розх. СЗ з ПДВ', 'Сума реалізованого за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (129, 18, 26, 'Розх. СР з ПДВ', 'Сума реалізованого за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (131, 20, 26, 'Розх. Сума ПДВ', 'Сума реалізованого за звітний період', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (185, 7, 32, 'Пов. постач. к-ть', 'Повернення постачальнику к-ть', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (186, 8, 32, 'Кінцева СЗ без ПДВ', 'Кінцева СЗ без ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (187, 9, 32, 'Кінцева СЗ з ПДВ', 'Кінцева СЗ з ПДВ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (188, 10, 32, 'Кінцева к-ть ', 'Кінцева к-ть ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (180, 2, 32, 'Пр. СЗ, грн', 'Прихід СЗ без ПДВ, грн', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (183, 5, 32, 'С. пов. постач., грн', 'Сума повернення постачальнику без ПДВ, грн', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (184, 6, 32, 'С.пов.пост. ПДВ, грн', 'Сума повернення постачальнику з ПДВ, грн', 'sum');
commit work;

INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (1, 'До двох знаків на 0,09', 1);
INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (2, 'До двох знаків', 2);
INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (3, 'До одного знаку', 3);
commit work;


