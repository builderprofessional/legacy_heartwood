CREATE TABLE IF NOT EXISTS `bseSlideshows` (
  `id` tinyint(1) unsigned NOT NULL auto_increment,
  `duration` tinyint(1) unsigned NOT NULL default '5',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
CREATE TABLE IF NOT EXISTS `bseSlideshowImages` (
  `id` tinyint(1) unsigned NOT NULL auto_increment,
  `show_id` tinyint(1) unsigned NOT NULL default '0',
  `file` varchar(75) NOT NULL DEFAULT '',
  `label` varchar(150) NOT NULL DEFAULT '',
  `link` varchar(100) NOT NULL DEFAULT '',
  `sorder` tinyint(1) unsigned NOT NULL default '255',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
INSERT INTO `bseSlideshows` SET `id`='1', `duration`='5';
