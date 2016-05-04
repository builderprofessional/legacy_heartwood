CREATE TABLE `bseSlideImage` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `slider_id` int(5) NOT NULL,
  `image_file` varchar(35) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `sorder` int(1) unsigned NOT NULL DEFAULT '255',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1'CREATE TABLE  `bseImageSlider` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `scrollWidth` float NOT NULL DEFAULT 0,
  `imageHeight` float NOT NULL DEFAULT 0,
  `sliderSpeed` int(1) NOT NULL DEFAULT '1',
  `backgroundColor` char(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;