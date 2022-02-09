# Banking-Query
A bank database is created in MySQL which included details such as 
customer information, and their relevant bank account details. This 
data is imported to Hive using Sqoop, and in Hive, the same is 
stored in an external table, which was partitioned with respect to type 
of the bank, and is compressed while saving, i.e., saved in ORC 
format. This data will be used to query any results for analysis 
purposes. The result of the query is again exported to MySQL using 
Sqoop. The same result is displayed in a webpage using Django.
