
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

-- Start time	2023-02-15 11:11:13.575
-- Finish time	2023-02-15 11:11:54.076
-- SHOW VARIABLES LIKE "secure_file_priv"

-- training.1600000.processed.noemoticon.csv
-- testdata.manual.2009.06.14.csv