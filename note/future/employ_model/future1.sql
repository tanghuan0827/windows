CREATE TABLE `万得` (
  `日期` varchar(255) DEFAULT NULL,
  `名次` varchar(255) DEFAULT NULL,
  `会员简称` varchar(255) DEFAULT NULL,
  `多单量` varchar(255) DEFAULT NULL,
  `增减` varchar(255) DEFAULT NULL,
  `多单占比(%)` varchar(255) DEFAULT NULL,
  `空单量` varchar(255) DEFAULT NULL,
  `增减 (1)` varchar(255) DEFAULT NULL,
  `空单占比(%)` varchar(255) DEFAULT NULL,
  `净多单` varchar(255) DEFAULT NULL,
  `增减 (2)` varchar(255) DEFAULT NULL,
  `净空单` varchar(255) DEFAULT NULL,
  `增减 (3)` varchar(255) DEFAULT NULL,
  `净单占比(%)` varchar(255) DEFAULT NULL,
  `成交量` varchar(255) DEFAULT NULL,
  `增减 (4)` varchar(255) DEFAULT NULL,
  `成交占比(%)` varchar(255) DEFAULT NULL,
  `结算价` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;