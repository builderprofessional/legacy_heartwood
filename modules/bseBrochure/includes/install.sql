CREATE TABLE  `bseBrochures` (
  `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL DEFAULT '',
  `height` float NOT NULL DEFAULT '0',
  `width` float NOT NULL DEFAULT '0',
  `maxZoom` float NOT NULL DEFAULT '0',
  `pageColor` varchar(25) NOT NULL DEFAULT '',
  `pdfFile` varchar(75) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Holds info for the brochures';
CREATE TABLE  `bseBrochurePages` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `brochureid` int(1) unsigned NOT NULL DEFAULT '0',
  `imageFile` varchar(75) NOT NULL DEFAULT '',
  `pageNum` int(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Pages in a brochure';