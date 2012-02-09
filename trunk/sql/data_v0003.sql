/******************************************************************************/
/***          Generated by IBExpert 2009.03.23 10.01.2012 10:02:06          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES WIN1251;


INSERT INTO T_SCALE_TYPES (SCALE_TYPE_ID, NAME, HAS_COM, HAS_EITHERNET) VALUES (2, '�����-� ���', 0, 1);
INSERT INTO T_SCALE_TYPES (SCALE_TYPE_ID, NAME, HAS_COM, HAS_EITHERNET) VALUES (3, '�����-� ��', 1, 0);
INSERT INTO T_SCALE_TYPES (SCALE_TYPE_ID, NAME, HAS_COM, HAS_EITHERNET) VALUES (4, 'METLER Tiger D', 0, 1);
INSERT INTO T_SCALE_TYPES (SCALE_TYPE_ID, NAME, HAS_COM, HAS_EITHERNET) VALUES (5, 'DIGI SP', 0, 1);
INSERT INTO T_SCALE_TYPES (SCALE_TYPE_ID, NAME, HAS_COM, HAS_EITHERNET) VALUES (1, 'CAS LP v1.5', 1, 1);

COMMIT WORK;

INSERT INTO T_SCALE_INTERFACES (SCALE_INTERFACE_ID, NAME) VALUES (0, 'COM ����');
INSERT INTO T_SCALE_INTERFACES (SCALE_INTERFACE_ID, NAME) VALUES (1, 'Eithernet');

COMMIT WORK;

INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (0, '��������');
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (1, '���������');
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (2, '³���������');
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (3, '������������ ��');

COMMIT WORK;

INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '������ ���� ������ (����)', 'select oid from ps_1c_import_groups(:iid, :iname, :iparent_id)', '�������   "" ��� opointer,   ret.��� ��� oid,   ret.������������ ��� oname,   ret.��������.��� ��� oparent_id  ��   ����������.������������ ��� ret  ��� (ret.��������� = ������)', 1, 0, NULL, NULL, NULL, 1);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, 'ֳ�� (����)', 'select oid from ps_1c_import_prices(:iid,:iname, :iprice_dealer, :icode_wares, icode_dealer)', 'PRICES', 5, 0, NULL, NULL, NULL, 2);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '������� ������ (����)', 'select oid from ps_1c_import_nomens (:iid, :iname_wares, :icode_group,  :icode_brand, :iname_wares_brand, :iname_wares_receipt, :icode_unit,  :icode_wares_relative, :ivat_type, :iexcise, :iold_articl, :iarticl_wares_brand,  :io_wares, :iis_purchase, :iis_sell)  ', '�������      "" ��� opointer,   ret.��� ��� oid,   ret.������������ ��� oname_wares,   ret.��������.��� ��� ocode_group,   ret.�����.��� ��� ocode_brand,   ret.������������������ ��� oname_wares_brand,   ret.����������������� ��� oname_wares_receipt,   ret.�����������������������.��� ��� ocode_unit,   ret.�������������.��� ��� ocode_wares_relative,   ret.���������.������� ��� ovat_type,   ret.����������� ��� oexcise,   ret.�������� ��� oold_articl,   ret.������� ��� oarticl_wares_brand,   ret.���������� ��� oo_wares,   ret.����������������� ��� ois_purchase,   ret.����������������� ��� ois_sell  ��   ����������.������������ ��� ret  ��� ret.������.��������� = ����', 3, 0, NULL, NULL, NULL, 3);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (0, 2, '�������� ���������', 'select oid, oid_1c, odoc_num, oedrpou, odoc_date, ois_closed from ps_1c_export_docs', 'DOCS', 4, 1, 'update t_docs set id_1c = :iid_1c where doc_id = :iid', 'select oid, oid_1c,oid_1c_doc_id, ocode_wares, ocode_unit, oquantity, oprice_with_vat, ovat_type from ps_1c_export_doc_recs(:idoc_id)', 'update t_doc_recs set id_1c=:iid_1c where doc_id = :iid', 4);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '������������ ������� ����� (����)', 'select oid from ps_1c_import_units(:iid, :iname)', '�������   "" ��� opointer,   ret.��� ��� oid,   ret.������������ ��� oname  ��   ����������.���������������������������� ��� ret', 2, 1, NULL, NULL, NULL, 5);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '������������ ������� �����', 'select oid from ps_1c_import_units(:iid, :iname)', '�������   ret.������ ��� opointer,   ret.������.��� ��� oid,   ret.������.������������ ��� oname  ��   ����������.����������������������������.��������� ��� ret  ��� ret.���� = &iknot', 2, 0, NULL, NULL, NULL, 6);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (0, 2, '������ ������ ��', 'select oid, oid_1c, ocode_unit, ocode_wares_relative, ocode_brand,   ovat_type, oexcise, oname_wares_receipt, oname_wares_brand,   oname_wares, ocode_group from ps_1c_export_nomens;', 'NOMENS', 1, 0, 'update wares set id_1c = :iid_1c where code_wares = :iid', NULL, NULL, 7);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '������� ������ (������)', 'select oid from ps_1c_import_nomens (:iid, :iname_wares, :icode_group,  :icode_brand, :iname_wares_brand, :iname_wares_receipt, :icode_unit,  :icode_wares_relative, :ivat_type, :iexcise, :iold_articl, :iarticl_wares_brand,  :io_wares, :iis_purchase, :iis_sell)  ', '�������   ret.������ ��� opointer,
   ret.������.��� ��� oid,
   ret.������.������������ ��� oname_wares,
   ret.������.��������.��� ��� ocode_group,
   ret.������.�����.��� ��� ocode_brand,
   ret.������.������������������ ��� oname_wares_brand,
   ret.������.����������������� ��� oname_wares_receipt,
   ret.������.�����������������������.��� ��� ocode_unit,
   ret.������.�������������.��� ��� ocode_wares_relative,
   ret.������.���������.������� ��� ovat_type,
   ret.������.����������� ��� oexcise,
   ret.������.�������� ��� oold_articl,
   ret.������.������� ��� oarticl_wares_brand,
   ret.������.���������� ��� oo_wares,
   ret.������.����������������� ��� ois_purchase,
   ret.������.����������������� ��� ois_sell
  ��   ����������.������������.��������� ��� ret
  ��� (ret.������.��������� = ����) �
   (ret.���� = &iknot)', 3, 0, NULL, NULL, NULL, 8);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '��������� (����)', 'select oid from ps_1c_import_barcodes(:iid, :ibar_code)', '�������   "" ��� opointer,
   ret.����������������.��� ��� oid,
   ret.�������� ��� obar_code
 ��   ���������������.��������� ��� ret', 8, 1, NULL, NULL, NULL, 9);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '��������� (�����)', 'select oid from ps_1c_import_barcodes(:icode_wares, :icode_unit, :ibar_code, :icoefficient)', '�������   "���������" ��� opointer,
   ret.����������������.��� ��� oid,
   ret.�������� ��� obar_code,
   ret.��������,   ret.������������,
   ret.����������������,
   ret.��������������������������,
   ret.�����������������,
   ret.��������,   ret.�������� 
 ��   ���������������.���������.��������� 
��� ret  ���   ret.���� = &iknot', 6, 0, NULL, NULL, NULL, 10);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (0, 1, '����', 'select oid, oid_1c, odate_order, otype_payment, ocode_client,          ocode_dealer, odiscount  from ps_1c_export_orders', 'ORDERS', 8, 1, 'update order_client_cache set id_1c = :iid_1c where code_order = :iid', 'select oid, oid_1c,oid_1c_doc_id, ocode_wares, ocode_unit, oquantity, oprice_with_vat, ovat_type, odiscount from ps_1c_export_order_recs(:idoc_id)', 'update wares_order_cache set id_1c=:iid_1c where code_order=:iid', 11);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '���� ��� (��������)', 'select oid from ps_1c_import_dealers(:iid, :iname)', '�������   "" ��� opointer,   ret.��� ��� oid,   ret.������������ ��� oname  ��   ����������.������������������� ��� ret', 2.5, 1, NULL, NULL, NULL, 12);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '������ ���� ������ (������)', 'select oid from ps_1c_import_groups(:iid, :iname, :iparent_id)', '�������   ret.������ ��� opointer,   ret.������.��� ��� oid,   ret.������.������������ ��� oname,   ret.������.��������.��� ��� oparent_id  ��   ����������.������������.��������� ��� ret  ��� (ret.������.��������� = ������) �   (ret.���� = &iknot)  ', 1, 0, NULL, NULL, NULL, 13);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '���� (����)', 'select oid from ps_1c_import_reg_cash_reg(:iid, :icode_company, :iserial_number_cash)', '�������   "" ��� opointer,   ret.��� ��� oid,   ret.�������������������������.��� ��� ocode_company,   ret.������������ ��� oserial_number_cash  ��   ����������.�������� ��� ret', 3, 1, NULL, NULL, NULL, 14);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '����������� (��������) (����)', 'select oid from ps_1c_import_p_clients (:iid, :ibar_code, :iis_active, :iis_payer_vat, :iimpocition,
 :iagree_number, :isurname, :iname,:ipatronymic,:iaddress, :idocument,:iname_for_print,
 :icode_discount_card,:iper_pp, :idiscount)', '�������
  "" ��� opointer,
  ret.��� ��� oid,
  "" ��� obar_code,
  ret.�������������������� ��� ois_not_active,
  1 ��� ois_payer_vat,
  ret.��� ��� oimpocition,
  ret.����������� ��� oagree_number,
  ret.������������ ��� osurname,
  ret.������������ ��� oname,
  ret.������������ ��� opatronymic,
  "" ��� oaddress,
  ret.������������������������������ ��� odocument,
  ret.������������������ ��� oname_for_print,
  "" ��� ocode_discount_card,
  0 ��� oper_pp,
  0 ��� odiscount
  ��
  ����������.����������� ��� ret
  ���
  ret.��������� = ����
  � ret.���������.������� = 1', 4, 1, NULL, NULL, NULL, 15);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '����������� (�������) (����)', 'select oid from ps_1c_import_f_clients (:iid, :ibar_code, :iis_not_active, :iis_payer_vat, :iimpocition,
 :iagree_number, :iname, :iaddress, :iname_for_print,
 :iper_pp, :idiscount, :icode_parent_firm, :icode_bank, :icode_zip,
 :iaccount, :iaddress_location)', '�������
  "" ��� opointer,
  ret.��� ��� oid,
  "" ��� obar_code,
  ret.�������������������� ��� ois_not_active,
  1 ��� ois_payer_vat,
  ret.��� ��� oimpocition,
    ret.����������� ��� oagree_number,
   ret.������������ ��� oname,
  "" ��� oaddress,
   ret.������������������ ��� oname_for_print,
   0 ��� oper_pp,
  0 ��� odiscount,
    ret.������������������.��� ��� ocode_parent_firm,
   ret.����������������������.����.��� ��� ocode_bank,
    ret.������������������ ��� ocode_zip,
  ret.����������������������.���������� ��� oaccount,
  "" ��� oaddress_location
 ��
  ����������.����������� ��� ret
  ���
  ret.��������� = ����
  � ret.���������.������� = 0
', 5, 1, NULL, NULL, NULL, 16);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '����������� (�������) (������)', 'select oid from ps_1c_import_f_clients (:iid, :ibar_code, :iis_not_active, :iis_payer_vat, :iimpocition,
 :iagree_number, :iname, :iaddress, :iname_for_print,
 :iper_pp, :idiscount, :icode_parent_firm, :icode_bank, :icode_zip,
 :iaccount, :iaddress_location)', '�������
  ret.������ ��� opointer,
  ret.������.��� ��� oid,
  "" ��� obar_code,
  ret.������.�������������������� ��� ois_not_active,
  1 ��� ois_payer_vat,
  ret.������.��� ��� oimpocition,
   ret.������.����������� ��� oagree_number,
  ret.������.������������ ��� oname,
   "" ��� oaddress,
 ret.������.������������������ ��� oname_for_print,
  0 ��� oper_pp,
  0 ��� odiscount,
  ret.������.������������������.��� ��� ocode_parent_firm,
   ret.������.����������������������.����.��� ��� ocode_bank,
   ret.������.������������������ ��� ocode_zip,
  ret.������.����������������������.���������� ��� oaccount,
  "" ��� oaddress_location
  ��
  ����������.�����������.��������� ��� ret
  ���
  ret.������.��������� = ����
  � ret.������.���������.������� = 0
  � ret.���� = &iknot
', 6, 1, NULL, NULL, NULL, 18);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '����������� (��������) (������)', 'select oid from ps_1c_import_p_clients (:iid, :ibar_code, :iis_active, :iis_payer_vat, :iimpocition,
 :iagree_number, :isurname, :iname,:ipatronymic,:iaddress, :idocument,:iname_for_print,
 :icode_discount_card,:iper_pp, :idiscount)
', '�������
  ret.������ ��� opointer,
  ret.������.��� ��� oid,
  "" ��� obar_code,
  ret.������.�������������������� ��� ois_not_active,
  1 ��� ois_payer_vat,
  ret.������.��� ��� oimpocition,
  ret.������.����������� ��� oagree_number,
  ret.������.������������ ��� osurname,
  ret.������.������������ ��� oname,
  ret.������.������������ ��� opatronymic,
  "" ��� oaddress,
  ret.������.������������������������������ ��� odocument,
  ret.������.������������������ ��� oname_for_print,
  "" ��� ocode_discount_card,
  0 ��� oper_pp,
  0 ��� odiscount
  ��
  ����������.�����������.��������� ��� ret
  ���
  ret.������.��������� = ����
  � ret.������.���������.������� = 1
  � ret.���� = &iknot', 7, 1, NULL, NULL, NULL, 19);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 3, '������� ����� (����)', 'select oid from ps_1c_import_add_units(:iid, :icode_wares, :icode_unit, :icoefficient)', '������� "" ��� opointer,
  ret.��� ��� oid,
  ret.��������.��� ��� ocode_wares,
  ret.�����������������������.��� ��� ocode_unit,
  ret.����������� ��� ocoefficient
 ��
  ����������.���������������� ��� ret', 6, 0, NULL, NULL, NULL, 20);
INSERT INTO T_1C_SYNC_STEPS (DIRECTION, TP_MODE_ID, NAME, QUERY_TP, QUERY_1C, WEIGHT, IS_ACTIVE, QUERY_TP_CONFIRM, QUERY_TP_RECORDS, QUERY_TP_RECORD_CONFIRM, ID) VALUES (1, 1, '������� ����� (�����)', 'select oid from ps_1c_import_add_units(:iid, :icode_wares, :icode_unit, :icoefficient)', '�������  ret.������ ��� opointer,
   ret.������.��� ��� oid,
   ret.������.��������.��� ��� ocode_wares,
   ret.������.�����������������������.��� ��� ocode_unit,
   ret.������.����������� ��� ocoefficient
��
   ����������.����������������.��������� ��� ret
���    (ret.���� = &iknot)', 7, 1, NULL, NULL, NULL, 21);

COMMIT WORK;
