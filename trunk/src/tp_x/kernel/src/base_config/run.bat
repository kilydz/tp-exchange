isql -i MD.sql -u SYSDBA -p masterkey

pause

isql 127.0.0.1:D:/BASE/SHOP.GDB -i data_init.sql -u SYSDBA -p masterkey

pause