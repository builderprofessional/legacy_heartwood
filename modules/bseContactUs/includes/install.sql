CREATE TABLE  `bseContactUs` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `useContactForm` tinyint(1) NOT NULL DEFAULT 1,
  `useWarrantyForm` tinyint(1) NOT NULL DEFAULT 1,
  `useContactsList` tinyint(1) NOT NULL DEFAULT 1,
  `company` varchar(50) NOT NULL DEFAULT '',
  `address1` varchar(75) NOT NULL DEFAULT '',
  `address2` varchar(75) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `state` varchar(30) NOT NULL DEFAULT '',
  `zip` varchar(15) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `fax` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `bseContactUs` SET `id`=NULL,`name`='default';
CREATE TABLE  `bseContacts` (
  `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(75) NOT NULL,
  `title` varchar(60) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `cell` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `image_file` varchar(150) NOT NULL,
  `department` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;