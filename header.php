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
	echo '<!DOCTYPE html>';
	echo '<html lang="' . _LANGCODE . '">'."\n";
	echo '<head>'."\n";

	# function to grab the page title.
	the_pagetitle();

	require NUKE_INCLUDE_DIR . 'meta.php';
	require NUKE_INCLUDE_DIR . 'styles.php';
	require NUKE_INCLUDE_DIR . 'javascript.php';
	require NUKE_THEMES_DIR . trailingslashit( $ThemeSel ) . 'theme.php';

	writeHEAD();

	echo '</head>'."\n";
	themeheader();

	if ( $ab_config['site_switch'] == 1 ) {
		echo '<center><img src="modules/NukeSentinel/images/disabled.png" alt="' . _AB_SITEDISABLED . '" title="' . _AB_SITEDISABLED . '" /></center>';
	}
}

function online() {
	global $prefix, $db, $name, $board_config, $userinfo;

	$ip           = get_user_IP();
	$url          = ( defined( 'ADMIN_FILE' ) ) ? 'index.php' : Fix_Quotes( $_SERVER['REQUEST_URI'] );
	$uname        = $ip;
	$guest        = 1;
	$user_agent   = get_user_agent();
	$is_mobile    = (int) evo_is_mobile();

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
	 * @since 2.0.9e
	 */
	dbquery( "REPLACE INTO `"._SESSION_TABLE."` VALUES ('" . $uname . "', '" . $ctime . "', '" . $ctime . "', '" . $ip . "', '" . $guest . "', '" . $custom_title . "', '" . $url . "', '" . $is_mobile . "')");

	/**
	 * This sql replace command is to track who has been to the site and records their last visit.
	 *
	 * @since 2.0.9e
	 */
	if ( $guest == 0 ) {
		// Moved from includes/sessions.php to be a little more precise.
		dbquery( "UPDATE " . USERS_TABLE . " SET user_lastvisit = " . $ctime . " WHERE user_id = '" . $userinfo['user_id'] . "'" );
		dbquery( "REPLACE INTO " . _USERS_WHO_BEEN . " (`user_ID`, `username`, `last_visit`) VALUES ('" . $userinfo['user_id'] . "', '" . $userinfo['username'] . "', " . time() . ")" );
	}
}

online();
head();

if ( ! defined( 'ADMIN_FILE' ) ) {
	include_once NUKE_INCLUDE_DIR . 'counter.php';

	if ( defined( 'HOME_FILE' ) ) {
		include_once NUKE_INCLUDE_DIR . 'messagebox.php';
		blocks( 'Center' );
		// If you want either of the following on all pages simply, move the include to before if (defined('HOME_FILE'))
		include NUKE_INCLUDE_DIR . 'cblocks1.php';
		include NUKE_INCLUDE_DIR . 'cblocks2.php';
	}
}
