CREATE TABLE  `bseUsers` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(75) NOT NULL,
  `lastName` varchar(75) NOT NULL,
  `typeId` int(4) unsigned NOT NULL DEFAULT '0',
  `uName` varchar(75) NOT NULL,
  `pWord` varchar(75) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `bseUsers` SET `firstName`="Rick",`lastName`="Powell",`typeId`=1,`uName`="rickbse9",`pWord`="29b17469a943f0bc0bd12b022f59552b043f012089d531735846824585d68228",`active`=1;
CREATE TABLE `bseUserData` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(9) unsigned NOT NULL,
  `address1` varchar(35) NOT NULL DEFAULT '',
  `address2` varchar(35) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `state` varchar(30) NOT NULL DEFAULT '',
  `zip` varchar(12) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `cell` varchar(20) NOT NULL DEFAULT '',
  `fax` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
CREATE TABLE  `bseUserTypes` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `typeName` varchar(25) NOT NULL DEFAULT '',
  `description` varchar(125) NOT NULL DEFAULT '',
  `priveleges_id` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Holds info for which type of user';
INSERT INTO `bseUserTypes` SET `id` = 1, `typeName`='Programmers',`description`='Has access to all parts of the site, including the site management pages',`priveleges_id`=1;
INSERT INTO `bseUserTypes` SET `id` = 2, `typeName`='Admin',`description`='Has access to all of the content management parts of the site.',`priveleges_id`=1;
CREATE TABLE  `bseUserPriveleges` (
  `id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `page` varchar(150) NOT NULL DEFAULT '',
  `privelege` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = Read access, 2 = write access.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Use This Table to set access rights for a specified webpage';
INSERT INTO `bseUserPriveleges` SET `name`="Complete Access", `page`="*", `privelege`=2;
INSERT INTO `bseUserPriveleges` SET `name`="Read-Only", `page`="*", `privelege`=1;
CREATE TABLE  `bseContentData` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page` varchar(45) NOT NULL DEFAULT '',
  `code` text,
  `title` varchar(75) DEFAULT NULL,
  `javascript` text,
  `metaDesc` text,
  `metaKeywords` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseModuleFiles` (
  `file_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(65) NOT NULL DEFAULT '',
  `module_directory` varchar(45) NOT NULL,
  `file_version` varchar(15) NOT NULL DEFAULT '',
  `file_installed` int(1) NOT NULL DEFAULT '0',
  `file_install_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`file_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseModules` (
  `module_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(1) unsigned NOT NULL DEFAULT '0',
  `module_name` varchar(60) NOT NULL DEFAULT '',
  `db_table_name` varchar(30) NOT NULL DEFAULT '',
  `module_installed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`) USING BTREE,
  UNIQUE KEY `module_name` (`module_name`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;