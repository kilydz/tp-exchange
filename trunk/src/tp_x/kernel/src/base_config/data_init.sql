INSERT INTO MAKER (MAKER_ID, MAKER_NAME, COLOR) VALUES (0, '�� �����', NULL);
commit work;

INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (1, '��');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (2, '�');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (3, '��');
INSERT INTO SI (SI_ID, SI_NAME)
        VALUES (4, '�');
commit work;

INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (0, '�������� �����');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (1, '�������� (����� �)');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (2, '�����');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (3, '�����������');
INSERT INTO SPECIALS_GROUPS (SG_ID, SG_NAME)
                     VALUES (4, '����');
commit work;

INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (1, '�� ��������������', 0);
INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (2, '��� �� �������', 0.2);
INSERT INTO TYPEPDV (TYPEPDV_ID, TYPEPDV_NAME, PDV)
             VALUES (3, '��� �� ����', 0.2);
commit work;

INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (1, '�������� ��������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (2, '�������� ��������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (4, '���������� �� �������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (11, '���');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (6, '�������� ������� ����������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (12, '��� ���������� ������� ���');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (14, '��������� ��������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (15, '��� ��������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (17, '���������� ��������������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (10, '�������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (16, '��������� �� ��������');
INSERT INTO TYPEDOC (TYPEDOC_ID, TYPEDOC_NAME)
             VALUES (7, '�������� ������� ����������');
commit work;

INSERT INTO T_DECR_TYPE (DECR_TYPE_ID, NAME) VALUES (0, '����������� �����');
commit work;

INSERT INTO T_DECREASE (DECR_ID, DECR_NAME, DECR_VALUE, DECR_TYPE_ID) VALUES (0, '��� ������', 0, 0);
commit work;

INSERT INTO DISCONT (DISCONT_ID, PROCENT) VALUES (0, 0);
commit work;

INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (0, '', '');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (1, '���������� � ��������� �������������', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (2, '��������� ���������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (3, '�������� ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (4, '������� ���������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (5, '³������ ���������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (6, '��������� ���������� �����', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (7, '������� ��������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (8, 'Գ����� �����-���������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (9, '���''��� ����. ��������-������� �����', '���-��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (10, '�������� �����', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (11, '�������� ��', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (12, '�������-��������� �����', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (13, '������ ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (14, '���������� �����', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (15, '������ ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (16, '���������� ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (18, 'ϳ��������', '�-��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (17, '���������� ���������� ��������� ����', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (19, 'Գ�� ���������� � ��������� ��-��', 'Գ�� ����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (20, 'C������������������� �������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (21, '�������� ���������-������� ����������', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (22, '���������-���������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (23, 'ϳ��������� � ���� ����', '�-��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (24, '���������� ������������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (25, '�� ���������� � ��������� �������������', '�� ����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (26, '�������� ���������� �����', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (27, '³������ ���������� ��������� ��������� ����', '��� ��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (28, '���������-����������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (29, '�������� ���������-���������� ����������', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (30, '������� ���������� �.�. ����������', '�����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (31, 'Գ�� ���������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (32, '���������� ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (33, '�������� ���������-���������� �����', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (35, 'Գ�� ��������� ������������ ����������', 'Գ�� ���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (34, '������� ���������� � ���������� ������������', '�ϲ�');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (36, 'Գ�� ���������� ����������', 'Գ�� ��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (37, 'Գ�� ���������-��������� ����������', 'Գ�� ���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (38, '�������� ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (39, 'Գ����� �����', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (40, '�������� ��-�� ���������-���������� �����', '�����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (41, '���������� ������������������� ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (42, '������ ���������� ����', '������');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (44, '������ ���������-�������� ����', '������');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (43, '������ ���������� ���', '�����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (45, '�������� ������������ ����������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (46, '��������� (����������) ������������', '���');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (47, '�������� ���������� ����������', '����');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (48, '�������������� ����������', '��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (49, '����������� ������� ����', '������');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (50, 'Գ�� �������� ����������', 'Գ�� ��');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (51, 'ѳ������������������ ���������� � ��������� �������������', '������');
INSERT INTO TYPEPROP (TYPEPROP_ID, NAME, SHORT_NAME)
              VALUES (52, '������� ���������� ����������', '���');
commit work;

INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (1, '�����');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (2, '������������');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (3, '��������');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (5, '�������� �볺��');
INSERT INTO TYPECLIENT (TYPECLIENT_ID, TYPECLIENT_NAME)
                VALUES (4, '������������ � ��������');
commit work;

INSERT INTO GRPC (GRPC_ID, GRPC_NAME, PREW_GRPC_ID, GRPC_CODE) VALUES (1, '�������', NULL, NULL);
commit work;

INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "ĳ���������"   ', '320854');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������-����" ', '322959');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "����������" ', '300272');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������� ����" ', '319092');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�˲�������� Ĳ�" ', '300647');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������-����" ', '331489');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������" ', '322711');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������ϲ���" ', '322625');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������������" ', '334969');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "����������" ', '320478');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������������" ', '320843');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������������" ', '304988');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���" ', '331768');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������" ', '300119');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� ������" ', '351931');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������в������" ', '313849');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��������-����" ', '320735');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����" ', '305062');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����-������" ', '328180');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������" ', '300023');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "Գ�����"   ', '328685');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����" ', '384577');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����" ', '322539');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('����������� ���� "ϳ�������" ', '328209');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�����-����" ', '300885');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� "���������� ����������" ', '300498');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� "�������" ', '300788');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� "Գ����� �� ������" ', '300131');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� ��������" ', '380322');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� �����" ', '322799');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���� �������� ��ϲ���" ', '380010');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������������" ', '300249');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������ ����" ', '380236');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "����� ����" ', '380009');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�����������" ', '380430');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���������" ', '380612');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���������" ', '328384');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�� "��������������" ', '337933');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�� "���������" ', '322294');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�� "����"   ', '380515');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "ʲ�" ', '322540');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "������������" ', '312248');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������" ', '313582');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "̲��� ����" ', '328760');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�� ����" ', '322432');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��Ѳ ����" ', '325990');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��� ����" ', '300528');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "ϲ���� ���� ���" ', '300658');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������� ����" ', '320984');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���������� ���� �����" ', '300335');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��ò��-����" ', '351254');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "����²� ����" ', '321712');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������� ��Ѳ�" ', '320627');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������� ������" (��������) ', '320650');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������" (�������) ', '300164');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������� ��������� �����" ', '300926');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "���������������" ', '380377');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�����������"   ', '322313');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "��������" ', '300142');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "����������" ', '351005');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "Բ���������" ', '328599');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� "�������-����" ', '300904');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� ���� "�����в�" ', '351663');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� �� "�� ������" ', '322830');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���� "������" ', '353575');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "������ ��������" ', '339500');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����������" ', '322302');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� "��ϲ���" ', '334828');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� 3/4" ', '380645');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ʲ���" ', '320940');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� ����" ', '320995');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� ����" ', '380913');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "³���� ����" ', '380537');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� ���� ���" ', '380731');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ����"   ', '380667');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����" ', '380292');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������������" ', '377090');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "�����-����" ', '300852');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "��������������" ', '334992');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������ ������ ����" ', '380571');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���������� ����" ', '380441');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "̳��������� ������������� ����" ', '380582');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��������" ', '300465');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���" ', '380388');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���-����" ', '300896');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���" ', '300205');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "Բ��������"   ', '380311');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� ����" ', '307123');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "������������� ����" ', '321477');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ����� ���� ', '380548');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ���� "��������� ������" ', '322324');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ���� "�����" ', '380474');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ��� ���� ', '321767');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "������" ', '380526');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "���������" ', '300216');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "�����" ', '320003');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "��������" ', '380690');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "��������" ', '300670');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ���� ���� ', '351588');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �������� ���� ', '303536');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�������� ������������ ������ ', '820172');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('������������ ���� ������ ', '300001');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "��������" ', '306500');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� �����������" ', '353489');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�-����" ', '307770');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� - ����" ', '380708');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� "�ȯ�" ', '322498');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� "�������" ', '307350');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� "�����-������" ', '380106');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� ����" ', '331100');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��������" ', '307394');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����-����" ', '300346');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� - ����" ', '380720');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� "�����" ', '351607');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� "���������� ������" ', '320371');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ���������� �� ����������" ', '380281');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� �����"   ', '380399');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ������ �Ͳ���" ', '305749');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ��ֲ�������� ������" ', '320702');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ������������-������" ', '300120');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ������ ��������" ', '380418');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� �������" ', '380623');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� �����" ', '322948');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� ����" ', '321723');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�������������� ���� ��������" ', '380719');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�-� ����" ', '380689');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������" ', '334970');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���" ', '305987');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�������������" ', '303484');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�������" ', '351652');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��� ���� ������" ', '300539');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������-����" ', '300614');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������" ', '351878');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "��������� ������" ', '305880');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "����������" ', '328210');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "ϲ�����������" ', '335946');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "������" ', '339555');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "���" ', '388313');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "���" ', '377777');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�� "Բ������� �Ͳֲ�����" ', '380054');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "ʲ� ���� �������" ', '300379');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������" ', '306704');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������� ���� "������" ', '380980');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����������" ', '339339');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������ ������ ����" ', '380366');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��������������" ', '300863');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���������" ', '325912');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�������" ', '300056');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "��������" ', '351629');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�����-����" ', '313009');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������ ������������� ����" ', '300506');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���� ����"   ', '336310');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� - ����" ', '300669');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���Բ� ����" ', '334594');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "������� ����" ', '319111');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "���������" ', '307305');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "ѳ�����" ', '300584');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����� ����" ', '380601');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "�������� ����" ', '322001');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "����������" ', '325213');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "���������" ', '397133');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ��� "������" ', '322335');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ��� "����" ', '325268');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ���� "��������" ', '322465');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ���� "��������" ', '324742');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "��������"   ', '380355');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� �� "����������" ', '305299');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� ������������� ', '300012');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('����� "�������-����" ', '321983');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���������� ', '353100');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���� "����" ', '380742');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���� "�� "���������" ', '380634');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���� "��� ����" ', '300175');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('���˲��� ��ֲ������ ���������� "����" ', '334851');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('�� ���� ', '304706');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('��� "ĳ��������"   ', '307112');
INSERT INTO BANKS (NAME, MFO)
           VALUES ('����� "��������" ', '380559');
commit work;

INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (1, '1000001', '�������', '�������', 1, '00000000', 1, '', '', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 1, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (2, '1000002', '������', '������', 1, '10001', 1, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 2, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (98, '1000098', '�����', '�����', 2, '10001', 1, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '', 0, 0, 0, 1, 98, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (100, '1000000', '��������', '��������', 3, '0', 0, '', '0', '', '', 1, NULL, 0, '2003-01-01', '', '', 0, '', '1234', 0, 0, 0, 1, 100, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (99, '1000099', '�������', '�������', 3, '0', 0, '', '0', '', '', 1, NULL, 0, '2005-02-16', '', '', 0, '', '', 0, 0, 0, 1, 99, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (95, '1000095', '����� ���������� �� ��������', '����� ���������� �� ��������', 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2009-04-01', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, NULL, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (96, '1000096', '����� ��������', '����� ��������', 1, '10001', 0, '', '0', '', '', 1, NULL, 0, '2008-03-05', '', '', 0, '', '', 0, 0, 0, 1, 9996, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (97, '1000097', '��������� ���', '��������� ���', 1, '10001', 0, NULL, '0', '', NULL, 1, NULL, 0, '2008-03-05', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, 9997, 1, 1);
INSERT INTO CLIENTS (CLIENTS_ID, CLIENTS_CODE, SHORTNAME, NAME, TYPECLIENT_ID, ZKPO, ISPDV, IPN, NUMPDV, ADRESS, PHONE, GRPC_ID, CLOSED, IS_OPT, DATE_UGODY, DIRECTOR, NUM_UGODY, TYPEPROP_ID, DELIV_ADDR, EMAIL, DISC_PERCENT, AMOUNT_DAYS, POSSIBLE_DEBT, IS_ACTIVE, W3_CLIENT_ID, IS_VISIBLE, IS_EXIST)
             VALUES (94, '1000094', '��� ��������', '��� ��������', 1, '10001', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2009-08-30', NULL, NULL, 0, NULL, NULL, 0, 0, 0, 1, 9994, 1, 1);
commit work;

INSERT INTO OBJECTS (OBJECTS_ID, OBJECTS_NAME, M_SALE, CLIENTS_ID, AROUND_PRICE_PDV)
             VALUES (1, '�������', 'Y', 1, 100);
commit work;

INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (1, '������', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (2, '�����������', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (3, '���������', 0);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (4, '̳����', 1);
INSERT INTO TYPEPAY (TYPEPAY_ID, TYPEPAY_NAME, PAY_LEVEL)
             VALUES (0, '����', 0);
commit work;

INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_documents', 'yes', '�� ���������� � �������� ��������� ������� �������� ���������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_general', 'yes', '�� ���������� ������� � ���������� �������� ������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_general', 'yes', '�� ���������� ������� � ��������� �������� ������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_general', '01.01.2006', '����� ���� ��������� ������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_general', '01.02.2006', '������ ���� ��������� ������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_nomen', 'no', '��������� ���������� �� � ������ ������ (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_general', 'td16', 'yes - ��������� ������ �����, no - �� ���������, td16 - ���������� ��������� �������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_nomens', 'yes', '�� �������� ��������� ���������� ��� ����� � ��������� ������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_nomen', 'no', '�� ��������� ����������� ���� ��� �����. ������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'export_1c', 'yes', '�� ���������� ���� X ��� ������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_nomen', 'yes', '���������� ��������� ��������� ������ �� �������������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'export_1c', 'no', '�� ��������� ���� �� ����������');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'revision_revision_r', 'plus', 'ĳ�, ��� ���������� ��� ������ ����� � ��� (rewrite - �������� �-��� ����������, plus - �������� �-��� � ��� �������� �� ��� ������ � ���)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_nomen', 'no', '����� ������� ������������ (yes/ins_only/upd_exc_name/no)   (��� yes ������������ � ��� ��������� � ������������ ��������,   � ����� ����� ������������ �������� ���������� �� ����� � ���,   ��� ins_only - ���� ����������� ��� ������,   ��� upd_exc_name - ����������� ��� ������, � ����� ��������� �� �������� ������ ���   ����� �� ������� �����)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_nomen', 'no', '���������� ���������� � �������, ��� ���� ����, ����, �� ����� (��� ������������ ������) (yes/without_w3_only/no)(��� without_w3_only ������������� ���������� � ��''������ �������)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_nomens', 'yes', '³��������� ����� ���� "���� �����-�����"');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (6, 'store_nomen', 'no', '�� ������������� �������� ���������� ������ (yes/no) (crt_markup - ���������� ���� ���������� �� ������ � ���� �������� ������������� ����, ��� �������)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_documents', '0', '�� ����������� ����� ����������� ������� (no/�-��� ��� ������������(������))(�� ������������ 1 ����)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (3, 'store_documents', 'yes', '�� ����� ������� �� � ����� �� ������� ��� ���������� ������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_clients', 'no', '���������� ���������� � �볺����� ���� "��������"(��� ������������ �볺���) (yes- ����������,srv-��������� ��� �볺��� �� ���� �� 100)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (2, 'store_clients', 'no', '����� ������������ �볺��� (yes-�������� clients ������������ ������)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (1, 'store_maker', 'no', '���������� ����������/���������� ������ �����');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (4, 'store_documents', 'no', '�� ������������� ��������� �� ����������� ����, � ��� ��� �������� ���������� (no-�, ����� -�-��� ���)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (5, 'store_documents', 'yes', '�� ��������� ���������� �������� �������� (yes/no)');
INSERT INTO T_CONFIGS (CONFIG_ID, MODULE, MARKER, DESCIPT)
               VALUES (400, 'store_nomen', 'no', '���������� ��������� ����� ������ � �.�. ��� ������������');
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
                VALUES (0, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'execute procedure PS_ROLL_TAX_ADD(:DOCUMENT_ID)', 'tax*.frf', '��������� ��������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (1, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'given*.frf', '��������� ��������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (2, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'movingOUT*.frf', '�������� ������� ����������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (3, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'return*.frf', '���������� �������������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (4, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'chargeoff*.frf', '��� ��������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (11, 'select * from PS_MARKUP_PRINT (:DOCUMENT_ID )', 'select * from PS_MARKUP_RECORD_PRINT (:DOCUMENT_ID )', 'UPDATE T_MARKUPS SET PRINT_CNT = PRINT_CNT + 1  WHERE MARKUP_ID = :DOCUMENT_ID', 'markup*.frf', '��� ����������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (5, 'select * from S_FAKTURA(:document_id)', 'select * from S_DOCREC_VIEW(:document_id)', NULL, 'faktura*.frf', '�������-�������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (6, 'SELECT * FROM S_PRN_RECEIPT(:DOCUMENT_ID)', 'SELECT * FROM S_PRN_RECEIPT_DTL(:DOCUMENT_ID, 1)', NULL, 'receiptout*.frf', '�������� �������� �� ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (7, 'SELECT * FROM S_PRN_RECEIPT(:DOCUMENT_ID)', 'SELECT * FROM S_PRN_RECEIPT_DTL(:DOCUMENT_ID, 1)', NULL, 'receiptin*.frf', '�������� �������� �� ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (10, NULL, 'SELECT * FROM S_REV_RECORDS_VIEW(:DOCUMENT_ID)', NULL, 'datarevision*.frf', '����� ����� ����� ���糿', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (8, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'certificate*.frf', '������� �� ��������� �������� (����������)', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (9, 'select * from PS_SW_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by OSG_ID, NOMEN_NAME', NULL, 'akt*.frf', '��� ��������� ����', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (12, 'select * from PS_LC_PACT_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'pact*.frf', '������ ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (13, 'select * from PS_LC_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'lc_akt*.frf', '��� ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (14, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'execute procedure PS_ROLL_TAX_ADD(:DOCUMENT_ID)', 'lc_tax*.frf', '��������� �������� ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (16, 'select dh.*, dh.name_s as SRC_FULLNAME, dh.name_d as DST_FULLNAME,         dh.shortname_s as SRC_NAME, dh.shortname_d as DST_NAME,         dh.oauth_name as auth_name   from PS_DOC_HEADER_VIEW(:DOCUMENT_ID) dh', 'select dp.*, dp.p_in_sum/dp.kilk as price_in, dp.p_in_sum_vat/dp.kilk as price_in_vat,         dp.out_price as price_out, dp.out_price_pdv as price_out_vat    from ps_docrec_print(:DOCUMENT_ID) dp order by docrec_id', NULL, 'breturning*.frf', '���������� �� �������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (15, 'select * from PS_LC_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_LC_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'lc_in_akt*.frf', '��� ��', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (17, 'SELECT * FROM PS_PRODUCTION_DOC_HEADER(:DOCUMENT_ID)', 'SELECT * FROM PS_PRODUCTION_DOCREC_PRINT(:DOCUMENT_ID)', NULL, 'internal_moving*.frf', '�������� �� ������� ���������� ��������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (18, 'SELECT * FROM PS_PRODUCTION_DOC_HEADER(:DOCUMENT_ID)', 'SELECT * FROM PS_PRODUCTION_DOCREC_PRINT(:DOCUMENT_ID)', NULL, 'technological*.frf', '����������� ��������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (19, 'select * from PS_CALCULATION_HEADER(:DOCUMENT_ID)', 'select * from PS_CALCULATION_PRINT(:DOCUMENT_ID) order by onomen_name', NULL, 'calc_kard*.frf', '������������� ������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (20, 'select * from PS_CALCULATION_HEADER(:DOCUMENT_ID)', 'select * from PS_CALCULATION_PRINT(:DOCUMENT_ID) order by onomen_name', NULL, 'tech_kard*.frf', '����������� ������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (21, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_DEBITORKA_CLNT_FULL(:date0, :date1, :document_id)', NULL, 'clnt_deb*.frf', '������� � �볺����', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (22, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_KREDITORKA_CLNT_FULL(:date0, :date1, :document_id)', NULL, 'clnt_cred*.frf', '������� � ��������������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (23, 'select * from PR_RALASE_NOMEN_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_RALASE_NOMEN_PERIOD(:date0, :date1, :document_id)', NULL, 'ralase_nomen*.frf', '�������� ��� �� �����', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (24, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_INVOICE_PAYS_DEBT(:date0, :date1, :document_id)', NULL, 'inv_pays_debt*.frf', '�������� �� ��������� � �볺����', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (25, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_INVOICE_PAYS_KRED(:date0, :date1, :document_id)', NULL, 'inv_pays_kred*.frf', '�������� �� ��������� � ��������������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (26, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_LIST_CHARGES(:date0, :date1, :document_id)', NULL, 'lst_charges*.frf', '������ ������� �� ������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (27, 'select * from PR_CLIENT_HEADER(:DOCUMENT_ID, :DATE0, :DATE1)', 'select *  from PR_REGISTER_INVOICES_OUT(:date0, :date1, :document_id)', NULL, 'registr_invoices*.frf', '����� ���������� ���������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (28, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by DOCREC_ID', NULL, 'returning_buy*.frf', '���������� �� �������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (29, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', NULL, 'wsEdition*.frf', '��������� ���������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (31, 'select * from ps_autoorder_header_view(:document_id)', 'select * from PS_AO_RECORDS_PRINT(:document_id) where oordered != 0 order by onomen_name', 'update autoorders set print_cnt = print_cnt + 1 where autoorder_id = :document_id', 'order*.frf', '���������� ������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (30, 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME', 'movingIN*.frf', '�������� ������� ����������', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (32, 'select * from PR_DOCUMENTS_PERIOD_HEADER(:DOCUMENT_ID, :DATE0, :DATE1, 1)', 'select *  from PR_DOCUMENTS_PERIOD(:date0, :date1, :document_id, 1)', NULL, 'documents_period*.frf', '��� � ����� ��������� ��� ���', NULL);
INSERT INTO T_INVOICES (INVOICE_ID, Q_HEADER, Q_RECORDS, Q_UPD_AFTER, FRF_FILTER, FRF_DESCRIPTOR, ACCESS_ID)
                VALUES (33, 'select * from PR_DOCUMENTS_PERIOD_HEADER(:DOCUMENT_ID, :DATE0, :DATE1, 3)', 'select *  from PR_DOCUMENTS_PERIOD(:date0, :date1, :document_id, 3)', NULL, 'documents_period*.frf', '��� � ����� ��������� � ���', NULL);
commit work;

INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (1, '����');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (2, '������������');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (3, '�����');
INSERT INTO T_RIGHTS_GRP (RIGHT_GRP_ID, NAME) VALUES (4, '������� �����');
commit work;

INSERT INTO T_USERS (USER_ID, USER_LOGIN, USER_KEYWORD, RIGHTS_GRP_ID, USER_SURNAME, USER_FIRST_NAME, USER_SECOND_NAME, NICK, LAST_DOC, SIGNATURE) VALUES (0, 'SYSDBA', 'masterkey', 2, '����������� ��', '', '', 'sys', 1, '1');
commit work;

INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1, '���� �� ������ "�����"', -1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30000, '������ �� �������� "�����������"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30006, '���� ������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30005, '����������� ������������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30004, '��������� ������������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30001, '��������� ������ �����������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30002, '����������� �����������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30003, '��������� �����������', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40000, '������ �� �������� "����� ������������"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40001, '��������� ���� �����', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40002, '����������� �����', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (40003, '��������� �����', 40000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (30007, '������� ����� �������� "�����������"', 30000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60000, '������ �� �������� "����"', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100100, '���� ������� �� ����������', 100000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100000, '����', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100110, '���� ���������', 100000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100200, '������� "���������"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100300, '������� "������"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100400, '������� "�볺���"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100500, '������� "���� ����������"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100600, '������� "�������"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100700, '������� "���糿"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100800, '������� "��������������"', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1000000, '��������', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (1000001, '������ ����������', 1000000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100201, '��������� �� �����������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100202, '��������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100401, '��������� �� ����������� �볺���', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100402, '��������� �볺���', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100203, 'Գ�������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100204, '��������������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100205, '³����������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100206, '������ ������������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100301, '��������� �� ����������� ������', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100302, '��������� ������', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100207, '������ ��������� ������������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100310, '������ ������� � ��������', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100311, '������ �� � ��', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900000, '������� � 1�', 1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900100, '������ ������ ��������', 900000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (900110, '������ ������� ������', 900000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (120004, '��''������� ����� �볺���', 100400);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60010, '������������ �������������', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60020, '���������� �������������', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60040, '�� ��������� ����������', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (60050, '�� ����������', 60000);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100208, '������� ��������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100209, '������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100312, '������� ��������', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100710, '������� ���������', 100700);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100702, '��������� ���糿', 100700);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100810, '������� ���������', 100800);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800001, '���� �� ������ "����"', -1);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100802, '��������� ��������������', 100800);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800100, '��������� ���������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800101, '��������� ����', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800102, '����������� ���������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800103, '����������� ����', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800120, '������� ������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800104, '����������� ���������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800140, '������ ����������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800130, '������ ��� ���������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800141, '������ ����', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800142, '������ �������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800131, '������ ���������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100214, 'ϳ����������� �������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100210, 'Գ�������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100211, '������������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100212, '³����������� ���������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100213, '������ ������������', 100200);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100502, '��������� ���� ����������', 100500);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100313, '������ "���������" �����', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100314, '���������� ��� ������', 100300);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800143, 'ϳ������������ ��������� ������� �������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (800144, '�������� ������� ������� ��� ������������', 800001);
INSERT INTO T_ACCESS (ACCESS_ID, NAME, PARENT)
              VALUES (100315, '��''�������� ������', 100300);
commit work;

execute procedure PA_ADMIN_RIGHTS_SET;
commit work;

INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (11, '��� �� ���� ��� �� ������', 'select rr.rgrp_id as rgrp_id, rr.rgrp_name as grp_name,         sum(rr.rprihod_k) as rprihod_k, sum(rr.rprihod_s) as rprihod_s,         sum(rr.rrashod_k) as rrashod_k, sum(rr.rrashod_s) as rrashod_s,         sum(rr.rrashod_s_pdv) as rrashod_s_pdv, sum(rr.rin_sum) as rin_sum,         sum(rr.rprihod_s_pdv) as rprihod_s_pdv,         sum(rr.RPDV) as pdv,         sum(rr.RNACINKA) as nacinka,         avg(rr.rper_nac) as per_nac,         avg(rr.rper_nac_ofic) as per_nac_ofic,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from PR_RALASETYPEPDV_BYGROUP(:date_begin, :date_end, 1, :grp_id) rr         left join grp g on g.grp_id = rr.rgrp_id   where rr.rtype_pdv in (:mn_typepdv)   group by rr.rgrp_id, rr.rgrp_name, g.grp_fullname   order by rr.rgrp_name', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (12, '��� �� ��������� ���������� � ������� �� ���', 'select * from pr_doc_del(:date_begin,:date_end)', NULL, 60040);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (19, '��� �� �������� ������', 'select * from pr_nomensrests(:idate)', '���, ���� �� ��� ������ ������� ������ �� ���� �������� �� ��������� ����', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (20, '����� �� ���������� ��� ���糿', 'select ocode, ofull_name, obarcode, orest, oprice_out, ogrp_name from pr_nomen_with_barcode(:id,0)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (21, '���������������� ������� � �������', 'select * from pr_revision_list(:idate)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (22, '��� �� �������������� ����������', 'select d.document_id, d.doc_num from documents d  where d.doc_date between :idate0 and :idate1 and  d.typedoc_id !=11 and       d.doc_lock < 2', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (1, '��� �� ����������', 'select rsd.typedoc_name, rsd.doc_date, rsd.doc_num,                         sum(rsd.sum_in) as sum_in,                          sum(rsd.sum_in_pdv) as sum_in_pdv,                         sum(rsd.sum_out) as sum_out,                         sum(rsd.sum_out_pdv) as sum_out_pdv, rsd.client_name                   from rs_documents(:date_begin, :date_end) rsd                   group by rsd.typedoc_name, rsd.doc_date, rsd.doc_num, rsd.client_name                   order by rsd.doc_num, rsd.typedoc_name, rsd.doc_date', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (23, '��� �� ��������� �� ���������� ������� �� �����', 'select odocument_id, okardcode, oname, opercent, odoc_date, odoc_time, osum_out_pdv from pr_discount_ralase(:idate0, :idate1)', '��� �� ��������� �� ���������� ������� �� �����', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (27, '��� �� ������� , �� �� ��������� � �����', 'select * from PR_NOMEN_REV (:idate0,:idate1,:igrp_id)', NULL, NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (28, '��� �� ��������� �������', 'select rs.nomen_code, rs.nomen_name, rs.ogrp_name,         around3(sum(rs.r_k)) r_k, around3(sum(rs.r_s_out)) r_s_out,         around3(sum(rs.e_k) * pp_out.oprice) e_s_out,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from pr_ralase_sales(:date_in, :date_out, :ingrp_id, :flag0) rs         left join grp g on g.grp_id = rs.ogrp_id,         ps_price_by_date(rs.nomen_id, :date_out) pp_out   group by rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,            pp_out.oprice, g.grp_fullname', '��� �� ��������� �������', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (26, '�������� ��� �� ��������� ���������', 'select rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,         around3(sum(rs.b_k)) b_k,         around3(sum(rs.e_s_in) - sum(rs.p_s_in) + sum(rs.r_s_in)) b_s_in,         around3(sum(rs.b_k) * pp_in.oprice) b_s_out,         around3(sum(rs.b_k) * pp_in.oprice - (sum(rs.e_s_in) - sum(rs.p_s_in) + sum(rs.r_s_in))) b_tn,         around3(sum(rs.p_k)) p_k, around3(sum(rs.p_s_in)) p_s_in,around3(sum(rs.p_s_out)) p_s_out, around3(sum(rs.p_s_out) - sum(rs.p_s_in)) p_tn,         around3(sum(rs.r_k)) r_k, around3(sum(rs.r_s_in)) r_s_in, around3(sum(rs.r_s_out)) r_s_out, around3(sum(rs.r_s_out) - sum(rs.r_s_in)) r_tn,         around3(sum(rs.r_s_vat)) r_s_vat,         around3(sum(rs.e_k)) e_k,         around3(sum(rs.e_s_in)) e_s_in, around3(sum(rs.e_k) * pp_out.oprice) e_s_out, around3((sum(rs.e_k) * (pp_out.oprice)) - sum(rs.e_s_in)) e_tn,         slashparser(g.grp_fullname, 1) as Group_Level1,         slashparser(g.grp_fullname, 2) as Group_Level2,         slashparser(g.grp_fullname, 3) as Group_Level3    from pr_ralase_nomen_v2(:date_in, :date_out, :ingrp_id, :flag0) rs         join ps_price_by_date(rs.nomen_id, :date_in) pp_in on 1=1         join ps_price_by_date(rs.nomen_id, :date_out) pp_out  on 1=1         left join grp g on g.grp_id = rs.ogrp_id   group by rs.nomen_id, rs.nomen_code, rs.nomen_name, rs.ogrp_name,           pp_in.oprice, pp_out.oprice, g.grp_fullname', '���������� �������� ��� �� ��������� ���������', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (31, '��� �� �������� �� ����', 'select o.name, d.doc_date, d.time_cr, c.name, k.kardcode, s.procent, slashparser(g.grp_fullname,1),         g.grp_name, n.nomen_name, m.maker_name, dr.kilk, dr.price, (dr.kilk * dr.price),         calcsum((dr.kilk * dr.price), (dr.kilk * dr.price) - dr.insum_pdv, dr.typepdv_pdv, dr.typepdv_id, 0),         ((dr.kilk * dr.price)-dr.insum_pdv)/(dr.kilk * dr.price + 0.0000000001)*100, g.grp_fullname   from documents d        left join docrec dr              left join nomen n                   left join grp   g on g.grp_id = n.grp_id                   left join maker m on n.maker_id = m.maker_id               on n.nomen_id = dr.nomen_id           on d.document_id = dr.document_id        left join clients o on d.objects_id = o.clients_id        left join clients c on d.clients_id = c.clients_id        left join kards   k            left join discont s on s.discont_id = k.discont_id          on d.kards_id   = k.kards_id  where d.typedoc_id = 11 and        d.doc_date between :idate0 and :idate1', '��� �� �������� �� ����', NULL);
INSERT INTO T_REPORTS (REPORT_ID, NAME, QUERY, DESCRIPT, ACCESS_ID)
               VALUES (32, '��� �� �������� ������', 'select omaker_name, osum_td2, osum_td2_pdv, okilk_td2, osum_td17, osum_td17_pdv,         okilk_td17, odelta_sum, odelta_sum_pdv, odelta_kilk   from pr_maker(:idate0, :idate1)', '��� ��� ����������� �����������', NULL);
commit work;

INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (11, 'DATE_BEGIN', 1, 11, 'DATE', '������� ������', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (12, 'DATE_END', 2, 11, 'DATE', 'ʳ���� ������', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (13, 'GRP_ID', 3, 11, 'TREE', '�� ����', NULL, NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (15, 'DATE_BEGIN', 1, 12, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (14, 'MN_TYPEPDV', 4, 11, 'IDLIST', '��� �������������', NULL, NULL, 'select t.typepdv_id as id, t.typepdv_name as name from typepdv t');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (16, 'DATE_END', 2, 12, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (17, 'DATE_BEGIN', 1, 1, 'DATE', '������� ������', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (18, 'DATE_END', 2, 1, 'DATE', 'ʳ���� ������', NULL, NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (31, 'IDATE', 1, 19, 'DATE', '��� ��:', '��� ��:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (32, 'ID', 1, 20, 'TREE', '��� �� ����:', '��� �� ����:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname    from grp   order by grp_id');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (33, 'IDATE', 1, 21, 'DATE', '³������ ��:', '³������ ��:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (34, 'IDATE0', 1, 22, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (35, 'IDATE1', 2, 22, 'DATE', 'ʳ���� ������:', 'ʳ���� ������:', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (36, 'IDATE0', 1, 23, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (37, 'IDATE1', 2, 23, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (42, 'IDATE0', 1, 27, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (43, 'IDATE1', 2, 27, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (44, 'IGRP_ID', 3, 27, 'TREE', '�� ����', '�� ����', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (46, 'INGRP_ID', 1, 28, 'TREE', '��� �� ����:', '��� �� ����:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp order by grp_id ');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (47, 'DATE_IN', 2, 28, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (48, 'DATE_OUT', 3, 28, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (49, 'FLAG0', 4, 28, 'IDLIST', '���� ����� ������', '���� ����� ������', NULL, ' select * from  ps_get_yesno');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (54, 'IDATE0', 1, 31, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (55, 'IDATE1', 2, 31, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (56, 'IDATE0', 1, 32, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (57, 'IDATE1', 2, 32, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (38, 'INGRP_ID', 1, 26, 'TREE', '��� �� ����:', '��� �� ����:', NULL, 'select grp_id as ogrp_id, prew_grp_id as oprew_grp_id, grp_name as oname from grp order by grp_id ');
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (39, 'DATE_IN', 2, 26, 'DATE', '������� ������', '������� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (40, 'DATE_OUT', 3, 26, 'DATE', 'ʳ���� ������', 'ʳ���� ������', NULL, NULL);
INSERT INTO T_REPORTFIELDS (T_REPORTFIELD_ID, NAME, FIELDPOSITION, REPORT_ID, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY)
                    VALUES (41, 'FLAG0', 4, 26, 'IDLIST', '���� ����� ������', '���� ����� ������', NULL, ' select * from  ps_get_yesno');
commit work;

INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (69, 8, 1, '����������', '����� �볺���', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (21, 1, 11, '���', '', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (26, 6, 11, '������ ��', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (22, 2, 11, '�����', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (23, 3, 11, '������ �-���', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (24, 4, 11, '������ ���� �������', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (27, 7, 11, '������ ��(���)', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (28, 8, 11, '������ ��', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (30, 10, 11, '������ ���', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (31, 11, 11, '�������', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (25, 5, 11, '������ �-���', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (29, 9, 11, '������ ��(���)', '', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (34, 1, 1, '��� ���.', '��� ���������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (35, 2, 1, '���� ���.', '���� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (36, 3, 1, '� ���.', '����� ���������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (37, 4, 1, '��', '���� �������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (38, 5, 1, '��(� ���)', '���� ������� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (39, 6, 1, '��', '���� ���������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (40, 7, 1, '�� (� ���)', '���� ��������� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (74, 1, 19, '�������� ���', '�������� ���', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (75, 2, 19, '����� ������', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (76, 3, 19, 'ʳ������', 'ʳ������ �� ���������� �� ���� ����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (77, 4, 19, 'ֳ��', 'ֳ�� �� ���� ����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (78, 5, 19, '����', '����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (79, 1, 20, '��. ���', '�������� ��� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (80, 2, 20, '�����', '����� ����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (81, 3, 20, '��������', '��������� ��������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (82, 4, 20, '�������', '������� ������ �� ����������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (83, 5, 20, '����. ����', 'ֳ�� �������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (84, 6, 20, '�����', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (85, 1, 21, '��� �����', '��� �����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (86, 2, 21, '����� �����', '����� �����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (87, 3, 21, '��� ���.', '��� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (88, 4, 21, '�����-���', '�����-���', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (89, 5, 21, '����� ������', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (90, 6, 21, '��.���.', '������� �����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (91, 7, 21, '����. �-���', '��������� �������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (92, 8, 21, 'ֳ�� ���������', 'ֳ�� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (93, 9, 21, '����. ����', '��������� ����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (94, 10, 21, '����. �-���', '�������� �������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (95, 11, 21, '����. ����', '�������� ����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (96, 12, 21, 'г��. �-���', 'г����� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (97, 13, 21, 'г�. ���', 'г����� ���', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (98, 1, 23, '� ���������', '� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (99, 2, 23, '��� ������', '��� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (100, 3, 23, '��''� �����������', '��''� �����������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (101, 4, 23, '������ �� ������', '������ �� ������ (�� ��� �����)', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (102, 5, 23, '���� ���������', '���� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (103, 6, 23, '��� ���������', '��� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (104, 7, 23, '�� (� ���)', '���� ��������� (� ���)', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (152, 14, 11, '����� г����1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (153, 15, 11, '����� г����2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (154, 16, 11, '����� г����3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (155, 25, 26, '����� г����1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (156, 26, 26, '����� г����2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (157, 27, 26, '����� г����3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (158, 7, 28, '����� г����1', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (159, 8, 28, '����� г����2', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (160, 9, 28, '����� г����3', '', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (163, 1, 31, '�������', '�������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (164, 2, 31, '���� ���������', '���� ���������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (136, 1, 28, '��. ���', '�������� ��� ������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (137, 2, 28, '����� ������', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (138, 3, 28, '����� �����', '����� �����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (139, 4, 28, '��������� �-���', 'ʳ������ ������, ����������� �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (140, 5, 28, '��������� ��� � ���', '���� ������������ �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (141, 6, 28, '������� ������ ���', '������� ������ ��� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (165, 3, 31, '��� ���������', '��� ���������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (161, 12, 11, '% �������', ' ', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (162, 13, 11, '����. % �������', ' ', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (166, 4, 31, '�볺��', '�볺��', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (167, 5, 31, '��� ������', '��� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (168, 6, 31, '������ �� ������', '������ �� ������', 'avg');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (169, 7, 31, '����� ������', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (170, 8, 31, 'ϳ������ ������', 'ϳ������ ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (171, 9, 31, '�����', '�����', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (172, 10, 31, '��������', '��������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (173, 11, 31, 'ʳ������', 'ʳ������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (174, 12, 31, 'ֳ��', 'ֳ��', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (175, 13, 31, '�� (� ���)', '�� (� ���)', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (176, 14, 31, '�� (��� ���)', '�� (��� ���)', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (177, 15, 31, '�������', '�������', 'avg');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (178, 16, 31, '������ ����', '������ ����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (179, 1, 32, '������� �����', '������� �����', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (181, 3, 32, '������ �� � ���, ���', '������ �� � ���, ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (182, 4, 32, '������ �-��', '������ �-��', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (112, 1, 26, '�� ������', '��������� ��� (��) ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (113, 2, 26, '��. ���', '�������� ��� ������', 'cou');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (114, 3, 26, '����� ������', '����� ������', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (115, 4, 26, '����� �����', '����� �����', NULL);
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (116, 5, 26, '���. �.', '���. �.', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (117, 6, 26, '���. �� � ���', '���. �� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (118, 7, 26, '���. �� � ���', '���. �� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (119, 8, 26, '���. ��.', '���. ��.', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (123, 12, 26, '����. �.', 'ʳ������ ������, ���������� �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (126, 15, 26, '����. ��', '����. ��', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (127, 16, 26, '����. �.', 'ʳ������ ������, ����������� �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (130, 19, 26, '����. ��', '����. ��', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (132, 21, 26, 'ʳ��. �.', 'ʳ������ ������ �� ����� ������� ������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (133, 22, 26, 'ʳ��. �� � ���', 'ʳ��. �� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (134, 23, 26, 'ʳ��. �� � ���', 'ʳ��. �� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (135, 24, 26, 'ʳ��. ��', 'ʳ��. ��', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (124, 13, 26, '����. �� � ���', '���� ����������� �� ������ ����� ������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (125, 14, 26, '����. �� � ���', '���� ����������� �� ������ ����� ������', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (128, 17, 26, '����. �� � ���', '���� ������������ �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (129, 18, 26, '����. �� � ���', '���� ������������ �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (131, 20, 26, '����. ���� ���', '���� ������������ �� ������ �����', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (185, 7, 32, '���. ������. �-��', '���������� ������������� �-��', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (186, 8, 32, 'ʳ����� �� ��� ���', 'ʳ����� �� ��� ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (187, 9, 32, 'ʳ����� �� � ���', 'ʳ����� �� � ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (188, 10, 32, 'ʳ����� �-�� ', 'ʳ����� �-�� ', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (180, 2, 32, '��. ��, ���', '������ �� ��� ���, ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (183, 5, 32, '�. ���. ������., ���', '���� ���������� ������������� ��� ���, ���', 'sum');
INSERT INTO T_REPORTCAPTIONS (REPORTCAPTION_ID, CAPTIONPOSITION, REPORT_ID, CAPTION, DESCRIPTION, FOOTER_OP)
                      VALUES (184, 6, 32, '�.���.����. ���, ���', '���� ���������� ������������� � ���, ���', 'sum');
commit work;

INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (1, '�� ���� ����� �� 0,09', 1);
INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (2, '�� ���� �����', 2);
INSERT INTO T_MARKUP_AROUNDS (MARKUP_AROUND_ID, AROUND_NAME, ORDER_ID)
                      VALUES (3, '�� ������ �����', 3);
commit work;


