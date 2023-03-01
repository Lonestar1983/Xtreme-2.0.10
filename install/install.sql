--
-- Table structure for table `nuke_admin_fc`
--

CREATE TABLE `nuke_admin_fc` (
  `fc_datetime` varchar(25) NOT NULL DEFAULT '',
  `fc_ip` varchar(255) NOT NULL DEFAULT '',
  `fc_attempts` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fc_attempts`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `nuke_authors`
--

CREATE TABLE `nuke_authors` (
  `aid` varchar(25) NOT NULL DEFAULT '',
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `pwd` varchar(40) DEFAULT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  `radminsuper` tinyint(1) NOT NULL DEFAULT '1',
  `admlanguage` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_autonews`
--

CREATE TABLE `nuke_autonews` (
  `anid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `aid` varchar(30) NOT NULL,
  `title` varchar(80) NOT NULL,
  `time` varchar(19) NOT NULL DEFAULT '',
  `hometext` text NOT NULL,
  `bodytext` text NOT NULL,
  `topic` int(11) NOT NULL DEFAULT '1',
  `informant` varchar(40) NOT NULL,
  `notes` text NOT NULL,
  `ihome` tinyint(4) NOT NULL DEFAULT '0',
  `alanguage` varchar(30) NOT NULL,
  `acomm` tinyint(4) NOT NULL DEFAULT '0',
  `associated` text NOT NULL,
  `ticon` tinyint(1) NOT NULL DEFAULT '0',
  `writes` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`anid`),
  UNIQUE KEY `anid` (`anid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbadvanced_username_color`
--

CREATE TABLE `nuke_bbadvanced_username_color` (
  `group_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL DEFAULT '',
  `group_color` varchar(6) NOT NULL DEFAULT '',
  `group_weight` smallint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbadvanced_username_color`
--

INSERT INTO `nuke_bbadvanced_username_color` (`group_id`, `group_name`, `group_color`, `group_weight`) VALUES
(1, 'Administrators', 'd12727', 1),
(2, 'Moderators', 'd38d01', 2),
(3, 'VIP', '00aa00', 3),
(4, 'Member', '00b3ff', 4);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbattachments`
--

CREATE TABLE `nuke_bbattachments` (
  `attach_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `privmsgs_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `user_id_1` mediumint(8) NOT NULL DEFAULT '0',
  `user_id_2` mediumint(8) NOT NULL DEFAULT '0',
  KEY `attach_id_post_id` (`attach_id`,`post_id`),
  KEY `attach_id_privmsgs_id` (`attach_id`,`privmsgs_id`),
  KEY `post_id` (`post_id`),
  KEY `privmsgs_id` (`privmsgs_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbattachments_config`
--

CREATE TABLE `nuke_bbattachments_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbattachments_config`
--

INSERT INTO `nuke_bbattachments_config` (`config_name`, `config_value`) VALUES
('upload_dir', 'modules/Forums/files'),
('upload_img', 'modules/Forums/images/attachment-download.png'),
('topic_icon', 'modules/Forums/images/attachment.png'),
('display_order', '0'),
('max_filesize', '262144'),
('attachment_quota', '52428800'),
('max_filesize_pm', '262144'),
('max_attachments', '3'),
('max_attachments_pm', '1'),
('disable_mod', '0'),
('allow_pm_attach', '1'),
('attachment_topic_review', '1'),
('allow_ftp_upload', '0'),
('show_apcp', '0'),
('attach_version', '2.4.5'),
('default_upload_quota', '0'),
('default_pm_quota', '0'),
('ftp_server', 'ftp.yoursite.com'),
('ftp_path', '/public_html/modules/Forums/files'),
('download_path', 'http://www.yoursite.com/modules/Forums/files'),
('ftp_user', ''),
('ftp_pass', ''),
('ftp_pasv_mode', '1'),
('img_display_inlined', '1'),
('img_max_width', '0'),
('img_max_height', '0'),
('img_link_width', '0'),
('img_link_height', '0'),
('img_create_thumbnail', '1'),
('img_min_thumb_filesize', '12000'),
('img_imagick', '/usr/bin/convert'),
('use_gd2', '0'),
('wma_autoplay', '0'),
('flash_autoplay', '0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbattachments_desc`
--

CREATE TABLE `nuke_bbattachments_desc` (
  `attach_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `physical_filename` varchar(255) NOT NULL DEFAULT '',
  `real_filename` varchar(255) NOT NULL DEFAULT '',
  `download_count` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `comment` varchar(255) DEFAULT NULL,
  `extension` varchar(100) DEFAULT NULL,
  `mimetype` varchar(100) DEFAULT NULL,
  `filesize` int(20) NOT NULL DEFAULT '0',
  `filetime` int(11) NOT NULL DEFAULT '0',
  `thumbnail` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attach_id`),
  KEY `filetime` (`filetime`),
  KEY `physical_filename` (`physical_filename`(10)),
  KEY `filesize` (`filesize`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbattach_quota`
--

CREATE TABLE `nuke_bbattach_quota` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `quota_type` smallint(2) NOT NULL DEFAULT '0',
  `quota_limit_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  KEY `quota_type` (`quota_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbauth_access`
--

CREATE TABLE `nuke_bbauth_access` (
  `group_id` mediumint(8) NOT NULL DEFAULT '0',
  `forum_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `auth_view` tinyint(1) NOT NULL DEFAULT '0',
  `auth_read` tinyint(1) NOT NULL DEFAULT '0',
  `auth_post` tinyint(1) NOT NULL DEFAULT '0',
  `auth_reply` tinyint(1) NOT NULL DEFAULT '0',
  `auth_edit` tinyint(1) NOT NULL DEFAULT '0',
  `auth_delete` tinyint(1) NOT NULL DEFAULT '0',
  `auth_sticky` tinyint(1) NOT NULL DEFAULT '0',
  `auth_announce` tinyint(1) NOT NULL DEFAULT '0',
  `auth_globalannounce` tinyint(1) NOT NULL DEFAULT '0',
  `auth_vote` tinyint(1) NOT NULL DEFAULT '0',
  `auth_pollcreate` tinyint(1) NOT NULL DEFAULT '0',
  `auth_attachments` tinyint(1) NOT NULL DEFAULT '0',
  `auth_mod` tinyint(1) NOT NULL DEFAULT '0',
  `auth_download` tinyint(1) NOT NULL DEFAULT '0',
  KEY `group_id` (`group_id`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbbanlist`
--

CREATE TABLE `nuke_bbbanlist` (
  `ban_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ban_userid` mediumint(8) NOT NULL DEFAULT '0',
  `ban_ip` varchar(8) NOT NULL DEFAULT '',
  `ban_email` varchar(255) DEFAULT NULL,
  `ban_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`ban_id`),
  KEY `ban_ip_user_id` (`ban_ip`,`ban_userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbcategories`
--

CREATE TABLE `nuke_bbcategories` (
  `cat_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(100) DEFAULT NULL,
  `cat_order` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  KEY `cat_order` (`cat_order`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbcategories`
--

INSERT INTO `nuke_bbcategories` (`cat_id`, `cat_title`, `cat_order`) VALUES
(1, 'General', 10);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbconfig`
--

CREATE TABLE `nuke_bbconfig` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbconfig`
--

INSERT INTO `nuke_bbconfig` (`config_name`, `config_value`) VALUES
('config_id', '1'),
('board_disable', '0'),
('board_disable_adminview', '1'),
('board_disable_msg', 'The board is currently disabled...'),
('sitename', 'My Site'),
('site_desc', ''),
('cookie_name', 'nukeevo'),
('cookie_path', '/'),
('cookie_domain', 'MySite.com'),
('cookie_secure', '0'),
('session_length', '3600'),
('allow_html', '1'),
('allow_html_tags', 'b,i,u,pre'),
('allow_bbcode', '1'),
('allow_smilies', '1'),
('allow_sig', '1'),
('allow_namechange', '0'),
('allow_theme_create', '0'),
('allow_avatar_local', '1'),
('allow_avatar_remote', '0'),
('allow_avatar_upload', '0'),
('override_user_style', '1'),
('posts_per_page', '15'),
('topics_per_page', '50'),
('hot_threshold', '25'),
('max_poll_options', '10'),
('max_sig_chars', '255'),
('max_smilies', '15'),
('max_inbox_privmsgs', '100'),
('max_sentbox_privmsgs', '100'),
('max_savebox_privmsgs', '100'),
('board_email_sig', 'Thanks, Webmaster@MySite.com'),
('board_email', 'Webmaster@MySite.com'),
('smtp_delivery', '0'),
('smtp_host', ''),
('require_activation', '0'),
('flood_interval', '15'),
('search_flood_interval', '15'),
('board_email_form', '0'),
('avatar_filesize', '6144'),
('avatar_max_width', '80'),
('avatar_max_height', '80'),
('avatar_path', 'modules/Forums/images/avatars'),
('avatar_gallery_path', 'modules/Forums/images/avatars'),
('smilies_path', 'modules/Forums/images/smiles'),
('default_style', '1'),
('default_dateformat', 'D M d, Y g:i a'),
('board_timezone', '10'),
('prune_enable', '0'),
('privmsg_disable', '0'),
('gzip_compress', '0'),
('coppa_fax', ''),
('coppa_mail', ''),
('board_startdate', '1131089812'),
('default_lang', 'english'),
('smtp_username', ''),
('smtp_password', ''),
('record_online_users', '2'),
('record_online_date', '1034668530'),
('server_name', 'MySite.com'),
('server_port', '80'),
('script_path', '/modules/Forums/'),
('version', '.0.23'),
('enable_confirm', '0'),
('sendmail_fix', '0'),
('sig_max_lines', '5'),
('sig_wordwrap', '100'),
('sig_allow_font_sizes', '1'),
('sig_min_font_size', '7'),
('sig_max_font_size', '12'),
('sig_allow_bold', '1'),
('sig_allow_italic', '1'),
('sig_allow_underline', '1'),
('sig_allow_colors', '1'),
('sig_allow_quote', '0'),
('sig_allow_code', '0'),
('sig_allow_list', '0'),
('sig_allow_url', '1'),
('sig_allow_images', '1'),
('sig_max_images', '0'),
('sig_max_img_height', '75'),
('sig_max_img_width', '500'),
('sig_allow_on_max_img_size_fail', '0'),
('sig_max_img_files_size', '10'),
('sig_max_img_av_files_size', '0'),
('sig_exotic_bbcodes_disallowed', ''),
('sig_allow_smilies', '1'),
('report_email', '1'),
('ropm_quick_reply', '1'),
('ropm_quick_reply_bbc', '1'),
('ropm_quick_reply_smilies', '22'),
('wrap_enable', '1'),
('wrap_min', '50'),
('wrap_max', '99'),
('wrap_def', '70'),
('allow_quickreply', '1'),
('anonymous_show_sqr', '0'),
('anonymous_sqr_mode', '0'),
('quick_search_enable', '1'),
('sig_line', '<hr>'),
('default_avatar_guests_url', 'modules/Forums/images/avatars/blank.png'),
('default_avatar_users_url', 'modules/Forums/images/avatars/blank.png'),
('default_avatar_set', '2'),
('pm_allow_threshold', '0'),
('welcome_pm', '0'),
('default_time_mode', '6'),
('default_dst_time_lag', '60'),
('glance_show', '2'),
('glance_show_override', '1'),
('glance_news_id', '0'),
('glance_num_news', '0'),
('glance_num', '6'),
('glance_ignore_forums', '0'),
('glance_table_width', '100%'),
('glance_auth_read', '1'),
('glance_topic_length', '0'),
('online_time', '300'),
('display_users_today', '0'),
('locked_view_open', 'Locked: <strike>'),
('locked_view_close', '</strike>'),
('global_view_open', 'Global Announcement:'),
('global_view_close', ''),
('announce_view_open', 'Announcement:'),
('announce_view_close', ''),
('sticky_view_open', 'Sticky:'),
('sticky_view_close', ''),
('moved_view_open', 'Moved:'),
('moved_view_close', ''),
('initial_group_id', '3'),
('hide_links', '0'),
('hide_emails', '0'),
('hide_images', '0'),
('use_dhtml', '1'),
('anonymous_open_sqr', '0'),
('smilies_in_titles', '1'),
('show_edited_logs', '1'),
('show_locked_logs', '1'),
('show_unlocked_logs', '1'),
('show_splitted_logs', '1'),
('show_moved_logs', '1'),
('logs_view_level', '2'),
('aprvmArchive', '0'),
('aprvmVersion', '1.6.0'),
('aprvmView', '0'),
('aprvmRows', '25'),
('aprvmIP', '1'),
('image_resize_width', '400'),
('image_resize_height', '400'),
('use_theme_style', '1'),
('allow_autologin', '1'),
('max_autologin_time', '0'),
('max_login_attempts', '5'),
('login_reset_time', '30'),
('show_sig_once', '0'),
('show_avatar_once', '0'),
('show_rank_once', '0'),
('loginpage', '1'),
('rand_seed', '0'),
('ftr_msg', 'Sorry *u*, you need to read our topic: \"*t*\" for new users. <br> After you read it, you can proceed to browse our posts normally. <br><br> Please click *l* to view the post.'),
('ftr_topic', '3'),
('ftr_active', '0'),
('ftr_who', '2'),
('ftr_installed', '1241642769'),
('global_title', 'Nuke-Evolution Xtreme!'),
('global_announcement', 'Evolution Xtreme brings you a fully loaded version of Nuke-Evolution.'),
('global_enable', '1'),
('marquee_disable', '0'),
('version_check_delay', '1241641548'),
('bday_show', '1'),
('bday_require', '0'),
('bday_year', '0'),
('bday_lock', '0'),
('bday_lookahead', '7'),
('bday_max', '100'),
('bday_min', '5'),
('bday_hide', '0'),
('bday_greeting', '0'),
('icon_per_row', '10'),
('ad_after_post', ''),
('ad_post_threshold', '1'),
('ad_every_post', '2'),
('ad_who', '1'),
('ad_no_forums', ''),
('ad_no_groups', ''),
('ad_old_style', '0'),
('xs_auto_compile', '1'),
('xs_auto_recompile', '1'),
('xs_use_cache', '1'),
('xs_php', 'php'),
('xs_def_template', 'subSilver'),
('xs_check_switches', '1'),
('xs_warn_includes', '1'),
('xs_add_comments', '0'),
('xs_ftp_host', ''),
('xs_ftp_login', ''),
('xs_ftp_path', ''),
('xs_downloads_count', '0'),
('xs_downloads_default', '0'),
('xs_shownav', '1'),
('xs_template_time', '1532797163'),
('xs_version', '8'),
('last_post_avatar', '1'),
('youtube_width', '640'),
('youtube_height', '360'),
('twitch_width', '640'),
('twitch_height', '360'),
('facebook_width', '640'),
('facebook_height', '360'),
('welcome_pm_username', '0'),
('glance_rowclass', '0'),
('smtp_encryption', 'none'),
('smtp_port', ''),
('smtp_auth', '0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbdisallow`
--

CREATE TABLE `nuke_bbdisallow` (
  `disallow_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `disallow_username` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`disallow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbextensions`
--

CREATE TABLE `nuke_bbextensions` (
  `ext_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `extension` varchar(100) NOT NULL DEFAULT '',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ext_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbextensions`
--

INSERT INTO `nuke_bbextensions` (`ext_id`, `group_id`, `extension`, `comment`) VALUES
(1, 1, 'gif', ''),
(2, 1, 'png', ''),
(3, 1, 'jpeg', ''),
(4, 1, 'jpg', ''),
(5, 1, 'tif', ''),
(6, 1, 'tga', ''),
(7, 2, 'gtar', ''),
(8, 2, 'gz', ''),
(9, 2, 'tar', ''),
(10, 2, 'zip', ''),
(11, 2, 'rar', ''),
(12, 2, 'ace', ''),
(13, 3, 'txt', ''),
(14, 3, 'c', ''),
(15, 3, 'h', ''),
(16, 3, 'cpp', ''),
(17, 3, 'hpp', ''),
(18, 3, 'diz', ''),
(19, 4, 'xls', ''),
(20, 4, 'doc', ''),
(21, 4, 'dot', ''),
(22, 4, 'pdf', ''),
(23, 4, 'ai', ''),
(24, 4, 'ps', ''),
(25, 4, 'ppt', ''),
(26, 5, 'rm', ''),
(27, 6, 'wma', ''),
(28, 7, 'swf', '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbextension_groups`
--

CREATE TABLE `nuke_bbextension_groups` (
  `group_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(20) NOT NULL DEFAULT '',
  `cat_id` tinyint(2) NOT NULL DEFAULT '0',
  `allow_group` tinyint(1) NOT NULL DEFAULT '0',
  `download_mode` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `upload_icon` varchar(100) DEFAULT '',
  `max_filesize` int(20) NOT NULL DEFAULT '0',
  `forum_permissions` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbextension_groups`
--

INSERT INTO `nuke_bbextension_groups` (`group_id`, `group_name`, `cat_id`, `allow_group`, `download_mode`, `upload_icon`, `max_filesize`, `forum_permissions`) VALUES
(1, 'Images', 1, 1, 2, '', 262144, ''),
(2, 'Archives', 0, 1, 2, '', 262144, ''),
(3, 'Plain Text', 0, 0, 2, '', 262144, ''),
(4, 'Documents', 0, 0, 2, '', 262144, ''),
(5, 'Real Media', 0, 0, 2, '', 262144, ''),
(6, 'Streams', 2, 0, 2, '', 262144, ''),
(7, 'Flash Files', 3, 0, 2, '', 262144, '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbflags`
--

CREATE TABLE `nuke_bbflags` (
  `flag_id` int(10) NOT NULL,
  `flag_name` varchar(50) DEFAULT NULL,
  `flag_image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`flag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=173;

INSERT INTO `nuke_bbflags` (`flag_id`, `flag_name`, `flag_image`) VALUES
(1, 'usa', 'usa.png'),
(2, 'afghanistan', 'afghanistan.png'),
(3, 'albania', 'albania.png'),
(4, 'algeria', 'algeria.png'),
(5, 'andorra', 'andorra.png'),
(6, 'antigua and barbuda', 'antigua_and_barbuda.png'),
(7, 'argentina', 'argentina.png'),
(8, 'armenia', 'armenia.png'),
(9, 'australia', 'australia.png'),
(10, 'austria', 'austria.png'),
(11, 'azerbaijan', 'azerbaijan.png'),
(12, 'bahamas', 'bahamas.png'),
(13, 'bahrain', 'bahrain.png'),
(14, 'bangladesh', 'bangladesh.png'),
(15, 'barbados', 'barbados.png'),
(16, 'belarus', 'belarus.png'),
(17, 'belgium', 'belgium.png'),
(18, 'belize', 'belize.png'),
(19, 'benin', 'benin.png'),
(20, 'bhutan', 'bhutan.png'),
(21, 'bolivia', 'bolivia.png'),
(22, 'bosnia and herzegovina', 'bosnia_and_herzegovina.png'),
(23, 'botswana', 'botswana.png'),
(24, 'brazil', 'brazil.png'),
(25, 'brunei', 'brunei.png'),
(26, 'bulgaria', 'bulgaria.png'),
(27, 'burkina faso', 'burkina_faso.png'),
(28, 'myanmar', 'myanmar.png'),
(29, 'burundi', 'burundi.png'),
(30, 'cambodia', 'cambodia.png'),
(31, 'cameroon', 'cameroon.png'),
(32, 'canada', 'canada.png'),
(33, 'chad', 'chad.png'),
(34, 'chile', 'chile.png'),
(35, 'china', 'china.png'),
(36, 'columbia', 'columbia.png'),
(37, 'comoros', 'comoros.png'),
(38, 'democratic republic of the congo', 'democratic_republic_of_the_congo.png'),
(39, 'croatia', 'croatia.png'),
(40, 'cuba', 'cuba.png'),
(41, 'cyprus', 'cyprus.png'),
(42, 'denmark', 'denmark.png'),
(43, 'djibouti', 'djibouti.png'),
(44, 'dominica', 'dominica.png'),
(45, 'dominican republic', 'dominican_republic.png'),
(46, 'ecuador', 'ecuador.png'),
(47, 'egypt', 'egypt.png'),
(48, 'el salvador', 'el_salvador.png'),
(49, 'england', 'england.png'),
(50, 'equatorial guinea', 'equatorial_guinea.png'),
(51, 'eritrea', 'eritrea.png'),
(52, 'estonia', 'estonia.png'),
(53, 'ethiopia', 'ethiopia.png'),
(54, 'fiji', 'fiji.png'),
(55, 'finland', 'finland.png'),
(56, 'france', 'france.png'),
(57, 'gabon', 'gabon.png'),

(58, 'gambia', 'gambia.png'),
(59, 'georgia', 'georgia.png'),
(60, 'germany', 'germany.png'),
(61, 'ghana', 'ghana.png'),
(62, 'greece', 'greece.png'),
(63, 'grenada', 'grenada.png'),
(64, 'saint vincent and the grenadines', 'saint_vincent_and_the_grenadines.png'),
(65, 'guatemala', 'guatemala.png'),
(66, 'guinea', 'guinea.png'),
(67, 'guyana', 'guyana.png'),
(68, 'haiti', 'haiti.png'),
(69, 'honduras', 'honduras.png'),
(70, 'hong kong', 'hong_kong.png'),
(71, 'hungary', 'hungary.png'),
(72, 'iceland', 'iceland.png'),
(73, 'india', 'india.png'),
(74, 'indonesia', 'indonesia.png'),
(75, 'iran', 'iran.png'),
(76, 'iraq', 'iraq.png'),
(77, 'ireland', 'ireland.png'),
(78, 'israel', 'israel.png'),
(79, 'italy', 'italy.png'),
(80, 'jamaica', 'jamaica.png'),
(81, 'japan', 'japan.png'),
(82, 'jordan', 'jordan.png'),
(83, 'kazakhstan', 'kazakhstan.png'),
(84, 'kenya', 'kenya.png'),
(85, 'kiribati', 'kiribati.png'),
(86, 'kuwait', 'kuwait.png'),
(87, 'kyrgyzstan', 'kyrgyzstan.png'),
(88, 'laos', 'laos.png'),
(89, 'latvia', 'latvia.png'),
(90, 'lebanon', 'lebanon.png'),
(91, 'liberia', 'liberia.png'),
(92, 'libya', 'libya.png'),
(93, 'liechtenstein', 'liechtenstein.png'),
(94, 'lithuania', 'lithuania.png'),
(95, 'luxembourg', 'luxembourg.png'),
(96, 'macau', 'macau.png'),
(97, 'madagascar', 'madagascar.png'),
(98, 'malawi', 'malawi.png'),
(99, 'malaysia', 'malaysia.png'),
(100, 'maldives', 'maldives.png'),
(101, 'mali', 'mali.png'),
(102, 'malta', 'malta.png'),
(103, 'mauritania', 'mauritania.png'),
(104, 'mauritius', 'mauritius.png'),
(105, 'mexico', 'mexico.png'),
(106, 'micronesia', 'micronesia.png'),
(107, 'moldova', 'moldova.png'),
(108, 'monaco', 'monaco.png'),
(109, 'mongolia', 'mongolia.png'),
(110, 'morocco', 'morocco.png'),
(111, 'mozambique', 'mozambique.png'),
(112, 'namibia', 'namibia.png'),
(113, 'nauru', 'nauru.png'),
(114, 'nepal', 'nepal.png'),
(115, 'netherlands', 'netherlands.png'),
(116, 'nicaragua', 'nicaragua.png'),
(117, 'niger', 'niger.png'),
(118, 'nigeria', 'nigeria.png'),
(119, 'norway', 'norway.png'),
(120, 'oman', 'oman.png'),
(121, 'pakistan', 'pakistan.png'),
(122, 'panama', 'panama.png'),
(123, 'paraguay', 'paraguay.png'),
(124, 'peru', 'peru.png'),
(125, 'philippines', 'philippines.png'),
(126, 'poland', 'poland.png'),
(127, 'portugal', 'portugal.png'),
(128, 'qatar', 'qatar.png'),
(129, 'romania', 'romania.png'),
(130, 'russia', 'russia.png'),
(131, 'sao tome and principe', 'sao_tome_and_principe.png'),
(132, 'senegal', 'senegal.png'),
(133, 'serbia', 'serbia.png'),
(134, 'seychelles', 'seychelles.png'),
(135, 'sierra leone', 'sierra_leone.png'),
(136, 'singapore', 'singapore.png'),
(137, 'slovakia', 'slovakia.png'),
(138, 'slovenia', 'slovenia.png'),
(139, 'solomon islands', 'solomon_islands.png'),
(140, 'somalia', 'somalia.png'),
(141, 'south_korea', 'south_korea.png'),
(142, 'spain', 'spain.png'),
(143, 'saint kitts and nevis', 'saint_kitts_and_nevis.png'),
(144, 'saint lucia', 'saint_lucia.png'),
(145, 'sudan', 'sudan.png'),
(146, 'suriname', 'suriname.png'),
(147, 'sweden', 'sweden.png'),
(148, 'switzerland', 'switzerland.png'),
(149, 'syria', 'syria.png'),
(150, 'taiwan', 'taiwan.png'),
(151, 'tajikistan', 'tajikistan.png'),
(152, 'tanzania', 'tanzania.png'),
(153, 'thailand', 'thailand.png'),
(154, 'togo', 'togo.png'),
(155, 'tonga', 'tonga.png'),
(156, 'tunisia', 'tunisia.png'),
(157, 'turkey', 'turkey.png'),
(158, 'turkmenistan', 'turkmenistan.png'),
(159, 'tuvalu', 'tuvalu.png'),
(160, 'uganda', 'uganda.png'),
(161, 'uk', 'uk.png'),
(162, 'ukraine', 'ukraine.png'),
(163, 'uruguay', 'uruguay.png'),
(164, 'uzbekistan', 'uzbekistan.png'),
(165, 'vanuatu', 'vanuatu.png'),
(166, 'venezuela', 'venezuela.png'),
(167, 'vietnam', 'vietnam.png'),
(168, 'western samoa', 'western_samoa.png'),
(169, 'yemen', 'yemen.png'),
(170, 'yugoslavia', 'yugoslavia.png'),
(171, 'zambia', 'zambia.png'),
(172, 'zimbabwe', 'zimbabwe.png');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbforbidden_extensions`
--

CREATE TABLE `nuke_bbforbidden_extensions` (
  `ext_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `extension` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`ext_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbforbidden_extensions`
--

INSERT INTO `nuke_bbforbidden_extensions` (`ext_id`, `extension`) VALUES
(1, 'php'),
(2, 'php3'),
(3, 'php4'),
(4, 'phtml'),
(5, 'pl'),
(6, 'asp'),
(7, 'cgi'),
(8, 'com'),
(9, 'bat'),
(10, 'scr');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbforums`
--

CREATE TABLE `nuke_bbforums` (
  `forum_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `forum_name` varchar(150) DEFAULT NULL,
  `forum_desc` text,
  `forum_status` tinyint(4) NOT NULL DEFAULT '0',
  `forum_order` mediumint(8) UNSIGNED NOT NULL DEFAULT '1',
  `forum_posts` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `forum_topics` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `forum_last_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `prune_next` int(11) DEFAULT NULL,
  `prune_enable` tinyint(1) NOT NULL DEFAULT '1',
  `auth_view` tinyint(2) NOT NULL DEFAULT '0',
  `auth_read` tinyint(2) NOT NULL DEFAULT '0',
  `auth_post` tinyint(2) NOT NULL DEFAULT '0',
  `auth_reply` tinyint(2) NOT NULL DEFAULT '0',
  `auth_edit` tinyint(2) NOT NULL DEFAULT '0',
  `auth_delete` tinyint(2) NOT NULL DEFAULT '0',
  `auth_sticky` tinyint(2) NOT NULL DEFAULT '0',
  `auth_announce` tinyint(2) NOT NULL DEFAULT '0',
  `auth_globalannounce` tinyint(2) NOT NULL DEFAULT '3',
  `auth_vote` tinyint(2) NOT NULL DEFAULT '0',
  `auth_pollcreate` tinyint(2) NOT NULL DEFAULT '0',
  `auth_attachments` tinyint(2) NOT NULL DEFAULT '0',
  `forum_display_sort` tinyint(1) NOT NULL DEFAULT '0',
  `forum_display_order` tinyint(1) NOT NULL DEFAULT '0',
  `auth_download` tinyint(2) NOT NULL DEFAULT '0',
  `forum_parent` int(11) NOT NULL DEFAULT '0',
  `forum_color` varchar(6) NOT NULL DEFAULT '',
  `title_is_link` tinyint(1) NOT NULL DEFAULT '0',
  `weblink` varchar(200) NOT NULL,
  `forum_link_icon` varchar(200) NOT NULL,
  `forum_link_count` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `forum_link_target` tinyint(1) NOT NULL DEFAULT '0',
  `forum_icon` varchar(255) DEFAULT NULL,
  `forum_thank` tinyint(1) NOT NULL DEFAULT '0',
  `forum_password` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`forum_id`),
  KEY `forums_order` (`forum_order`),
  KEY `cat_id` (`cat_id`),
  KEY `forum_last_post_id` (`forum_last_post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbforums`
--

INSERT INTO `nuke_bbforums` (`forum_id`, `cat_id`, `forum_name`, `forum_desc`, `forum_status`, `forum_order`, `forum_posts`, `forum_topics`, `forum_last_post_id`, `prune_next`, `prune_enable`, `auth_view`, `auth_read`, `auth_post`, `auth_reply`, `auth_edit`, `auth_delete`, `auth_sticky`, `auth_announce`, `auth_globalannounce`, `auth_vote`, `auth_pollcreate`, `auth_attachments`, `forum_display_sort`, `forum_display_order`, `auth_download`, `forum_parent`, `forum_color`, `title_is_link`, `weblink`, `forum_link_icon`, `forum_link_count`, `forum_link_target`, `forum_icon`, `forum_thank`, `forum_password`) VALUES
(1, 1, 'Site', '', 0, 10, 0, 0, 0, NULL, 0, 0, 0, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 0, 0, 1, 0, 'd40000', 0, 'http://', '', 0, 0, 'images/forum_icons/general.png', 1, '');


-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbforum_prune`
--

CREATE TABLE `nuke_bbforum_prune` (
  `prune_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `forum_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `prune_days` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  `prune_freq` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`prune_id`),
  KEY `forum_id` (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbgroups`
--

CREATE TABLE `nuke_bbgroups` (
  `group_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `group_type` tinyint(4) NOT NULL DEFAULT '1',
  `group_name` varchar(40) NOT NULL DEFAULT '',
  `group_description` varchar(255) NOT NULL DEFAULT '',
  `group_moderator` mediumint(8) NOT NULL DEFAULT '0',
  `group_single_user` tinyint(1) NOT NULL DEFAULT '1',
  `group_allow_pm` tinyint(2) NOT NULL DEFAULT '5',
  `group_color` varchar(15) NOT NULL DEFAULT '',
  `group_rank` varchar(5) NOT NULL DEFAULT '0',
  `max_inbox` mediumint(10) NOT NULL DEFAULT '100',
  `max_sentbox` mediumint(10) NOT NULL DEFAULT '100',
  `max_savebox` mediumint(10) NOT NULL DEFAULT '100',
  `override_max_inbox` tinyint(1) NOT NULL DEFAULT '0',
  `override_max_sentbox` tinyint(1) NOT NULL DEFAULT '0',
  `override_max_savebox` tinyint(1) NOT NULL DEFAULT '0',
  `group_count` int(4) UNSIGNED DEFAULT '99999999',
  `group_count_max` int(4) UNSIGNED DEFAULT '99999999',
  `group_count_enable` smallint(2) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`group_id`),
  KEY `group_single_user` (`group_single_user`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbgroups`
--

INSERT INTO `nuke_bbgroups` (`group_id`, `group_type`, `group_name`, `group_description`, `group_moderator`, `group_single_user`, `group_allow_pm`, `group_color`, `group_rank`, `max_inbox`, `max_sentbox`, `max_savebox`, `override_max_inbox`, `override_max_sentbox`, `override_max_savebox`, `group_count`, `group_count_max`, `group_count_enable`) VALUES
(1, 1, 'Anonymous', 'Personal User', 0, 1, 0, '', '', 0, 0, 0, 0, 0, 0, 99999999, 99999999, 0),
(2, 2, 'Moderators', 'Moderators of this Forum', 2, 0, 5, '', 2, 0, 0, 0, 0, 0, 0, 99999999, 99999999, 0),
(3, 0, 'Users', 'Default Usergroup', 2, 0, 5, '', 3, 0, 0, 0, 0, 0, 0, 99999999, 99999999, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbinline_ads`
--

CREATE TABLE `nuke_bbinline_ads` (
  `ad_id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `ad_code` text NOT NULL,
  `ad_name` char(25) NOT NULL,
  PRIMARY KEY (`ad_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bblogs`
--

CREATE TABLE `nuke_bblogs` (
  `log_id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `mode` varchar(50) DEFAULT '',
  `topic_id` mediumint(10) DEFAULT '0',
  `user_id` mediumint(8) DEFAULT '0',
  `username` varchar(255) DEFAULT '',
  `user_ip` varchar(8) NOT NULL DEFAULT '0',
  `time` int(11) DEFAULT '0',
  `new_topic_id` mediumint(10) NOT NULL DEFAULT '0',
  `forum_id` mediumint(10) NOT NULL DEFAULT '0',
  `new_forum_id` mediumint(10) NOT NULL DEFAULT '0',
  `last_post_id` mediumint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bblogs_config`
--

CREATE TABLE `nuke_bblogs_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bblogs_config`
--

INSERT INTO `nuke_bblogs_config` (`config_name`, `config_value`) VALUES
('all_admin', '0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbposts`
--

CREATE TABLE `nuke_bbposts` (
  `post_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `topic_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `forum_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `poster_id` mediumint(8) NOT NULL DEFAULT '0',
  `post_time` int(11) NOT NULL DEFAULT '0',
  `poster_ip` varchar(8) NOT NULL DEFAULT '',
  `post_username` varchar(25) DEFAULT NULL,
  `enable_bbcode` tinyint(1) NOT NULL DEFAULT '1',
  `enable_html` tinyint(1) NOT NULL DEFAULT '0',
  `enable_smilies` tinyint(1) NOT NULL DEFAULT '1',
  `enable_sig` tinyint(1) NOT NULL DEFAULT '1',
  `post_edit_time` int(11) DEFAULT NULL,
  `post_edit_count` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `post_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `post_move` tinyint(1) NOT NULL DEFAULT '0',
  `post_icon` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_id` (`topic_id`),
  KEY `poster_id` (`poster_id`),
  KEY `post_time` (`post_time`),
  KEY `post_icon` (`post_icon`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbposts_text`
--

CREATE TABLE `nuke_bbposts_text` (
  `post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `bbcode_uid` varchar(10) NOT NULL DEFAULT '',
  `post_subject` varchar(60) DEFAULT NULL,
  `post_text` text,
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbpost_reports`
--

CREATE TABLE `nuke_bbpost_reports` (
  `report_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `post_id` mediumint(8) NOT NULL DEFAULT '0',
  `reporter_id` mediumint(8) NOT NULL DEFAULT '0',
  `report_status` tinyint(1) NOT NULL DEFAULT '0',
  `report_time` int(11) NOT NULL DEFAULT '0',
  `report_comments` text,
  `last_action_user_id` mediumint(8) DEFAULT '0',
  `last_action_time` int(11) NOT NULL DEFAULT '0',
  `last_action_comments` text,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbprivmsgs`
--

CREATE TABLE `nuke_bbprivmsgs` (
  `privmsgs_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `privmsgs_type` tinyint(4) NOT NULL DEFAULT '0',
  `privmsgs_subject` varchar(255) NOT NULL DEFAULT '0',
  `privmsgs_from_userid` mediumint(8) NOT NULL DEFAULT '0',
  `privmsgs_to_userid` mediumint(8) NOT NULL DEFAULT '0',
  `privmsgs_date` int(11) NOT NULL DEFAULT '0',
  `privmsgs_ip` varchar(8) NOT NULL DEFAULT '',
  `privmsgs_enable_bbcode` tinyint(1) NOT NULL DEFAULT '1',
  `privmsgs_enable_html` tinyint(1) NOT NULL DEFAULT '0',
  `privmsgs_enable_smilies` tinyint(1) NOT NULL DEFAULT '1',
  `privmsgs_attach_sig` tinyint(1) NOT NULL DEFAULT '1',
  `privmsgs_attachment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`privmsgs_id`),
  KEY `privmsgs_from_userid` (`privmsgs_from_userid`),
  KEY `privmsgs_to_userid` (`privmsgs_to_userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbprivmsgs_archive`
--

CREATE TABLE `nuke_bbprivmsgs_archive` (
  `privmsgs_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `privmsgs_type` tinyint(4) NOT NULL DEFAULT '0',
  `privmsgs_subject` varchar(255) NOT NULL DEFAULT '0',
  `privmsgs_from_userid` mediumint(8) NOT NULL DEFAULT '0',
  `privmsgs_to_userid` mediumint(8) NOT NULL DEFAULT '0',
  `privmsgs_date` int(11) NOT NULL DEFAULT '0',
  `privmsgs_ip` varchar(8) NOT NULL DEFAULT '',
  `privmsgs_enable_bbcode` tinyint(1) NOT NULL DEFAULT '1',
  `privmsgs_enable_html` tinyint(1) NOT NULL DEFAULT '0',
  `privmsgs_enable_smilies` tinyint(1) NOT NULL DEFAULT '1',
  `privmsgs_attach_sig` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`privmsgs_id`),
  KEY `privmsgs_from_userid` (`privmsgs_from_userid`),
  KEY `privmsgs_to_userid` (`privmsgs_to_userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbprivmsgs_text`
--

CREATE TABLE `nuke_bbprivmsgs_text` (
  `privmsgs_text_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `privmsgs_bbcode_uid` varchar(10) NOT NULL DEFAULT '0',
  `privmsgs_text` text,
  PRIMARY KEY (`privmsgs_text_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbquicksearch`
--

CREATE TABLE `nuke_bbquicksearch` (
  `search_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `search_name` varchar(255) NOT NULL DEFAULT '',
  `search_url1` varchar(255) NOT NULL DEFAULT '',
  `search_url2` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`search_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbquicksearch`
--

INSERT INTO `nuke_bbquicksearch` (`search_id`, `search_name`, `search_url1`, `search_url2`) VALUES
(1, 'Google', 'http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=', '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbquota_limits`
--

CREATE TABLE `nuke_bbquota_limits` (
  `quota_limit_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quota_desc` varchar(20) NOT NULL DEFAULT '',
  `quota_limit` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`quota_limit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbquota_limits`
--

INSERT INTO `nuke_bbquota_limits` (`quota_limit_id`, `quota_desc`, `quota_limit`) VALUES
(1, 'Low', 262144),
(2, 'Medium', 2097152),
(3, 'High', 5242880);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbranks`
--

CREATE TABLE `nuke_bbranks` (
  `rank_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rank_title` varchar(100) NOT NULL DEFAULT '',
  `rank_min` mediumint(8) NOT NULL DEFAULT '0',
  `rank_special` tinyint(1) DEFAULT '0',
  `rank_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rank_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbranks`
--

INSERT INTO `nuke_bbranks` (`rank_id`, `rank_title`, `rank_min`, `rank_special`, `rank_image`) VALUES
(1, 'Site Admin', -1, 1, 'images/ranks/administrator.png'),
(2, 'Moderator', -1, 1, 'images/ranks/moderator.png'),
(3, 'Member', -1, 1, 'images/ranks/regular-member.png');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbreputation`
--

CREATE TABLE `nuke_bbreputation` (
  `user_id` mediumint(8) NOT NULL DEFAULT '0',
  `user_id_2` mediumint(8) NOT NULL DEFAULT '0',
  `post_id` mediumint(8) NOT NULL DEFAULT '0',
  `rep_sum` float NOT NULL DEFAULT '0',
  `rep_neg` tinyint(1) NOT NULL DEFAULT '0',
  `rep_comment` varchar(200) NOT NULL DEFAULT '',
  `rep_time` int(11) NOT NULL DEFAULT '0',
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbreputation_config`
--

CREATE TABLE `nuke_bbreputation_config` (
  `config_name` varchar(255) NOT NULL,
  `config_value` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbreputation_config`
--

INSERT INTO `nuke_bbreputation_config` (`config_name`, `config_value`) VALUES
('posts_to_earn', '5'),
('rep_disable', '0'),
('days_to_earn', '30'),
('flood_control_time', '30'),
('graphic_version', '0'),
('medal4_to_earn', '10'),
('medal3_to_earn', '50'),
('medal2_to_earn', '100'),
('medal1_to_earn', '200'),
('given_rep_to_earn', '20'),
('show_stats_to_mods', '0'),
('repsum_limit', '0'),
('pm_notify', '0'),
('default_amount', '0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsearch_rebuild`
--

CREATE TABLE `nuke_bbsearch_rebuild` (
  `rebuild_session_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `start_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `end_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `last_cycle_time` int(11) NOT NULL DEFAULT '0',
  `session_time` int(11) NOT NULL DEFAULT '0',
  `session_posts` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `session_cycles` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `search_size` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `rebuild_session_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rebuild_session_id`),
  KEY `end_post_id` (`end_post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsearch_results`
--

CREATE TABLE `nuke_bbsearch_results` (
  `search_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `search_array` text NOT NULL,
  `search_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`search_id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsearch_wordlist`
--

CREATE TABLE `nuke_bbsearch_wordlist` (
  `word_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `word_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `word_common` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_text`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbsearch_wordlist`
--

INSERT INTO `nuke_bbsearch_wordlist` (`word_text`, `word_id`, `word_common`, `post_id`) VALUES
('already', 32, 0, 0),
('archive', 33, 0, 0),
('browser', 34, 0, 0),
('com', 35, 0, 0),
('configure', 36, 0, 0),
('containing', 37, 0, 0),
('contains', 38, 0, 0),
('convert', 39, 0, 0),
('documentation', 40, 0, 0),
('documents', 41, 0, 0),
('downloaded', 42, 0, 0),
('due', 43, 0, 0),
('edited', 27, 0, 0),
('edition', 44, 0, 0),
('edits', 45, 0, 0),
('encourage', 46, 0, 0),
('enjoy', 47, 0, 0),
('errors', 48, 0, 0),
('evo', 49, 0, 0),
('evolutionxtreme', 50, 0, 0),
('explain', 51, 0, 0),
('familiar', 52, 0, 0),
('fastest', 53, 0, 0),
('features', 54, 0, 0),
('few', 55, 0, 0),
('first', 56, 0, 0),
('folder', 57, 0, 0),
('folders', 58, 0, 0),
('follow', 59, 0, 0),
('fully', 60, 0, 0),
('functional', 61, 0, 0),
('hard', 62, 0, 0),
('help', 63, 0, 0),
('helpful', 64, 0, 0),
('hope', 65, 0, 0),
('improperly', 66, 0, 0),
('included', 67, 0, 0),
('information', 68, 0, 0),
('inside', 69, 0, 0),
('install', 70, 0, 0),
('installing', 71, 0, 0),
('instructions', 72, 0, 0),
('make', 73, 0, 0),
('may', 74, 0, 0),
('nuke', 75, 0, 0),
('nukeevolution', 28, 0, 0),
('one', 76, 0, 0),
('original', 77, 0, 0),
('phpnuke', 78, 0, 0),
('power', 79, 0, 0),
('properly', 80, 0, 0),
('provided', 81, 0, 0),
('quot', 82, 0, 0),
('read', 83, 0, 0),
('release', 84, 0, 0),
('resolve', 85, 0, 0),
('run', 86, 0, 0),
('second', 87, 0, 0),
('secure', 88, 0, 0),
('settings', 89, 0, 0),
('setup', 90, 0, 0),
('several', 91, 0, 0),
('site', 92, 0, 0),
('software', 93, 0, 0),
('stop', 94, 0, 0),
('support', 95, 0, 0),
('sure', 96, 0, 0),
('team', 97, 0, 0),
('thanks', 98, 0, 0),
('theme', 99, 0, 0),
('third', 100, 0, 0),
('three', 101, 0, 0),
('together', 102, 0, 0),
('trust', 103, 0, 0),
('understand', 104, 0, 0),
('updates', 105, 0, 0),
('welcome', 30, 0, 0),
('work', 106, 0, 0),
('xtreme', 31, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsearch_wordmatch`
--

CREATE TABLE `nuke_bbsearch_wordmatch` (
  `post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `word_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `title_match` tinyint(1) NOT NULL DEFAULT '0',
  KEY `post_id` (`post_id`),
  KEY `word_id` (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbsearch_wordmatch`
--

INSERT INTO `nuke_bbsearch_wordmatch` (`post_id`, `word_id`, `title_match`) VALUES
(2, 32, 0),
(2, 33, 0),
(2, 34, 0),
(2, 35, 0),
(2, 36, 0),
(2, 37, 0),
(2, 38, 0),
(2, 39, 0),
(2, 40, 0),
(2, 41, 0),
(2, 42, 0),
(2, 43, 0),
(2, 27, 0),
(2, 44, 0),
(2, 45, 0),
(2, 46, 0),
(2, 47, 0),
(2, 48, 0),
(2, 49, 0),
(2, 50, 0),
(2, 51, 0),
(2, 52, 0),
(2, 53, 0),
(2, 54, 0),
(2, 55, 0),
(2, 56, 0),
(2, 57, 0),
(2, 58, 0),
(2, 59, 0),
(2, 60, 0),
(2, 61, 0),
(2, 62, 0),
(2, 63, 0),
(2, 64, 0),
(2, 65, 0),
(2, 66, 0),
(2, 67, 0),
(2, 68, 0),
(2, 69, 0),
(2, 70, 0),
(2, 71, 0),
(2, 72, 0),
(2, 73, 0),
(2, 74, 0),
(2, 75, 0),
(2, 28, 0),
(2, 76, 0),
(2, 77, 0),
(2, 78, 0),
(2, 79, 0),
(2, 80, 0),
(2, 81, 0),
(2, 82, 0),
(2, 83, 0),
(2, 84, 0),
(2, 85, 0),
(2, 86, 0),
(2, 87, 0),
(2, 88, 0),
(2, 89, 0),
(2, 90, 0),
(2, 91, 0),
(2, 92, 0),
(2, 93, 0),
(2, 94, 0),
(2, 95, 0),
(2, 96, 0),
(2, 97, 0),
(2, 98, 0),
(2, 99, 0),
(2, 100, 0),
(2, 101, 0),
(2, 102, 0),
(2, 103, 0),
(2, 104, 0),
(2, 105, 0),
(2, 106, 0),
(2, 31, 0),
(2, 28, 1),
(2, 30, 1),
(2, 31, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsessions`
--

CREATE TABLE `nuke_bbsessions` (
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `session_user_id` mediumint(8) NOT NULL DEFAULT '0',
  `session_start` int(11) NOT NULL DEFAULT '0',
  `session_time` int(11) NOT NULL DEFAULT '0',
  `session_ip` varchar(8) NOT NULL DEFAULT '0',
  `session_page` int(11) NOT NULL DEFAULT '0',
  `session_logged_in` tinyint(1) NOT NULL DEFAULT '0',
  `session_admin` tinyint(2) NOT NULL DEFAULT '0',
  `session_url_qs` varchar(255) NOT NULL DEFAULT '',
  `session_url_ps` varchar(255) NOT NULL DEFAULT '',
  `session_url_specific` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`),
  KEY `session_user_id` (`session_user_id`),
  KEY `session_id_ip_user_id` (`session_id`,`session_ip`,`session_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsessions_keys`
--

CREATE TABLE `nuke_bbsessions_keys` (
  `key_id` varchar(32) NOT NULL DEFAULT '0',
  `user_id` mediumint(8) NOT NULL DEFAULT '0',
  `last_ip` varchar(8) NOT NULL DEFAULT '0',
  `last_login` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`key_id`,`user_id`),
  KEY `last_login` (`last_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbsmilies`
--

CREATE TABLE `nuke_bbsmilies` (
  `smilies_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `smile_url` varchar(100) DEFAULT NULL,
  `emoticon` varchar(75) DEFAULT NULL,
  `smile_stat` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`smilies_id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbsmilies`
--

INSERT INTO `nuke_bbsmilies` (`smilies_id`, `code`, `smile_url`, `emoticon`, `smile_stat`) VALUES
(1, ':D', 'bigsmile.png', 'Very Happy', 0),
(2, ':-D', 'bigsmile.png', 'Very Happy', 0),
(3, ':grin:', 'bigsmile.png', 'Very Happy', 0),
(4, ':)', 'smile.png', 'Smile', 0),
(5, ':-)', 'smile.png', 'Smile', 0),
(6, ':smile:', 'smile.png', 'Smile', 0),
(7, ':(', 'sad.png', 'Sad', 0),
(8, ':-(', 'sad.png', 'Sad', 0),
(9, ':sad:', 'sad.png', 'Sad', 0),
(10, ':o', 'surprised.png', 'Surprised', 0),
(11, ':-o', 'surprised.png', 'Surprised', 0),
(12, ':eek:', 'surprised.png', 'Surprised', 0),
(13, '8O', 'eek.png', 'Shocked', 0),
(14, '8-O', 'eek.png', 'Shocked', 0),
(15, ':shock:', 'eek.png', 'Shocked', 0),
(16, ':?', 'confused.png', 'Confused', 0),
(17, ':-?', 'confused.png', 'Confused', 0),
(18, ':???:', 'confused.png', 'Confused', 0),
(19, '8)', 'cool.png', 'Cool', 0),
(20, '8-)', 'cool.png', 'Cool', 0),
(21, ':cool:', 'cool.png', 'Cool', 0),
(22, ':lol:', 'lol.png', 'Laughing', 0),
(23, ':x', 'mad.png', 'Mad', 0),
(24, ':-x', 'mad.png', 'Mad', 0),
(25, ':mad:', 'mad.png', 'Mad', 0),
(26, ':P', 'razz.png', 'Razz', 0),
(27, ':-P', 'razz.png', 'Razz', 0),
(28, ':razz:', 'razz.png', 'Razz', 0),
(29, ':oops:', 'redface.png', 'Embarassed', 0),
(30, ':cry:', 'cry.png', 'Crying or Very sad', 0),
(31, ':evil:', 'evil.png', 'Evil or Very Mad', 0),
(32, ':twisted:', 'twisted.png', 'Twisted Evil', 0),
(33, ':hearts:', 'hearts.png', 'In Love', 0),
(34, ':wink:', 'wink.png', 'Wink', 0),
(35, ';)', 'wink.png', 'Wink', 0),
(36, ';-)', 'wink.png', 'Wink', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_config`
--

CREATE TABLE `nuke_bbstats_config` (
  `config_name` varchar(100) NOT NULL DEFAULT '',
  `config_value` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbstats_config`
--

INSERT INTO `nuke_bbstats_config` (`config_name`, `config_value`) VALUES
('install_date', '0'),
('return_limit', '10'),
('version', '3.0.0'),
('page_views', '17');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_modules`
--

CREATE TABLE `nuke_bbstats_modules` (
  `module_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `short_name` varchar(100) DEFAULT NULL,
  `update_time` mediumint(8) NOT NULL DEFAULT '0',
  `module_order` mediumint(8) NOT NULL DEFAULT '0',
  `active` tinyint(2) NOT NULL DEFAULT '0',
  `perm_all` tinyint(2) UNSIGNED NOT NULL DEFAULT '1',
  `perm_reg` tinyint(2) UNSIGNED NOT NULL DEFAULT '1',
  `perm_mod` tinyint(2) UNSIGNED NOT NULL DEFAULT '1',
  `perm_admin` tinyint(2) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbstats_modules`
--

INSERT INTO `nuke_bbstats_modules` (`module_id`, `short_name`, `update_time`, `module_order`, `active`, `perm_all`, `perm_reg`, `perm_mod`, `perm_admin`) VALUES
(1, 'stats_overview', 360, 10, 1, 1, 1, 1, 1),
(2, 'top_posters', 360, 30, 1, 1, 1, 1, 1),
(3, 'admin_statistics', 360, 20, 1, 1, 1, 1, 1),
(4, 'most_viewed_topics', 360, 80, 1, 1, 1, 1, 1),
(5, 'top_posters_month', 360, 60, 1, 1, 1, 1, 1),
(6, 'topics_by_month', 360, 100, 1, 1, 1, 1, 1),
(7, 'most_interesting_topics', 360, 120, 1, 1, 1, 1, 1),
(8, 'top_words', 360, 90, 1, 1, 1, 1, 1),
(9, 'least_interesting_topics', 360, 130, 1, 1, 1, 1, 1),
(10, 'most_active_topicstarter', 360, 40, 1, 1, 1, 1, 1),
(11, 'top_smilies', 0, 110, 1, 1, 1, 1, 1),
(12, 'users_by_month', 360, 140, 1, 1, 1, 1, 1),
(13, 'posts_by_month', 360, 150, 1, 1, 1, 1, 1),
(14, 'top_posters_week', 360, 50, 1, 1, 1, 1, 1),
(15, 'top_attachments', 360, 160, 1, 1, 1, 1, 1),
(16, 'most_active_topics', 360, 70, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_module_admin_panel`
--

CREATE TABLE `nuke_bbstats_module_admin_panel` (
  `module_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  `config_type` varchar(20) NOT NULL DEFAULT '',
  `config_title` varchar(100) NOT NULL DEFAULT '',
  `config_explain` varchar(100) DEFAULT NULL,
  `config_trigger` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbstats_module_admin_panel`
--

INSERT INTO `nuke_bbstats_module_admin_panel` (`module_id`, `config_name`, `config_value`, `config_type`, `config_title`, `config_explain`, `config_trigger`) VALUES
(1, 'num_columns', '2', 'number', 'num_columns_title', 'num_columns_explain', 'integer'),
(15, 'exclude_images', '0', 'number', 'exclude_images_title', 'exclude_images_explain', 'enum');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_module_cache`
--

CREATE TABLE `nuke_bbstats_module_cache` (
  `module_id` mediumint(8) NOT NULL DEFAULT '0',
  `module_cache_time` int(12) NOT NULL DEFAULT '0',
  `db_cache` text NOT NULL,
  `priority` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_module_group_auth`
--

CREATE TABLE `nuke_bbstats_module_group_auth` (
  `module_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_module_info`
--

CREATE TABLE `nuke_bbstats_module_info` (
  `module_id` mediumint(8) NOT NULL DEFAULT '0',
  `long_name` varchar(100) NOT NULL DEFAULT '',
  `author` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `version` varchar(10) NOT NULL DEFAULT '',
  `update_site` varchar(100) DEFAULT NULL,
  `extra_info` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbstats_module_info`
--

INSERT INTO `nuke_bbstats_module_info` (`module_id`, `long_name`, `author`, `email`, `url`, `version`, `update_site`, `extra_info`) VALUES
(1, 'Statistics Overview Section', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module will print out a link Block with Links to the current Module at the Statistics Site.\nYou are able to define the number of columns displayed for this Module within the Administration Panel -&gt; Edit Module.'),
(2, 'Top Posters', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the Top Posters from your board.\nAnonymous Poster are not counted.'),
(3, 'Administrative Statistics', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays some Admin Statistics about your Board.\nIt is nearly the same you are able to see within the first Administration Panel visit.'),
(4, 'Most viewed topics', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the most viewed topics at your board.'),
(5, 'Top Posters this Month (Site History Mod)', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module does NOT require the Site History Mod,\nit will display the Top Posters on a Monthly basis.'),
(6, 'New topics by month', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module will display the topics created at your Board in a monthly statistic.'),
(7, 'Most Interesting Topics', 'JRSweets', 'JRSweets@gmail.com', 'http://www.jeffrusso.net', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This module will show the most intresting topics.'),
(8, 'Top Words', 'JRSweets', 'JRSweets@gmail.com', 'http://www.jeffrusso.net', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the most used words on your board.'),
(9, 'Least Interesting Topics', 'JRSweets', 'JRSweets@gmail.com', 'http://www.jeffrusso.net', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This module will show the least intresting topics.'),
(10, 'Most Active Topicstarter', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the most active topicstarter on your board.\nAnonymous Poster are not counted.'),
(11, 'Top Smilies', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the Top Smilies used at your board.\nThis Module uses an Smilie Index Table for caching the smilie data and to not\nrequire re-indexing of all posts.'),
(12, 'New users by month', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module will display the users registered to your Board in a monthly statistic.'),
(13, 'New posts by month', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module will display the posts created at your Board in a monthly statistic.'),
(14, 'Top Posters this Week (Site History Mod)', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module does NOT require the Site History Mod,\nit will display the Top Posters on a Weekly basis.'),
(15, 'Top Downloaded Attachments', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module will print out the most downloaded Files.\nThe Attachment Mod Version 2.3.x have to be installed in order to let this Module work.\nYou are able to exclude Images from the statistic too.'),
(16, 'Most active Topics', 'Acyd Burn', 'acyd.burn@gmx.de', 'http://www.opentools.de', '3.0.0', 'http://www.opentools.de/board/show_modules.php', 'This Module displays the most active topics at your board.');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_smilies_index`
--

CREATE TABLE `nuke_bbstats_smilies_index` (
  `code` varchar(50) NOT NULL DEFAULT '',
  `smile_url` varchar(100) DEFAULT NULL,
  `smile_count` mediumint(8) DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbstats_smilies_info`
--

CREATE TABLE `nuke_bbstats_smilies_info` (
  `last_post_id` mediumint(8) NOT NULL DEFAULT '0',
  `last_update_time` int(12) NOT NULL DEFAULT '0',
  `update_time` mediumint(8) NOT NULL DEFAULT '10080',
  PRIMARY KEY (`last_post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbstats_smilies_info`
--

INSERT INTO `nuke_bbstats_smilies_info` (`last_post_id`, `last_update_time`, `update_time`) VALUES
(0, 0, 10080);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbthanks`
--

CREATE TABLE `nuke_bbthanks` (
  `topic_id` mediumint(8) NOT NULL,
  `user_id` mediumint(8) NOT NULL,
  `thanks_time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbthemes`
--

CREATE TABLE `nuke_bbthemes` (
  `themes_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_name` varchar(30) NOT NULL DEFAULT '',
  `style_name` varchar(30) NOT NULL DEFAULT '',
  `head_stylesheet` varchar(100) DEFAULT NULL,
  `body_background` varchar(100) DEFAULT NULL,
  `body_bgcolor` varchar(6) DEFAULT NULL,
  `body_text` varchar(6) DEFAULT NULL,
  `body_link` varchar(6) DEFAULT NULL,
  `body_vlink` varchar(6) DEFAULT NULL,
  `body_alink` varchar(6) DEFAULT NULL,
  `body_hlink` varchar(6) DEFAULT NULL,
  `tr_color1` varchar(6) DEFAULT NULL,
  `tr_color2` varchar(6) DEFAULT NULL,
  `tr_color3` varchar(6) DEFAULT NULL,
  `tr_class1` varchar(25) DEFAULT NULL,
  `tr_class2` varchar(25) DEFAULT NULL,
  `tr_class3` varchar(25) DEFAULT NULL,
  `th_color1` varchar(6) DEFAULT NULL,
  `th_color2` varchar(6) DEFAULT NULL,
  `th_color3` varchar(6) DEFAULT NULL,
  `th_class1` varchar(25) DEFAULT NULL,
  `th_class2` varchar(25) DEFAULT NULL,
  `th_class3` varchar(25) DEFAULT NULL,
  `td_color1` varchar(6) DEFAULT NULL,
  `td_color2` varchar(6) DEFAULT NULL,
  `td_color3` varchar(6) DEFAULT NULL,
  `td_class1` varchar(25) DEFAULT NULL,
  `td_class2` varchar(25) DEFAULT NULL,
  `td_class3` varchar(25) DEFAULT NULL,
  `fontface1` varchar(50) DEFAULT NULL,
  `fontface2` varchar(50) DEFAULT NULL,
  `fontface3` varchar(50) DEFAULT NULL,
  `fontsize1` tinyint(4) DEFAULT NULL,
  `fontsize2` tinyint(4) DEFAULT NULL,
  `fontsize3` tinyint(4) DEFAULT NULL,
  `fontcolor1` varchar(6) DEFAULT NULL,
  `fontcolor2` varchar(6) DEFAULT NULL,
  `fontcolor3` varchar(6) DEFAULT NULL,
  `span_class1` varchar(25) DEFAULT NULL,
  `span_class2` varchar(25) DEFAULT NULL,
  `span_class3` varchar(25) DEFAULT NULL,
  `img_size_poll` smallint(5) UNSIGNED DEFAULT NULL,
  `img_size_privmsg` smallint(5) UNSIGNED DEFAULT NULL,
  `online_color` varchar(6) NOT NULL DEFAULT '',
  `offline_color` varchar(6) NOT NULL DEFAULT '',
  `hidden_color` varchar(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`themes_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbthemes`
--

INSERT INTO `nuke_bbthemes` (`themes_id`, `template_name`, `style_name`, `head_stylesheet`, `body_background`, `body_bgcolor`, `body_text`, `body_link`, `body_vlink`, `body_alink`, `body_hlink`, `tr_color1`, `tr_color2`, `tr_color3`, `tr_class1`, `tr_class2`, `tr_class3`, `th_color1`, `th_color2`, `th_color3`, `th_class1`, `th_class2`, `th_class3`, `td_color1`, `td_color2`, `td_color3`, `td_class1`, `td_class2`, `td_class3`, `fontface1`, `fontface2`, `fontface3`, `fontsize1`, `fontsize2`, `fontsize3`, `fontcolor1`, `fontcolor2`, `fontcolor3`, `span_class1`, `span_class2`, `span_class3`, `img_size_poll`, `img_size_privmsg`, `online_color`, `offline_color`, `hidden_color`) VALUES
(1, 'subSilver', 'subSilver', 'subSilver.css', '', '0E3259', '000000', '006699', '5493B4', '', 'DD6900', 'EFEFEF', 'DEE3E7', 'D1D7DC', '', '', '', '98AAB1', '006699', 'FFFFFF', 'cellpic1.gif', 'cellpic3.gif', 'cellpic2.jpg', 'FAFAFA', 'FFFFFF', '', 'row1', 'row2', '', 'Verdana, Arial, Helvetica, sans-serif', 'Trebuchet MS', 'Courier, \'Courier New\', sans-serif', 10, 11, 12, '444444', '006600', 'FFA34F', '', '', '', NULL, NULL, '008500', 'DF0000', 'EBD400');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbthemes_name`
--

CREATE TABLE `nuke_bbthemes_name` (
  `themes_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `tr_color1_name` char(50) DEFAULT NULL,
  `tr_color2_name` char(50) DEFAULT NULL,
  `tr_color3_name` char(50) DEFAULT NULL,
  `tr_class1_name` char(50) DEFAULT NULL,
  `tr_class2_name` char(50) DEFAULT NULL,
  `tr_class3_name` char(50) DEFAULT NULL,
  `th_color1_name` char(50) DEFAULT NULL,
  `th_color2_name` char(50) DEFAULT NULL,
  `th_color3_name` char(50) DEFAULT NULL,
  `th_class1_name` char(50) DEFAULT NULL,
  `th_class2_name` char(50) DEFAULT NULL,
  `th_class3_name` char(50) DEFAULT NULL,
  `td_color1_name` char(50) DEFAULT NULL,
  `td_color2_name` char(50) DEFAULT NULL,
  `td_color3_name` char(50) DEFAULT NULL,
  `td_class1_name` char(50) DEFAULT NULL,
  `td_class2_name` char(50) DEFAULT NULL,
  `td_class3_name` char(50) DEFAULT NULL,
  `fontface1_name` char(50) DEFAULT NULL,
  `fontface2_name` char(50) DEFAULT NULL,
  `fontface3_name` char(50) DEFAULT NULL,
  `fontsize1_name` char(50) DEFAULT NULL,
  `fontsize2_name` char(50) DEFAULT NULL,
  `fontsize3_name` char(50) DEFAULT NULL,
  `fontcolor1_name` char(50) DEFAULT NULL,
  `fontcolor2_name` char(50) DEFAULT NULL,
  `fontcolor3_name` char(50) DEFAULT NULL,
  `span_class1_name` char(50) DEFAULT NULL,
  `span_class2_name` char(50) DEFAULT NULL,
  `span_class3_name` char(50) DEFAULT NULL,
  PRIMARY KEY (`themes_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbthemes_name`
--

INSERT INTO `nuke_bbthemes_name` (`themes_id`, `tr_color1_name`, `tr_color2_name`, `tr_color3_name`, `tr_class1_name`, `tr_class2_name`, `tr_class3_name`, `th_color1_name`, `th_color2_name`, `th_color3_name`, `th_class1_name`, `th_class2_name`, `th_class3_name`, `td_color1_name`, `td_color2_name`, `td_color3_name`, `td_class1_name`, `td_class2_name`, `td_class3_name`, `fontface1_name`, `fontface2_name`, `fontface3_name`, `fontsize1_name`, `fontsize2_name`, `fontsize3_name`, `fontcolor1_name`, `fontcolor2_name`, `fontcolor3_name`, `span_class1_name`, `span_class2_name`, `span_class3_name`) VALUES
(1, 'The lightest row colour', 'The medium row color', 'The darkest row colour', '', '', '', 'Border round the whole page', 'Outer table border', 'Inner table border', 'Silver gradient picture', 'Blue gradient picture', 'Fade-out gradient on index', 'Background for quote boxes', 'All white areas', '', 'Background for topic posts', '2nd background for topic posts', '', 'Main fonts', 'Additional topic title font', 'Form fonts', 'Smallest font size', 'Medium font size', 'Normal font size (post body etc)', 'Quote & copyright text', 'Code text colour', 'Main table header text colour', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbtopics`
--

CREATE TABLE `nuke_bbtopics` (
  `topic_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `forum_id` smallint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_title` char(60) NOT NULL DEFAULT '',
  `topic_poster` mediumint(8) NOT NULL DEFAULT '0',
  `topic_time` int(11) NOT NULL DEFAULT '0',
  `topic_views` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_replies` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_status` tinyint(3) NOT NULL DEFAULT '0',
  `topic_vote` tinyint(1) NOT NULL DEFAULT '0',
  `topic_type` tinyint(3) NOT NULL DEFAULT '0',
  `topic_last_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_first_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_moved_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `topic_priority` smallint(6) NOT NULL DEFAULT '0',
  `topic_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `topic_glance_priority` smallint(6) NOT NULL DEFAULT '0',
  `topic_icon` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `forum_id` (`forum_id`),
  KEY `topic_moved_id` (`topic_moved_id`),
  KEY `topic_status` (`topic_status`),
  KEY `topic_type` (`topic_type`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbtopic_view`
--

CREATE TABLE `nuke_bbtopic_view` (
  `topic_id` mediumint(8) NOT NULL,
  `user_id` mediumint(8) NOT NULL,
  `view_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbtopics_email`
--

CREATE TABLE `nuke_bbtopics_email` (
  `user_id` mediumint(8) NOT NULL,
  `friend_name` varchar(100) NOT NULL,
  `friend_email` varchar(100) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '',
  `topic_id` mediumint(8) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbtopics_watch`
--

CREATE TABLE `nuke_bbtopics_watch` (
  `topic_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` mediumint(8) NOT NULL DEFAULT '0',
  `notify_status` tinyint(1) NOT NULL DEFAULT '0',
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  KEY `notify_status` (`notify_status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbtopic_moved`
--

CREATE TABLE `nuke_bbtopic_moved` (
  `moved_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `moved_topic_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `moved_oldtopic_id` mediumint(8) UNSIGNED DEFAULT '0',
  `moved_type` varchar(8) NOT NULL DEFAULT '0',
  `moved_parent` mediumint(8) UNSIGNED DEFAULT '0',
  `moved_target` mediumint(8) UNSIGNED DEFAULT '0',
  `moved_mod` mediumint(8) NOT NULL DEFAULT '0',
  `moved_time` int(11) NOT NULL DEFAULT '0',
  `last_post_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`moved_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbuser_group`
--

CREATE TABLE `nuke_bbuser_group` (
  `group_id` mediumint(8) NOT NULL DEFAULT '0',
  `user_id` mediumint(8) NOT NULL DEFAULT '0',
  `user_pending` tinyint(1) DEFAULT NULL,
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbuser_group`
--

INSERT INTO `nuke_bbuser_group` (`group_id`, `user_id`, `user_pending`) VALUES
(1, -1, 0),
(3, 2, 0),
(5, 2, 0),
(5, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbvote_desc`
--

CREATE TABLE `nuke_bbvote_desc` (
  `vote_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `topic_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `vote_text` text NOT NULL,
  `vote_start` int(11) NOT NULL DEFAULT '0',
  `vote_length` int(11) NOT NULL DEFAULT '0',
  `poll_view_toggle` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`vote_id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbvote_results`
--

CREATE TABLE `nuke_bbvote_results` (
  `vote_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `vote_option_id` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  `vote_option_text` varchar(255) NOT NULL DEFAULT '',
  `vote_result` int(11) NOT NULL DEFAULT '0',
  KEY `vote_option_id` (`vote_option_id`),
  KEY `vote_id` (`vote_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbvote_voters`
--

CREATE TABLE `nuke_bbvote_voters` (
  `vote_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `vote_user_id` mediumint(8) NOT NULL DEFAULT '0',
  `vote_user_ip` char(8) NOT NULL DEFAULT '',
  `vote_cast` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  KEY `vote_id` (`vote_id`),
  KEY `vote_user_id` (`vote_user_id`),
  KEY `vote_user_ip` (`vote_user_ip`),
  KEY `vote_cast` (`vote_cast`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbwords`
--

CREATE TABLE `nuke_bbwords` (
  `word_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `word` char(100) NOT NULL DEFAULT '',
  `replacement` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbxdata_auth`
--

CREATE TABLE `nuke_bbxdata_auth` (
  `field_id` smallint(5) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  `auth_value` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbxdata_data`
--

CREATE TABLE `nuke_bbxdata_data` (
  `field_id` smallint(5) UNSIGNED NOT NULL,
  `user_id` mediumint(8) UNSIGNED NOT NULL,
  `xdata_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_bbxdata_fields`
--

CREATE TABLE `nuke_bbxdata_fields` (
  `field_id` smallint(5) UNSIGNED NOT NULL,
  `field_name` varchar(255) NOT NULL DEFAULT '',
  `field_desc` text NOT NULL,
  `field_type` varchar(255) NOT NULL DEFAULT '',
  `field_order` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `code_name` varchar(255) NOT NULL DEFAULT '',
  `field_length` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `field_values` text NOT NULL,
  `field_regexp` text NOT NULL,
  `manditory` tinyint(1) NOT NULL DEFAULT '0',
  `default_auth` tinyint(1) NOT NULL DEFAULT '1',
  `display_register` tinyint(1) NOT NULL DEFAULT '1',
  `display_viewprofile` tinyint(1) NOT NULL DEFAULT '0',
  `display_posting` tinyint(1) NOT NULL DEFAULT '0',
  `handle_input` tinyint(1) NOT NULL DEFAULT '0',
  `allow_html` tinyint(1) NOT NULL DEFAULT '0',
  `allow_bbcode` tinyint(1) NOT NULL DEFAULT '0',
  `allow_smilies` tinyint(1) NOT NULL DEFAULT '0',
  `viewtopic` tinyint(1) NOT NULL DEFAULT '0',
  `signup` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `code_name` (`code_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_bbxdata_fields`
--

INSERT INTO `nuke_bbxdata_fields` (`field_id`, `field_name`, `field_desc`, `field_type`, `field_order`, `code_name`, `field_length`, `field_values`, `field_regexp`, `manditory`, `default_auth`, `display_register`, `display_viewprofile`, `display_posting`, `handle_input`, `allow_html`, `allow_bbcode`, `allow_smilies`, `viewtopic`, `signup`) VALUES
(5, 'Website', '', 'special', 5, 'website', 0, '', '', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Location', '', 'special', 6, 'location', 0, '', '', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Occupation', '', 'special', 7, 'occupation', 0, '', '', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 'Interests', '', 'special', 8, 'interests', 0, '', '', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Signature', '', 'special', 9, 'signature', 0, '', '', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_blocks`
--

CREATE TABLE `nuke_blocks` (
  `bid` int(10) NOT NULL AUTO_INCREMENT,
  `bkey` varchar(15) NOT NULL DEFAULT '',
  `title` varchar(60) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `url` varchar(200) NOT NULL DEFAULT '',
  `bposition` char(1) NOT NULL DEFAULT '',
  `weight` int(10) NOT NULL DEFAULT '1',
  `active` int(1) NOT NULL DEFAULT '1',
  `refresh` int(10) NOT NULL DEFAULT '0',
  `time` varchar(14) NOT NULL DEFAULT '0',
  `blanguage` varchar(30) NOT NULL DEFAULT '',
  `blockfile` varchar(255) NOT NULL DEFAULT '',
  `view` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`),
  KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_blocks`
--

INSERT INTO `nuke_blocks` VALUES(1, '', 'Main Menu', '', '', 'l', 1, 1, 1800, '0', '', 'block-Modules.php', '1');
INSERT INTO `nuke_blocks` VALUES(2, '', 'Search', '', '', 'l', 4, 1, 3600, '', '', 'block-Search.php', '0');
INSERT INTO `nuke_blocks` VALUES(3, '', 'Survey', '', '', 'r', 4, 0, 3600, '', '', 'block-Survey.php', '0');
INSERT INTO `nuke_blocks` VALUES(4, '', 'Information', '<br /><center><span class="content">\r\n<a href="http://phpnuke.org"><img src="images/powered/powered8.jpg" border="0" alt="Powered by PHP-Nuke" title="Powered by PHP-Nuke" width="88" height="31" /></a>\r\n<br /><br />\r\n<a href="http://validator.w3.org/check/referer"><img src="images/html401.gif" width="88" height="31" alt="Valid HTML 4.01!" title="Valid HTML 4.01!" border="0" /></a>\r\n<br /><br />\r\n<a href="http://jigsaw.w3.org/css-validator"><img src="images/css.gif" width="88" height="31" alt="Valid CSS!" title="Valid CSS!" border="0" /></a></span></center><br />', '', 'r', 5, 1, 0, '', '', '', '0');
INSERT INTO `nuke_blocks` VALUES(5, '', 'User Info', '', '', 'r', 0, 1, 0, '', '', 'block-Evo_User_Info.php', '0');
INSERT INTO `nuke_blocks` VALUES(6, '', 'Nuke-Evolution', '', '', 'c', 1, 0, 0, '', '', 'block-Nuke-Evolution.php', '0');
INSERT INTO `nuke_blocks` VALUES(7, '', 'Top 10 Links', '', '', 'r', 7, 0, 3600, '', '', 'block-Top10_Links.php', '0');
INSERT INTO `nuke_blocks` VALUES(8, '', 'Forums', '', '', 'c', 0, 1, 3600, '', '', 'block-Forums.php', '0');
INSERT INTO `nuke_blocks` VALUES(9, '', 'Submissions', '', '', 'l', 2, 0, 0, '', '', 'block-Submissions.php', '4');
INSERT INTO `nuke_blocks` VALUES(10, '', 'Donations', '', '', 'r', 1, 0, 3600, '0', '', 'block-Donations.php', '0');
INSERT INTO `nuke_blocks` VALUES(11, '', 'ECalendar', '', '', 'l', 3, 0, 3600, '0', '', 'block-ECalendar.php', '1');
INSERT INTO `nuke_blocks` VALUES(12, '', 'Security', '', '', 'd', 2, 1, 3600, '0', '', 'block-Sentinel_Center.php', '1');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_cnbya_config`
--

CREATE TABLE `nuke_cnbya_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` longtext,
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_cnbya_config`
--

INSERT INTO `nuke_cnbya_config` (`config_name`, `config_value`) VALUES
('sendaddmail', '0'),
('senddeletemail', '0'),
('allowuserdelete', '0'),
('allowusertheme', '0'),
('allowuserreg', '0'),
('allowmailchange', '1'),
('emailvalidate', '0'),
('requireadmin', '0'),
('servermail', '0'),
('useactivate', '0'),
('autosuspend', '0'),
('perpage', '100'),
('expiring', '86400'),
('nick_min', '4'),
('nick_max', '20'),
('pass_min', '4'),
('pass_max', '20'),
('bad_mail', 'yoursite.com\r\nmysite.com'),
('bad_nick', 'adm\r\nadmin\r\nanonimo\r\nanonymous\r\nannimo\r\ngod\r\nlinux\r\nnobody\r\noperator\r\nroot\r\nstaff\r\nwebmaster'),
('coppa', '0'),
('tos', '0'),
('tosall', '1'),
('cookiecheck', '1'),
('cookiecleaner', '1'),
('cookietimelife', '2592000'),
('cookiepath', ''),
('cookieinactivity', '-'),
('autosuspendmain', '0'),
('doublecheckemail', '0'),
('version', '4.4.2'),
('tos_text', 'This is your default TOS. You may edit this through the Your Account Admin Panel.');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_cnbya_field`
--

CREATE TABLE `nuke_cnbya_field` (
  `fid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'field',
  `value` varchar(255) DEFAULT NULL,
  `size` int(3) DEFAULT NULL,
  `need` int(1) NOT NULL DEFAULT '1',
  `pos` int(3) DEFAULT NULL,
  `public` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_cnbya_value`
--

CREATE TABLE `nuke_cnbya_value` (
  `vid` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `fid` int(10) NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------


--
-- Table structure for table `nuke_cnbya_value_temp`
--

CREATE TABLE `nuke_cnbya_value_temp` (
  `vid` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `fid` int(10) NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_comments`
--

CREATE TABLE `nuke_comments` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `name` varchar(60) NOT NULL DEFAULT '',
  `email` varchar(60) DEFAULT NULL,
  `url` varchar(60) DEFAULT NULL,
  `host_name` varchar(60) DEFAULT NULL,
  `subject` varchar(85) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  `score` tinyint(4) NOT NULL DEFAULT '0',
  `reason` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `pid` (`pid`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_config`
--

CREATE TABLE `nuke_config` (
  `sitename` varchar(255) NOT NULL DEFAULT '',
  `nukeurl` varchar(255) NOT NULL DEFAULT '',
  `site_logo` varchar(255) NOT NULL DEFAULT '',
  `slogan` varchar(255) NOT NULL DEFAULT '',
  `startdate` varchar(50) NOT NULL DEFAULT '',
  `adminmail` varchar(255) NOT NULL DEFAULT '',
  `anonpost` tinyint(1) NOT NULL DEFAULT '0',
  `default_Theme` varchar(255) NOT NULL DEFAULT '',
  `foot1` text NOT NULL,
  `foot2` text NOT NULL,
  `foot3` text NOT NULL,
  `commentlimit` int(9) NOT NULL DEFAULT '4096',
  `anonymous` varchar(255) NOT NULL DEFAULT '',
  `minpass` tinyint(1) NOT NULL DEFAULT '5',
  `pollcomm` tinyint(1) NOT NULL DEFAULT '1',
  `articlecomm` tinyint(1) NOT NULL DEFAULT '1',
  `broadcast_msg` tinyint(1) NOT NULL DEFAULT '1',
  `my_headlines` tinyint(1) NOT NULL DEFAULT '1',
  `top` int(3) NOT NULL DEFAULT '10',
  `storyhome` int(2) NOT NULL DEFAULT '10',
  `user_news` tinyint(1) NOT NULL DEFAULT '1',
  `oldnum` int(2) NOT NULL DEFAULT '30',
  `ultramode` tinyint(1) NOT NULL DEFAULT '0',
  `banners` tinyint(1) NOT NULL DEFAULT '1',
  `backend_title` varchar(255) NOT NULL DEFAULT '',
  `backend_language` varchar(10) NOT NULL DEFAULT '',
  `language` varchar(100) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT '',
  `multilingual` tinyint(1) NOT NULL DEFAULT '0',
  `useflags` tinyint(1) NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `notify_email` varchar(255) NOT NULL DEFAULT '',
  `notify_subject` varchar(255) NOT NULL DEFAULT '',
  `notify_message` varchar(255) NOT NULL DEFAULT '',
  `notify_from` varchar(255) NOT NULL DEFAULT '',
  `moderate` tinyint(1) NOT NULL DEFAULT '0',
  `admingraphic` tinyint(1) NOT NULL DEFAULT '1',
  `httpref` tinyint(1) NOT NULL DEFAULT '1',
  `httprefmax` int(5) NOT NULL DEFAULT '1000',
  `CensorMode` tinyint(1) NOT NULL DEFAULT '3',
  `CensorReplace` varchar(10) NOT NULL DEFAULT '',
  `copyright` text NOT NULL,
  `Version_Num` varchar(10) NOT NULL DEFAULT '',
  `admin_pos` tinyint(1) NOT NULL DEFAULT '1',
  `admin_log_lines` int(11) NOT NULL DEFAULT '0',
  `error_log_lines` int(11) NOT NULL DEFAULT '0',
  `cache_data` mediumblob NOT NULL,
  PRIMARY KEY (`sitename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_config`
--

INSERT INTO `nuke_config` (`sitename`, `nukeurl`, `site_logo`, `slogan`, `startdate`, `adminmail`, `anonpost`, `default_Theme`, `foot1`, `foot2`, `foot3`, `commentlimit`, `anonymous`, `minpass`, `pollcomm`, `articlecomm`, `broadcast_msg`, `my_headlines`, `top`, `storyhome`, `user_news`, `oldnum`, `ultramode`, `banners`, `backend_title`, `backend_language`, `language`, `locale`, `multilingual`, `useflags`, `notify`, `notify_email`, `notify_subject`, `notify_message`, `notify_from`, `moderate`, `admingraphic`, `httpref`, `httprefmax`, `CensorMode`, `CensorReplace`, `copyright`, `Version_Num`, `admin_pos`, `admin_log_lines`, `error_log_lines`, `cache_data`) VALUES
('My Site', 'http://-------------.---', 'logo.png', 'Your Slogan here', 'December 2018', 'Webmaster@MySite.com', 0, 'XtremeV3', '<a href=\"modules.php?name=Spambot_Killer\" target=\"_blank\">Spambot Killer</a> | <a href=\"modules.php?name=Site_Map\" target=\"_blank\">Site Map</a><br />', '<a href=\"rss.php?feed=news\" target=\"_blank\"><img border=\"0\" src=\"images/powered/feed_20_news.png\" width=\"94\" height=\"15\" alt=\"[News Feed]\" title=\"News Feed\" /></a> <a href=\"rss.php?feed=forums\" target=\"_blank\"><img border=\"0\" src=\"images/powered/feed_20_forums.png\" width=\"94\" height=\"15\" alt=\"[Forums Feed]\" title=\"Forums Feed\" /></a> <a href=\"rss.php?feed=downloads\" target=\"_blank\" /><img border=\"0\" src=\"images/powered/feed_20_down.png\" width=\"94\" height=\"15\" alt=\"[Downloads Feed]\" title=\"Downloads Feed\" /></a> <a href=\"rss.php?feed=weblinks\" target=\"_blank\"><img border=\"0\" src=\"images/powered/feed_20_links.png\" width=\"94\" height=\"15\" alt=\"[Web Links Feed]\" title=\"Web Links Feed\" /></a> <a href=\"http://htmlpurifier.org/\"><img src=\"images/powered/html_purifier_powered.png\" alt=\"Powered by HTML Purifier\" border=\"0\" /></a> <a href=\"http://tool.motoricerca.info/robots-checker.phtml?checkreferer=1\" target=\"_blank\"><img border=\"0\" src=\"images/powered/valid-robots.png\" width=\"80\" height=\"15\" alt=\"[Validate robots.txt]\" title=\"Validate robots.txt\" /></a>', '', 4096, 'Anonymous', 5, 1, 1, 1, 1, 10, 10, 1, 30, 1, 0, 'Powered by Evolution Xtreme 2.0.9f', 'en-us', 'english', 'en_US', 1, 0, 0, 'webmaster@---------.---', 'NEWS for my site', 'Hey! You got a new submission for your site.', 'webmaster', 0, 1, 1, 1000, 3, '*****', 'PHP-Nuke Copyright &copy; 2006 by Francisco Burzi.<br>All logos, trademarks and posts in this site are property of their respective owners, all the rest &copy; 2006 by the site owner.<br>Powered by <a href=\"http://www.nuke-evolution.com\" target=\"_blank\">Nuke Evolution 2.0.7</a> - <a href=\"https://www.evolution-xtreme.com\" target=\"_blank\">Nuke-Evolution Xtreme 2.0.9f Edition</a>.<br>', '7.6.0', 1, 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_confirm`
--

CREATE TABLE `nuke_confirm` (
  `confirm_id` char(32) NOT NULL DEFAULT '',
  `session_id` char(32) NOT NULL DEFAULT '',
  `code` char(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`session_id`,`confirm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_counter`
--

CREATE TABLE `nuke_counter` (
  `type` varchar(80) NOT NULL DEFAULT '',
  `var` varchar(80) NOT NULL DEFAULT '',
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  KEY `var` (`var`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_counter`
--

INSERT INTO `nuke_counter` (`type`, `var`, `count`) VALUES
('total', 'hits', 0),
('browser', 'Avant', 0),
('browser', 'Camino', 0),
('browser', 'Crazy', 0),
('browser', 'DEVONtech', 0),
('browser', 'Dillo', 0),
('browser', 'Galeon', 0),
('browser', 'ELinks', 0),
('browser', 'Epiphany', 0),
('browser', 'Firefox', 0),
('browser', 'iRider', 0),
('browser', 'K-Meleon', 0),
('browser', 'Konqueror', 0),
('browser', 'Lynx', 0),
('browser', 'Maxthon', 0),
('browser', 'Mozilla', 0),
('browser', 'MSIE', 0),
('browser', 'MultiZilla', 0),
('browser', 'NetCaptor', 0),
('browser', 'Netscape', 0),
('browser', 'OmniWeb', 0),
('browser', 'Opera', 0),
('browser', 'Safari', 0),
('browser', 'Shiira', 0),
('browser', 'Voyager', 0),
('browser', 'w3m', 0),
('browser', 'WAP', 0),
('browser', 'WebWasher', 0),
('browser', 'Bot', 0),
('browser', 'Other', 0),
('os', 'Windows', 0),
('os', 'Linspire', 0),
('os', 'Linux', 0),
('os', 'Mac', 0),
('os', 'FreeBSD', 0),
('os', 'SunOS', 0),
('os', 'IRIX', 0),
('os', 'OS/2', 0),
('os', 'AIX', 0),
('os', 'Other', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_donators`
--

CREATE TABLE `nuke_donators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `uname` varchar(60) NOT NULL DEFAULT '',
  `fname` varchar(25) NOT NULL DEFAULT '',
  `lname` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `donated` decimal(8,2) NOT NULL DEFAULT '0.00',
  `dondate` varchar(255) NOT NULL DEFAULT '',
  `donshow` tinyint(1) NOT NULL DEFAULT '0',
  `uip` varchar(255) NOT NULL DEFAULT '',
  `donok` tinyint(1) NOT NULL DEFAULT '0',
  `msg` text,
  `donto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_donators_config`
--

CREATE TABLE `nuke_donators_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` text NOT NULL,
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_donators_config`
--

INSERT INTO `nuke_donators_config` (`config_name`, `config_value`) VALUES
('values', '5,10,25,50,100'),
('block_show_amount', 'yes'),
('block_show_anon_amount', 'yes'),
('block_button_image', 'images/donations/paypal.png'),
('block_num_donations', '10'),
('block_show_dates', 'yes'),
('block_message', 'Find our site useful? Make a small donation to show your support.'),
('block_show_goal', 'no'),
('block_scroll', 'yes'),
('block_numbers', 'no'),
('page_num_donations', '25'),
('page_show_anon_amount', 'yes'),
('page_show_amount', 'yes'),
('page_show_dates', 'no'),
('page_header_image', ''),
('gen_pp_email', ''),
('gen_donation_name', 'Site Donation'),
('gen_donation_code', 'site_donation'),
('gen_button_image', 'images/donations/paypal.png'),
('gen_currency', 'USD'),
('gen_monthly_goal', '50.00'),
('gen_date_format', 'm/d/Y'),
('gen_type_private', 'no'),
('gen_type_anon', 'no'),
('gen_thank_image', ''),
('gen_thank_message', 'Thank you for your kind donation!<br /><br />Please come again!'),
('gen_cancel_image', 'images/logo.png'),
('gen_cancel_message', 'Sorry you could not donate!<br /><br />Please come again!'),
('gen_page_image', 'images/logo.png'),
('gen_message', 'yes'),
('gen_codes', ''),
('gen_cookie', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_ecalendar`
--

CREATE TABLE `nuke_ecalendar` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `month` varchar(11) DEFAULT NULL,
  `day` varchar(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `reoccur` int(11) NOT NULL DEFAULT '0',
  `time` varchar(5) DEFAULT NULL,
  `ampm` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`eid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_evolution`
--

CREATE TABLE `nuke_evolution` (
  `evo_field` varchar(50) NOT NULL DEFAULT '',
  `evo_value` text NOT NULL,
  PRIMARY KEY (`evo_field`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_evolution`
--

INSERT INTO `nuke_evolution` (`evo_field`, `evo_value`) VALUES
('sub', 'Xtreme'),
('ver_check', '0'),
('ver_previous', '2.0.9f'),
('lock_modules', '0'),
('queries_count', '1'),
('adminssl', '0'),
('poll_random', '0'),
('poll_days', '30'),
('censor_words', 'ass asshole arse bitch bullshit c0ck clit cock crap cum cunt fag faggot fuck fucker fucking fuk fuking motherfucker pussy shit tits twat'),
('censor', '0'),
('usrclearcache', '0'),
('cache_last_cleared', '1536324841'),
('textarea', 'bbcode'),
('use_colors', '1'),
('usegfxcheck', '0'),
('codesize', '7'),
('iphub_use', '0'),
('useimage', '1'),
('lazy_tap', '0'),
('img_resize', '1'),
('img_width', '300'),
('img_height', '300'),
('capfile', ''),
('module_collapse', '1'),
('collapse', '0'),
('evouserinfo_ec', '1'),
('collapsetype', '1'),
('analytics', ''),
('img_viewer', 'fancybox'),
('html_auth', '1'),
('pm_alert_status', '1'),
('pm_cookie_name', 'jquery_pm_popup'),
('pm_cookie_minutes', '5'),
('pm_cookie_seconds', '1'),
('pm_overlay_color', '#000000'),
('pm_button_color', '#004594'),
('pm_button_color2', '#006de9'),
('pm_alert_sound', '1'),
('admin_fc_status', '0'),
('admin_fc_attempts', '5'),
('admin_fc_timeout', '15'),
('iphub_status', '0'),
('iphub_key', ''),
('iphub_cookietime', '5'),
('recap_color', 'white'),
('recap_lang', 'en'),
('recap_site_key', ''),
('recap_priv_key', ''),
('block_cachetime', '86400');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_evo_userinfo`
--

CREATE TABLE `nuke_evo_userinfo` (
  `name` varchar(25) NOT NULL,
  `filename` varchar(25) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(10) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_evo_userinfo`
--

INSERT INTO `nuke_evo_userinfo` (`name`, `filename`, `active`, `position`, `image`) VALUES
('Good Afternoon', 'good_afternoon', 1, 1, ''),
('Username', 'username', 0, 2, ''),
('Rank', 'rank', 0, 4, ''),
('Login/logout/register', 'login', 1, 5, ''),
('Current Online', 'online', 1, 17, ''),
('PMs', 'pms', 1, 4, ''),
('Users', 'users', 1, 9, ''),
('Most Ever', 'mostever', 0, 13, ''),
('Members', 'members', 1, 7, ''),
('Avatar', 'avatar', 1, 2, ''),
('Personal Message', 'personal_message', 0, 1, ''),
('Language', 'language', 0, 3, ''),
('Posts', 'posts', 0, 11, ''),
('Break', 'Break', 1, 14, ''),
('Break', 'Break', 1, 12, ''),
('Break', 'Break', 1, 10, ''),
('Break', 'Break', 1, 8, ''),
('Break', 'Break', 1, 6, ''),
('Break', 'Break', 1, 3, ''),
('Break', 'Break', 1, 16, '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_evo_userinfo_addons`
--

CREATE TABLE `nuke_evo_userinfo_addons` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_evo_userinfo_addons`
--

INSERT INTO `nuke_evo_userinfo_addons` (`name`, `value`) VALUES
('good_afternoon_message', 'Good morning %name%:'),
('personal_message_message', '<div style=\"text-align:center\">Hello %name%, <br />\r\nWelcome to %site%.</div>'),
('username_center', 'yes'),
('online_show_hv', 'no'),
('online_scroll', 'no'),
('online_show_members', 'yes'),
('online_tooltip', 'yes'),
('online_country_flag', 'yes'),
('online_user_level_image', 'yes'),
('rank_show_title', 'no'),
('rank_show_2nd', 'no'),
('rank_show_3rd', 'no'),
('rank_show_4th', 'no'),
('rank_show_5th', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_faqanswer`
--

CREATE TABLE `nuke_faqanswer` (
  `id` int(25) NOT NULL AUTO_INCREMENT,
  `id_cat` int(25) NOT NULL DEFAULT '0',
  `question` varchar(255) DEFAULT '',
  `answer` text,
  PRIMARY KEY (`id`),
  KEY `id_cat` (`id_cat`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_faqcategories`
--

CREATE TABLE `nuke_faqcategories` (
  `id_cat` tinyint(3) NOT NULL AUTO_INCREMENT,
  `categories` varchar(255) DEFAULT NULL,
  `flanguage` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_cat`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_categories`
--

CREATE TABLE `nuke_file_repository_categories` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `parentid` int(11) NOT NULL DEFAULT '0',
  `permissions` int(11) NOT NULL DEFAULT '0',
  `isallowed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_comments`
--

CREATE TABLE `nuke_file_repository_comments` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL DEFAULT '0',
  `comment` text,
  `date` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `rating` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  `user` varchar(255) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_files`
--

CREATE TABLE `nuke_file_repository_files` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL,
  `ftitle` varchar(50) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `filesize` int(20) NOT NULL,
  `last_downloaded` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_items`
--

CREATE TABLE `nuke_file_repository_items` (
  `cid` int(11) NOT NULL DEFAULT '0',
  `author` varchar(100) NOT NULL DEFAULT '',
  `author_email` varchar(100) NOT NULL DEFAULT '',
  `author_website` varchar(100) NOT NULL DEFAULT '',
  `color` varchar(7) NOT NULL DEFAULT '',
  `currency` varchar(7) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `description` text,
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `fixes` longtext,
  `groups` int(11) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0',
  `isactive` int(11) NOT NULL DEFAULT '0',
  `isapproved` int(11) NOT NULL DEFAULT '0',
  `isbroken` tinyint(1) NOT NULL DEFAULT '0',
  `isfeatured` int(11) NOT NULL DEFAULT '0',
  `isnew` int(11) NOT NULL DEFAULT '0',
  `isupdated` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `lastdownloaded` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `paypal` varchar(255) NOT NULL DEFAULT '',
  `points` int(11) NOT NULL DEFAULT '0',
  `posts` int(11) NOT NULL DEFAULT '0',
  `preview` varchar(255) NOT NULL DEFAULT '',
  `price` int(11) NOT NULL DEFAULT '0',
  `semail` varchar(100) NOT NULL DEFAULT '',
  `sname` varchar(100) NOT NULL DEFAULT '',
  `suid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `version` varchar(30) NOT NULL DEFAULT '',
  `views` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`did`),
  KEY `cid` (`cid`),
  KEY `title` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_screenshots`
--

CREATE TABLE `nuke_file_repository_screenshots` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL,
  `size` int(11) NOT NULL DEFAULT '0',
  `active` int(11) NOT NULL DEFAULT '1',
  `submitter` varchar(100) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `did` (`did`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_settings`
--

CREATE TABLE `nuke_file_repository_settings` (
  `config_name` varchar(255) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_file_repository_settings`
--

INSERT INTO `nuke_file_repository_settings` (`config_name`, `config_value`) VALUES
('uhead', '1'),
('utext', '0'),
('pophits', '250'),
('version', '1.1.0'),

('usegfxcheck', '1'),
('currency', 'GBP'),
('parse_smilies', '1'),
('date_format', 'M jS, Y g:i a'),
('viewer', 'lightboxevo'),
('developer_mode', '1'),
('overview_display', '1'),
('overview_count', '5'),
('most_popular', '50'),
('download_view', '1'),
('adminBypass', '0'),
('users_can_upload', '1'),
('users_file_upload_amount', '2'),
('users_screens_upload_amount', '3'),
('overview_display_areas', 'newdownloads,mostpopular,statistics'),
('show_legend', '0'),
('allowed_file_extensions', '7z,arj,rar,tar.gz,zip,tar,pdf'),
('allowed_image_extensions', 'jpeg,jpg,png,gif'),
('group_allowed_to_upload', '1');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_file_repository_themes`
--

CREATE TABLE `nuke_file_repository_themes` (
  `theme_name` varchar(255) NOT NULL,
  `cell` int(11) NOT NULL,
  `head` int(11) NOT NULL,
  `per_row` int(11) NOT NULL,
  `show_left` int(11) NOT NULL,
  PRIMARY KEY (`theme_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_file_repository_themes`
--

INSERT INTO `nuke_file_repository_themes` (`theme_name`, `cell`, `head`, `per_row`, `show_left`) VALUES
('XtremeV3', 0, 0, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_headlines`
--

CREATE TABLE `nuke_headlines` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `sitename` varchar(30) NOT NULL DEFAULT '',
  `headlinesurl` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`hid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_headlines`
--

INSERT INTO `nuke_headlines` (`hid`, `sitename`, `headlinesurl`) VALUES
(1, 'AbsoluteGames', 'http://files.gameaholic.com/agfa.rdf'),
(2, 'DailyDaemonNews', 'http://daily.daemonnews.org/ddn.rdf.php3'),
(3, 'FreeDOS', 'http://sourceforge.net/export/rss2_projnews.php?group_id=5109'),
(4, 'LinuxWeelyNews', 'http://lwn.net/headlines/rss'),
(5, 'Listology', 'http://listology.com/recent.rdf'),
(6, 'PHP-Nuke', 'http://phpnuke.org/backend.php'),
(7, 'PerlMonks', 'http://www.perlmonks.org/headlines.rdf'),
(8, 'WebReference', 'http://webreference.com/webreference.rdf');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_hnl_categories`
--

CREATE TABLE `nuke_hnl_categories` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `ctitle` varchar(50) NOT NULL DEFAULT '',
  `cdescription` text NOT NULL,
  `cblocklimit` int(4) NOT NULL DEFAULT '10',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_hnl_categories`
--

INSERT INTO `nuke_hnl_categories` (`cid`, `ctitle`, `cdescription`, `cblocklimit`) VALUES
(1, '*Unassigned*', 'This is a catch-all category where newsletters can default to or if all other categories are removed.  Do NOT remove this category!  This category of newsletters are only shown to the Admins.  ', 5),
(2, 'Archived Newsletters', 'This category is for newsletter subscribers.', 5),
(3, 'Archived Mass Mails', 'This category is used for mass mails.', 5);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_hnl_cfg`
--

CREATE TABLE `nuke_hnl_cfg` (
  `cfg_nm` varchar(255) NOT NULL DEFAULT '',
  `cfg_val` longtext NOT NULL,
  PRIMARY KEY (`cfg_nm`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_hnl_cfg`
--

INSERT INTO `nuke_hnl_cfg` (`cfg_nm`, `cfg_val`) VALUES
('debug_mode', 'ERROR'),
('debug_output', 'DISPLAY'),
('show_blocks', '0'),
('dl_module', 'downloads'),
('blk_lmt', '10'),
('scroll', '0'),
('scroll_height', '180'),
('scroll_amt', '2'),
('scroll_delay', '100'),
('version', '1.3.0'),
('show_hits', '0'),
('show_dates', '0'),
('show_sender', '0'),
('show_categories', '0'),
('nsn_groups', '0'),
('latest_news', '5'),
('latest_downloads', '0'),
('latest_links', '5'),
('latest_forums', '5'),
('latest_reviews', '0'),
('wysiwyg_on', '1'),
('wysiwyg_rows', '30');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_hnl_newsletters`
--

CREATE TABLE `nuke_hnl_newsletters` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '1',
  `topic` varchar(100) NOT NULL DEFAULT '',
  `sender` varchar(20) NOT NULL DEFAULT '',
  `filename` varchar(32) NOT NULL DEFAULT '',
  `datesent` date DEFAULT NULL,
  `view` int(1) NOT NULL DEFAULT '0',
  `groups` text NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nid`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_hnl_newsletters`
--

INSERT INTO `nuke_hnl_newsletters` (`nid`, `cid`, `topic`, `sender`, `filename`, `datesent`, `view`, `groups`, `hits`) VALUES
(1, 1, 'PREVIEW Newsletter File', 'Admin', 'tmp.php', '2018-12-12', 99, '', 0),
(2, 1, 'Tested Email Temporary File', 'Admin', 'testemail.php', '2018-12-12', 99, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_honeypot`
--

CREATE TABLE `nuke_honeypot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(55) NOT NULL,
  `realname` varchar(75) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip` varchar(60) NOT NULL DEFAULT '',
  `date` varchar(50) NOT NULL DEFAULT '',
  `potnum` varchar(1) NOT NULL DEFAULT '',
  `reason` varchar(255) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_honeypot_config`
--

CREATE TABLE `nuke_honeypot_config` (
  `usehp` tinyint(1) NOT NULL,
  `botlisting` tinyint(1) NOT NULL,
  `perpage` varchar(3) NOT NULL,
  `pagenumberpos` tinyint(1) NOT NULL,
  `headcolor` varchar(7) NOT NULL,
  `rowcolor1` varchar(7) NOT NULL,
  `rowcolor2` varchar(7) NOT NULL,
  `pagebgcolor` varchar(7) NOT NULL,
  `pagebordercolor` varchar(7) NOT NULL,
  `fontcolor` varchar(7) NOT NULL,
  `fontcolor2` varchar(7) NOT NULL,
  `check1` tinyint(1) NOT NULL,
  `check2` tinyint(1) NOT NULL,
  `check3` tinyint(1) NOT NULL,
  `check4` tinyint(1) NOT NULL,
  `check5` tinyint(1) NOT NULL,
  `check6` tinyint(1) NOT NULL,
  `c7opt1` tinyint(1) NOT NULL,
  `c7opt2` tinyint(1) NOT NULL,
  `c7amount` varchar(2) NOT NULL,
  `c8opt1` tinyint(1) NOT NULL,
  `c8opt2` tinyint(1) NOT NULL,
  `usebsapi` tinyint(1) NOT NULL,
  `c8apikey` varchar(255) NOT NULL,
  `fs9opt1` tinyint(1) NOT NULL,
  `fs9opt2` tinyint(1) NOT NULL,
  `fs9apikey` varchar(255) NOT NULL,
  `check3time` varchar(2) NOT NULL,
  `check4question` varchar(255) NOT NULL,
  `check4answer` varchar(255) NOT NULL,
  `usefeedback` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `version` varchar(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_honeypot_config`
--

INSERT INTO `nuke_honeypot_config` (`usehp`, `botlisting`, `perpage`, `pagenumberpos`, `headcolor`, `rowcolor1`, `rowcolor2`, `pagebgcolor`, `pagebordercolor`, `fontcolor`, `fontcolor2`, `check1`, `check2`, `check3`, `check4`, `check5`, `check6`, `c7opt1`, `c7opt2`, `c7amount`, `c8opt1`, `c8opt2`, `usebsapi`, `c8apikey`, `fs9opt1`, `fs9opt2`, `fs9apikey`, `check3time`, `check4question`, `check4answer`, `usefeedback`, `email`, `version`) VALUES
(1, 1, '30', 2, '#a92828', '#e48600', '#f8ce55', '#f8ce55', '#a92828', '#000000', '#000000', 1, 1, 1, 0, 1, 1, 1, 1, '5', 0, 0, 0, '', 0, 0, '', '30', '', '', 0, 'admin@YourSite.com', '2.2');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_image_repository_settings`
--

CREATE TABLE `nuke_image_repository_settings` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `nuke_image_repository_settings` (`config_name`, `config_value`) VALUES
('alignment', 'left'),
('basedir', 'modules/Image_Repository/files'),
('spacing', '1'),
('image_view', '2'),
('perpage', '20'),
('admin_perpage', '20'),
('lytebox_color', 'black'),
('allow_colorization', '0'),
('thumb_width', '160'),
('thumb_height', '120'),
('jquery_prefix', 'nuke_jq'),
('pagination', '1'),
('max_upload', '4194304'),
('quota', '52428800');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_image_repository_uploads`
--

CREATE TABLE `nuke_image_repository_uploads` (
  `pid` int(20) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `submitter` varchar(255) DEFAULT NULL,
  `image` text,
  `size` int(11) NOT NULL DEFAULT '0',
  `screensize` varchar(255) DEFAULT NULL,
  `uploaded` int(11) NOT NULL DEFAULT '0',
  `bypass_thumb` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_image_repository_users`
--

CREATE TABLE `nuke_image_repository_users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `background_color` varchar(20) DEFAULT NULL,
  `border_color` varchar(20) DEFAULT NULL,
  `border_thickness` varchar(3) DEFAULT NULL,
  `folder` int(11) NOT NULL DEFAULT '0',
  `percent_color` varchar(20) DEFAULT NULL,
  `quota` varchar(255) DEFAULT NULL,
  `quota_request` tinyint(2) NOT NULL DEFAULT '0',
  `custom_color` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_jmap`
--

CREATE TABLE `nuke_jmap` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_jmap`
--

INSERT INTO `nuke_jmap` (`name`, `value`) VALUES
('xml', '1'),
('ntopics', '10'),
('nnews', '15'),
('ndown', '10'),
('nrev', '10'),
('nuser', '5');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_main`
--

CREATE TABLE `nuke_main` (
  `main_module` varchar(255) NOT NULL DEFAULT '',
  KEY `main_module` (`main_module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_main`
--

INSERT INTO `nuke_main` (`main_module`) VALUES
('News');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_message`
--

CREATE TABLE `nuke_message` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `date` varchar(14) NOT NULL DEFAULT '',
  `expire` int(7) NOT NULL DEFAULT '0',
  `active` int(1) NOT NULL DEFAULT '1',
  `view` int(1) NOT NULL DEFAULT '1',
  `groups` text NOT NULL,
  `mlanguage` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`mid`),
  UNIQUE KEY `mid` (`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_meta`
--

CREATE TABLE `nuke_meta` (
  `meta_name` varchar(50) NOT NULL DEFAULT '',
  `meta_content` text NOT NULL,
  PRIMARY KEY (`meta_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_meta`
--

INSERT INTO `nuke_meta` (`meta_name`, `meta_content`) VALUES
('resource-type', 'document'),
('distribution', 'global'),
('author', 'Nuke-Evolution Xtreme'),
('copyright', 'Copyright (c) by Nuke-Evolution'),
('keywords', 'Nuke-Evolution, evo, pne, evolution, nuke, php-nuke, software, downloads, community, forums, bulletin, boards, cms, nuke-evo, phpnuke'),
('description', 'Nuke-Evolution Xtreme'),
('robots', 'index, follow'),
('revisit-after', '1 days'),
('rating', 'general');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_modules`
--

CREATE TABLE `nuke_modules` (
  `mid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `custom_title` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `view` tinyint(4) NOT NULL DEFAULT '0',
  `inmenu` tinyint(4) NOT NULL DEFAULT '1',
  `pos` tinyint(4) NOT NULL DEFAULT '0',
  `cat_id` tinyint(4) NOT NULL DEFAULT '0',
  `blocks` tinyint(4) NOT NULL DEFAULT '1',
  `admins` varchar(255) NOT NULL DEFAULT '',
  `groups` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mid`),
  UNIQUE KEY `mid` (`mid`),
  KEY `title` (`title`),
  KEY `custom_title` (`custom_title`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_modules`
--

INSERT INTO `nuke_modules` (`mid`, `title`, `custom_title`, `active`, `view`, `inmenu`, `pos`, `cat_id`, `blocks`, `admins`, `groups`) VALUES
(1, 'Forums', 'Forums', 1, 1, 1, 3, 3, 1, '', ''),
(2, 'File_Repository', 'File Repository', 1, 1, 1, 0, 5, 1, '', ''),
(3, 'Your_Account', 'Your Account', 1, 0, 1, 4, 2, 1, '', ''),
(4, 'ECalendar', 'ECalendar', 0, 0, 1, 17, 7, 1, '', ''),
(5, 'Content', 'Content', 1, 0, 1, 0, 3, 1, '', ''),
(6, 'Docs', 'Docs', 1, 0, 1, 21, 7, 1, '', ''),
(7, 'Evo_UserBlock', 'Evo UserBlock', 0, 0, 1, 26, 7, 1, '', ''),
(8, 'FAQ', 'FAQ', 0, 0, 1, 25, 7, 1, '', ''),
(9, 'Feedback', 'Feedback', 1, 0, 1, 2, 3, 1, '', ''),
(10, 'Groups', 'Groups', 1, 0, 1, 4, 3, 1, '', ''),
(11, 'Members_List', 'Members List', 1, 0, 1, 1, 2, 1, '', ''),
(12, 'News', 'News', 1, 0, 1, 0, 6, 3, '', ''),
(13, 'NukeSentinel', 'NukeSentinel', 0, 0, 1, 15, 7, 1, '', ''),
(14, 'Private_Messages', 'Private Messages', 1, 0, 1, 3, 2, 1, '', ''),
(15, 'Profile', 'Profile', 1, 0, 1, 2, 2, 1, '', ''),
(16, 'Recommend_Us', 'Recommend Us', 0, 0, 1, 5, 7, 1, '', ''),
(17, 'Search', 'Search', 0, 0, 1, 3, 7, 1, '', ''),
(18, 'Site_Map', 'Site Map', 0, 0, 1, 2, 7, 1, '', ''),
(19, 'Spambot_Killer', 'Spambot Killer', 0, 0, 1, 1, 7, 1, '', ''),
(20, 'Statistics', 'Statistics', 0, 0, 1, 7, 7, 1, '', ''),
(21, 'Stories_Archive', 'Stories Archive', 0, 0, 1, 8, 7, 1, '', ''),
(22, 'Submit_News', 'Submit News', 0, 0, 1, 14, 7, 1, '', ''),
(23, 'Surveys', 'Surveys', 0, 0, 1, 12, 7, 1, '', ''),
(24, 'Top', 'Top', 0, 0, 1, 11, 7, 1, '', ''),
(25, 'Topics', 'Topics', 0, 0, 1, 10, 7, 1, '', ''),
(26, 'Image_Repository', 'Image Repository', 1, 3, 1, 0, 7, 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_modules_cat`
--

CREATE TABLE `nuke_modules_cat` (
  `cid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `image` text NOT NULL,
  `pos` tinyint(4) NOT NULL DEFAULT '0',
  `link_type` tinyint(4) NOT NULL DEFAULT '0',
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_modules_cat`
--

INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (1, 'Home', 'home.png', 0, 2, 'index.php');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (2, 'Members', 'members.png', 1, 0, '');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (3, 'Community', 'community.png', 2, 0, '');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (4, 'Statistics', 'poll.png', 3, 0, '');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (5, 'Files &amp; Links', 'web.png', 4, 0, '');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (6, 'News', 'news.png', 5, 0, '');
INSERT INTO `nuke_modules_cat` (`cid`, `name`, `image`, `pos`, `link_type`, `link`) VALUES (7, 'Other', 'general.png', 6, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_modules_links`
--

CREATE TABLE `nuke_modules_links` (
  `lid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `link_type` tinyint(4) NOT NULL DEFAULT '0',
  `link` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `view` tinyint(4) NOT NULL DEFAULT '0',
  `pos` tinyint(4) NOT NULL DEFAULT '0',
  `cat_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lid`),
  UNIQUE KEY `lid` (`lid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_modules_links`
--

INSERT INTO `nuke_modules_links` (`lid`, `title`, `link_type`, `link`, `active`, `view`, `pos`, `cat_id`) VALUES (2, 'Home', 1, 'index.php', 1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_mostonline`
--

CREATE TABLE `nuke_mostonline` (
  `total` int(10) NOT NULL DEFAULT '0',
  `members` int(10) NOT NULL DEFAULT '0',
  `nonmembers` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`total`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_mostonline`
--

INSERT INTO `nuke_mostonline` (`total`, `members`, `nonmembers`) VALUES (1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsncb_blocks`
--

CREATE TABLE `nuke_nsncb_blocks` (
  `rid` tinyint(2) NOT NULL DEFAULT '0',
  `cgid` tinyint(2) NOT NULL DEFAULT '0',
  `cbid` tinyint(2) NOT NULL DEFAULT '0',
  `title` varchar(60) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `wtype` tinyint(1) NOT NULL DEFAULT '0',
  `width` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `rid` (`rid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsncb_blocks`
--

INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (1, 1, 1, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (2, 1, 2, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (3, 1, 3, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (4, 1, 4, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (5, 2, 1, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (6, 2, 2, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (7, 2, 3, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (8, 2, 4, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (9, 3, 1, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (10, 3, 2, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (11, 3, 3, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (12, 3, 4, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (13, 4, 1, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (14, 4, 2, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (15, 4, 3, 'Place Holder', '', 'This is only a place holder', 1, 25);
INSERT INTO `nuke_nsncb_blocks` (`rid`, `cgid`, `cbid`, `title`, `filename`, `content`, `wtype`, `width`) VALUES (16, 4, 4, 'Place Holder', '', 'This is only a place holder', 1, 25);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsncb_config`
--

CREATE TABLE `nuke_nsncb_config` (
  `cgid` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `height` smallint(6) NOT NULL,
  `count` tinyint(1) NOT NULL,
  PRIMARY KEY (`cgid`),
  UNIQUE KEY `cfgid` (`cgid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsncb_config`
--

INSERT INTO `nuke_nsncb_config` (`cgid`, `enabled`, `height`, `count`) VALUES (1, 0, 0, 0);
INSERT INTO `nuke_nsncb_config` (`cgid`, `enabled`, `height`, `count`) VALUES (2, 0, 0, 0);
INSERT INTO `nuke_nsncb_config` (`cgid`, `enabled`, `height`, `count`) VALUES (3, 0, 0, 0);
INSERT INTO `nuke_nsncb_config` (`cgid`, `enabled`, `height`, `count`) VALUES (4, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnne_config`
--

CREATE TABLE `nuke_nsnne_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` longtext NOT NULL,
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnne_config`
--

INSERT INTO `nuke_nsnne_config` (`config_name`, `config_value`) VALUES
('columns', '0'),
('readmore', '0'),
('texttype', '0'),
('notifyauth', '0'),
('homenumber', '0'),
('hometopic', '0'),
('version_number', '1.1.6');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_admins`
--

CREATE TABLE `nuke_nsnst_admins` (
  `aid` varchar(25) NOT NULL DEFAULT '',
  `login` varchar(25) NOT NULL DEFAULT '',
  `password` varchar(20) NOT NULL DEFAULT '',
  `password_md5` varchar(60) NOT NULL DEFAULT '',
  `password_crypt` varchar(60) NOT NULL DEFAULT '',
  `protected` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`),
  KEY `password_md5` (`password_md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_blocked_ips`
--

CREATE TABLE `nuke_nsnst_blocked_ips` (
  `ip_addr` varchar(15) NOT NULL DEFAULT '',
  `ip_long` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '1',
  `username` varchar(60) NOT NULL DEFAULT 'Anonymous',
  `user_agent` text NOT NULL,
  `date` int(20) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `reason` tinyint(1) NOT NULL DEFAULT '0',
  `query_string` text NOT NULL,
  `get_string` text NOT NULL,
  `post_string` text NOT NULL,
  `x_forward_for` varchar(32) NOT NULL DEFAULT 'None',
  `client_ip` varchar(32) NOT NULL DEFAULT 'None',
  `remote_addr` varchar(32) NOT NULL DEFAULT '',
  `remote_port` varchar(11) NOT NULL DEFAULT 'Unknown',
  `request_method` varchar(10) NOT NULL DEFAULT '',
  `expires` int(20) NOT NULL DEFAULT '0',
  `c2c` char(2) NOT NULL DEFAULT '00',
  PRIMARY KEY (`ip_addr`),
  KEY `ip_long` (`ip_long`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_blocked_ranges`
--

CREATE TABLE `nuke_nsnst_blocked_ranges` (
  `ip_lo` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ip_hi` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `date` int(20) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `reason` tinyint(1) NOT NULL DEFAULT '0',
  `expires` int(20) NOT NULL DEFAULT '0',
  `c2c` char(2) NOT NULL DEFAULT '00',
  KEY `code` (`ip_lo`,`ip_hi`,`c2c`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_blockers`
--

CREATE TABLE `nuke_nsnst_blockers` (
  `blocker` int(4) NOT NULL DEFAULT '0',
  `block_name` varchar(20) NOT NULL DEFAULT '',
  `activate` int(4) NOT NULL DEFAULT '0',
  `block_type` int(4) NOT NULL DEFAULT '0',
  `email_lookup` int(4) NOT NULL DEFAULT '0',
  `forward` varchar(255) NOT NULL DEFAULT '',
  `reason` varchar(20) NOT NULL DEFAULT '',
  `template` varchar(255) NOT NULL DEFAULT '',
  `duration` int(20) NOT NULL DEFAULT '0',
  `htaccess` int(4) NOT NULL DEFAULT '0',
  `list` longtext NOT NULL,
  PRIMARY KEY (`blocker`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_blockers`
--

INSERT INTO `nuke_nsnst_blockers` (`blocker`, `block_name`, `activate`, `block_type`, `email_lookup`, `forward`, `reason`, `template`, `duration`, `htaccess`, `list`) VALUES
(0, 'other', 0, 0, 0, '', 'Abuse-Other', 'abuse_default.tpl', 0, 0, ''),
(1, 'union', 5, 0, 2, '', 'Abuse-Union', 'abuse_union.tpl', 0, 0, ''),
(2, 'clike', 5, 0, 2, '', 'Abuse-CLike', 'abuse_clike.tpl', 0, 0, ''),
(3, 'harvester', 0, 0, 0, '', 'Abuse-Harvest', 'abuse_harvester.tpl', 0, 0, '@yahoo.com\r\nalexibot\r\nalligator\r\nanonymiz\r\nasterias\r\nbackdoorbot\r\nblack hole\r\nblackwidow\r\nblowfish\r\nbotalot\r\nbuiltbottough\r\nbullseye\r\nbunnyslippers\r\ncatch\r\ncegbfeieh\r\ncharon\r\ncheesebot\r\ncherrypicker\r\nchinaclaw\r\ncombine\r\ncopyrightcheck\r\ncosmos\r\ncrescent\r\ncurl\r\ndbrowse\r\ndisco\r\ndittospyder\r\ndlman\r\ndnloadmage\r\ndownload\r\ndreampassport\r\ndts agent\r\necatch\r\neirgrabber\r\nerocrawler\r\nexpress webpictures\r\nextractorpro\r\neyenetie\r\nfantombrowser\r\nfantomcrew browser\r\nfileheap\r\nfilehound\r\nflashget\r\nfoobot\r\nfranklin locator\r\nfreshdownload\r\nfscrawler\r\ngamespy_arcade\r\ngetbot\r\ngetright\r\ngetweb\r\ngo!zilla\r\ngo-ahead-got-it\r\ngrab\r\ngrafula\r\ngsa-crawler\r\nharvest\r\nhloader\r\nhmview\r\nhttplib\r\nhttpresume\r\nhttrack\r\nhumanlinks\r\nigetter\r\nimage stripper\r\nimage sucker\r\nindustry program\r\nindy library\r\ninfonavirobot\r\ninstallshield digitalwizard\r\nINTerget\r\niria\r\nirvine\r\niupui research bot\r\njbh agent\r\njennybot\r\njetcar\r\njobo\r\njoc\r\nkapere\r\nkenjin spider\r\nkeyword density\r\nlarbin\r\nleechftp\r\nleechget\r\nlexibot\r\nlibweb/clshttp\r\nlibwww-perl\r\nlightningdownload\r\nlincoln state web browser\r\nlinkextractorpro\r\nlinkscan/8.1a.unix\r\nlinkwalker\r\nlwp-trivial\r\nlwp::simple\r\nmac finder\r\nmata hari\r\nmediasearch\r\nmetaproducts\r\nmicrosoft url control\r\nmidown tool\r\nmiixpc\r\nmissauga locate\r\nmissouri college browse\r\nmister pix\r\nmoget\r\nmozilla.*newt\r\nmozilla/3.0 (compatible)\r\nmozilla/3.mozilla/2.01\r\nmsie 4.0 (win95)\r\nmultiblocker browser\r\nmydaemon\r\nmygetright\r\nnabot\r\nnavroad\r\nnearsite\r\nnet vampire\r\nnetants\r\nnetmechanic\r\nnetpumper\r\nnetspider\r\nnewsearchengine\r\nnicerspro\r\nninja\r\nnitro downloader\r\nnpbot\r\noctopus\r\noffline explorer\r\noffline navigator\r\nopenfind\r\npagegrabber\r\npapa foto\r\npavuk\r\npbrowse\r\npcbrowser\r\npeval\r\npompos/\r\nprogram shareware\r\npropowerbot\r\nprowebwalker\r\npsurf\r\npuf\r\npuxarapido\r\nqueryn metasearch\r\nrealdownload\r\nreget\r\nrepomonkey\r\nrsurf\r\nrumours-agent\r\nsakura\r\nscan4mail\r\nsemanticdiscovery\r\nsitesnagger\r\nslysearch\r\nspankbot\r\nspanner \r\nspiderzilla\r\nsq webscanner\r\nstamina\r\nstar downloader\r\nsteeler\r\nsteeler\r\nstrip\r\nsuperbot\r\nsuperhttp\r\nsurfbot\r\nsuzuran\r\nswbot\r\nszukacz\r\ntakeout\r\nteleport\r\ntelesoft\r\ntest spider\r\nthe INTraformant\r\nthenomad\r\ntighttwatbot\r\ntitan\r\ntocrawl/urldispatcher\r\ntrue_robot\r\ntsurf\r\nturing machine\r\nturingos\r\nurlblaze\r\nurlgetfile\r\nurly warning\r\nutilmind\r\nvci\r\nvoideye\r\nweb image collector\r\nweb sucker\r\nwebauto\r\nwebbandit\r\nwebcapture\r\nwebcollage\r\nwebcopier\r\nwebenhancer\r\nwebfetch\r\nwebgo\r\nwebleacher\r\nwebmasterworldforumbot\r\nwebql\r\nwebreaper\r\nwebsite extractor\r\nwebsite quester\r\nwebster\r\nwebstripper\r\nwebwhacker\r\nwep search\r\nwget\r\nwhizbang\r\nwidow\r\nwildsoft surfer\r\nwww-collector-e\r\nwww.netwu.com\r\nwwwoffle\r\nxaldon\r\nxenu\r\nzeus\r\nziggy\r\nzippy'),
(4, 'script', 5, 0, 2, '', 'Abuse-Script', 'abuse_script.tpl', 0, 0, ''),
(5, 'author', 5, 0, 2, '', 'Abuse-Author', 'abuse_author.tpl', 0, 0, ''),
(6, 'referer', 5, 0, 2, '', 'Abuse-Referer', 'abuse_referer.tpl', 0, 0, '121hr.com\r\n1st-call.net\r\n1stcool.com\r\n5000n.com\r\n69-xxx.com\r\n9irl.com\r\n9uy.com\r\na-day-at-the-party.com\r\naccessthepeace.com\r\nadult-model-nude-pictures.com\r\nadult-sex-toys-free-porn.com\r\nagnitum.com\r\nalfonssackpfeiffe.com\r\nalongwayfrommars.com\r\nanime-sex-1.com\r\nanorex-sf-stimulant-free.com\r\nantibot.net\r\nantique-tokiwa.com\r\napotheke-heute.com\r\narmada31.com\r\nartark.com\r\nartlilei.com\r\nascendbtg.com\r\naschalaecheck.com\r\nasian-sex-free-sex.com\r\naslowspeeker.com\r\nassasinatedfrogs.com\r\nathirst-for-tranquillity.net\r\naubonpanier.com\r\navalonumc.com\r\nayingba.com\r\nbayofnoreturn.com\r\nbbw4phonesex.com\r\nbeersarenotfree.com\r\nbierikiuetsch.com\r\nbilingualannouncements.com\r\nblack-pussy-toon-clip-anal-lover-single.com\r\nblownapart.com\r\nblueroutes.com\r\nboasex.com\r\nbooksandpages.com\r\nbootyquake.com\r\nbossyhunter.com\r\nboyz-sex.com\r\nbrokersaandpokers.com\r\nbrowserwindowcleaner.com\r\nbudobytes.com\r\nbusiness2fun.com\r\nbuymyshitz.com\r\nbyuntaesex.com\r\ncaniputsomeloveINToyou.com\r\ncartoons.net.ru\r\ncaverunsailing.com\r\ncertainhealth.com\r\nclantea.com\r\nclose-protection-services.com\r\nclubcanino.com\r\nclubstic.com\r\ncobrakai-skf.com\r\ncollegefucktour.co.uk\r\ncommanderspank.com\r\ncoolenabled.com\r\ncrusecountryart.com\r\ncrusingforsex.co.uk\r\ncunt-twat-pussy-juice-clit-licking.com\r\ncustomerhandshaker.com\r\ncyborgrama.com\r\ndarkprofits.co.uk\r\ndatingforme.co.uk\r\ndatingmind.com\r\ndegree.org.ru\r\ndelorentos.com\r\ndiggydigger.com\r\ndinkydonkyaussie.com\r\ndjpritchard.com\r\ndjtop.com\r\ndraufgeschissen.com\r\ndreamerteens.co.uk\r\nebonyarchives.co.uk\r\nebonyplaya.co.uk\r\necobuilder2000.com\r\nemailandemail.com\r\nemedici.net\r\nengine-on-fire.com\r\nerocity.co.uk\r\nesport3.com\r\neteenbabes.com\r\neurofreepages.com\r\neurotexans.com\r\nevolucionweb.com\r\nfakoli.com\r\nfe4ba.com\r\nferienschweden.com\r\nfindly.com\r\nfirsttimeteadrinker.com\r\nfishing.net.ru\r\nflatwonkers.com\r\nflowershopentertainment.com\r\nflymario.com\r\nfree-xxx-pictures-porno-gallery.com\r\nfreebestporn.com\r\nfreefuckingmovies.co.uk\r\nfreexxxstuff.co.uk\r\nfruitologist.net\r\nfruitsandbolts.com\r\nfuck-cumshots-free-midget-movie-clips.com\r\nfuck-michaelmoore.com\r\nfundacep.com\r\ngadless.com\r\ngallapagosrangers.com\r\ngalleries4free.co.uk\r\ngalofu.com\r\ngaypixpost.co.uk\r\ngeomasti.com\r\ngirltime.co.uk\r\nglassrope.com\r\ngodjustblessyouall.com\r\ngoldenageresort.com\r\ngonnabedaddies.com\r\ngranadasexi.com\r\ngranadasexi.com\r\nguardingtheangels.com\r\nguyprofiles.co.uk\r\nhappy1225.com\r\nhappychappywacky.com\r\nhealth.org.ru\r\nhexplas.com\r\nhighheelsmodels4fun.com\r\nhillsweb.com\r\nhiptuner.com\r\nhistoryINTospace.com\r\nhoa-tuoi.com\r\nhomebuyinginatlanta.com\r\nhorizonultra.com\r\nhorseminiature.net\r\nhotkiss.co.uk\r\nhotlivegirls.co.uk\r\nhotmatchup.co.uk\r\nhusler.co.uk\r\niaentertainment.com\r\niamnotsomeone.com\r\niconsofcorruption.com\r\nihavenotrustinyou.com\r\ninformat-systems.com\r\nINTeriorproshop.com\r\nINTersoftnetworks.com\r\nINThecrib.com\r\ninvestment4cashiers.com\r\niti-trailers.com\r\njackpot-hacker.com\r\njacks-world.com\r\njamesthesailorbasher.com\r\njesuislemonds.com\r\njustanotherdomainname.com\r\nkampelicka.com\r\nkanalrattenarsch.com\r\nkatzasher.com\r\nkerosinjunkie.com\r\nkillasvideo.com\r\nkoenigspisser.com\r\nkontorpara.com\r\nl8t.com\r\nlaestacion101.com\r\nlambuschlamppen.com\r\nlankasex.co.uk\r\nlaser-creations.com\r\nle-tour-du-monde.com\r\nlecraft.com\r\nledo-design.com\r\nleftregistration.com\r\nlekkikoomastas.com\r\nlepommeau.com\r\nlibr-animal.com\r\nlibraries.org.ru\r\nlikewaterlikewind.com\r\nlimbojumpers.com\r\nlink.ru\r\nlockportlinks.com\r\nloiproject.com\r\nlongtermalternatives.com\r\nlottoeco.com\r\nlucalozzi.com\r\nmaki-e-pens.com\r\nmalepayperview.co.uk\r\nmangaxoxo.com\r\nmaps.org.ru\r\nmarcofields.com\r\nmasterofcheese.com\r\nmasteroftheblasterhill.com\r\nmastheadwankers.com\r\nmegafrontier.com\r\nmeinschuppen.com\r\nmercurybar.com\r\nmetapannas.com\r\nmicelebre.com\r\nmidnightlaundries.com\r\nmikeapartment.co.uk\r\nmillenniumchorus.com\r\nmimundial2002.com\r\nminiaturegallerymm.com\r\nmixtaperadio.com\r\nmondialcoral.com\r\nmonja-wakamatsu.com\r\nmonstermonkey.net\r\nmouthfreshners.com\r\nmullensholiday.com\r\nmusilo.com\r\nmyhollowlog.com\r\nmyhomephonenumber.com\r\nmykeyboardisbroken.com\r\nmysofia.net\r\nnaked-cheaters.com\r\nnaked-old-women.com\r\nnastygirls.co.uk\r\nnationclan.net\r\nnatterratter.com\r\nnaughtyadam.com\r\nnestbeschmutzer.com\r\nnetwu.com\r\nnewrealeaseonline.com\r\nnewrealeasesonline.com\r\nnextfrontiersonline.com\r\nnikostaxi.com\r\nnotorious7.com\r\nnrecruiter.com\r\nnursingdepot.com\r\nnustramosse.com\r\nnuturalhicks.com\r\noccaz-auto49.com\r\nocean-db.net\r\noilburnerservice.net\r\nomburo.com\r\noneoz.com\r\nonepageahead.net\r\nonlinewithaline.com\r\norganizate.net\r\nourownweddingsong.com\r\nowen-music.com\r\np-partners.com\r\npaginadeautor.com\r\npakistandutyfree.com\r\npamanderson.co.uk\r\nparentsense.net\r\nparticlewave.net\r\npay-clic.com\r\npay4link.net\r\npcisp.com\r\npersist-pharma.com\r\npeteband.com\r\npetplusindia.com\r\npickabbw.co.uk\r\npicture-oral-position-lesbian.com\r\npl8again.com\r\nplaneting.net\r\npopusky.com\r\nporn-expert.com\r\npromoblitza.com\r\nproproducts-usa.com\r\nptcgzone.com\r\nptporn.com\r\npublishmybong.com\r\nputtingtogether.com\r\nqualifiedcancelations.com\r\nrahost.com\r\nrainbow21.com\r\nrakkashakka.com\r\nrandomfeeding.com\r\nrape-art.com\r\nrd-brains.com\r\nrealestateonthehill.net\r\nrebuscadobot\r\nrequested-stuff.com\r\nretrotrasher.com\r\nricopositive.com\r\nrisorseinrete.com\r\nrotatingcunts.com\r\nrunawayclicks.com\r\nrutalibre.com\r\ns-marche.com\r\nsabrosojazz.com\r\nsamuraidojo.com\r\nsanaldarbe.com\r\nsasseminars.com\r\nschlampenbruzzler.com\r\nsearchmybong.com\r\nseckur.com\r\nsex-asian-porn-INTerracial-photo.com\r\nsex-porn-fuck-hardcore-movie.com\r\nsexa3.net\r\nsexer.com\r\nsexINTention.com\r\nsexnet24.tv\r\nsexomundo.com\r\nsharks.com.ru\r\nshells.com.ru\r\nshop-ecosafe.com\r\nshop-toon-hardcore-fuck-cum-pics.com\r\nsilverfussions.com\r\nsin-city-sex.net\r\nsluisvan.com\r\nsmutshots.com\r\nsnagglersmaggler.com\r\nsomethingtoforgetit.com\r\nsophiesplace.net\r\nsoursushi.com\r\nsouthernxstables.com\r\nspeed467.com\r\nspeedpal4you.com\r\nsporty.org.ru\r\nstopdriving.net\r\nstw.org.ru\r\nsufficientlife.com\r\nsussexboats.net\r\nswinger-party-free-dating-porn-sluts.com\r\nsydneyhay.com\r\nszmjht.com\r\nteninchtrout.com\r\nthebalancedfruits.com\r\ntheendofthesummit.com\r\nthiswillbeit.com\r\nthosethosethose.com\r\nticyclesofindia.com\r\ntits-gay-fagot-black-tits-bigtits-amateur.com\r\ntonius.com\r\ntoohsoft.com\r\ntoolvalley.com\r\ntooporno.net\r\ntoosexual.com\r\ntorngat.com\r\ntour.org.ru\r\ntowneluxury.com\r\ntrafficmogger.com\r\ntriacoach.net\r\ntrottinbob.com\r\ntttframes.com\r\ntvjukebox.net\r\nundercvr.com\r\nunfinished-desires.com\r\nunicornonero.com\r\nunionvillefire.com\r\nupsandowns.com\r\nupthehillanddown.com\r\nvallartavideo.com\r\nvietnamdatingservices.com\r\nvinegarlemonshots.com\r\nvizy.net.ru\r\nvnladiesdatingservices.com\r\nvomitandbusted.com\r\nwalkingthewalking.com\r\nwell-I-am-the-type-of-boy.com\r\nwhales.com.ru\r\nwhincer.net\r\nwhitpagesrippers.com\r\nwhois.sc\r\nwipperrippers.com\r\nwordfilebooklets.com\r\nworld-sexs.com\r\nxsay.com\r\nxxxchyangel.com\r\nxxxzips.com\r\nyouarelostINTransit.com\r\nyuppieslovestocks.com\r\nyuzhouhuagong.com\r\nzhaori-food.com\r\nzwiebelbacke.com'),
(7, 'filter', 5, 0, 2, '', 'Abuse-Filter', 'abuse_filter.tpl', 0, 0, ''),
(8, 'request', 0, 0, 0, '', 'Abuse-Request', 'abuse_request.tpl', 0, 0, ''),
(9, 'string', 0, 0, 0, '', 'Abuse-String', 'abuse_string.tpl', 0, 0, ''),
(10, 'admin', 0, 0, 0, '', 'Abuse-Admin', 'abuse_admin.tpl', 0, 0, ''),
(11, 'flood', 0, 1, 2, '', 'Abuse-Flood', 'abuse_flood.tpl', 0, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_cidrs`
--

CREATE TABLE `nuke_nsnst_cidrs` (
  `cidr` int(2) NOT NULL DEFAULT '0',
  `hosts` int(10) NOT NULL DEFAULT '0',
  `mask` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`cidr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_cidrs`
--

INSERT INTO `nuke_nsnst_cidrs` (`cidr`, `hosts`, `mask`) VALUES
(1, 2147483647, '127.255.255.255'),
(2, 1073741824, '63.255.255.255'),
(3, 536870912, '31.255.255.255'),
(4, 268435456, '15.255.255.255'),
(5, 134217728, '7.255.255.255'),
(6, 67108864, '3.255.255.255'),
(7, 33554432, '1.255.255.255'),
(8, 16777216, '0.255.255.255'),
(9, 8388608, '0.127.255.255'),
(10, 4194304, '0.63.255.255'),
(11, 2097152, '0.31.255.255'),
(12, 1048576, '0.15.255.255'),
(13, 524288, '0.7.255.255'),
(14, 262144, '0.3.255.255'),
(15, 131072, '0.1.255.255'),
(16, 65536, '0.0.255.255'),
(17, 32768, '0.0.127.255'),
(18, 16384, '0.0.63.255'),
(19, 8192, '0.0.31.255'),
(20, 4096, '0.0.15.255'),
(21, 2048, '0.0.7.255'),
(22, 1024, '0.0.3.255'),
(23, 512, '0.0.1.255'),
(24, 256, '0.0.0.255'),
(25, 128, '0.0.0.127'),
(26, 64, '0.0.0.63'),
(27, 32, '0.0.0.31'),
(28, 16, '0.0.0.15'),
(29, 8, '0.0.0.7'),
(30, 4, '0.0.0.3'),
(31, 2, '0.0.0.1'),
(32, 1, '0.0.0.0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_config`
--

CREATE TABLE `nuke_nsnst_config` (
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` longtext NOT NULL,
  PRIMARY KEY (`config_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_config`
--

INSERT INTO `nuke_nsnst_config` (`config_name`, `config_value`) VALUES
('admin_contact', 'webmaster@yoursite.com'),
('block_perpage', '50'),
('block_sort_column', 'date'),
('block_sort_direction', 'desc'),
('crypt_salt', 'N$'),
('display_link', '3'),
('display_reason', '3'),
('force_nukeurl', '0'),
('help_switch', '1'),
('htaccess_path', ''),
('http_auth', '0'),
('lookup_link', 'http://www.DNSstuff.com/tools/whois.ch?ip='),
('page_delay', '5'),
('prevent_dos', '1'),
('proxy_reason', 'admin_proxy_reason.tpl'),
('proxy_switch', '0'),
('santy_protection', '1'),
('self_expire', '0'),
('site_reason', 'admin_site_reason.tpl'),
('site_switch', '0'),
('staccess_path', ''),
('track_active', '1'),
('track_max', '604800'),
('track_perpage', '50'),
('track_sort_column', '6'),
('track_sort_direction', 'desc'),
('ip_reason', 'admin_ip_reason.tpl'),
('ip_switch', '0'),
('ftaccess_path', ''),
('flood_delay', '2'),
('disable_switch', '0'),
('track_clear', '1539388800'),
('blocked_clear', '0'),
('version_check', '$checktime'),
('version_newest', '2.6.01'),
('version_number', '2.6.01'),
('dump_directory', ''),
('show_right', '0'),
('test_switch', '0');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_countries`
--

CREATE TABLE `nuke_nsnst_countries` (
  `c2c` char(2) NOT NULL DEFAULT '',
  `country` varchar(60) NOT NULL DEFAULT '',
  KEY `c2c` (`c2c`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_countries`
--

INSERT INTO `nuke_nsnst_countries` (`c2c`, `country`) VALUES
('00', 'Unknown'),
('01', 'IANA Reserved'),
('ac', 'Ascension Island'),
('ad', 'Andorra'),
('ae', 'United Arab Emirates'),
('af', 'Afghanistan'),
('ag', 'Antigua And Barbuda'),
('ai', 'Anguilla'),
('al', 'Albania'),
('am', 'Armenia'),
('an', 'Netherlands Antilles'),
('ao', 'Angola'),
('aq', 'Antarctica'),
('ar', 'Argentina'),
('as', 'American Samoa'),
('at', 'Austria'),
('au', 'Australia'),
('aw', 'Aruba'),
('ax', 'Aland Islands'),
('az', 'Azerbaijan'),
('ba', 'Bosnia And Herzegovina'),
('bb', 'Barbados'),
('bd', 'Bangladesh'),
('be', 'Belgium'),
('bf', 'Burkina Faso'),
('bg', 'Bulgaria'),
('bh', 'Bahrain'),
('bi', 'Burundi'),
('bj', 'Benin'),
('bm', 'Bermuda'),
('bn', 'Brunei Darussalam'),
('bo', 'Bolivia'),
('br', 'Brazil'),
('bs', 'Bahamas'),
('bt', 'Bhutan'),
('bv', 'Bouvet Island'),
('bw', 'Botswana'),
('by', 'Belarus'),
('bz', 'Belize'),
('ca', 'Canada'),
('cc', 'Cocos Keeling Islands'),
('cd', 'Democratic Republic of the Congo'),
('cf', 'Central African Republic'),
('cg', 'Republic of the Congo'),
('ch', 'Switzerland'),
('ci', 'Cote D\'ivoire'),
('ck', 'Cook Islands'),
('cl', 'Chile'),
('cm', 'Cameroon'),
('cn', 'China'),
('co', 'Colombia'),
('cr', 'Costa Rica'),
('cs', 'Czechoslovakia'),
('cu', 'Cuba'),
('cv', 'Cape Verde'),
('cx', 'Christmas Island'),
('cy', 'Cyprus'),
('cz', 'Czech Republic'),
('de', 'Germany'),
('dj', 'Djibouti'),
('dk', 'Denmark'),
('dm', 'Dominica'),
('do', 'Dominican Republic'),
('dz', 'Algeria'),
('ec', 'Ecuador'),
('ee', 'Estonia'),
('eg', 'Egypt'),
('eh', 'Western Sahara'),
('er', 'Eritrea'),
('es', 'Spain'),
('et', 'Ethiopia'),
('eu', 'European Union'),
('fi', 'Finland'),
('fj', 'Fiji'),
('fk', 'Falkland Islands'),
('fm', 'Micronesia'),
('fo', 'Faroes'),
('fr', 'France'),
('fx', 'Metropolitan France'),
('ga', 'Gabon'),
('gb', 'United Kingdom'),
('gd', 'Grenada'),
('ge', 'Georgia'),
('gf', 'French Guiana'),
('gg', 'Guernsey'),
('gh', 'Ghana'),
('gi', 'Gibraltar'),
('gl', 'Greenland'),
('gm', 'Gambia'),
('gn', 'Guinea'),
('gp', 'Guadeloupe'),
('gq', 'Equatorial Guinea'),
('gr', 'Greece'),
('gs', 'South Georgia and The Islands'),
('gt', 'Guatemala'),
('gu', 'Guam'),
('gw', 'Guinea-Bissau'),
('gy', 'Guyana'),
('hk', 'Hong Kong'),
('hm', 'Heard and McDonald Islands'),
('hn', 'Honduras'),
('hr', 'Croatia'),
('ht', 'Haiti'),
('hu', 'Hungary'),
('id', 'Indonesia'),
('ie', 'Ireland'),
('il', 'Israel'),
('im', 'Isle Of Man'),
('in', 'India'),
('io', 'British Indian Ocean Territory'),
('iq', 'Iraq'),
('ir', 'Iran'),
('is', 'Iceland'),
('it', 'Italy'),
('je', 'Jersey'),
('jm', 'Jamaica'),
('jo', 'Jordan'),
('jp', 'Japan'),
('ke', 'Kenya'),
('kg', 'Kyrgyzstan'),
('kh', 'Cambodia'),
('ki', 'Kiribati'),
('km', 'Comoros'),
('kn', 'SaINT Kitts And Nevis'),
('kp', 'North Korea'),
('kr', 'South Korea'),
('kw', 'Kuwait'),
('ky', 'Cayman Islands'),
('kz', 'Kazakhstan'),
('la', 'Laos'),
('lb', 'Lebanon'),
('lc', 'SaINT Lucia'),
('li', 'Liechtenstein'),
('lk', 'Sri Lanka'),
('lr', 'Liberia'),
('ls', 'Lesotho'),
('lt', 'Lithuania'),
('lu', 'Luxembourg'),
('lv', 'Latvia'),
('ly', 'Libya'),
('ma', 'Morocco'),
('mc', 'Monaco'),
('md', 'Moldova'),
('me', 'Montenegro'),
('mg', 'Madagascar'),
('mh', 'Marshall Islands'),
('mk', 'Macedonia'),
('ml', 'Mali'),
('mm', 'Myanmar'),
('mn', 'Mongolia'),
('mo', 'Macau'),
('mp', 'Northern Mariana Islands'),
('mq', 'Martinique'),
('mr', 'Mauritania'),
('ms', 'Montserrat'),
('mt', 'Malta'),
('mu', 'Mauritius'),
('mv', 'Maldives'),
('mw', 'Malawi'),
('mx', 'Mexico'),
('my', 'Malaysia'),
('mz', 'Mozambique'),
('na', 'Namibia'),
('nc', 'New Caledonia'),
('ne', 'Niger'),
('nf', 'Norfolk Island'),
('ng', 'Nigeria'),
('ni', 'Nicaragua'),
('nl', 'Netherlands'),
('no', 'Norway'),
('np', 'Nepal'),
('nr', 'Nauru'),
('nu', 'Niue'),
('nz', 'New Zealand'),
('om', 'Oman'),
('pa', 'Panama'),
('pe', 'Peru'),
('pf', 'French Polynesia'),
('pg', 'Papua New Guinea'),
('ph', 'Philippines'),
('pk', 'Pakistan'),
('pl', 'Poland'),
('pm', 'SaINT Pierre and Miquelon'),
('pn', 'Pitcairn Islands'),
('pr', 'Puerto Rico'),
('ps', 'Palestine'),
('pt', 'Portugal'),
('pw', 'Palau'),
('py', 'Paraguay'),
('qa', 'Qatar'),
('re', 'Reunion'),
('rs', 'Serbia'),
('ro', 'Romania'),
('ru', 'Russia'),
('rw', 'Rwanda'),
('sa', 'Saudi Arabia'),
('sb', 'Solomon Islands'),
('sc', 'Seychelles'),
('sd', 'Sudan'),
('se', 'Sweden'),
('sg', 'Singapore'),
('sh', 'SaINT Helena'),
('si', 'Slovenia'),
('sj', 'Svalbard'),
('sk', 'Slovakia'),
('sl', 'Sierra Leone'),
('sm', 'San Marino'),
('sn', 'Senegal'),
('so', 'Somalia'),
('sr', 'Suriname'),
('st', 'Sao Tome And Principe'),
('sv', 'El Salvador'),
('sy', 'Syria'),
('sz', 'Swaziland'),
('tc', 'Turks And Caicos Islands'),
('td', 'Chad'),
('tf', 'French Southern Territories'),
('tg', 'Togo'),
('th', 'Thailand'),
('tj', 'Tajikistan'),
('tk', 'Tokelau'),
('tl', 'East Timor'),
('tm', 'Turkmenistan'),
('tn', 'Tunisia'),
('to', 'Tonga'),
('tp', 'East Timor'),
('tr', 'Turkey'),
('tt', 'Trinidad And Tobago'),
('tv', 'Tuvalu'),
('tw', 'Taiwan'),
('tz', 'Tanzania'),
('ua', 'Ukraine'),
('ug', 'Uganda'),
('um', 'United States Minor Outlying Islands'),
('un', 'United Nations'),
('us', 'United States'),
('uy', 'Uruguay'),
('uz', 'Uzbekistan'),
('va', 'Vatican City'),
('vc', 'SaINT Vincent And The Grenadines'),
('ve', 'Venezuela'),
('vg', 'British Virgin Islands'),
('vi', 'US Virgin Islands'),
('vn', 'Vietnam'),
('vu', 'Vanuatu'),
('wf', 'Wallis and Futuna Islands'),
('ws', 'Samoa'),
('xe', 'England'),
('xs', 'Scotland'),
('xw', 'Wales'),
('ye', 'Yemen'),
('yt', 'Mayotte'),
('yu', 'Yugoslavia'),
('za', 'South Africa'),
('zm', 'Zambia'),
('zw', 'Zimbabwe'),
('02', 'UnAllocated');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_excluded_ranges`
--

CREATE TABLE `nuke_nsnst_excluded_ranges` (
  `ip_lo` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ip_hi` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `date` int(20) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `c2c` char(2) NOT NULL DEFAULT '00',
  KEY `code` (`ip_lo`,`ip_hi`,`c2c`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_harvesters`
--

CREATE TABLE `nuke_nsnst_harvesters` (
  `hid` int(2) NOT NULL AUTO_INCREMENT,
  `harvester` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`harvester`),
  KEY `hid` (`hid`)
) ENGINE=MyISAM AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_harvesters`
--

INSERT INTO `nuke_nsnst_harvesters` (`hid`, `harvester`) VALUES
(1, '@yahoo.com'),
(2, 'alexibot'),
(3, 'alligator'),
(4, 'anonymiz'),
(5, 'asterias'),
(6, 'backdoorbot'),
(7, 'black hole'),
(8, 'blackwidow'),
(9, 'blowfish'),
(10, 'botalot'),
(11, 'builtbottough'),
(12, 'bullseye'),
(13, 'bunnyslippers'),
(14, 'catch'),
(15, 'cegbfeieh'),
(16, 'charon'),
(17, 'cheesebot'),
(18, 'cherrypicker'),
(19, 'chinaclaw'),
(20, 'combine'),
(21, 'copyrightcheck'),
(22, 'cosmos'),
(23, 'crescent'),
(24, 'curl'),
(25, 'dbrowse'),
(26, 'disco'),
(27, 'dittospyder'),
(28, 'dlman'),
(29, 'dnloadmage'),
(30, 'download'),
(31, 'dreampassport'),
(32, 'dts agent'),
(33, 'ecatch'),
(34, 'eirgrabber'),
(35, 'erocrawler'),
(36, 'express webpictures'),
(37, 'extractorpro'),
(38, 'eyenetie'),
(39, 'fantombrowser'),
(40, 'fantomcrew browser'),
(41, 'fileheap'),
(42, 'filehound'),
(43, 'flashget'),
(44, 'foobot'),
(45, 'franklin locator'),
(46, 'freshdownload'),
(47, 'fscrawler'),
(48, 'gamespy_arcade'),
(49, 'getbot'),
(50, 'getright'),
(51, 'getweb'),
(52, 'go!zilla'),
(53, 'go-ahead-got-it'),
(54, 'grab'),
(55, 'grafula'),
(56, 'gsa-crawler'),
(57, 'harvest'),
(58, 'hloader'),
(59, 'hmview'),
(60, 'httplib'),
(61, 'httpresume'),
(62, 'httrack'),
(63, 'humanlinks'),
(64, 'igetter'),
(65, 'image stripper'),
(66, 'image sucker'),
(67, 'industry program'),
(68, 'indy library'),
(69, 'infonavirobot'),
(70, 'installshield digitalwizard'),
(71, 'interget'),
(72, 'iria'),
(73, 'irvine'),
(74, 'iupui research bot'),
(75, 'jbh agent'),
(76, 'jennybot'),
(77, 'jetcar'),
(78, 'jobo'),
(79, 'joc'),
(80, 'kapere'),
(81, 'kenjin spider'),
(82, 'keyword density'),
(83, 'larbin'),
(84, 'leechftp'),
(85, 'leechget'),
(86, 'lexibot'),
(87, 'libweb/clshttp'),
(88, 'libwww-perl'),
(89, 'lightningdownload'),
(90, 'lincoln state web browser'),
(91, 'linkextractorpro'),
(92, 'linkscan/8.1a.unix'),
(93, 'linkwalker'),
(94, 'lwp-trivial'),
(95, 'lwp::simple'),
(96, 'mac finder'),
(97, 'mata hari'),
(98, 'mediasearch'),
(99, 'metaproducts'),
(100, 'microsoft url control'),
(101, 'midown tool'),
(102, 'miixpc'),
(103, 'missauga locate'),
(104, 'missouri college browse'),
(105, 'mister pix'),
(106, 'moget'),
(107, 'mozilla.*newt'),
(108, 'mozilla/3.0 (compatible)'),
(109, 'mozilla/3.mozilla/2.01'),
(110, 'msie 4.0 (win95)'),
(111, 'multiblocker browser'),
(112, 'mydaemon'),
(113, 'mygetright'),
(114, 'nabot'),
(115, 'navroad'),
(116, 'nearsite'),
(117, 'net vampire'),
(118, 'netants'),
(119, 'netmechanic'),
(120, 'netpumper'),
(121, 'netspider'),
(122, 'newsearchengine'),
(123, 'nicerspro'),
(124, 'ninja'),
(125, 'nitro downloader'),
(126, 'npbot'),
(127, 'octopus'),
(128, 'offline explorer'),
(129, 'offline navigator'),
(130, 'openfind'),
(131, 'pagegrabber'),
(132, 'papa foto'),
(133, 'pavuk'),
(134, 'pbrowse'),
(135, 'pcbrowser'),
(136, 'peval'),
(137, 'pompos/'),
(138, 'program shareware'),
(139, 'propowerbot'),
(140, 'prowebwalker'),
(141, 'psurf'),
(142, 'puf'),
(143, 'puxarapido'),
(144, 'queryn metasearch'),
(145, 'realdownload'),
(146, 'reget'),
(147, 'repomonkey'),
(148, 'rsurf'),
(149, 'rumours-agent'),
(150, 'sakura'),
(151, 'scan4mail'),
(152, 'semanticdiscovery'),
(153, 'sitesnagger'),
(154, 'slysearch'),
(155, 'spankbot'),
(156, 'spanner '),
(157, 'spiderzilla'),
(158, 'sq webscanner'),
(159, 'stamina'),
(160, 'star downloader'),
(161, 'steeler'),
(162, 'strip'),
(163, 'superbot'),
(164, 'superhttp'),
(165, 'surfbot'),
(166, 'suzuran'),
(167, 'swbot'),
(168, 'szukacz'),
(169, 'takeout'),
(170, 'teleport'),
(171, 'telesoft'),
(172, 'test spider'),
(173, 'the intraformant'),
(174, 'thenomad'),
(175, 'tighttwatbot'),
(176, 'titan'),
(177, 'tocrawl/urldispatcher'),
(178, 'true_robot'),
(179, 'tsurf'),
(180, 'turing machine'),
(181, 'turingos'),
(182, 'urlblaze'),
(183, 'urlgetfile'),
(184, 'urly warning'),
(185, 'utilmind'),
(186, 'vci'),
(187, 'voideye'),
(188, 'web image collector'),
(189, 'web sucker'),
(190, 'webauto'),
(191, 'webbandit'),
(192, 'webcapture'),
(193, 'webcollage'),
(194, 'webcopier'),
(195, 'webenhancer'),
(196, 'webfetch'),
(197, 'webgo'),
(198, 'webleacher'),
(199, 'webmasterworldforumbot'),
(200, 'webql'),
(201, 'webreaper'),
(202, 'website extractor'),
(203, 'website quester'),
(204, 'webster'),
(205, 'webstripper'),
(206, 'webwhacker'),
(207, 'wep search'),
(208, 'wget'),
(209, 'whizbang'),
(210, 'widow'),
(211, 'wildsoft surfer'),
(212, 'www-collector-e'),
(213, 'www.netwu.com'),
(214, 'wwwoffle'),
(215, 'xaldon'),
(216, 'xenu'),
(217, 'zeus'),
(218, 'ziggy'),
(219, 'zippy');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_protected_ranges`
--

CREATE TABLE `nuke_nsnst_protected_ranges` (
  `ip_lo` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ip_hi` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `date` int(20) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `c2c` char(2) NOT NULL DEFAULT '00',
  KEY `code` (`ip_lo`,`ip_hi`,`c2c`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_referers`
--

CREATE TABLE `nuke_nsnst_referers` (
  `rid` int(2) NOT NULL AUTO_INCREMENT,
  `referer` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`referer`),
  KEY `rid` (`rid`)
) ENGINE=MyISAM AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_nsnst_referers`
--

INSERT INTO `nuke_nsnst_referers` (`rid`, `referer`) VALUES
(1, '121hr.com'),
(2, '1st-call.net'),
(3, '1stcool.com'),
(4, '5000n.com'),
(5, '69-xxx.com'),
(6, '9irl.com'),
(7, '9uy.com'),
(8, 'a-day-at-the-party.com'),
(9, 'accessthepeace.com'),
(10, 'adult-model-nude-pictures.com'),
(11, 'adult-sex-toys-free-porn.com'),
(12, 'agnitum.com'),
(13, 'alfonssackpfeiffe.com'),
(14, 'alongwayfrommars.com'),
(15, 'anime-sex-1.com'),
(16, 'anorex-sf-stimulant-free.com'),
(17, 'antibot.net'),
(18, 'antique-tokiwa.com'),
(19, 'apotheke-heute.com'),
(20, 'armada31.com'),
(21, 'artark.com'),
(22, 'artlilei.com'),
(23, 'ascendbtg.com'),
(24, 'aschalaecheck.com'),
(25, 'asian-sex-free-sex.com'),
(26, 'aslowspeeker.com'),
(27, 'assasinatedfrogs.com'),
(28, 'athirst-for-tranquillity.net'),
(29, 'aubonpanier.com'),
(30, 'avalonumc.com'),
(31, 'ayingba.com'),
(32, 'bayofnoreturn.com'),
(33, 'bbw4phonesex.com'),
(34, 'beersarenotfree.com'),
(35, 'bierikiuetsch.com'),
(36, 'bilingualannouncements.com'),
(37, 'black-pussy-toon-clip-anal-lover-single.com'),
(38, 'blownapart.com'),
(39, 'blueroutes.com'),
(40, 'boasex.com'),
(41, 'booksandpages.com'),
(42, 'bootyquake.com'),
(43, 'bossyhunter.com'),
(44, 'boyz-sex.com'),
(45, 'brokersaandpokers.com'),
(46, 'browserwindowcleaner.com'),
(47, 'budobytes.com'),
(48, 'business2fun.com'),
(49, 'buymyshitz.com'),
(50, 'byuntaesex.com'),
(51, 'caniputsomeloveintoyou.com'),
(52, 'cartoons.net.ru'),
(53, 'caverunsailing.com'),
(54, 'certainhealth.com'),
(55, 'clantea.com'),
(56, 'close-protection-services.com'),
(57, 'clubcanino.com'),
(58, 'clubstic.com'),
(59, 'cobrakai-skf.com'),
(60, 'collegefucktour.co.uk'),
(61, 'commanderspank.com'),
(62, 'coolenabled.com'),
(63, 'crusecountryart.com'),
(64, 'crusingforsex.co.uk'),
(65, 'cunt-twat-pussy-juice-clit-licking.com'),
(66, 'customerhandshaker.com'),
(67, 'cyborgrama.com'),
(68, 'darkprofits.co.uk'),
(69, 'datingforme.co.uk'),
(70, 'datingmind.com'),
(71, 'degree.org.ru'),
(72, 'delorentos.com'),
(73, 'diggydigger.com'),
(74, 'dinkydonkyaussie.com'),
(75, 'djpritchard.com'),
(76, 'djtop.com'),
(77, 'draufgeschissen.com'),
(78, 'dreamerteens.co.uk'),
(79, 'ebonyarchives.co.uk'),
(80, 'ebonyplaya.co.uk'),
(81, 'ecobuilder2000.com'),
(82, 'emailandemail.com'),
(83, 'emedici.net'),
(84, 'engine-on-fire.com'),
(85, 'erocity.co.uk'),
(86, 'esport3.com'),
(87, 'eteenbabes.com'),
(88, 'eurofreepages.com'),
(89, 'eurotexans.com'),
(90, 'evolucionweb.com'),
(91, 'fakoli.com'),
(92, 'fe4ba.com'),
(93, 'ferienschweden.com'),
(94, 'findly.com'),
(95, 'firsttimeteadrinker.com'),
(96, 'fishing.net.ru'),
(97, 'flatwonkers.com'),
(98, 'flowershopentertainment.com'),
(99, 'flymario.com'),
(100, 'free-xxx-pictures-porno-gallery.com'),
(101, 'freebestporn.com'),
(102, 'freefuckingmovies.co.uk'),
(103, 'freexxxstuff.co.uk'),
(104, 'fruitologist.net'),
(105, 'fruitsandbolts.com'),
(106, 'fudge-cumshots-free-midget-movie-clips.com'),
(107, 'fudge-michaelmoore.com'),
(108, 'fundacep.com'),
(109, 'gadless.com'),
(110, 'gallapagosrangers.com'),
(111, 'galleries4free.co.uk'),
(112, 'galofu.com'),
(113, 'gaypixpost.co.uk'),
(114, 'geomasti.com'),
(115, 'girltime.co.uk'),
(116, 'glassrope.com'),
(117, 'godjustblessyouall.com'),
(118, 'goldenageresort.com'),
(119, 'gonnabedaddies.com'),
(120, 'granadasexi.com'),
(121, 'guardingtheangels.com'),
(122, 'guyprofiles.co.uk'),
(123, 'happy1225.com'),
(124, 'happychappywacky.com'),
(125, 'health.org.ru'),
(126, 'hexplas.com'),
(127, 'highheelsmodels4fun.com'),
(128, 'hillsweb.com'),
(129, 'hiptuner.com'),
(130, 'historyintospace.com'),
(131, 'hoa-tuoi.com'),
(132, 'homebuyinginatlanta.com'),
(133, 'horizonultra.com'),
(134, 'horseminiature.net'),
(135, 'hotkiss.co.uk'),
(136, 'hotlivegirls.co.uk'),
(137, 'hotmatchup.co.uk'),
(138, 'husler.co.uk'),
(139, 'iaentertainment.com'),
(140, 'iamnotsomeone.com'),
(141, 'iconsofcorruption.com'),
(142, 'ihavenotrustinyou.com'),
(143, 'informat-systems.com'),
(144, 'interiorproshop.com'),
(145, 'intersoftnetworks.com'),
(146, 'inthecrib.com'),
(147, 'investment4cashiers.com'),
(148, 'iti-trailers.com'),
(149, 'jackpot-hacker.com'),
(150, 'jacks-world.com'),
(151, 'jamesthesailorbasher.com'),
(152, 'jesuislemonds.com'),
(153, 'justanotherdomainname.com'),
(154, 'kampelicka.com'),
(155, 'kanalrattenarsch.com'),
(156, 'katzasher.com'),
(157, 'kerosinjunkie.com'),
(158, 'killasvideo.com'),
(159, 'koenigspisser.com'),
(160, 'kontorpara.com'),
(161, 'l8t.com'),
(162, 'laestacion101.com'),
(163, 'lambuschlamppen.com'),
(164, 'lankasex.co.uk'),
(165, 'laser-creations.com'),
(166, 'le-tour-du-monde.com'),
(167, 'lecraft.com'),
(168, 'ledo-design.com'),
(169, 'leftregistration.com'),
(170, 'lekkikoomastas.com'),
(171, 'lepommeau.com'),
(172, 'libr-animal.com'),
(173, 'libraries.org.ru'),
(174, 'likewaterlikewind.com'),
(175, 'limbojumpers.com'),
(176, 'link.ru'),
(177, 'lockportlinks.com'),
(178, 'loiproject.com'),
(179, 'longtermalternatives.com'),
(180, 'lottoeco.com'),
(181, 'lucalozzi.com'),
(182, 'maki-e-pens.com'),
(183, 'malepayperview.co.uk'),
(184, 'mangaxoxo.com'),
(185, 'maps.org.ru'),
(186, 'marcofields.com'),
(187, 'masterofcheese.com'),
(188, 'masteroftheblasterhill.com'),
(189, 'mastheadwankers.com'),
(190, 'megafrontier.com'),
(191, 'meinschuppen.com'),
(192, 'mercurybar.com'),
(193, 'metapannas.com'),
(194, 'micelebre.com'),
(195, 'midnightlaundries.com'),
(196, 'mikeapartment.co.uk'),
(197, 'millenniumchorus.com'),
(198, 'mimundial2002.com'),
(199, 'miniaturegallerymm.com'),
(200, 'mixtaperadio.com'),
(201, 'mondialcoral.com'),
(202, 'monja-wakamatsu.com'),
(203, 'monstermonkey.net'),
(204, 'mouthfreshners.com'),
(205, 'mullensholiday.com'),
(206, 'musilo.com'),
(207, 'myhollowlog.com'),
(208, 'myhomephonenumber.com'),
(209, 'mykeyboardisbroken.com'),
(210, 'mysofia.net'),
(211, 'naked-cheaters.com'),
(212, 'naked-old-women.com'),
(213, 'nastygirls.co.uk'),
(214, 'nationclan.net'),
(215, 'natterratter.com'),
(216, 'naughtyadam.com'),
(217, 'nestbeschmutzer.com'),
(218, 'netwu.com'),
(219, 'newrealeaseonline.com'),
(220, 'newrealeasesonline.com'),
(221, 'nextfrontiersonline.com'),
(222, 'nikostaxi.com'),
(223, 'notorious7.com'),
(224, 'nrecruiter.com'),
(225, 'nursingdepot.com'),
(226, 'nustramosse.com'),
(227, 'nuturalhicks.com'),
(228, 'occaz-auto49.com'),
(229, 'ocean-db.net'),
(230, 'oilburnerservice.net'),
(231, 'omburo.com'),
(232, 'oneoz.com'),
(233, 'onepageahead.net'),
(234, 'onlinewithaline.com'),
(235, 'organizate.net'),
(236, 'ourownweddingsong.com'),
(237, 'owen-music.com'),
(238, 'p-partners.com'),
(239, 'paginadeautor.com'),
(240, 'pakistandutyfree.com'),
(241, 'pamanderson.co.uk'),
(242, 'parentsense.net'),
(243, 'particlewave.net'),
(244, 'pay-clic.com'),
(245, 'pay4link.net'),
(246, 'pcisp.com'),
(247, 'persist-pharma.com'),
(248, 'peteband.com'),
(249, 'petplusindia.com'),
(250, 'pickabbw.co.uk'),
(251, 'picture-oral-position-lesbian.com'),
(252, 'pl8again.com'),
(253, 'planeting.net'),
(254, 'popusky.com'),
(255, 'porn-expert.com'),
(256, 'promoblitza.com'),
(257, 'proproducts-usa.com'),
(258, 'ptcgzone.com'),
(259, 'ptporn.com'),
(260, 'publishmybong.com'),
(261, 'puttingtogether.com'),
(262, 'qualifiedcancelations.com'),
(263, 'rahost.com'),
(264, 'rainbow21.com'),
(265, 'rakkashakka.com'),
(266, 'randomfeeding.com'),
(267, 'rape-art.com'),
(268, 'rd-brains.com'),
(269, 'realestateonthehill.net'),
(270, 'rebuscadobot'),
(271, 'requested-stuff.com'),
(272, 'retrotrasher.com'),
(273, 'ricopositive.com'),
(274, 'risorseinrete.com'),
(275, 'rotatingcunts.com'),
(276, 'runawayclicks.com'),
(277, 'rutalibre.com'),
(278, 's-marche.com'),
(279, 'sabrosojazz.com'),
(280, 'samuraidojo.com'),
(281, 'sanaldarbe.com'),
(282, 'sasseminars.com'),
(283, 'schlampenbruzzler.com'),
(284, 'searchmybong.com'),
(285, 'seckur.com'),
(286, 'sex-asian-porn-interracial-photo.com'),
(287, 'sex-porn-fudge-hardcore-movie.com'),
(288, 'sexa3.net'),
(289, 'sexer.com'),
(290, 'sexintention.com'),
(291, 'sexnet24.tv'),
(292, 'sexomundo.com'),
(293, 'sharks.com.ru'),
(294, 'shells.com.ru'),
(295, 'shop-ecosafe.com'),
(296, 'shop-toon-hardcore-fudge-cum-pics.com'),
(297, 'silverfussions.com'),
(298, 'sin-city-sex.net'),
(299, 'sluisvan.com'),
(300, 'smutshots.com'),
(301, 'snagglersmaggler.com'),
(302, 'somethingtoforgetit.com'),
(303, 'sophiesplace.net'),
(304, 'soursushi.com'),
(305, 'southernxstables.com'),
(306, 'speed467.com'),
(307, 'speedpal4you.com'),
(308, 'sporty.org.ru'),
(309, 'stopdriving.net'),
(310, 'stw.org.ru'),
(311, 'sufficientlife.com'),
(312, 'sussexboats.net'),
(313, 'swinger-party-free-dating-porn-sluts.com'),
(314, 'sydneyhay.com'),
(315, 'szmjht.com'),
(316, 'teninchtrout.com'),
(317, 'thebalancedfruits.com'),
(318, 'theendofthesummit.com'),
(319, 'thiswillbeit.com'),
(320, 'thosethosethose.com'),
(321, 'ticyclesofindia.com'),
(322, 'tits-gay-fagot-black-tits-bigtits-amateur.com'),
(323, 'tonius.com'),
(324, 'toohsoft.com'),
(325, 'toolvalley.com'),
(326, 'tooporno.net'),
(327, 'toosexual.com'),
(328, 'torngat.com'),
(329, 'tour.org.ru'),
(330, 'towneluxury.com'),
(331, 'trafficmogger.com'),
(332, 'triacoach.net'),
(333, 'trottinbob.com'),
(334, 'tttframes.com'),
(335, 'tvjukebox.net'),
(336, 'undercvr.com'),
(337, 'unfinished-desires.com'),
(338, 'unicornonero.com'),
(339, 'unionvillefire.com'),
(340, 'upsandowns.com'),
(341, 'upthehillanddown.com'),
(342, 'vallartavideo.com'),
(343, 'vietnamdatingservices.com'),
(344, 'vinegarlemonshots.com'),
(345, 'vizy.net.ru'),
(346, 'vnladiesdatingservices.com'),
(347, 'vomitandbusted.com'),
(348, 'walkingthewalking.com'),
(349, 'well-I-am-the-type-of-boy.com'),
(350, 'whales.com.ru'),
(351, 'whincer.net'),
(352, 'whitpagesrippers.com'),
(353, 'whois.sc'),
(354, 'wipperrippers.com'),
(355, 'wordfilebooklets.com'),
(356, 'world-sexs.com'),
(357, 'xsay.com'),
(358, 'xxxchyangel.com'),
(359, 'xxxx:'),
(360, 'xxxzips.com'),
(361, 'youarelostintransit.com'),
(362, 'yuppieslovestocks.com'),
(363, 'yuzhouhuagong.com'),
(364, 'zhaori-food.com'),
(365, 'zwiebelbacke.com');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_strings`
--

CREATE TABLE `nuke_nsnst_strings` (
  `string` varchar(60) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_nsnst_tracked_ips`
--

CREATE TABLE `nuke_nsnst_tracked_ips` (
  `tid` int(10) NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(15) NOT NULL DEFAULT '',
  `ip_long` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '1',
  `username` varchar(60) NOT NULL DEFAULT '',
  `user_agent` text NOT NULL,
  `refered_from` text NOT NULL,
  `date` int(20) NOT NULL DEFAULT '0',
  `page` text NOT NULL,
  `x_forward_for` varchar(32) NOT NULL DEFAULT '',
  `client_ip` varchar(32) NOT NULL DEFAULT '',
  `remote_addr` varchar(32) NOT NULL DEFAULT '',
  `remote_port` varchar(11) NOT NULL DEFAULT '',
  `request_method` varchar(10) NOT NULL DEFAULT '',
  `c2c` char(2) NOT NULL DEFAULT '00',
  PRIMARY KEY (`tid`),
  KEY `maintracking` (`ip_addr`,`ip_long`),
  KEY `ip_addr` (`ip_addr`),
  KEY `ip_long` (`ip_long`),
  KEY `user_id` (`user_id`),
  KEY `username` (`username`),
  KEY `user_agent` (`user_agent`(255)),
  KEY `refered_from` (`refered_from`(255)),
  KEY `date` (`date`),
  KEY `page` (`page`(255)),
  KEY `c2c` (`c2c`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_pages`
--

CREATE TABLE `nuke_pages` (
  `pid` int(10) NOT NULL AUTO_INCREMENT,
  `cid` int(10) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `subtitle` varchar(255) NOT NULL DEFAULT '',
  `active` int(1) NOT NULL DEFAULT '0',
  `page_header` text NOT NULL,
  `text` text NOT NULL,
  `page_footer` text NOT NULL,
  `signature` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `counter` int(10) NOT NULL DEFAULT '0',
  `clanguage` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`pid`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_pages_categories`
--

CREATE TABLE `nuke_pages_categories` (
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_pollcomments`
--

CREATE TABLE `nuke_pollcomments` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0',
  `pollID` int(11) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `name` varchar(60) NOT NULL DEFAULT '',
  `email` varchar(60) DEFAULT NULL,
  `url` varchar(60) DEFAULT NULL,
  `host_name` varchar(60) DEFAULT NULL,
  `subject` varchar(60) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  `score` tinyint(4) NOT NULL DEFAULT '0',
  `reason` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `pid` (`pid`),
  KEY `pollID` (`pollID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_poll_check`
--
CREATE TABLE `nuke_poll_check` (
  `ip` varchar(20) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `pollID` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_poll_data`
--

CREATE TABLE `nuke_poll_data` (
  `pollID` int(11) NOT NULL DEFAULT '0',
  `optionText` char(50) NOT NULL DEFAULT '',
  `optionCount` int(11) NOT NULL DEFAULT '0',
  `voteID` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_poll_data`
--

INSERT INTO `nuke_poll_data` (`pollID`, `optionText`, `optionCount`, `voteID`) VALUES
(1, 'Ummmm, not bad', 0, 1),
(1, 'Cool', 0, 2),
(1, 'Terrific', 0, 3),
(1, 'The best one!', 0, 4),
(1, 'what the hell is this?', 0, 5),
(1, '', 0, 6),
(1, '', 0, 7),
(1, '', 0, 8),
(1, '', 0, 9),
(1, '', 0, 10),
(1, '', 0, 11),
(1, '', 0, 12);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_poll_desc`
--

CREATE TABLE `nuke_poll_desc` (
  `pollID` int(11) NOT NULL AUTO_INCREMENT,
  `pollTitle` varchar(100) NOT NULL DEFAULT '',
  `timeStamp` int(11) NOT NULL DEFAULT '0',
  `voters` mediumint(9) NOT NULL DEFAULT '0',
  `planguage` varchar(30) NOT NULL DEFAULT '',
  `artid` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pollID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_poll_desc`
--

INSERT INTO `nuke_poll_desc` (`pollID`, `pollTitle`, `timeStamp`, `voters`, `planguage`, `artid`) VALUES
(1, 'What do you think about this site?', 961405160, 0, 'english', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_queue`
--

CREATE TABLE `nuke_queue` (
  `qid` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL DEFAULT '0',
  `uname` varchar(40) NOT NULL DEFAULT '',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `story` text,
  `storyext` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT '2018-12-12 00:00:00',
  `topic` varchar(20) NOT NULL DEFAULT '',
  `alanguage` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`qid`),
  KEY `uid` (`uid`),
  KEY `uname` (`uname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_quotes`
--

CREATE TABLE `nuke_quotes` (
  `qid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `quote` text,
  PRIMARY KEY (`qid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_quotes`
--

INSERT INTO `nuke_quotes` (`qid`, `quote`) VALUES
(1, 'Nos morituri te salutamus - CBHS');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_referer`
--

CREATE TABLE `nuke_referer` (
  `url` varchar(100) NOT NULL,
  `lasttime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `link` varchar(100) NOT NULL,
  PRIMARY KEY (`url`),
  KEY `lasttime` (`lasttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_related`
--

CREATE TABLE `nuke_related` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`rid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_security_agents`
--

CREATE TABLE `nuke_security_agents` (
  `agent_name` varchar(20) NOT NULL DEFAULT '',
  `agent_fullname` varchar(30) DEFAULT '',
  `agent_hostname` varchar(30) DEFAULT '',
  `agent_url` varchar(80) DEFAULT '',
  `agent_ban` int(1) NOT NULL DEFAULT '0',
  `agent_desc` text,
  PRIMARY KEY (`agent_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_security_agents`
--

INSERT INTO `nuke_security_agents` (`agent_name`, `agent_fullname`, `agent_hostname`, `agent_url`, `agent_ban`, `agent_desc`) VALUES
('1Noon', '1Noonbot', NULL, '1nooncorp.com', -1, 'Doesn\'t follow robots.txt'),
('AI', 'AIBOT', NULL, '21seek.com', 0, '(China) robot (218.17.90.xxx)'),
('aip', 'aipbot/', NULL, 'nameprotect.com', 0, 'copyright search robot (24.177.134.x), s. also\r\n- np/0.1_(np;_http://www.nameprotect.com...\r\n- abot/0.1 (abot; http://www.abot.com...'),
('Alexa', 'ia_archiver', '.alexa.com', 'alexa.com', 0, 'Alexa (209.237.238.1xx)'),
('Archive', 'ia_archiver', '.archive.org', 'archive.org', 0, 'The Internet Archive (209.237.238.1xx)'),
('AltaVista', 'Scooter', NULL, 'altavista.com', 0, NULL),
('Amfibi', 'Amfibibot', NULL, 'amfibi.com', 0, NULL),
('Ansearch', 'AnsearchBot/', NULL, 'ansearch.com.au', 0, NULL),
('AnswerBus', 'AnswerBus', NULL, 'answerbus.com', 0, NULL),
('Argus', 'Argus/', NULL, 'simpy.com/bot.html', 0, NULL),
('Arachmo', 'Arachmo', NULL, NULL, -1, 'Impolite bandwidth sucker. Netblock owned by SOFTBANK BB CORP, Japan.\r\nDoesn\'t follow robots.txt'),
('Ask Jeeves', 'Ask Jeeves/Teoma', '.ask.com', 'sp.ask.com/docs/about/tech_crawling.html', 0, NULL),
('ASPseek', 'ASPseek/', NULL, 'aspseek.org', 0, 'search engine software'),
('AvantGo', 'AvantGo', 'avantgo.com', 'avantgo.com', 0, NULL),
('Axadine', 'Axadine Crawler', NULL, 'axada.de', 0, NULL),
('Baidu', 'Baiduspider', NULL, 'baidu.com/search/spider.htm', 0, NULL),
('Become', 'BecomeBot', NULL, NULL, 0, NULL),
('BigClique', 'BigCliqueBOT', NULL, 'bigclique.com', 0, NULL),
('BilderSauger', 'BilderSauger', NULL, 'google.com/search?q=BilderSauger+data+becker', -1, NULL),
('BitTorrent', 'btbot/', NULL, 'btbot.com/btbot.html', 0, NULL),
('Bruin', 'BruinBot', NULL, 'webarchive.cs.ucla.edu/bruinbot.html', 0, NULL),
('cfetch', 'cfetch/', NULL, NULL, 0, NULL),
('Cipinet', 'Cipinet', NULL, 'cipinet.com/bot.html', 0, NULL),
('Combine', 'Combine/', NULL, 'lub.lu.se/combine/', -1, 'harvesting robot'),
('Convera', 'ConveraCrawler/', NULL, 'authoritativeweb.com/crawl', -1, 'Impolite robot. Netblock owned by Convera Corp, Vienna'),
('Cydral', 'CydralSpider', NULL, 'cydral.com', 0, 'Cydral Web Image Search'),
('curl', 'curl/', NULL, 'curl.haxx.se', 0, 'file transferring tool'),
('Datapark', 'DataparkSearch/', NULL, 'dataparksearch.org', 0, NULL),
('Demo', 'Demo Bot', NULL, NULL, -1, NULL),
('DHCrawler', 'DHCrawler', NULL, NULL, 0, NULL),
('Diamond', 'DiamondBot', NULL, 'searchscout.com', -1, 'Claria (ex Gator) robot (64.152.73.xx), s. also Claria'),
('DISCo', 'DISCo Pump', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Dragonfly CMS', 'Dragonfly File Reader', NULL, NULL, 0, NULL),
('Drecom', 'Drecombot/', 'drecom.jp', 'career.drecom.jp/bot.html', -1, 'Doesn\'t follow robots.txt'),
('Dumbfind', 'Dumbot', NULL, 'dumbfind.com/dumbot.html', 0, NULL),
('e-Society', 'e-SocietyRobot', NULL, 'yama.info.waseda.ac.jp/~yamana/es/', 0, NULL),
('EmailSiphon', 'EmailSiphon', NULL, NULL, -1, NULL),
('EmeraldShield', 'EmeraldShield.com WebBot', NULL, 'emeraldshield.com/webbot.aspx', 0, NULL),
('Educate', 'Educate Search', NULL, NULL, -1, NULL),
('Envolk', 'envolk[ITS]spider/', NULL, 'envolk.com/envolkspider.html', 0, NULL),
('Eruvo', 'EruvoBot', NULL, 'eruvo.com', 0, NULL),
('Esperanza', 'EsperanzaBot', NULL, 'esperanza.to/bot/', 0, NULL),
('eStyle', 'eStyleSearch', NULL, NULL, 0, NULL),
('Eurip', 'EuripBot', NULL, 'eurip.com', 0, NULL),
('Fast', 'FAST MetaWeb Crawler', NULL, NULL, 0, NULL),
('FAST Enterprise', 'FAST Enterprise Crawler', 'fastsearch.net', NULL, 0, NULL),
('Feedster', 'Feedster Crawler', NULL, NULL, 0, NULL),
('FetchAPI', 'Fetch API Request', NULL, NULL, -1, 'Some sort of application that tries to download and store your full website.\r\nDoesn\'t follow robots.txt'),
('fg', 'fgcrawler', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Filangy', 'Filangy', NULL, 'filangy.com/filangyinfo.jsp?inc=robots.jsp', 0, NULL),
('Findexa', 'Findexa Crawler', 'gulesider.no', 'findexa.no/gulesider/article26548.ece', 0, NULL),
('FindLinks', 'findlinks', NULL, 'wortschatz.uni-leipzig.de/findlinks/', 0, NULL),
('Franklin', 'Franklin locator', NULL, NULL, -1, NULL),
('FullWeb', 'Full Web Bot', NULL, NULL, -1, NULL),
('Fyber', 'FyberSpider', NULL, 'fybersearch.com/fyberspider.php', 0, NULL),
('Gais', 'Gaisbot', NULL, 'gais.cs.ccu.edu.tw/robot.php', 0, NULL),
('Genie', 'geniebot', NULL, 'genieknows.com', 0, NULL),
('GetRight', 'GetRight/', NULL, NULL, 0, NULL),
('Giga', 'Gigabot/', NULL, 'gigablast.com/spider.html', 0, NULL),
('Girafa', 'Girafabot', NULL, 'girafa.com', 0, NULL),
('GoForIt', 'GOFORITBOT', NULL, 'goforit.com/about/', 0, NULL),
('Gonzo', 'gonzo1', '.t-ipconnect.de', 'telekom.de', 0, NULL),
('Google', 'Googlebot', 'crawl[0-9\\-]+.googlebot.com', 'google.com/bot.html', 0, NULL),
('GoogleAds', 'Mediapartners-Google', NULL, NULL, 0, NULL),
('GoogleImg', 'Googlebot-Image', NULL, NULL, 0, NULL),
('GPU', 'GPU p2p crawler', NULL, 'gpu.sourceforge.net/search_engine.php', 0, NULL),
('Grub', 'grub-client', NULL, 'grub.org', 0, NULL),
('GSA', 'gsa-crawler', NULL, 'arsenaldigital.com', 0, NULL),
('HappyFun', 'HappyFunBot/', NULL, 'happyfunsearch.com/bot.html', 0, NULL),
('Harvest', 'Harvest/', NULL, NULL, 0, NULL),
('HeadScan', 'head-scan.pl/', NULL, NULL, -1, NULL),
('Heritrix', 'heritrix/', NULL, 'crawler.xtramind.com', 0, NULL),
('HooWWWer', 'HooWWWer', NULL, 'cosco.hiit.fi/search/hoowwwer/', 0, NULL),
('htdig', 'htdig/', NULL, NULL, -1, NULL),
('HTMLParser', 'HTMLParser/', NULL, 'htmlparser.sourceforge.net', -1, 'Doesn\'t follow robots.txt'),
('HTTrack', 'HTTrack', NULL, NULL, 0, NULL),
('Ichiro', 'ichiro/', NULL, 'nttr.co.jp', 0, NULL),
('IconSurf', 'IconSurf/', NULL, 'iconsurf.com/robot.html', 0, NULL),
('Industry', 'Industry Program', NULL, NULL, -1, NULL),
('Indy', 'Indy Library', NULL, NULL, -1, 'Originally, the Indy Library is a programming library which is available at http://www.nevrona.com/Indy or http://indy.torry.net under an Open Source license. This library is included with Borland Delphi 6, 7, C++Builder 6, plus all of the Kylix versions. Unfortunately, this library is hi-jacked and abused by some Chinese spam bots. All recent user-agents with the unmodified \"Indy Library\" string were of Chinese origin.\r\nDoesn\'t follow robots.txt'),
('InetURL', 'InetURL/', NULL, NULL, 0, NULL),
('Infocious', 'InfociousBot', NULL, 'corp.infocious.com/tech_crawler.php', 0, NULL),
('Ingrid', 'INGRID', NULL, 'webmaster.ilse.nl/jsp/webmaster.jsp', 0, NULL),
('Interseek', 'InterseekWeb/', NULL, NULL, 0, NULL),
('Ipwalk', 'IpwalkBot/', NULL, NULL, 0, NULL),
('IRL', 'IRLbot', NULL, 'irl.cs.tamu.edu/crawler', 0, NULL),
('Java', 'Java/', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Jyxo', 'Jyxobot/', NULL, NULL, 0, NULL),
('KnowItAll', 'KnowItAll(', NULL, 'cs.washington.edu', 0, NULL),
('Kumm', 'KummHttp/', NULL, NULL, 0, NULL),
('Lapozz', 'LapozzBot', NULL, 'robot.lapozz.hu/', 0, NULL),
('Larbin', 'larbin', NULL, 'larbin.sourceforge.net/index-eng.html', 0, NULL),
('LeechGet', 'LeechGet', NULL, 'leechget.net', 0, NULL),
('libwww-perl', 'libwww-perl/', NULL, NULL, 0, NULL),
('lmspider', 'lmspider', NULL, 'scansoft.com', 0, NULL),
('Local', 'LocalcomBot/', NULL, 'local.com/bot.htm', 0, NULL),
('Looksmart', 'ZyBorg/', '.looksmart.com', 'WISEnutbot.com', 0, NULL),
('LoveSMS', 'LoveSMS Search Engine', NULL, 'cauta.lovesms.ro', 0, NULL),
('Lycos', 'Lycos_Spider', '.lycos.com', NULL, 0, NULL),
('Mac Finder', 'Mac Finder', NULL, NULL, 0, NULL),
('Majestic-12', 'MJ12bot', NULL, 'majestic12.co.uk/bot.php', 0, NULL),
('MapoftheInternet', 'MapoftheInternet.com', NULL, 'mapoftheinternet.com', 0, NULL),
('McBot', 'McBot/', NULL, NULL, 0, NULL),
('Medusa', 'Medusa', NULL, NULL, -1, 'Medusa is a tool for finding images, movie-clips or other kinds of files on webpages and downloading them. You start by entering a starting URL and Medusa searches for the filetypes you are interested in on this page and all pages found up to a given depth.\r\nDoesn\'t follow robots.txt'),
('Metaspinner', 'Metaspinner/', NULL, 'meta-spinner.de', 0, NULL),
('MetaTag', 'MetaTagRobot', NULL, 'widexl.com/remote/search-engines/metatag-analyzer.html', 0, NULL),
('Minuteman', 'Minuteman', NULL, NULL, 0, NULL),
('Mirago', 'HenryTheMiragoRobot', NULL, 'miragorobot.com/scripts/mrinfo.asp', 0, NULL),
('Missauga', 'Missauga Locate', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Missigua', 'Missigua Locator', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Mister PiX', 'Mister PiX', NULL, NULL, 0, NULL),
('Mojeek', 'MojeekBot', NULL, 'mojeek.com/bot.html', 0, NULL),
('MSCCDS', 'Microsoft Scheduled Cache Cont', NULL, 'google.com/search?q=Scheduled+Cache+Content+Download+Service', -1, NULL),
('MDAIPP', 'Microsoft Data Access Internet', NULL, 'google.com/search?q=Microsoft+Data+Access+Internet+Publishin', -1, 'This agent is used to exploit your system regarding the following security issue in FrontPage2000: http://lists.grok.org.uk/pipermail/full-disclosure/2004-December/030467.html'),
('MSIECrawler', 'MSIECrawler', NULL, NULL, -1, NULL),
('MSN', 'msnbot', 'msnbot.msn.com', 'search.msn.com/msnbot.htm', 0, NULL),
('MSR', 'MSRBOT/', NULL, NULL, 0, NULL),
('MUC', 'Microsoft URL Control', NULL, NULL, 0, NULL),
('Naver', 'NaverBot', NULL, NULL, 0, NULL),
('NetMechanic', 'NetMechanic', NULL, NULL, 0, NULL),
('nicebot', 'nicebot', NULL, NULL, -1, NULL),
('Ninja', 'Download Ninja', NULL, NULL, 0, NULL),
('Noxtrum', 'noxtrumbot', NULL, 'noxtrum.com', 0, NULL),
('NRS', 'NetResearchServer', NULL, 'loopimprovements.com/robot.html', 0, NULL),
('Nutch', 'Nutch', NULL, 'nutch.org/docs/en/bot.html', 0, NULL),
('NutchCVS', 'NutchCVS/', NULL, 'lucene.apache.org/nutch/bot.html', 0, NULL),
('Nutscrape', 'Nutscrape/', NULL, NULL, 0, NULL),
('oegp', 'oegp', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Offline Explorer', 'Offline Explorer/', NULL, 'metaproducts.com', 0, 'A Windows offline browser that allows you to download an unlimited number of your favorite Web and FTP sites for later offline viewing, editing or browsing.'),
('OmniExplorer', 'OmniExplorer_Bot/', NULL, 'omni-explorer.com', -1, 'Doesn\'t follow robots.txt'),
('Onet', 'OnetSzukaj/', NULL, 'szukaj.onet.pl', 0, NULL),
('Openfind', 'Openbot/', NULL, 'openfind.com.tw/robot.html', 0, NULL),
('Orbit', 'Orbiter', NULL, 'dailyorbit.com/bot.htm', 0, NULL),
('P3P Validator', 'P3P Validator', NULL, NULL, 0, NULL),
('Patsearch', 'Patwebbot', NULL, 'herz-power.de/technik.html', 0, NULL),
('PhpDig', 'PhpDig/', NULL, 'phpdig.net/robot.php', 0, NULL),
('PicSearch', 'psbot/', NULL, 'picsearch.com/bot.html', 0, NULL),
('Pipeline', 'pipeLiner', NULL, 'pipeline-search.com/webmaster.html', 0, NULL),
('Pogodak', 'Pogodak', NULL, NULL, 0, NULL),
('Poly', 'polybot', NULL, 'cis.poly.edu/polybot/', 0, NULL),
('Pompos', 'Pompos/', NULL, 'dir.com/pompos.html', 0, NULL),
('Poodle', 'Poodle predictor', NULL, NULL, 0, NULL),
('Powermarks', 'Powermarks/', NULL, 'kaylon.com/power.html', 0, NULL),
('PrivacyFinder', 'PrivacyFinder Cache Bot', NULL, NULL, 0, NULL),
('Privatizer', 'privatizer.net', NULL, 'privatizer.net/whatis.php', 0, NULL),
('Production', 'Production Bot', NULL, NULL, 0, NULL),
('PS', 'Program Shareware', NULL, NULL, 0, NULL),
('PuxaRapido', 'PuxaRapido v1.0', NULL, NULL, 0, NULL),
('Python-urllib', 'Python-urllib/', NULL, NULL, 0, NULL),
('Qweery', 'qweery', NULL, NULL, 0, NULL),
('Rambler', 'StackRambler/', NULL, 'rambler.ru', 0, NULL),
('Roffle', 'Roffle/', NULL, NULL, -1, NULL),
('RPT-HTTP', 'RPT-HTTPClient/', NULL, NULL, -1, NULL),
('rssImages', 'rssImagesBot', NULL, 'herbert.groot.jebbink.nl/?app=rssImages', 0, NULL),
('Ryan', 'Ryanbot/', NULL, NULL, 0, NULL),
('SBIder', 'SBIder/', NULL, 'sitesell.com/sbider.html', 0, NULL),
('schibstedsok', 'schibstedsokbot', NULL, 'schibstedsok.no', 0, NULL),
('Schmozilla', 'Schmozilla/', NULL, NULL, -1, 'Doesn\'t follow robots.txt'),
('Scrubby', 'Scrubby', NULL, 'scrubtheweb.com/abs/meta-check.html', 0, NULL),
('ScSpider', 'ScSpider/', NULL, NULL, 0, NULL),
('SearchGuild', 'SearchGuild/', NULL, NULL, 0, 'DMOZ Experiment'),
('Seekbot', 'Seekbot', NULL, 'seekbot.net', 0, NULL),
('Seznam', 'SeznamBot/', NULL, 'fulltext.seznam.cz', 0, NULL),
('Siets', 'SietsCrawler/', NULL, NULL, 0, NULL),
('SitiDi', '/SitiDiBot/', NULL, 'SitiDi.net', 0, NULL),
('Snoopy', 'Snoopy', NULL, 'sourceforge.net/projects/snoopy/', 0, 'Snoopy is a PHP class that simulates a web browser. It automates the task of retrieving web page content and posting forms, for example.'),
('Sohu', 'sohu-search', NULL, 'sogou.com', 0, 'Searchbot of sohu.com'),
('Spambot', NULL, NULL, NULL, -1, 'Global name for bots which try to fill guestbooks and other stuff with garbage\r\nThey don\'t follow robots.txt either\r\n\r\nCurrent agents in this list:\r\nMissigua Locator\r\nProduction Bot\r\nFull Web Bot\r\nDemo Bot\r\nEducate Search\r\nFranklin locator\r\nIndustry Program\r\nMac Finder\r\nProgram Shareware\r\nMissauga Locate '),
('Spip', 'SPIP-', NULL, 'spip.net', 0, NULL),
('SurveyBot', 'SurveyBot/', NULL, 'whois.sc', 0, NULL),
('Susie', '!Susie', NULL, 'sync2it.com/susie', 0, NULL),
('Thumbshots', 'thumbshots-de-Bot', NULL, 'thumbshots.de', 0, NULL),
('Turnitin', 'TurnitinBot', NULL, 'turnitin.com/robot/crawlerinfo.html', 0, NULL),
('TutorGig', 'TutorGigBot', NULL, 'tutorgig.info', 0, NULL),
('Twiceler', 'Twiceler', NULL, 'cuill.com/robots.html', 0, NULL),
('Updated', 'updated/', NULL, 'updated.com', 0, NULL),
('Versus', 'versus crawler', NULL, 'eda.baykan@epfl.ch', 0, NULL),
('Vagabondo', 'Vagabondo', NULL, NULL, 0, NULL),
('Virgo', 'Virgo/', NULL, NULL, 0, NULL),
('Voila', 'VoilaBot', NULL, 'voila.com', 0, NULL),
('vspider', 'vspider', NULL, NULL, 0, NULL),
('W3C Checklink', 'W3C-checklink', NULL, NULL, 0, NULL),
('W3C Validator', 'W3C_Validator', NULL, NULL, 0, NULL),
('Walhello', 'appie', NULL, 'walhello.com', 0, NULL),
('WebIndexer', 'WebIndexer/', NULL, NULL, 0, NULL),
('WebReaper', 'WebReaper', NULL, 'webreaper.net', 0, NULL),
('WebStripper', 'WebStripper/', NULL, NULL, 0, NULL),
('Wget', 'Wget/', NULL, NULL, 0, NULL),
('Wire', 'WIRE', NULL, NULL, 0, NULL),
('YaCy', 'yacy', NULL, 'yacy.net/yacy/', -1, 'p2p-based distributed Web Search Engine\r\nDoesn\'t follow robots.txt'),
('Yadows', 'YadowsCrawler', NULL, 'yadows.com', 0, NULL),
('Yahoo', 'Yahoo! Slurp', NULL, 'help.yahoo.com/help/us/ysearch/slurp', 0, NULL),
('YahooFS', 'YahooFeedSeeker/', '.yahoo.', 'help.yahoo.com/help/us/ysearch/slurp', 0, NULL),
('YahooMM', 'Yahoo-MMCrawler', NULL, 'help.yahoo.com/help/us/ysearch/slurp', 0, NULL),
('YANDEX', 'YANDEX', NULL, NULL, 0, NULL),
('Zeus', 'Zeus', NULL, NULL, 0, NULL),
('NextGen', 'NextGenSearchBot', NULL, 'about.zoominfo.com/PublicSite/NextGenSearchBot.asp', 0, NULL),
('PoI', 'PictureOfInternet/', NULL, 'malfunction.org/poi', -1, NULL),
('Sensis', 'Sensis Web Crawler', NULL, 'sensis.com.au', 0, NULL),
('IlTrovatore', 'IlTrovatore-Setaccio/', NULL, 'iltrovatore.it/bot.html', -1, NULL),
('Rufus', 'RufusBot', NULL, '64.124.122.252/feedback.html', -1, NULL),
('WebMiner', 'WebMiner', NULL, NULL, -1, 'See RufusBot'),
('Accoona', 'Accoona-AI-Agent/', NULL, 'accoona.com', 0, NULL),
('Xirq', 'xirq/', NULL, 'xirq.com/', 0, NULL),
('Blogpulse', 'Blogpulse', NULL, 'blogpulse.com', 0, 'IntelliSeek service'),
('KnackAttack', 'KnackAttack', NULL, NULL, -1, NULL),
('Miva', 'Miva', NULL, 'miva.com', 0, NULL),
('PictureRipper', 'PictureRipper/', NULL, 'pictureripper.com', -1, NULL),
('Teleport', 'Teleport Pro/', NULL, NULL, -1, NULL),
('NetSprint', 'NetSprint', NULL, NULL, -1, NULL),
('SVSpider', 'SVSpider/', NULL, 'bildkiste.de', -1, NULL),
('SVSearch', 'SVSearchRobot/', NULL, NULL, -1, NULL),
('Lorkyll', 'Lorkyll', NULL, '444.net', -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_session`
--

CREATE TABLE `nuke_session` (
  `uname` varchar(25) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `starttime` varchar(14) NOT NULL DEFAULT '',
  `host_addr` varchar(48) NOT NULL DEFAULT '',
  `guest` int(1) NOT NULL DEFAULT '0',
  `module` varchar(30) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `is_mobile` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uname`),
  KEY `time` (`time`),
  KEY `guest` (`guest`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `nuke_sommaire`
--

CREATE TABLE `nuke_sommaire` (
  `groupmenu` int(2) NOT NULL DEFAULT '0',
  `name` varchar(200) DEFAULT NULL,
  `image` varchar(99) DEFAULT NULL,
  `lien` text,
  `hr` char(2) DEFAULT NULL,
  `center` char(2) DEFAULT NULL,
  `bgcolor` tinytext,
  `invisible` int(1) DEFAULT NULL,
  `class` tinytext,
  `bold` char(2) DEFAULT NULL,
  `new` char(2) DEFAULT NULL,
  `listbox` char(2) DEFAULT NULL,
  `dynamic` char(2) DEFAULT NULL,
  PRIMARY KEY (`groupmenu`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_sommaire`
--

INSERT INTO `nuke_sommaire` (`groupmenu`, `name`, `image`, `lien`, `hr`, `center`, `bgcolor`, `invisible`, `class`, `bold`, `new`, `listbox`, `dynamic`) VALUES
(0, 'Home', 'icon_home.gif', 'index.php', '', '', '', 2, 'storytitle', '', '', '', 'on'),
(1, 'Discussions', 'icon_community.gif', '', 'on', '', '', 2, 'storytitle', '', '', '', 'on'),
(2, 'News', 'favoritos.gif', '', '', '', '', 2, 'storytitle', '', '', '', 'on'),
(3, 'Files & Links', 'som_downloads.gif', '', '', '', '', 2, 'storytitle', '', '', '', 'on'),
(4, 'General', 'icon_poll.gif', '', '', '', '', 2, 'storytitle', '', '', '', 'on'),
(5, 'Infos', 'icon_members.gif', '', '', '', '', 2, 'storytitle', '', '', '', 'on'),
(99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_sommaire_categories`
--

CREATE TABLE `nuke_sommaire_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupmenu` int(2) NOT NULL DEFAULT '0',
  `module` varchar(50) NOT NULL DEFAULT '',
  `url` text NOT NULL,
  `url_text` text NOT NULL,
  `image` varchar(50) NOT NULL DEFAULT '',
  `new` char(2) DEFAULT NULL,
  `new_days` tinyint(4) NOT NULL DEFAULT '-1',
  `class` varchar(20) DEFAULT NULL,
  `bold` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_sommaire_categories`
--

INSERT INTO `nuke_sommaire_categories` (`id`, `groupmenu`, `module`, `url`, `url_text`, `image`, `new`, `new_days`, `class`, `bold`) VALUES
(1, 1, 'Forums', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(2, 1, 'Private_Messages', '', '', 'tree-L.gif', '', 7, 'boxcontent', ''),
(3, 2, 'News', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(4, 2, 'Topics', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(5, 2, 'Stories_Archive', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(6, 2, 'Submit_News', '', '', 'tree-L.gif', '', 7, 'boxcontent', ''),
(7, 3, 'Downloads', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(8, 3, 'Web_Links', '', '', 'tree-L.gif', '', 7, 'boxcontent', ''),
(9, 4, 'Content', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(10, 4, 'faq', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(11, 4, 'Top', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(12, 4, 'Reviews', '', '', 'tree-L.gif', '', 7, 'boxcontent', ''),
(13, 5, 'Feedback', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(14, 5, 'Recommend_Us', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(15, 5, 'Statistics', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(16, 5, 'Search', '', '', 'tree-T.gif', '', 7, 'boxcontent', ''),
(17, 5, 'Your_Account', '', '', 'tree-L.gif', '', 7, 'boxcontent', '');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_stats_hour`
--

CREATE TABLE `nuke_stats_hour` (
  `year` smallint(6) NOT NULL DEFAULT '0',
  `month` tinyint(4) NOT NULL DEFAULT '0',
  `date` tinyint(4) NOT NULL DEFAULT '0',
  `hour` tinyint(4) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_stories`
--

CREATE TABLE `nuke_stories` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `aid` varchar(25) NOT NULL DEFAULT '',
  `title` varchar(80) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `hometext` text,
  `bodytext` text NOT NULL,
  `comments` int(11) DEFAULT '0',
  `counter` mediumint(8) UNSIGNED DEFAULT NULL,
  `topic` int(3) NOT NULL DEFAULT '1',
  `informant` varchar(25) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `ihome` int(1) NOT NULL DEFAULT '0',
  `alanguage` varchar(30) NOT NULL DEFAULT '',
  `acomm` int(1) NOT NULL DEFAULT '0',
  `haspoll` int(1) NOT NULL DEFAULT '0',
  `pollID` int(10) NOT NULL DEFAULT '0',
  `score` int(10) NOT NULL DEFAULT '0',
  `ratings` int(10) NOT NULL DEFAULT '0',
  `associated` text NOT NULL,
  `ticon` tinyint(1) NOT NULL DEFAULT '0',
  `writes` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sid`),
  KEY `catid` (`catid`),
  KEY `counter` (`counter`),
  KEY `topic` (`topic`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_stories`
--

INSERT INTO `nuke_stories` (`sid`, `catid`, `aid`, `title`, `time`, `hometext`, `bodytext`, `comments`, `counter`, `topic`, `informant`, `notes`, `ihome`, `alanguage`, `acomm`, `haspoll`, `pollID`, `score`, `ratings`, `associated`, `ticon`, `writes`) VALUES
(1, 0, 'admin', 'Welcome to Nuke Evolution Xtreme 2.0.9F', '2018-11-03 05:56:20', 'Thank you for choosing nuke evolution, we hope you enjoy using our cms and we appreciate feedback and donations.

[b]NOTE:[/b] Your admin and user accounts have already been logged in for you so please visit [url=admin.php]this link[/url] to get started. 

You can remove this new story by going into the News Administration or by clicking the delete image below.', '', 0, 0, 1, 'coRpSE', '', 0, '', 0, 0, 0, 0, 0, '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_stories_cat`
--

CREATE TABLE `nuke_stories_cat` (
  `catid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL DEFAULT '',
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_themes`
--

CREATE TABLE `nuke_themes` (
  `theme_name` varchar(100) NOT NULL DEFAULT '',
  `groups` varchar(50) NOT NULL DEFAULT '',
  `permissions` tinyint(2) NOT NULL DEFAULT '1',
  `custom_name` varchar(100) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `theme_info` text NOT NULL,
  PRIMARY KEY (`theme_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_themes`
--

INSERT INTO `nuke_themes` (`theme_name`, `groups`, `permissions`, `custom_name`, `active`, `theme_info`) VALUES
('XtremeV3', '', 1, 'XtremeV3', 1, '1368:::#454545:::#383838:::Go to ATO panel to change this message:::Go to ATO panel to change this message:::#ccc:::#ccc');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_topics`
--

CREATE TABLE `nuke_topics` (
  `topicid` int(3) NOT NULL AUTO_INCREMENT,
  `topicname` varchar(20) DEFAULT NULL,
  `topicimage` varchar(100) DEFAULT NULL,
  `topictext` varchar(40) DEFAULT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`topicid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_topics`
--

INSERT INTO `nuke_topics` (`topicid`, `topicname`, `topicimage`, `topictext`, `counter`) VALUES
(1, 'evolution', 'nuke.png', 'Nuke-Evolution', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nuke_users`
--

CREATE TABLE `nuke_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `username` varchar(25) NOT NULL DEFAULT '',
  `user_email` varchar(255) NOT NULL DEFAULT '',
  `femail` varchar(255) NOT NULL DEFAULT '',
  `user_website` varchar(255) NOT NULL DEFAULT '',
  `user_avatar` varchar(255) NOT NULL DEFAULT '',
  `user_regdate` varchar(20) NOT NULL DEFAULT '',
  `user_occ` varchar(100) DEFAULT NULL,
  `user_from` varchar(100) DEFAULT NULL,
  `user_from_flag` varchar(64) DEFAULT NULL,
  `user_interests` varchar(150) NOT NULL DEFAULT '',
  `user_sig` text,
  `user_viewemail` tinyint(2) DEFAULT NULL,
  `user_theme` int(3) DEFAULT NULL,
  `user_facebook` varchar(255) DEFAULT NULL,
  `user_password` varchar(40) NOT NULL DEFAULT '',
  `storynum` tinyint(4) NOT NULL DEFAULT '10',
  `umode` varchar(10) NOT NULL DEFAULT '',
  `uorder` tinyint(1) NOT NULL DEFAULT '0',
  `thold` tinyint(1) NOT NULL DEFAULT '0',
  `noscore` tinyint(1) NOT NULL DEFAULT '0',
  `bio` longtext,
  `ublockon` tinyint(1) NOT NULL DEFAULT '0',
  `ublock` tinytext,
  `theme` varchar(255) NOT NULL DEFAULT '',
  `commentmax` int(11) NOT NULL DEFAULT '4096',
  `counter` int(11) NOT NULL DEFAULT '0',
  `newsletter` int(1) NOT NULL DEFAULT '0',
  `user_posts` int(10) NOT NULL DEFAULT '0',
  `user_attachsig` int(2) NOT NULL DEFAULT '1',
  `user_rank` int(10) NOT NULL DEFAULT '0',
  `user_level` int(10) NOT NULL DEFAULT '1',
  `broadcast` tinyint(1) NOT NULL DEFAULT '1',
  `popmeson` tinyint(1) NOT NULL DEFAULT '0',
  `user_active` tinyint(1) DEFAULT '1',
  `user_session_time` int(11) NOT NULL DEFAULT '0',
  `user_session_page` smallint(5) NOT NULL DEFAULT '0',
  `user_lastvisit` int(11) NOT NULL DEFAULT '0',
  `user_timezone` decimal(5,2) NOT NULL DEFAULT '0.00',
  `user_style` tinyint(4) DEFAULT NULL,
  `user_lang` varchar(255) NOT NULL DEFAULT 'english',
  `user_dateformat` varchar(14) NOT NULL DEFAULT 'D M d, Y g:i a',
  `user_new_privmsg` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `user_unread_privmsg` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `user_last_privmsg` int(11) NOT NULL DEFAULT '0',
  `user_emailtime` int(11) DEFAULT NULL,
  `user_allowhtml` tinyint(1) DEFAULT '1',
  `user_allowbbcode` tinyint(1) DEFAULT '1',
  `user_allowsmile` tinyint(1) DEFAULT '1',
  `user_allowavatar` tinyint(1) NOT NULL DEFAULT '1',
  `user_allow_pm` tinyint(1) NOT NULL DEFAULT '1',
  `user_allow_mass_pm` tinyint(1) DEFAULT '4',
  `user_allow_viewonline` tinyint(1) NOT NULL DEFAULT '1',
  `user_notify` tinyint(1) NOT NULL DEFAULT '0',
  `user_notify_pm` tinyint(1) NOT NULL DEFAULT '1',
  `user_popup_pm` tinyint(1) NOT NULL DEFAULT '1',
  `user_avatar_type` tinyint(4) NOT NULL DEFAULT '3',
  `user_sig_bbcode_uid` varchar(10) DEFAULT NULL,
  `user_actkey` varchar(32) DEFAULT NULL,
  `user_newpasswd` varchar(32) DEFAULT NULL,
  `points` int(10) DEFAULT '0',
  `last_ip` varchar(15) NOT NULL DEFAULT '0',
  `user_wordwrap` smallint(3) NOT NULL DEFAULT '70',
  `agreedtos` tinyint(1) NOT NULL DEFAULT '0',
  `user_allowsignature` tinyint(4) NOT NULL DEFAULT '1',
  `user_report_optout` tinyint(1) NOT NULL DEFAULT '0',
  `user_show_quickreply` tinyint(1) NOT NULL DEFAULT '1',
  `user_quickreply_mode` tinyint(1) NOT NULL DEFAULT '1',
  `user_color_gc` varchar(6) DEFAULT '',
  `user_color_gi` text,
  `user_showavatars` tinyint(1) DEFAULT '1',
  `user_showsignatures` tinyint(1) DEFAULT '1',
  `user_time_mode` tinyint(4) NOT NULL DEFAULT '6',
  `user_dst_time_lag` tinyint(4) NOT NULL DEFAULT '60',
  `user_pc_timeOffsets` varchar(55) NOT NULL DEFAULT '0',
  `user_view_log` tinyint(4) NOT NULL DEFAULT '0',
  `user_glance_show` varchar(255) NOT NULL DEFAULT '1',
  `user_hide_images` tinyint(2) NOT NULL DEFAULT '0',
  `user_open_quickreply` tinyint(1) NOT NULL DEFAULT '1',
  `sceditor_in_source` tinyint(1) NOT NULL DEFAULT '0',
  `xdata_bbcode` varchar(10) DEFAULT NULL,
  `user_ftr` smallint(1) NOT NULL DEFAULT '0',
  `user_ftr_time` int(10) NOT NULL DEFAULT '0',
  `user_rank2` int(11) DEFAULT '-1',
  `user_rank3` int(11) DEFAULT '-2',
  `user_rank4` int(11) DEFAULT '-2',
  `user_rank5` int(11) DEFAULT '-2',
  `user_gender` tinyint(4) NOT NULL DEFAULT '0',
  `user_birthday` int(8) NOT NULL DEFAULT '0',
  `user_birthday2` int(8) DEFAULT NULL,
  `birthday_display` tinyint(1) NOT NULL DEFAULT '0',
  `birthday_greeting` tinyint(1) NOT NULL DEFAULT '0',
  `user_next_birthday` smallint(4) NOT NULL DEFAULT '0',
  `user_reputation` float NOT NULL DEFAULT '0',
  `user_rep_last_time` int(11) DEFAULT NULL,
  `user_admin_notes` text,
  PRIMARY KEY (`user_id`),
  KEY `uname` (`username`),
  KEY `user_session_time` (`user_session_time`),
  KEY `user_birthday` (`user_birthday`),
  KEY `user_birthday2` (`user_birthday2`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_users`
--

INSERT INTO `nuke_users` (`user_id`, `name`, `username`, `user_email`, `femail`, `user_website`, `user_avatar`, `user_regdate`, `user_occ`, `user_from`, `user_from_flag`, `user_interests`, `user_sig`, `user_viewemail`, `user_theme`, `user_facebook`, `user_password`, `storynum`, `umode`, `uorder`, `thold`, `noscore`, `bio`, `ublockon`, `ublock`, `theme`, `commentmax`, `counter`, `newsletter`, `user_posts`, `user_attachsig`, `user_rank`, `user_level`, `broadcast`, `popmeson`, `user_active`, `user_session_time`, `user_session_page`, `user_lastvisit`, `user_timezone`, `user_style`, `user_lang`, `user_dateformat`, `user_new_privmsg`, `user_unread_privmsg`, `user_last_privmsg`, `user_emailtime`, `user_allowhtml`, `user_allowbbcode`, `user_allowsmile`, `user_allowavatar`, `user_allow_pm`, `user_allow_mass_pm`, `user_allow_viewonline`, `user_notify`, `user_notify_pm`, `user_popup_pm`, `user_avatar_type`, `user_sig_bbcode_uid`, `user_actkey`, `user_newpasswd`, `points`, `last_ip`, `user_wordwrap`, `agreedtos`, `user_allowsignature`, `user_report_optout`, `user_show_quickreply`, `user_quickreply_mode`, `user_color_gc`, `user_color_gi`, `user_showavatars`, `user_showsignatures`, `user_time_mode`, `user_dst_time_lag`, `user_pc_timeOffsets`, `user_view_log`, `user_glance_show`, `user_hide_images`, `user_open_quickreply`, `sceditor_in_source`, `xdata_bbcode`, `user_ftr`, `user_ftr_time`, `user_rank2`, `user_rank3`, `user_rank4`, `user_rank5`, `user_gender`, `user_birthday`, `user_birthday2`, `birthday_display`, `birthday_greeting`, `user_next_birthday`, `user_reputation`, `user_rep_last_time`, `user_admin_notes`) VALUES
(1, '', 'Anonymous', '', '', '', 'blank.gif', 'Nov 03, 2018', '', '', NULL, '', '', 0, 0, NULL, '', 10, '', 0, 0, 0, '', 0, '', '', 4096, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, '10.00', NULL, 'english', 'D M d, Y g:i a', 0, 0, 0, NULL, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 3, NULL, NULL, NULL, 0, '0', 70, 0, 0, 0, 0, 0, '', '', 1, 1, 6, 60, '0', 0, '1', 0, 1, 0, '', 0, 0, -1, -2, -2, -2, 0, 0, NULL, 0, 0, 0, 43.2825, 1243272322, '');

--
-- Table structure for table `nuke_users_countries`
--

CREATE TABLE `nuke_users_countries` (
  `id_country` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `iso_code_2` char(2) NOT NULL DEFAULT '',
  `iso_code_3` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_country`),
  KEY `IDX_NAME` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuke_users_countries`
--

INSERT INTO `nuke_users_countries` (`id_country`, `name`, `iso_code_2`, `iso_code_3`) VALUES
(1, 'Afghanistan', 'AF', 'AFG'),
(2, 'Albania', 'AL', 'ALB'),
(3, 'Algeria', 'DZ', 'DZA'),
(4, 'American Samoa', 'AS', 'ASM'),
(5, 'Andorra', 'AD', 'AND'),
(6, 'Angola', 'AO', 'AGO'),
(7, 'Anguilla', 'AI', 'AIA'),
(8, 'Antarctica', 'AQ', 'ATA'),
(9, 'Antigua and Barbuda', 'AG', 'ATG'),
(10, 'Argentina', 'AR', 'ARG'),
(11, 'Armenia', 'AM', 'ARM'),
(12, 'Aruba', 'AW', 'ABW'),
(13, 'Australia', 'AU', 'AUS'),
(14, 'Austria', 'AT', 'AUT'),
(15, 'Azerbaijan', 'AZ', 'AZE'),
(16, 'Bahamas', 'BS', 'BHS'),
(17, 'Bahrain', 'BH', 'BHR'),
(18, 'Bangladesh', 'BD', 'BGD'),
(19, 'Barbados', 'BB', 'BRB'),
(20, 'Belarus', 'BY', 'BLR'),
(21, 'Belgium', 'BE', 'BEL'),
(22, 'Belize', 'BZ', 'BLZ'),
(23, 'Benin', 'BJ', 'BEN'),
(24, 'Bermuda', 'BM', 'BMU'),
(25, 'Bhutan', 'BT', 'BTN'),
(26, 'Bolivia', 'BO', 'BOL'),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH'),
(28, 'Botswana', 'BW', 'BWA'),
(29, 'Bouvet Island', 'BV', 'BVT'),
(30, 'Brazil', 'BR', 'BRA'),
(31, 'British Indian Ocean Territory', 'IO', 'IOT'),
(32, 'Brunei Darussalam', 'BN', 'BRN'),
(33, 'Bulgaria', 'BG', 'BGR'),
(34, 'Burkina Faso', 'BF', 'BFA'),
(35, 'Burundi', 'BI', 'BDI'),
(36, 'Cambodia', 'KH', 'KHM'),
(37, 'Cameroon', 'CM', 'CMR'),
(38, 'Canada', 'CA', 'CAN'),
(39, 'Cape Verde', 'CV', 'CPV'),
(40, 'Cayman Islands', 'KY', 'CYM'),
(41, 'Central African Republic', 'CF', 'CAF'),
(42, 'Chad', 'TD', 'TCD'),
(43, 'Chile', 'CL', 'CHL'),
(44, 'China', 'CN', 'CHN'),
(45, 'Christmas Island', 'CX', 'CXR'),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK'),
(47, 'Colombia', 'CO', 'COL'),
(48, 'Comoros', 'KM', 'COM'),
(49, 'Congo', 'CG', 'COG'),
(50, 'Cook Islands', 'CK', 'COK'),
(51, 'Costa Rica', 'CR', 'CRI'),
(52, 'Cote D\'Ivoire', 'CI', 'CIV'),
(53, 'Croatia', 'HR', 'HRV'),
(54, 'Cuba', 'CU', 'CUB'),
(55, 'Cyprus', 'CY', 'CYP'),
(56, 'Czech Republic', 'CZ', 'CZE'),
(57, 'Denmark', 'DK', 'DNK'),
(58, 'Djibouti', 'DJ', 'DJI'),
(59, 'Dominica', 'DM', 'DMA'),
(60, 'Dominican Republic', 'DO', 'DOM'),
(61, 'East Timor', 'TP', 'TMP'),
(62, 'Ecuador', 'EC', 'ECU'),
(63, 'Egypt', 'EG', 'EGY'),
(64, 'El Salvador', 'SV', 'SLV'),
(65, 'Equatorial Guinea', 'GQ', 'GNQ'),
(66, 'Eritrea', 'ER', 'ERI'),
(67, 'Estonia', 'EE', 'EST'),
(68, 'Ethiopia', 'ET', 'ETH'),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK'),
(70, 'Faroe Islands', 'FO', 'FRO'),
(71, 'Fiji', 'FJ', 'FJI'),
(72, 'Finland', 'FI', 'FIN'),
(73, 'France', 'FR', 'FRA'),
(74, 'France, Metropolitan', 'FX', 'FXX'),
(75, 'French Guiana', 'GF', 'GUF'),
(76, 'French Polynesia', 'PF', 'PYF'),
(77, 'French Southern Territories', 'TF', 'ATF'),
(78, 'Gabon', 'GA', 'GAB'),
(79, 'Gambia', 'GM', 'GMB'),
(80, 'Georgia', 'GE', 'GEO'),
(81, 'Germany', 'DE', 'DEU'),
(82, 'Ghana', 'GH', 'GHA'),
(83, 'Gibraltar', 'GI', 'GIB'),
(84, 'Greece', 'GR', 'GRC'),
(85, 'Greenland', 'GL', 'GRL'),
(86, 'Grenada', 'GD', 'GRD'),
(87, 'Guadeloupe', 'GP', 'GLP'),
(88, 'Guam', 'GU', 'GUM'),
(89, 'Guatemala', 'GT', 'GTM'),
(90, 'Guinea', 'GN', 'GIN'),
(91, 'Guinea-bissau', 'GW', 'GNB'),
(92, 'Guyana', 'GY', 'GUY'),
(93, 'Haiti', 'HT', 'HTI'),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD'),
(95, 'Honduras', 'HN', 'HND'),
(96, 'Hong Kong', 'HK', 'HKG'),
(97, 'Hungary', 'HU', 'HUN'),
(98, 'Iceland', 'IS', 'ISL'),
(99, 'India', 'IN', 'IND'),
(100, 'Indonesia', 'ID', 'IDN'),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN'),
(102, 'Iraq', 'IQ', 'IRQ'),
(103, 'Ireland', 'IE', 'IRL'),
(104, 'Israel', 'IL', 'ISR'),
(105, 'Italy', 'IT', 'ITA'),
(106, 'Jamaica', 'JM', 'JAM'),
(107, 'Japan', 'JP', 'JPN'),
(108, 'Jordan', 'JO', 'JOR'),
(109, 'Kazakhstan', 'KZ', 'KAZ'),
(110, 'Kenya', 'KE', 'KEN'),
(111, 'Kiribati', 'KI', 'KIR'),
(112, 'Korea, Democratic People\'s Republic of', 'KP', 'PRK'),
(113, 'Korea, Republic of', 'KR', 'KOR'),
(114, 'Kuwait', 'KW', 'KWT'),
(115, 'Kyrgyzstan', 'KG', 'KGZ'),
(116, 'Lao People\'s Democratic Republic', 'LA', 'LAO'),
(117, 'Latvia', 'LV', 'LVA'),
(118, 'Lebanon', 'LB', 'LBN'),
(119, 'Lesotho', 'LS', 'LSO'),
(120, 'Liberia', 'LR', 'LBR'),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY'),
(122, 'Liechtenstein', 'LI', 'LIE'),
(123, 'Lithuania', 'LT', 'LTU'),
(124, 'Luxembourg', 'LU', 'LUX'),
(125, 'Macau', 'MO', 'MAC'),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD'),
(127, 'Madagascar', 'MG', 'MDG'),
(128, 'Malawi', 'MW', 'MWI'),
(129, 'Malaysia', 'MY', 'MYS'),
(130, 'Maldives', 'MV', 'MDV'),
(131, 'Mali', 'ML', 'MLI'),
(132, 'Malta', 'MT', 'MLT'),
(133, 'Marshall Islands', 'MH', 'MHL'),
(134, 'Martinique', 'MQ', 'MTQ'),
(135, 'Mauritania', 'MR', 'MRT'),
(136, 'Mauritius', 'MU', 'MUS'),
(137, 'Mayotte', 'YT', 'MYT'),
(138, 'Mexico', 'MX', 'MEX'),
(139, 'Micronesia, Federated States of', 'FM', 'FSM'),
(140, 'Moldova, Republic of', 'MD', 'MDA'),
(141, 'Monaco', 'MC', 'MCO'),
(142, 'Mongolia', 'MN', 'MNG'),
(143, 'Montserrat', 'MS', 'MSR'),
(144, 'Morocco', 'MA', 'MAR'),
(145, 'Mozambique', 'MZ', 'MOZ'),
(146, 'Myanmar', 'MM', 'MMR'),
(147, 'Namibia', 'NA', 'NAM'),
(148, 'Nauru', 'NR', 'NRU'),
(149, 'Nepal', 'NP', 'NPL'),
(150, 'Netherlands', 'NL', 'NLD'),
(151, 'Netherlands Antilles', 'AN', 'ANT'),
(152, 'New Caledonia', 'NC', 'NCL'),
(153, 'New Zealand', 'NZ', 'NZL'),
(154, 'Nicaragua', 'NI', 'NIC'),
(155, 'Niger', 'NE', 'NER'),
(156, 'Nigeria', 'NG', 'NGA'),
(157, 'Niue', 'NU', 'NIU'),
(158, 'Norfolk Island', 'NF', 'NFK'),
(159, 'Northern Mariana Islands', 'MP', 'MNP'),
(160, 'Norway', 'NO', 'NOR'),
(161, 'Oman', 'OM', 'OMN'),
(162, 'Pakistan', 'PK', 'PAK'),
(163, 'Palau', 'PW', 'PLW'),
(164, 'Panama', 'PA', 'PAN'),
(165, 'Papua New Guinea', 'PG', 'PNG'),
(166, 'Paraguay', 'PY', 'PRY'),
(167, 'Peru', 'PE', 'PER'),
(168, 'Philippines', 'PH', 'PHL'),
(169, 'Pitcairn', 'PN', 'PCN'),
(170, 'Poland', 'PL', 'POL'),
(171, 'Portugal', 'PT', 'PRT'),
(172, 'Puerto Rico', 'PR', 'PRI'),
(173, 'Qatar', 'QA', 'QAT'),
(174, 'Reunion', 'RE', 'REU'),
(175, 'Romania', 'RO', 'ROM'),
(176, 'Russian Federation', 'RU', 'RUS'),
(177, 'Rwanda', 'RW', 'RWA'),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA'),
(179, 'Saint Lucia', 'LC', 'LCA'),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT'),
(181, 'Samoa', 'WS', 'WSM'),
(182, 'San Marino', 'SM', 'SMR'),
(183, 'Sao Tome and Principe', 'ST', 'STP'),
(184, 'Saudi Arabia', 'SA', 'SAU'),
(185, 'Senegal', 'SN', 'SEN'),
(186, 'Serbia', 'RS', 'SER'),
(187, 'Seychelles', 'SC', 'SYC'),
(188, 'Sierra Leone', 'SL', 'SLE'),
(189, 'Singapore', 'SG', 'SGP'),
(190, 'Sudan', 'SD', 'SDN'),
(191, 'Slovenia', 'SI', 'SVN'),
(192, 'Solomon Islands', 'SB', 'SLB'),
(193, 'Somalia', 'SO', 'SOM'),
(194, 'South Africa', 'ZA', 'ZAF'),
(195, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS'),
(196, 'Spain', 'ES', 'ESP'),
(197, 'Sri Lanka', 'LK', 'LKA'),
(198, 'St. Helena', 'SH', 'SHN'),
(199, 'St. Pierre and Miquelon', 'PM', 'SPM'),
(201, 'Suriname', 'SR', 'SUR'),
(202, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM'),
(203, 'Swaziland', 'SZ', 'SWZ'),
(204, 'Sweden', 'SE', 'SWE'),
(205, 'Switzerland', 'CH', 'CHE'),
(206, 'Syrian Arab Republic', 'SY', 'SYR'),
(207, 'Taiwan', 'TW', 'TWN'),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA'),
(209, 'Thailand', 'TH', 'THA'),
(210, 'Togo', 'TG', 'TGO'),
(211, 'Tokelau', 'TK', 'TKL'),
(212, 'Tonga', 'TO', 'TON'),
(213, 'Trinidad and Tobago', 'TT', 'TTO'),
(214, 'Tunisia', 'TN', 'TUN'),
(215, 'Turkey', 'TR', 'TUR'),
(216, 'Turkmenistan', 'TM', 'TKM'),
(217, 'Turks and Caicos Islands', 'TC', 'TCA'),
(218, 'Tuvalu', 'TV', 'TUV'),
(219, 'Uganda', 'UG', 'UGA'),
(220, 'Ukraine', 'UA', 'UKR'),
(221, 'United Arab Emirates', 'AE', 'ARE'),
(222, 'United Kingdom', 'GB', 'GBR'),
(223, 'United States', 'US', 'USA'),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI'),
(225, 'Uruguay', 'UY', 'URY'),
(226, 'Uzbekistan', 'UZ', 'UZB'),
(227, 'Vanuatu', 'VU', 'VUT'),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT'),
(229, 'Venezuela', 'VE', 'VEN'),
(230, 'Viet Nam', 'VN', 'VNM'),
(231, 'Virgin Islands (British)', 'VG', 'VGB'),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR'),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF'),
(234, 'Western Sahara', 'EH', 'ESH'),
(235, 'Yemen', 'YE', 'YEM'),
(237, 'Zaire', 'ZR', 'ZAR'),
(238, 'Zambia', 'ZM', 'ZMB'),
(239, 'Zimbabwe', 'ZW', 'ZWE');

-- --------------------------------------------------------

--
-- Table structure for table `nuke_users_temp`
--

CREATE TABLE `nuke_users_temp` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL DEFAULT '',
  `user_email` varchar(255) NOT NULL DEFAULT '',
  `user_password` varchar(40) NOT NULL DEFAULT '',
  `user_regdate` varchar(20) NOT NULL DEFAULT '',
  `check_num` varchar(50) NOT NULL DEFAULT '',
  `time` varchar(14) NOT NULL DEFAULT '',
  `realname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_users_who_been`
--

CREATE TABLE `nuke_users_who_been` (
  `user_ID` int(11) NOT NULL default '0',
  `username` varchar(25) NOT NULL default '',
  `last_visit` int(15) default NULL,
  PRIMARY KEY  (`user_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuke_welcome_pm`
--

CREATE TABLE `nuke_welcome_pm` (
  `subject` varchar(30) NOT NULL DEFAULT '',
  `msg` text NOT NULL,
  PRIMARY KEY (`subject`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
