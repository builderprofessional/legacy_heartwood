CREATE TABLE  `bseProducts` (
  `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gallery_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `contact_id` int(1) UNSIGNED NOT NULL DEFAULT '0',
  `special_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `category_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `categoryName` varchar(75) NOT NULL DEFAULT '',
  `name` varchar(45) NOT NULL DEFAULT '',
  `description` text,
  `pitch_blurb` varchar(120) NOT NULL DEFAULT '',
  `price` varchar(15) NOT NULL DEFAULT '',
  `image_file` varchar(90) NOT NULL DEFAULT '',
  `pdf_file` varchar(90) NOT NULL DEFAULT '',
  `status` varchar(40) NOT NULL DEFAULT '',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `active` int(1) UNSIGNED NOT NULL DEFAULT '1',
  `stock` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `sorder` int(1) UNSIGNED NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE  `bseProductFeatures` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `prodid` int(2) NOT NULL DEFAULT '0',
  `text` varchar(75) NOT NULL DEFAULT '',
  `featured` bit(1) NOT NULL DEFAULT b'0',
  `sorder` int(1) NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;