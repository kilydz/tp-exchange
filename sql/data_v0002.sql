SET SQL DIALECT 3;

SET NAMES WIN1251;

INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 1, 'Дерево груп товарів', 'select oid from ps_1c_import_groups(:iid, :iname, :iparent_id)', 'GROUPS', 1, 0, NULL);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 3, 'Ціни', 'select oid from ps_1c_import_prices(:iid,:iname, :iprice_dealer, :icode_wares, icode_dealer)', 'PRICES', 5, 1, NULL);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 3, 'Довідник товарів', 'select oid from ps_1c_import_nomens (:iid, :iname_wares, :icode_group,  :icode_brand, :iname_wares_brand, :iname_wares_receipt, :icode_unit,  :icode_wares_relative, :ivat_type, :iexcise, :iold_articl, :iarticl_wares_brand)', 'NOMENS', 3, 0, NULL);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (0, 3, 'Тестовий крок', 'select code_sposuser, user_name from spa_users where id_1c is null', 'TEST', 4, 0, 'update spa_users set id_1c = :iid_1c where code_sposuser = :iid');
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 3, 'Класифікатор одиниць виміру (повн)', 'select oid from ps_1c_import_units(:iid, :iname)', 'UNITS', 2, 0, NULL);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 1, 'Класифікатор одиниць виміру', 'select oid from ps_1c_import_units(:iid, :iname)', 'UNITS', 2, 0, NULL);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM)
                     VALUES (1, 3, 'Типи цін (Магазини)', 'select oid from ps_1c_import_dealers(:iid, :iname)', 'DEALERS', 2.5, 1, NULL);
COMMIT WORK;


INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (3, 'Ініціалізація ТП');
COMMIT WORK;
