CREATE TABLE  `bseHomes` (
  `id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_id` int(1) UNSIGNED NOT NULL DEFAULT '0',
  `gallery_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `community_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `contact_id` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `lot` varchar(10) NOT NULL DEFAULT '',
  `addr` varchar(40) NOT NULL DEFAULT '',
  `city` varchar(30) NOT NULL DEFAULT '',
  `state` varchar(25) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `price` varchar(15) NOT NULL DEFAULT '',
  `beds` varchar(10) NOT NULL DEFAULT '',
  `baths` varchar(10) NOT NULL DEFAULT '',
  `partbaths` varchar(10) NOT NULL DEFAULT '',
  `floors` varchar(4) NOT NULL DEFAULT '',
  `garage` varchar(30) NOT NULL DEFAULT '',
  `sqft` varchar(10) NOT NULL DEFAULT '',
  `lotsize` varchar(35) NOT NULL DEFAULT '',
  `acres` varchar(15) NOT NULL DEFAULT '',
  `yr_built` varchar(4) NOT NULL DEFAULT '',
  `mls` varchar(20) NOT NULL DEFAULT '',
  `image_file` varchar(90) NOT NULL DEFAULT '',
  `fp_pdf` varchar(90) NOT NULL DEFAULT '',
  `fp_jpg` varchar(90) NOT NULL DEFAULT '',
  `description` text,
  `status` varchar(40) NOT NULL DEFAULT '',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `active` int(1) UNSIGNED NOT NULL DEFAULT '1',
  `sorder` int(1) UNSIGNED NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `bseHomesPage` (
  `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page` varchar(90) NOT NULL DEFAULT '',
  `useMailFriend` tinyint(1) NOT NULL DEFAULT '1',
  `useMortgageCalc` tinyint(1) NOT NULL DEFAULT '1',
  `usePrintPage` tinyint(1) NOT NULL DEFAULT '1',
  `useToolBox` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE  `sent_mails` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `time_sent` varchar(15) NOT NULL,
  `ip_address` varchar(20) NOT NULL,
  `from_email` varchar(70) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;