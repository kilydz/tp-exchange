/******************************************************************************/
/***          Generated by IBExpert 2009.03.23 22.11.2011 18:57:13          ***/
/******************************************************************************/



SET SQL DIALECT 3;

SET NAMES WIN1251;

/* ������������ ������� � �������� �������������� ��    */
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (0, '��������');
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (1, '���������');
INSERT INTO TS_TP_MODES (TP_MODE_ID, NAME) VALUES (2, '³���������');

COMMIT WORK;

/* � ������� ��������� ����� �������������� ������ ����� � ������� ������������� */
INSERT INTO T_TP_STATES (TP_MODE_ID) VALUES (1);

COMMIT WORK;
