USE Bank;

DROP TABLE IF EXISTS `creditcard`;
CREATE TABLE `creditcard` (
`ccid` int primary key NOT NULL AUTO_INCREMENT,
`cc_number` char(30) NOT NULL,
`user_id` int NOT NULL,
`maximum_credit` int NOT NULL,
`outstanding_bal` int NOT NULL,
`due_date` date NOT NULL,
`issuingbank` CHAR(100) NOT NULL,
`created_on` TIMESTAMP
);

DROP PROCEDURE insert_test_data;
DELIMITER $
CREATE PROCEDURE insert_test_data()
BEGIN
DECLARE i INT DEFAULT 1000;
WHILE i < 2000 DO

INSERT INTO `creditcard`(
`cc_number`
,`user_id`
,`maximum_credit`
,`outstanding_bal`
,`due_date`
, `issuingbank`
)
VALUES(
concat(convert(floor(rand()*10000),char),convert(floor(rand()*10000),char),convert(floor(rand()*10000),char),convert(floor(rand()*10000),char))
,floor(rand()*1000)
,rand()*10000
,rand()*10000
,TIMESTAMP('2019-10-01 00:53:27')-INTERVAL RAND()*365 DAY
,'MYBANK'
);

SET i = i + 1;
END WHILE;
END$$
DELIMITER ;
call insert_test_data();

update creditcard set issuingbank = 'YOURBANK' where ccid < (300);
update creditcard set issuingbank = 'OURBANK' where ccid > (600);


