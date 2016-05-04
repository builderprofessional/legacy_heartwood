CREATE TABLE  `bseBuildProcess` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `image_file` varchar(100) NOT NULL DEFAULT '',
  `sorder` int(1) unsigned NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8