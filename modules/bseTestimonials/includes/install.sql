CREATE TABLE  `bseTestimonials` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `customerName` varchar(75) NOT NULL DEFAULT '',
  `image_file` varchar(75) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `sorder` int(1) unsigned NOT NULL DEFAULT '255',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8