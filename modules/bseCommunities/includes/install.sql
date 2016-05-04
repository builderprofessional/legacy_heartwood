CREATE TABLE  `bseCommunities` (
  `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `map_id` int(1) UNSIGNED NOT NULL DEFAULT '1',
  `contact_id` int(4) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(150) NOT NULL DEFAULT 'New Community',
  `address` text NOT NULL,
  `description` text,
  `priceRange` varchar(255) NOT NULL DEFAULT '',
  `sizeRange` varchar(255) NOT NULL DEFAULT '',
  `point` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseCommMaps` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mapName` varchar(255) NOT NULL DEFAULT '',
  `point` varchar(255) NOT NULL DEFAULT '',
  `zoom` int(2) unsigned NOT NULL DEFAULT '0',
  `width` int(5) unsigned NOT NULL DEFAULT '650',
  `height` int(5) unsigned NOT NULL DEFAULT '400',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `bseCommMaps` SET `id`=0,`mapName`='Default',`point`='39.5,-98.35',`zoom`='4',`width`='600',`height`='350';
UPDATE `bseCommMaps` SET `id`=0;
CREATE TABLE  `bseCommFloorplans` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `comm_id` int(2) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `shortDesc` varchar(350) NOT NULL DEFAULT '',
  `price` int(4) unsigned NOT NULL DEFAULT '0',
  `size` varchar(30) NOT NULL DEFAULT '',
  `completion` varchar(100) NOT NULL DEFAULT '',
  `photo` varchar(45) NOT NULL DEFAULT '',
  `pdf` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseCommFloorplanTexts` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `planid` int(2) unsigned NOT NULL,
  `label` varchar(25) NOT NULL,
  `text` varchar(300) NOT NULL,
  `sorder` int(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseCommFloorplanImages` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `planid` int(2) unsigned NOT NULL DEFAULT '0',
  `imageFile` varchar(75) NOT NULL,
  `pdfFile` varchar(75) NOT NULL,
  `sorder` int(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseCommunityDetailDefaultMetaData` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `panel` char(1) NOT NULL,
  `title` varchar(200) NOT NULL,
  `desc` text NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseCommDetail` (
  `id` INT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `comm_id` INT(4) UNSIGNED NOT NULL DEFAULT '0',
  `cpanel` char(2) NOT NULL DEFAULT '',
  `commphoto` varchar(64) NOT NULL DEFAULT '',
  `commpdf` varchar(64) NOT NULL DEFAULT '',
  `commtext` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8