CREATE TABLE  `bsePhotoGalleryImages` (
  `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `catid` int(1) NOT NULL DEFAULT 0,
  `image_file` varchar(50) NOT NULL DEFAULT '',
  `caption` varchar(150) NOT NULL DEFAULT '',
  `sorder` int(1) UNSIGNED NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bsePhotoGalleryCategories` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `galid` int(1) NOT NULL DEFAULT 0,
  `name` varchar(35) NOT NULL DEFAULT '',
  `description` varchar(250) NOT NULL DEFAULT '',
  `sorder` int(1) UNSIGNED NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE `bsePhotoGalleries` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page` varchar(100) NOT NULL DEFAULT '',
  `rows` int(1) UNSIGNED NOT NULL DEFAULT 3,
  `cols` int(1) UNSIGNED NOT NULL DEFAULT 4,
  `sliding` int(1) UNSIGNED NOT NULL DEFAULT 0,
  `thumb_h` int(2) UNSIGNED NOT NULL DEFAULT 150,
  `thumb_w` int(2) UNSIGNED NOT NULL DEFAULT 200,
  `sorder` int(1) UNSIGNED NOT NULL DEFAULT 99,
  PRIMARY KEY(`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `bsePhotoGalleries` SET `page`='gallery/index.php';