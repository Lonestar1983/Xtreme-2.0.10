<?php

/*=======================================================================
 Nuke-Evolution Basic: Enhanced PHP-Nuke Web Portal System
 =======================================================================*/

/************************************************************************/
/* PHP-NUKE: Advanced Content Management System                         */
/* ============================================                         */
/*                                                                      */
/* Copyright (c) 2002 by Francisco Burzi                                */
/* http://phpnuke.org                                                   */
/*                                                                      */
/* This program is free software. You can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 2 of the License.       */
/************************************************************************/

if ( defined( 'NUKE_EVO' ) ) {
	return;
}

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
    exit( 'Access Denied' );
}

define_once( 'NUKE_EVO', '2.0.9f' );
define_once( 'EVO_EDITION', 'xtreme' );
define_once( 'EVO_VERSION', NUKE_EVO . ' ' . EVO_EDITION );
define_once( 'EVO_BUILD', '20102023' );
define( 'PHPVERS', phpversion() );
define( 'PHP_5', version_compare( PHPVERS, '5.0.0', '>=' ) );

// if ( ! ini_get( 'register_globals' ) ) {
// 	$import = true;
// 	//Need register_globals so try the built in import function
// 	if (function_exists('import_request_variables')) {
// 		@import_request_variables('GPC');
// 	} else {
// 		function evo_import_globals($array) {
// 			foreach ($array as $k => $v) {
// 				global $$k;
// 				$$k = $v;
// 			}
// 		}
// 		if (!empty($_GET)) {
// 			evo_import_globals($_GET);
// 		}
// 		if (!empty($_POST)) {
// 			evo_import_globals($_POST);
// 		}
// 		if (!empty($_COOKIE)) {
// 			evo_import_globals($_COOKIE);
// 		}
// 	}
// }

$methods = array( "_GET", "_POST", "_REQUEST", "_FILES" );
foreach( $methods as $method ) {
	if ( isset( $$method ) ) {
		extract( $$method );
	}
}

if ( ( isset( $_POST['name'] ) && ! empty( $_POST['name'] ) ) && ( isset( $_GET['name'] ) && ! empty( $_GET['name'] ) ) ) {
	$name = ( isset( $_GET['name'] ) && ! stristr( $_GET['name'], '..' ) && ! stristr( $_GET['name'], '://' ) ) ? addslashes( trim( $_GET['name'] ) ) : false;
} else {
	$name = ( isset( $_REQUEST['name'] ) && ! stristr( $_REQUEST['name'], '..' ) && ! stristr( $_REQUEST['name'], '://' ) ) ? addslashes( trim( $_REQUEST['name'] ) ) : false;
}

$admin      = ( isset( $_COOKIE['admin'] ) ) ? $_COOKIE['admin'] : false;
$user       = ( isset( $_COOKIE['user'] ) )  ? $_COOKIE['user'] : false;
// $start_mem  = function_exists( 'memory_get_usage' ) ? memory_get_usage() : 0;
$start_mem  = memory_get_usage();
$start_time = get_microtime();

// Stupid handle to create REQUEST_URI for IIS 5 servers
if ( preg_match( '/IIS/', $_SERVER['SERVER_SOFTWARE'] ) && isset( $_SERVER['SCRIPT_NAME'] ) ) {
    $requesturi = $_SERVER['SCRIPT_NAME'];

    if ( isset( $_SERVER['QUERY_STRING'] ) ) {
        $requesturi .= '?' . $_SERVER['QUERY_STRING'];
    }

    $_SERVER['REQUEST_URI'] = $requesturi;
}

// PHP5 with register_long_arrays off?
if ( PHP_5 && ( ! ini_get( 'register_long_arrays' ) || ini_get( 'register_long_arrays' ) == '0' || strtolower( 'off' === ini_get( 'register_long_arrays' ) ) ) ) {
	$HTTP_POST_VARS   =& $_POST;
	$HTTP_GET_VARS    =& $_GET;
	$HTTP_SERVER_VARS =& $_SERVER;
	$HTTP_COOKIE_VARS =& $_COOKIE;
	$HTTP_ENV_VARS    =& $_ENV;
	$HTTP_POST_FILES  =& $_FILES;
	if ( isset( $_SESSION ) ) {
		$HTTP_SESSION_VARS =& $_SESSION;
	}
}

//Inspired by phoenix-cms at website-portals.net
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

define( 'NUKE_BASE_DIR', __DIR__ . '/' );
define( 'NUKE_BLOCKS_DIR', NUKE_BASE_DIR . 'blocks/' );
define( 'NUKE_CSS_DIR', 'includes/css/');
define( 'NUKE_IMAGES_DIR', NUKE_BASE_DIR . 'images/' );
define( 'NUKE_INCLUDE_DIR', NUKE_BASE_DIR . 'includes/' );
define( 'NUKE_JQUERY_INCLUDE_DIR', 'includes/js/' );
define( 'NUKE_JQUERY_SCRIPTS_DIR', 'includes/js/scripts/' );
define( 'NUKE_LANGUAGE_DIR', NUKE_BASE_DIR . 'language/' );
define( 'NUKE_MODULES_DIR', NUKE_BASE_DIR . 'modules/' );
define( 'NUKE_THEMES_DIR', NUKE_BASE_DIR . 'themes/' );
define( 'NUKE_THEMES_SAVE_DIR', NUKE_INCLUDE_DIR . 'saved_themes/' );
define( 'NUKE_ADMIN_DIR', NUKE_BASE_DIR . 'admin/' );
define( 'NUKE_RSS_DIR', NUKE_INCLUDE_DIR . 'rss/' );
define( 'NUKE_DB_DIR', NUKE_INCLUDE_DIR . 'db/' );
define( 'NUKE_ADMIN_MODULE_DIR', NUKE_ADMIN_DIR . 'modules/' );
define( 'NUKE_FORUMS_DIR', ( defined( 'IN_ADMIN' ) ? './../' : 'modules/Forums/' ) );
define( 'NUKE_CACHE_DIR', NUKE_INCLUDE_DIR . 'cache/' );
define( 'NUKE_CLASSES_DIR', NUKE_INCLUDE_DIR . 'classes/' );
define( 'NUKE_ZEND_DIR', NUKE_INCLUDE_DIR . 'Zend/' );
define( 'NUKE_CLASS_EXCEPTION_DIR',  NUKE_CLASSES_DIR . 'exceptions/' );
define( 'VENDOR_DIRECTORY', NUKE_INCLUDE_DIR . 'vendor' );

// User Profile URL, URL was defined here for future use with new account module.
define( 'ACCOUNT_PROFILE_URL', 'modules.php?name=Profile&amp;mode=viewprofile&amp;u=' );

define( 'GZIPSUPPORT', extension_loaded( 'zlib' ) );
define( 'GDSUPPORT', extension_loaded( 'gd' ) );
define( 'CAN_MOD_INI', ! stristr( ini_get( 'disable_functions' ), 'ini_set' ) );

/**
 * If a class hasn't been loaded yet find the required file on the server and load
 * it in using the special autoloader detection built into PHP5+
 */
if ( ! function_exists( 'classAutoloader' ) ) {
    function classAutoloader( $class ) {
        // Set the class file path
        if ( preg_match( '/Exception/', $class ) ) {
            $file = NUKE_CLASS_EXCEPTION_DIR . strtolower( $class ) . '.php';
        } else {
            $file = NUKE_CLASSES_DIR . 'class.' . strtolower( $class ) . '.php';
        }

        if ( ! class_exists( $class, false ) && file_exists( $file ) ) {
            require_once $file;
        }
    }

    spl_autoload_register( 'classAutoloader' );
}

if ( CAN_MOD_INI ) {
	ini_set( 'magic_quotes_sybase', 0 );
	ini_set( 'zlib.output_compression', 0 );
}

// Include config file
require_once NUKE_BASE_DIR . 'config.php';

$directory_mode = ( ! $directory_mode ) ? 0777 : 0755;
$file_mode      = ( ! $file_mode ) ? 0666 : 0644;

// Include the required files
require_once NUKE_DB_DIR . 'db.php';
require_once NUKE_CLASSES_DIR . 'class.identify.php';
require_once NUKE_INCLUDE_DIR . 'log.php';
//$db->debug = true;

if ( ini_get( 'output_buffering' ) && ! isset( $agent['bot'] ) ) {
	ob_end_clean();
	header( 'Content-Encoding: none' );
}

$do_gzip_compress = false;
if ( GZIPSUPPORT && ! ini_get( 'zlib.output_compression' ) && isset( $_SERVER['HTTP_ACCEPT_ENCODING'] ) && preg_match( '/gzip/i', $_SERVER['HTTP_ACCEPT_ENCODING'] ) ) {
	if ( version_compare( PHPVERS, '4.3.0', '>=' ) ) {
		ob_start( 'ob_gzhandler' );
	} else {
		$do_gzip_compress = true;
		ob_start();
		ob_implicit_flush( 0 );
		header( 'Content-Encoding: gzip' );
	}
} else {
	ob_start();
	ob_implicit_flush( 0 );
}

require NUKE_CLASSES_DIR . 'class.cache.php';
require NUKE_CLASSES_DIR . 'class.zip.php';
require NUKE_CLASSES_DIR . 'class.debugger.php';

require NUKE_INCLUDE_DIR . 'constants.php';
require NUKE_INCLUDE_DIR . 'formatting.php';
require NUKE_INCLUDE_DIR . 'functions_database.php';
require NUKE_INCLUDE_DIR . 'functions_cache.php';
require NUKE_INCLUDE_DIR . 'functions_evo.php';
require NUKE_INCLUDE_DIR . 'functions_evo_custom.php';
require NUKE_INCLUDE_DIR . 'nsn_center_block_functions.php';
require NUKE_INCLUDE_DIR . 'options.php';
require NUKE_INCLUDE_DIR . 'templates-evo.php';
require NUKE_INCLUDE_DIR . 'user.php';
require NUKE_INCLUDE_DIR . 'validation.php';
require NUKE_INCLUDE_DIR . 'vars.php';
require NUKE_INCLUDE_DIR . 'widgets.php';

/**
 * We globalize the $cookie and $userinfo variables,
 * so that they dont have to be called each time
 * And as you can see, getusrinfo() is now deprecated.
 * Because you dont have to call it anymore, just call $userinfo
 */
if ( is_user() ) {
	$cookie   = cookiedecode();
	$userinfo = get_user_field( '*', $cookie[1], true );
} else {
	$cookie   = array();
	$userinfo = get_user_field( '*', 'Anonymous', true );
}

//If they have been deactivated send them to logout to kill their cookie and sessions
if ( is_array( $userinfo ) && isset( $userinfo['user_active'] ) && $userinfo['user_id'] != 1 && $userinfo['user_id'] != 0 && $userinfo['user_active'] == 0 && $_GET['name'] != 'Your_Account' ) {
	redirect( 'modules.php?name=Your_Account&op=logout' );
	die();
}

if ( stristr( $_SERVER['REQUEST_URI'], '.php/' ) ) {
	redirect( str_replace( '.php/', '.php', $_SERVER['REQUEST_URI'] ) );
}

require_once NUKE_MODULES_DIR . 'Your_Account/includes/mainfileend.php';

if ( isset( $_POST['clear_cache'] ) ) {
    cache_clear();
}

define( 'NUKE_FILE', true );

$sitekey      = md5( $_SERVER['HTTP_HOST'] );
$tipath       = 'modules/News/images/topics/';

$reasons      = array(
	'As Is',
	'Offtopic',
	'Flamebait',
	'Troll',
	'Redundant',
	'Insighful',
	'Interesting',
	'Informative',
	'Funny',
	'Overrated',
	'Underrated'
);

$AllowableHTML = array(
	'b'          => 1,
	'i'          => 1,
	'a'          => 2,
	'em'         => 1,
	'br'         => 1,
	'strong'     => 1,
	'blockquote' => 1,
	'tt'         => 1,
	'li'         => 1,
	'ol'         => 1,
	'ul'         => 1,
	'pre'        => 1
);

$nukeconfig = load_nukeconfig();
foreach( $nukeconfig as $var => $value ) {
    $$var = $value;
}

require_once NUKE_INCLUDE_DIR . 'language.php';

$adminmail    = stripslashes( $adminmail );
$foot1        = stripslashes( $foot1 );
$foot2        = stripslashes( $foot2 );
$foot3        = stripslashes( $foot3 );
$commentlimit = (int) $commentlimit;
$minpass      = (int) $minpass;
$pollcomm     = (int) $pollcomm;
$articlecomm  = (int) $articlecomm;
$my_headlines = (int) $my_headlines;
$top          = (int) $top;
$storyhome    = (int) $storyhome;
$user_news    = (int) $user_news;
$oldnum       = (int) $oldnum;
$ultramode    = (int) $ultramode;
$banners      = (int) $banners;
$multilingual = (int) $multilingual;
$useflags     = (int) $useflags;
$notify       = (int) $notify;
$moderate     = (int) $moderate;
$admingraphic = (int) $admingraphic;
$httpref      = (int) $httpref;
$httprefmax   = (int) $httprefmax;
// $domain       = str_replace( 'http://', '', $nukeurl );
$domain       = str_replace( array( 'http://', 'https://' ), '', $nukeurl );

if ( isset( $default_Theme ) ) {
	$Default_Theme = $default_Theme;
}

if ( CAN_MOD_INI ) {
	ini_set( 'sendmail_from', $adminmail );
}

$evoconfig       = load_evoconfig();
$board_config    = evo_load_all_board_options();

$lock_modules    = (int) $evoconfig['lock_modules'];
$queries_count   = (int) $evoconfig['queries_count'];
$adminssl        = (int) $evoconfig['adminssl'];
$censor_words    = (string) $evoconfig['censor_words'];
$censor          = (int) $evoconfig['censor'];
$usrclearcache   = (int) $evoconfig['usrclearcache'];
$use_colors      = (int) $evoconfig['use_colors'];
$lazy_tap        = (int) $evoconfig['lazy_tap'];
$img_resize      = (int) $evoconfig['img_resize'];
$img_width       = (int) $evoconfig['img_width'];
$img_height      = (int) $evoconfig['img_height'];
$wysiwyg         = (string) $evoconfig['textarea'];
$capfile         = (string) $evoconfig['capfile'];
$collapse        = (int) $evoconfig['collapse'];
$collapsetype    = (int) $evoconfig['collapsetype'];
$module_collapse = (int) $evoconfig['module_collapse'];
$evouserinfo_ec  = (int) $evoconfig['evouserinfo_ec'];
$analytics       = (string) $evoconfig['analytics'];
$html_auth       = (int) $evoconfig['html_auth'];

$more_js         = '';
$more_styles     = '';

require_once NUKE_INCLUDE_DIR . 'functions_browser.php';
require_once NUKE_INCLUDE_DIR . 'themes.php';
include_once NUKE_INCLUDE_DIR . 'functions_tap.php';
if ( ! defined( 'NO_SENTINEL' ) ) {
    require_once NUKE_INCLUDE_DIR . 'nukesentinel.php';
}
require_once NUKE_CLASSES_DIR . 'class.variables.php';
require_once NUKE_CLASSES_DIR . 'class.wysiwyg.php';

if ( file_exists( NUKE_INCLUDE_DIR . 'custom_files/custom_mainfile.php' ) ) {
    require_once NUKE_INCLUDE_DIR . 'custom_files/custom_mainfile.php';
}

// if ( ! defined( 'FORUM_ADMIN' ) && ! isset( $ThemeSel ) && ! defined( 'RSS_FEED' ) ) {
//     $ThemeSel = get_theme();
//     include_once NUKE_THEMES_DIR . $ThemeSel . '/theme.php';
// }

if ( ! defined( 'FORUM_ADMIN' ) ) {
    global $admin_file;
    if ( ! isset( $admin_file ) || empty( $admin_file ) ) {
        die( 'You must set a value for $admin_file in config.php' );
    } elseif ( ! empty( $admin_file ) && ! file_exists( NUKE_BASE_DIR . $admin_file . '.php' ) ) {
        die( 'The ' . $admin_file . ' you defined in config.php does not exist' );
    }
}

function define_once( $constant, $value ) {
    if ( ! defined( $constant ) ) {
        define( $constant, $value );
    }
}

function cookiedecode() {
    global $cookie;
    static $rcookie;
    if(isset($rcookie)) { return $rcookie; }
    $usercookie = $_COOKIE['user'];
    $rcookie = (!is_array($usercookie)) ? explode(':', base64_decode($usercookie)) : $usercookie;
    $pass = get_user_field('user_password', $rcookie[1], true);
    if ($rcookie[2] == $pass && !empty($pass)) {
        return $cookie = $rcookie;
    }
    return false;
}

function title( $text ) {
    OpenTable();
    echo '<div class="title" style="text-align: center"><strong>'.$text.'</strong></div>';
    CloseTable();
    echo '<br />';
}

function rss_content($url) {
    if (!evo_site_up($url)) return false;
    require_once(NUKE_CLASSES_DIR.'class.rss.php');
    if ($rss = RSS::read($url)) {
        $items =& $rss['items'];
        $site_link =& $rss['link'];
        $content = '';
        for ($i=0,$j = count($items);$i  <$j;$i++) {
            $link = $items[$i]['link'];
            $title2 = $items[$i]['title'];
            $content .= "<strong><big>&middot;</big></strong> <a href=\"$link\" target=\"new\">$title2</a><br />\n";
        }
        if (!empty($site_link)) {
            $content .= "<br /><a href=\"$site_link\" target=\"_blank\"><strong>"._HREADMORE.'</strong></a>';
        }
        return $content;
    }
    return false;
}

function ultramode() {
    global $db, $prefix, $multilingual, $currentlang;
    $querylang = ($multilingual == 1) ? "AND (s.alanguage='".$currentlang."' OR s.alanguage='')" : "";
    $sql = "SELECT s.sid, s.catid, s.aid, s.title, s.time, s.hometext, s.comments, s.topic, s.ticon, t.topictext, t.topicimage FROM `".$prefix."_stories` s LEFT JOIN `".$prefix."_topics` t ON t.topicid = s.topic WHERE s.ihome = '0' ".$querylang." ORDER BY s.time DESC LIMIT 0,10";
    $result = $db->sql_query($sql);
    while ($row = $db->sql_fetchrow($result)) {
        $rsid = $row['sid'];
        $raid = $row['aid'];
        $rtitle = htmlspecialchars(stripslashes($row['title']));
        $rtime = $row['time'];
        $rcomments = $row['comments'];
        $topictext = $row['topictext'];
        $topicimage = ($row['ticon']) ? stripslashes($row['topicimage']) : '';
        $rtime = formatTimestamp($rtime, 'l, F d');
        $content .= "%%\n".$rtitle."\n/modules.php?name=News&file=article&sid=".$rsid."\n".$rtime."\n".$raid."\n".$topictext."\n".$rcomments."\n".$topicimage."\n";
    }
    $db->sql_freeresult($result);
    if (file_exists(NUKE_BASE_DIR."ultramode.txt") && is_writable(NUKE_BASE_DIR."ultramode.txt")) {
        $file = fopen(NUKE_BASE_DIR."ultramode.txt", "w");
        fwrite($file, "General purpose self-explanatory file with news headlines\n".$content);
        fclose($file);
    } else {
        global $debugger;
        $debugger->handle_error('Unable to write ultramode content to file', 'Error');
    }
}

// Adds slashes to string and strips PHP+HTML for SQL insertion and hack prevention
// $str: the string to modify
// $nohtml: strip PHP+HTML tags, false=no, true=yes, default=false
function Fix_Quotes( $str, $nohtml = false ) {
    global $db;

    if ( $nohtml ) {
        $str = strip_tags( $str );
    }

    return $str;
}

function Remove_Slashes($str) {
    global $_GETVAR;
    return $_GETVAR->stripSlashes($str);
}

// check_words function by ReOrGaNiSaTiOn
function check_words($message) {
    global $censor_words;
    if(empty($message)) {
        return '';
    }
    if(empty($censor_words)) {
        return $message;
    }
    $orig_word = array();
    $replacement_word = array();
    foreach( $censor_words as $word => $replacement ) {
        $orig_word[] = '#\b(' . str_replace('\*', '\w*?', preg_quote($word, '#')) . ')\b#i';
        $replacement_word[] = $replacement;
    }
    $return_message = @preg_replace($orig_word, $replacement_word, $message);
    return $return_message;
}

function check_html($str, $strip='') {
/*****[BEGIN]******************************************
 [ Base:    PHP Input Filter                   v1.2.2 ]
 ******************************************************/
    if(defined('INPUT_FILTER')) {
        if ($strip == 'nohtml') {
            global $AllowableHTML;
        }
        if (!is_array($AllowableHTML)) {
            $html = '';
        } else {
            $html = '';
            foreach($AllowableHTML as $type => $key) {
                 if($key == 1) {
                   $html[] = $type;
                 }
            }
        }
        $html_filter = new InputFilter($html, "", 0, 0, 1);
        $str = $html_filter->process($str);
    } else {
/*****[END]********************************************
 [ Base:    PHP Input Filter                   v1.2.2 ]
 ******************************************************/
        $str = Fix_Quotes($str, !empty($strip));
/*****[BEGIN]******************************************
 [ Base:    PHP Input Filter                   v1.2.2 ]
 ******************************************************/
    }
/*****[END]********************************************
 [ Base:    PHP Input Filter                   v1.2.2 ]
 ******************************************************/
    return $str;
}

function filter_text($Message, $strip='') {
    $Message = check_words($Message);
    $Message = check_html($Message, $strip);
    return $Message;
}

// actualTime function by ReOrGaNiSaTiOn
function actualTime() {
  $date = date('Y-m-d H:i:s');
  $actualTime_tempdate = formatTimestamp($date, $format='Y-m-d H:i:s');
  return $actualTime_tempdate;
}

// formatTimestamp function by ReOrGaNiSaTiOn
function formatTimestamp($time, $format='', $dateonly='') {
    global $datetime, $locale, $userinfo, $board_config;
    if (empty($format)) {
        if (isset($userinfo['user_dateformat']) && !empty($userinfo['user_dateformat'])) {
            $format = $userinfo['user_dateformat'];
        } else if (isset($board_config['default_dateformat']) && !empty($board_config['default_dateformat'])) {
            $format = $board_config['default_dateformat'];
        } else {
            $format = 'D M d, Y g:i a';
        }
    }
    if (!empty($dateonly)) {
        $replaces = array('a', 'A', 'B', 'c', 'D', 'g', 'G', 'h', 'H', 'i', 'I', 'O', 'r', 's', 'U', 'Z', ':');
        $format = str_replace($replaces, '', $format);
    }
    if ((isset($userinfo['user_timezone']) && !empty($userinfo['user_timezone'])) && $userinfo['user_id'] != 1) {
        $tz = $userinfo['user_timezone'];
    } else if (isset($board_config['board_timezone']) && !empty($board_config['board_timezone'])) {
        $tz = $board_config['board_timezone'];
    } else {
        $tz = '10';
    }
    setlocale(LC_TIME, $locale);
    if (!is_numeric($time)) {
        preg_match('/([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})/', $time, $datetime);
        $time = gmmktime($datetime[4],$datetime[5],$datetime[6],$datetime[2],$datetime[3],$datetime[1]);
    }
    $datetime = EvoDate($format, $time, $tz);
    return $datetime;
}

function get_microtime() {
    list($usec, $sec) = explode(' ', microtime());
    return ($usec + $sec);
}



function getTopics($s_sid) {
    global $topicname, $topicimage, $topictext, $db;
    $sid = intval($s_sid);
    $sql = 'SELECT t.`topicname`, t.`topicimage`, t.`topictext` FROM (`'._STORIES_TABLE.'` s LEFT JOIN `'._TOPICS_TABLE.'` t ON t.`topicid` = s.`topic`) WHERE s.`sid` = "'.$sid.'"';
    $result = $db->sql_query($sql);
    $row = $db->sql_fetchrow($result);
    $db->sql_freeresult($result);
    $topicname = $row['topicname'];
    $topicimage = $row['topicimage'];
    $topictext = stripslashes($row['topictext']);
}

/*****[BEGIN]******************************************
 [ Module:    Advertising                    v7.8.3.1 ]
 ******************************************************/
function ads($position) {
    global $prefix, $db, $sitename, $adminmail, $nukeurl, $banners;
    if(!$banners) { return ''; }
    $position = intval($position);
    $result = $db->sql_query("SELECT * FROM `".$prefix."_banner` WHERE `position`='$position' AND `active`='1' ORDER BY RAND() LIMIT 0,1");
    $numrows = $db->sql_numrows($result);
    if ($numrows < 1) return '';
    $row = $db->sql_fetchrow($result);
    $db->sql_freeresult($result);
    foreach($row as $var => $value) {
        if (isset($$var)) unset($$var);
        $$var = $value;
    }
    $bid = intval($bid);
    if(!is_admin()) {
        $db->sql_query("UPDATE `".$prefix."_banner` SET `impmade`=" . $impmade . "+1 WHERE `bid`='$bid'");
    }
    $sql2 = "SELECT `cid`, `imptotal`, `impmade`, `clicks`, `date`, `ad_class`, `ad_code`, `ad_width`, `ad_height` FROM `".$prefix."_banner` WHERE `bid`='$bid'";
    $result2 = $db->sql_query($sql2);
    list($cid, $imptotal, $impmade, $clicks, $date, $ad_class, $ad_code, $ad_width, $ad_height) = $db->sql_fetchrow($result2);
    $db->sql_freeresult($result2);
    $cid = intval($cid);
    $imptotal = intval($imptotal);
    $impmade = intval($impmade);
    $clicks = intval($clicks);
    /* Check if this impression is the last one and print the banner */
    if (($imptotal <= $impmade) && ($imptotal != 0)) {
        $db->sql_query("UPDATE `".$prefix."_banner` SET `active`='0' WHERE `bid`='$bid'");
        $sql3 = "SELECT `name`, `contact`, `email` FROM `".$prefix."_banner_clients` WHERE `cid`='$cid'";
        $result3 = $db->sql_query($sql3);
        list($c_name, $c_contact, $c_email) = $db->sql_fetchrow($result3);
        $db->sql_freeresult($result3);
        if (!empty($c_email)) {
            $from = $sitename.' <'.$adminmail.'>';
            $to = $c_contact.' <'.$c_email.'>';
            $message = _HELLO." $c_contact:\n\n";
            $message .= _THISISAUTOMATED."\n\n";
            $message .= _THERESULTS."\n\n";
            $message .= _TOTALIMPRESSIONS." $imptotal\n";
            $message .= _CLICKSRECEIVED." $clicks\n";
            $message .= _IMAGEURL." $imageurl\n";
            $message .= _CLICKURL." $clickurl\n";
            $message .= _ALTERNATETEXT." $alttext\n\n";
            $message .= _HOPEYOULIKED."\n\n";
            $message .= _THANKSUPPORT."\n\n";
            $message .= "- $sitename "._TEAM."\n";
            $message .= $nukeurl;
            $subject = $sitename.': '._BANNERSFINNISHED;
            $mailcommand = evo_mail($to, $subject, $message, "From: $from\nX-Mailer: PHP/" . PHPVERS);
            $mailcommand = removecrlf($mailcommand);
        }
    }
    if ($ad_class == "code") {
        $ad_code = stripslashes($ad_code);
        $ads = "<center>$ad_code</center>";
    } elseif ($ad_class == "flash") {
        $ads = "<center>"
              ."<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0\" width=\"".$ad_width."\" height=\"".$ad_height."\" id=\"$bid\">"
              ."<param name=\"movie\" value=\"".$imageurl."\" />"
              ."<param name=\"quality\" value=\"high\" />"
              ."<embed src=\"".$imageurl."\" quality=\"high\" width=\"".$ad_width."\" height=\"".$ad_height."\" name=\"".$bid."\" align=\"\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\"></embed></object>"
              ."</center>";
    } else {
        $ads = "<center><a href=\"index.php?op=ad_click&amp;bid=$bid\" target=\"_blank\"><img src=\"$imageurl\" border=\"0\" alt=\"$alttext\" title=\"$alttext\"></a></center>";
    }
    return $ads;
}

/**
 * Enqueue a script.
 *
 * @since 2.0.10
 *
 * @param string           $handle    Name of the script. Should be unique.
 * @param string           $src       Full URL of the script, or path of the script relative to the WordPress root directory.
 *                                    Default empty.
 * @param string|bool|null $ver       Optional. String specifying script version number, if it has one, which is added to the URL
 *                                    as a query string for cache busting purposes. If version is set to false, a version
 *                                    number is automatically added equal to current installed WordPress version.
 *                                    If set to null, no version is added.
 * @param bool             $in_footer Optional. Whether to enqueue the script before `</body>` instead of in the `<head>`.
 *                                    Default 'false'.
 */
function evo_include_script( $handle, $src = '', $ver = false, $in_footer = false ) {
	global $_headJS, $_bodyJS;
	if ( $src || $in_footer ) {

		$_handle = explode( '?', $handle );
		$script  = array( $_handle[0], $src, $ver );

		if ( ( is_array( $_bodyJS ) && count( $_bodyJS ) > 0) && ( in_array( $script, $_bodyJS ) ) ) :
			return;
		endif;

		if ( $src && $in_footer === false ) {
			$_headJS[] = $script;
		}

		if ( $src && $in_footer === true ) {
			$_bodyJS[] = $script;
		}
	}
}

/**
 * Adds extra code to a script.
 *
 * @since 2.0.10
 *
 * @param string $handle   Name of the script to add the inline script to.
 * @param string $data     String containing the JavaScript to be added.
 * @param string $position Optional. Whether to add the inline script before the handle
 *                         or after. Default 'after'.
 * @return array
 */
function evo_add_inline_script( $handle, $data, $in_footer = false ) {
	global $_headJS, $_bodyJS;

	if ( ! $data ) {
		return false;
	}

	$data = trim( preg_replace( '#<script[^>]*>(.*)</script>#is', '$1', $data ) );

	if ( $in_footer === false ) {
		$_headJS[] = array( $handle, $data, 'inline' );
	}

	if ( $in_footer === true ) {
		$_bodyJS[] = array( $handle, $data, 'inline' );
	}
}

/**
 * Enqueue a CSS stylesheet.
 *
 * @since 2.0.10
 *
 * @param string           $handle Name of the stylesheet. Should be unique.
 * @param string           $src    Full URL of the stylesheet, or path of the stylesheet relative to the WordPress root directory.
 *                                 Default empty.
 * @param string[]         $deps   Optional. An array of registered stylesheet handles this stylesheet depends on. Default empty array.
 * @param string|bool|null $ver    Optional. String specifying stylesheet version number, if it has one, which is added to the URL
 *                                 as a query string for cache busting purposes. If version is set to false, a version
 *                                 number is automatically added equal to current installed WordPress version.
 *                                 If set to null, no version is added.
 * @param string           $media  Optional. The media for which this stylesheet has been defined.
 *                                 Default 'all'. Accepts media types like 'all', 'print' and 'screen', or media queries like
 *                                 '(orientation: portrait)' and '(max-width: 640px)'.
 */
function evo_include_style( $handle, $src = '', $ver = false, $media = 'all' ) {
	global $_headCSS;

	if ( $src ) {
		$_handle = explode( '?', $handle );
		$script  = array( $_handle[0], $src, $ver, $media );

		if ( ( is_array( $_headCSS ) && count( $_headCSS ) > 0 ) && ( in_array( $script, $_headCSS ) ) ) :
			return;
		endif;

		$_headCSS[] = $script;
	}
}

/**
 * Add extra CSS styles to a stylesheet.
 *
 * @since 2.0.10
 *
 * @param string $handle Name of the stylesheet to add the extra styles to.
 * @param string $data   String containing the CSS styles to be added.
 * @return array
 */
function evo_add_inline_style( $handle, $data ) {
	global $_headCSS;

	if ( $data ) {
		$data       = trim( preg_replace( '#<style[^>]*>(.*)</style>#is', '$1', $data ) );
		$_headCSS[] = array( $handle, $data, 'inline' );
	}
}

function writeHEAD() {
	global $_headCSS, $_headJS;
	if ( is_array( $_headCSS ) && count( $_headCSS ) > 0)  {
		foreach( $_headCSS as $i => $css ) {
			if ( $css[ 2 ] !== 'inline' ) {
				if ( $css[ 2 ] === false ) :
					echo "<link id='" . $css[ 0 ] . "-css' rel='stylesheet' href='" . $css[ 1 ] . "' media='" . $css[ 3 ] . "'>\n";
				else:
					echo "<link id='" . $css[ 0 ] . "-css' rel='stylesheet' href='" . $css[ 1 ] . "?ver=" . $css[ 2 ] . "' media='" . $css[ 3 ] . "'>\n";
				endif;
			} else {
				echo '<style id="' . $css[ 0 ] . '">';
				echo $css[ 1 ];
				echo '</style>';
			}
		}
	}

	if ( is_array( $_headJS ) && count( $_headJS ) > 0)  {
		foreach( $_headJS as $i => $js ) {
			if ( $js[ 2 ] !== 'inline' ) {
				if ( $js[ 2 ] === false ) :
					echo "<script id='" . $js[ 0 ] . "-js' src='" . $js[ 1 ] . "'></script>\n";
				else:
					echo "<script id='" . $js[ 0 ] . "-js' src='" . $js[ 1 ] . "?ver=" . $js[ 2 ] . "'></script>\n";
				endif;
			} else {
				echo "<script id='" . $js[ 0 ] . "-js'>\n";
				echo $js[ 1 ];
				echo "</script>\n";
			}
		}
	}
}

function writeBODYJS() {
	global $_bodyJS;
	if ( is_array( $_bodyJS ) && count( $_bodyJS ) > 0)  {
		foreach( $_bodyJS as $i => $js ) {
			if ( $js[ 2 ] !== 'inline' ) {
				if ( $js[ 2 ] === false ) :
					echo "<script id='" . $js[ 0 ] . "-js' src='" . $js[ 1 ] . "'></script>\n";
				else:
					echo "<script id='" . $js[ 0 ] . "-js' src='" . $js[ 1 ] . "?ver=" . $js[ 2 ] . "'></script>\n";
				endif;
			} else {
				echo "<script id='" . $js[ 0 ] . "-js'>\n";
				echo $js[ 1 ];
				echo "</script>\n";
			}
		}
	}
}

/*****[BEGIN]******************************************
 [ Base:    Theme Management                   v1.0.2 ]
 [ Base:    Evolution Functions                v1.5.0 ]
 ******************************************************/
function get_theme() {
    static $ThemeSel;
    if (isset($ThemeSel)) return $ThemeSel;
    global $Default_Theme, $cookie;

    #Quick Theme Change - Theme Management (JeFFb68CAM)
    if(isset($_REQUEST['chngtheme']) && is_user()) {
        ChangeTheme($_REQUEST['theme'], $cookie[0]);
    }

    #Theme Preview Mod - Theme Management (JeFFb68CAM)
    if(isset($_REQUEST['tpreview']) && ThemeAllowed($_REQUEST['tpreview'])) {
        $ThemeSel = $_REQUEST['tpreview'];
        if(!is_user()) {
            setcookie('guest_theme', $ThemeSel, time()+84600);
        }
        return $ThemeSel;
    }

    #Theme Preview for guests Mod - Theme Management (JeFFb68CAM)
    if (isset($_COOKIE['guest_theme']) && !is_user()) {
        return (ThemeAllowed($_COOKIE['guest_theme']) ? $_COOKIE['guest_theme'] : $Default_Theme);
    }

    #New feature to grab a backup theme if the one we are trying to use does not exist, no more missing theme errors :)
    $ThemeSel = (ThemeAllowed($nTheme = (isset($cookie[9]) ? $cookie[9] : $Default_Theme))) ? $nTheme : ThemeBackup($nTheme);

    return $ThemeSel;
}
/*****[END]********************************************
 [ Base:    Theme Management                   v1.0.2 ]
 [ Base:    Evolution Functions                v1.5.0 ]
 ******************************************************/

// Function to translate Datestrings
function translate($phrase) {
    switch($phrase) {
        case'xdatestring': $tmp='%A, %B %d @ %T %Z'; break;
        case'linksdatestring': $tmp='%d-%b-%Y'; break;
        case'xdatestring2': $tmp='%A, %B %d'; break;
        default: $tmp=$phrase; break;
    }
    return $tmp;
}

function removecrlf($str) {
    return strtr($str, '\015\012', ' ');
}

function validate_mail($email) {
    if(strlen($email) < 7 || !preg_match('/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/', $email)) {
        DisplayError(_ERRORINVEMAIL);
        return false;
    } else {
        return $email;
    }
}

function encode_mail($email) {
    $finished = '';
    for($i=0, $j = strlen($email); $i<$j; ++$i) {
        $n = mt_rand(0, 1);
        $finished .= ($n) ? '&#x'.sprintf('%X',ord($email[$i])).';' : '&#'.ord($email[$i]).';';
    }
    return $finished;
}



function GroupColor($group_name, $short=0) {
    global $db, $use_colors, $cache;
    static $cached_groups;
    if(!$use_colors) return $group_name;
    $plaingroupname = ( $short !=0 ) ? $group_name.'_short' : $group_name;
    if (!empty($cached_groups[$plaingroupname])) {
        return $cached_groups[$plaingroupname];
    }
    if ((($cached_groups = $cache->load('GroupColors', 'config')) === false) || empty($cached_groups)) {
        $cached_groups = array();
        $sql = 'SELECT `auc`.`group_color` as `group_color`, `gr`.`group_name` as`group_name` FROM ( `'.GROUPS_TABLE.'` `gr` LEFT JOIN  `' . AUC_TABLE . '` `auc` ON `gr`.`group_color` =  `auc`.`group_id`) WHERE `gr`.`group_description` <> "Personal User" ORDER BY `gr`.`group_name` ASC';
        $result = $db->sql_query($sql);
        while (list($group_color, $groupcolor_name) = $db->sql_fetchrow($result)) {
            $colorgroup_short = (strlen($groupcolor_name) > 13) ? substr($groupcolor_name,0,10).'...' : $groupcolor_name;
            $colorgroup_name  = $groupcolor_name;
            $cached_groups[$groupcolor_name.'_short'] = (strlen($group_color) == 6) ? '<span style="color: #'. $group_color .'"><strong>'. $colorgroup_short .'</strong></span>' : $colorgroup_short;
            $cached_groups[$groupcolor_name] = (strlen($group_color) == 6) ? '<span style="color: #'. $group_color .'"><strong>'. $colorgroup_name .'</strong></span>' : $colorgroup_name;
        }
        $db->sql_freeresult($result);
        $cache->save('GroupColors', 'config', $cached_groups);
    }
    if (!empty($cached_groups[$plaingroupname])) {
        return $cached_groups[$plaingroupname];
    } else {
        return $plaingroupname;
    }
}

include_once NUKE_INCLUDE_DIR . 'nbbcode.php';

referer();

function block_vpn_proxy_user() {
    if (get_evo_option( 'iphub_status', 'int' ) == 1 ) {
        include_once NUKE_INCLUDE_DIR . 'iphub.novpn.php';
    }
}
