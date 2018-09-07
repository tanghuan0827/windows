use future;
/*drop table pap805;*/
	
CREATE TABLE `pap805` (
  `date_p` date DEFAULT NULL,
  `open_p` decimal(20,3) DEFAULT NULL,
  `high_p` decimal(20,3) DEFAULT NULL,
  `low_p` decimal(20,3) DEFAULT NULL,
  `close_p` decimal(20,3) DEFAULT NULL,
  `hold_number_p` int default null
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


	
load data infile 'E:/note/future/AP1805_price.csv' into table pap805 fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n';