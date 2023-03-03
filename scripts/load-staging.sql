
-- Stage the data

USE tweety;

LOAD DATA INFILE '/var/lib/mysql-files/training.1600000.processed.noemoticon.csv' IGNORE 
INTO TABLE staging
CHARACTER SET 
	latin1
FIELDS 
	TERMINATED BY ','
	ENCLOSED BY '"'
	ESCAPED BY ''
LINES TERMINATED BY '\n'
