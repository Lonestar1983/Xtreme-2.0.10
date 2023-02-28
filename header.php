<?php
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

if ( ! defined( 'HEADER' ) ) {
	define( 'HEADER', true );
} else {
	return;
}

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

require_once __DIR__ . '/mainfile.php';
// $add_count = array();

function head() {
	global $sitename, $ab_config, $modheader, $cache;

	$ThemeSel = get_theme();
	// echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">'."\n";
	echo '<!DOCTYPE html>';
	echo '<html lang="' . _LANGCODE . '" dir="' . _LANG_DIRECTION . '">'."\n";
	echo '<head>'."\n";

	# function to grab the page title.
	the_pagetitle();

	require NUKE_INCLUDE_DIR . 'meta.php';
	require NUKE_INCLUDE_DIR . 'styles.php';
	require NUKE_INCLUDE_DIR . 'javascript.php';
	require NUKE_THEMES_DIR . trailingslashit( $ThemeSel ) . 'theme.php';

	// if ((($favicon = $cache->load('favicon', 'config')) === false) || empty($favicon)) {
	// 	if (file_exists(NUKE_BASE_DIR.'favicon.ico')) {
	// 		$favicon = "favicon.ico";
	// 	} else if (file_exists(NUKE_IMAGES_DIR.'favicon.ico')) {
	// 		$favicon = "images/favicon.ico";
	// 	} else if (file_exists(NUKE_THEMES_DIR.$ThemeSel.'/images/favicon.ico')) {
	// 		$favicon = "themes/$ThemeSel/images/favicon.ico";
	// 	} else {
	// 		$favicon = 'none';
	// 	}
	// 	if ($favicon != 'none') {
	// 		echo "<link rel=\"shortcut icon\" href=\"$favicon\" type=\"image/x-icon\" />\n";
	// 	}
	// 	$cache->save('favicon', 'config', $favicon);
	// } else {
	// 	if ($favicon != 'none') {
	// 		echo "<link rel=\"shortcut icon\" href=\"$favicon\" type=\"image/x-icon\" />\n";
	// 	}
	// }

	writeHEAD();

	// if ((($custom_head = $cache->load('custom_head', 'config')) === false) || empty($custom_head)) {
	// 	$custom_head = array();
	// 	if (file_exists(NUKE_INCLUDE_DIR.'custom_files/custom_head.php')) {
	// 		$custom_head[] = 'custom_head';
	// 	}
	// 	if (file_exists(NUKE_INCLUDE_DIR.'custom_files/custom_header.php')) {
	// 		$custom_head[] = 'custom_header';
	// 	}
	// 	if (!empty($custom_head)) {
	// 		foreach ($custom_head as $file) {
	// 			include_once(NUKE_INCLUDE_DIR.'custom_files/'.$file.'.php');
	// 		}
	// 	}
	// 	$cache->save('custom_head', 'config', $custom_head);
	// } else {
	// 	if (!empty($custom_head)) {
	// 		foreach ($custom_head as $file) {
	// 			include_once(NUKE_INCLUDE_DIR.'custom_files/'.$file.'.php');
	// 		}
	// 	}
	// }

	echo '</head>'."\n";
	themeheader();

	if ( $ab_config['site_switch'] == 1 ) {
		echo '<center><img src="modules/NukeSentinel/images/disabled.png" alt="' . _AB_SITEDISABLED . '" title="' . _AB_SITEDISABLED . '" /></center>';
	}
}

function online() {
	global $prefix, $db, $name, $board_config, $userinfo;

	$ip         = get_user_IP();
	$url        = ( defined( 'ADMIN_FILE' ) ) ? 'index.php' : Fix_Quotes( $_SERVER['REQUEST_URI'] );
	$uname      = $ip;
	$guest      = 1;
	$user_agent = get_user_agent();
	$is_mobile  = (int) evo_is_mobile();

	if ( is_user() ) {
		$uname = $userinfo['username'];
		$guest = 0;
	} elseif ( $user_agent['engine'] == 'bot' ) {
		$uname = $user_agent['bot'];
		$guest = 3;
	}

	$custom_title = $name;
	$url          = str_replace( "&amp;", "&", $url );
	$url          = addslashes( $url );
	$ctime        = time();
	$past         = time() - $board_config['online_time'];
	dbquery( "DELETE FROM " . _SESSION_TABLE . " WHERE time < '" . $past . "'" );

	/**
	 * A replace into sql command was added, to prevent the duplication of users, This also saves on several lines of code.
	 *
	 * @since 2.0.9E
	 */
	dbquery( "REPLACE INTO `"._SESSION_TABLE."` VALUES ('" . $uname . "', '" . $ctime . "', '" . $ctime . "', '" . $ip . "', '" . $guest . "', '" . $custom_title . "', '" . $url . "', '" . $is_mobile . "')");

	/**
	 * This sql replace command is to track who has been to the site and records their last visit.
	 *
	 * @since 2.0.9E
	 */
	if ( $guest == 0 ) {
		dbquery("REPLACE INTO " . _USERS_WHO_BEEN . " (`user_ID`, `username`, `last_visit`) VALUES ('" . $userinfo['user_id'] . "', '" . $userinfo['username'] . "', " . time() . ")" );
	}
}

online();
head();

if (!defined('ADMIN_FILE')):

	include_once(NUKE_INCLUDE_DIR.'counter.php');

	if (defined('HOME_FILE')):

		include_once(NUKE_INCLUDE_DIR.'messagebox.php');
		blocks('Center');
		// If you want either of the following on all pages simply, move the include to before if (defined('HOME_FILE'))
		include(NUKE_INCLUDE_DIR.'cblocks1.php');
		include(NUKE_INCLUDE_DIR.'cblocks2.php');
	
	endif;

endif;

?>