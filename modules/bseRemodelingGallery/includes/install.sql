CREATE TABLE `bseRemodelingGalleryImages` (
  `id` int(2) unsigned NOT NULL auto_increment,
  `img_id` int(2) unsigned NOT NULL default '0',
  `during_galid` int(2) unsigned NOT NULL default '0',
  `before_file` varchar(75) NOT NULL default '',
  `description` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `img_id` (`img_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
