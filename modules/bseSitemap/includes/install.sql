CREATE TABLE  `bseSitemap` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(150) NOT NULL,
  `url` varchar(100) NOT NULL,
  `sorder` int(1) unsigned NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8