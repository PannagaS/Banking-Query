USE bankproject;

CREATE TABLE creditcard (
ccid int ,
cc_number string,
user_id int,
maximum_credit int,
outstanding_bal int,
due_date date ,
issuingbank string,
created_on timestamp
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',';
LOAD DATA  INPATH '/user/cloudera/Project_cc/part-m-00000' INTO TABLE creditcard;


SET hive.exec.dynamic.partition.mode = nonstrict;
DROP TABLE IF EXISTS creditcard_ext;
CREATE TABLE creditcard_ext (
day_id int,
cc_number string,
user_id int,
maximum_credit int,
outstanding_bal int,
due_date date)
PARTITIONED BY(`issuingbank` string);
INSERT OVERWRITE TABLE creditcard_ext PARTITION(issuingbank) SELECT ccid,Encrypt_text(cc_number),user_id,maximum_credit, outstanding_bal,due_date,issuingbank FROM creditcard;
DROP TABLE creditcard;


FROM creditcard_ext
INSERT INTO TABLE cc_external SELECT *;

DROP TABLE IF EXISTS report;
CREATE TABLE report
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
AS SELECT Evaluate_text(Decrypt_text(cc_number)), user_id,issuingbank,
location FROM creditcard_ext
INNER JOIN bankinfo_external ON 
creditcard_ext.issuingbank = bankinfo_external.name
WHERE date_format (due_date,'yyyy')='2019';
insert overwrite table report select distinct * from report;



