mysql -uroot -pcloudera < /home/cloudera/Desktop/MysqlScript.sql
sqoop job --exec BankProject
hive < /home/cloudera/Desktop/HiveScript.hql
sqoop export --username root --password cloudera --connect jdbc:mysql://localhost/Bank -m 1 --table report_mysql --export-dir /user/hive/warehouse/bankproject.db/report --input-fields-terminated-by ','
