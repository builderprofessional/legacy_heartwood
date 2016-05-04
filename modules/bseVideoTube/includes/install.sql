CREATE TABLE  `bseVideos` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_id` int(2) unsigned NOT NULL DEFAULT '0',
  `width` int(1) unsigned NOT NULL DEFAULT '520',
  `height` int(1) unsigned NOT NULL DEFAULT '460',
  `title` varchar(75) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `videoFile` varchar(150) NOT NULL DEFAULT '',
  `previewFile` varchar(150) NOT NULL DEFAULT '',
  `originalFile` varchar(150) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseVideoGalleries` (
  `id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(2) unsigned NOT NULL DEFAULT '0',
  `width` int(1) unsigned NOT NULL DEFAULT '300',
  `height` int(1) unsigned NOT NULL DEFAULT '250',
  `bgColor` char(6) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;