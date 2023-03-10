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
/*                                                                      */
/************************************************************************/

/*****[CHANGES]**********************************************************
-=[Base]=-
	  Nuke Patched                             v3.1.0       06/26/2005
	  NukeSentinel                             v2.5.00      07/11/2006
	  Caching System                           v1.0.0       10/31/2005
	  Module Simplifications                   v1.0.0       11/17/2005
	  Evolution Functions                      v1.5.0       12/14/2005
-=[Other]=-
	  Admin Field Size                         v1.0.0       06/02/2005
	  Need To Delete                           v1.0.0       06/03/2005
	  Date Fix                                 v1.0.0       06/20/2005
-=[Mod]=-
	  Admin Icon/Link Pos                      v1.0.0       06/02/2005
	  Admin Tracker                            v1.0.1       06/08/2005
	  Advanced Username Color                  v1.0.6       06/13/2005
	  CNBYA Modifications                      v1.0.0       07/05/2005
	  Password Strength Meter                  v1.0.0       07/12/2005
	  Auto Admin Protector                     v2.0.0       08/18/2005
	  Admin IP Lock                            v2.1.0       11/18/2005
	  Evolution Version Checker                v1.1.0       08/21/2005
	  Auto Admin Login                         v2.0.1       08/27/2005
	  Auto First User Login                    v1.0.0       08/27/2005
	  Persistent Admin Login                   v2.0.0       12/10/2005
	  External Admin Index                     v1.0.0       08/27/2005
	  External Admin Functions                 v1.0.0       12/14/2005
 ************************************************************************/

define( 'ADMIN_FILE', true );
define( 'VALIDATE', true );

// require_once dirname( __FILE__ ) . '/mainfile.php';
require_once __DIR__ . DIRECTORY_SEPARATOR . 'mainfile.php';
require_once NUKE_ADMIN_DIR . 'functions.php';

global $sitename, $currentlang, $domain, $admin_file, $identify;

$op = get_query_var( 'op', 'request', 'string' );

// if(isset($aid) && ($aid) && (!isset($admin) || empty($admin)) && $op != 'login'){
if ( $op != 'login' && ( ( isset( $aid ) && ( $aid ) ) && ( ! isset( $admin ) || empty( $admin ) ) ) ) {
	unset($aid, $admin);
	die( 'Access Denied' );
}

include NUKE_BASE_DIR . 'ips.php';

if ( isset( $ips ) && is_array( $ips ) ) {
	$ip_check = implode( '|^', $ips );

	if ( ! preg_match( "/^" . $ip_check . "/", $identify->get_ip() ) ) {
		unset( $aid );
		unset( $admin );

		global $cookie;
		$name = ( isset( $cookie[1] ) && ! empty( $cookie[1] ) ) ? $cookie[1] : _ANONYMOUS;

		log_write(
			'admin',
			$name . ' used invalid IP address attempted to access the admin area',
			'Security Breach'
		);

		die( 'Invalid IP<br />Access denied' );
	}
	define( 'ADMIN_IP_LOCK', true );
}

need_delete( 'install.php' );
need_delete( 'upgrade.php' );
need_delete( 'install', true );

if ( isset( $aid ) && ( preg_match( "/[^a-zA-Z0-9_-]/", trim( $aid ) ) ) ) {
	die( 'Begone' );
}

if ( isset( $aid ) ) {
	$aid = substr( $aid, 0, 25 );
}

if ( isset( $pwd ) ) {
	$pwd = substr( $pwd, 0, 40 );
}

if ( ( isset( $aid ) ) && ( isset( $pwd ) ) && ( isset( $op ) ) && ( $op == "login" ) ) {
	$gfxchk = array( 1, 5, 6, 7 );

	if ( ! security_code_check( $_POST['g-recaptcha-response'], $gfxchk ) ) {
		redirect( $admin_file . '.php' );
	}

	if ( ! empty( $aid ) AND ! empty( $pwd ) ) {
		$txt_pwd     = $pwd;
		$evo_crypt   = EvoCrypt( $pwd );
		$pwd         = md5( $pwd );
		$admlanguage = addslashes( get_admin_field( 'admlanguage', $aid ) );
		$rpwd        = get_admin_field( 'pwd', $aid );

		// Un-evocrypt
		if ( $evo_crypt == $rpwd ) {
			$db->sql_query( "UPDATE " . $prefix . "_authors SET pwd = '" . $pwd . "' WHERE aid = '" . $aid . "'" );
			$rpwd = get_admin_field( 'pwd', $aid );
		}

		if ( $rpwd == $pwd && ! empty( $rpwd ) ) {
			$persistent = intval( $persistent );
			$superadmin = get_admin_field( 'radminsuper', $aid );
			$admin      = base64_encode( "$aid:$pwd:$admlanguage:$persistent" );
			$time       = ( intval( $admin1[3] ) ) ? 43200 : 60;

			setcookie(
				'admin',
				$admin,
				array(
					'expires'  => time() + ( $time * 60 ),
					'path'     => trailingslashit( get_board_option( 'cookie_path' ) ),
					'domain'   => untrailingslashit( get_board_option( 'cookie_domain' ) ),
					'secure'   => is_ssl() ?: false,
					'httponly' => true,
					'samesite' => is_ssl() ? 'None' : 'Strict'
				)
			);

			unset( $op );
			unset( $txt_pwd );
			redirect( $_SERVER['REQUEST_URI'] );
		} else {
			log_write(
				'admin',
				'Attempted to login with "' . $aid . '"/"' . $txt_pwd . '" but failed',
				'Security Breach'
			);

			unset( $txt_pwd );

			global $admin_fc_status, $admin_fc_attempts, $admin_fc_timeout;
			if ( get_evo_option( 'admin_fc_status' ) == 1 ) {
				$ip     = get_user_IP();
				$fcdate = date( 'mdYHi' );
				$fc     = dburow( "SELECT * FROM `" . _FAILED_LOGIN_INFO_TABLE . "` WHERE fc_ip = '$ip'" );

				if ( empty( $fc ) ) {
					dbquery( "INSERT INTO `" . _FAILED_LOGIN_INFO_TABLE . "` VALUES ('$fcdate', '$ip', '1')" );
				} else {
					$fc_tries = $fc['fc_attempts'] + 1;
					dbquery( "UPDATE `" . _FAILED_LOGIN_INFO_TABLE . "` SET `fc_datetime` = '$fcdate', `fc_ip` = '$ip', `fc_attempts` = '$fc_tries' WHERE fc_ip = '$ip'" );
				}
			}
		}
	} else {
		if ( empty( $aid ) AND empty( $pwd ) ) {
			log_write(
				'admin',
				'Attempted to login to the admin area with no username and password',
				'Security Breach'
			);
		} elseif ( empty( $aid ) ) {
			log_write(
				'admin',
				'Attempted to login to the admin area with no username',
				'Security Breach'
			);
		} elseif ( empty( $pwd ) ) {
			log_write(
				'admin',
				'Attempted to login to the admin area with no password',
				'Security Breach'
			);
		}
	}
}

$admintest = false;

if ( isset( $admin ) && ! empty( $admin ) && ( ! isset( $admin1 ) || ! is_array( $admin1 ) ) ) {
	$admin1      = base64_decode( $admin );
	$admin1      = explode( ':', $admin1 );
	$aid         = addslashes( $admin1[0] );
	$pwd         = $admin1[1];
	$admlanguage = ( isset( $admin1[2] ) ) ? $admin1[2] : 'english';

	if ( empty( $aid ) OR empty( $pwd ) ) {
		$admintest = false;
		log_write( 'admin', 'Caused an Intruder Alert', 'Security Breach' );
		die( 'Illegal Operation' );
	}

	$aid = substr( $aid, 0,25 );

	if ( ! ( $admdata = get_admin_field( '*', $aid ) ) ){
		die( 'Selection from database failed!' );
	} else {
		if ( $admdata['pwd'] == $pwd && ! empty( $admdata['pwd'] ) ) {
			$admintest = true;
			$time      = ( intval( $admin1[3] ) ) ? 43200 : 60;

			if ( ! isset( $op ) || $op != 'logout' ) {
				setcookie(
					'admin',
					$admin,
					array(
						'expires'  => time() + ( $time * 60 ),
						'path'     => trailingslashit( get_board_option( 'cookie_path' ) ),
						'domain'   => untrailingslashit( get_board_option( 'cookie_domain' ) ),
						'secure'   => is_ssl() ?: false,
						'httponly' => true,
						'samesite' => is_ssl() ? 'None' : 'Strict'
					)
				);
			}
		} else {
			$admdata = array();
			log_write(
				'admin',
				'Attempted to login with "' . $aid . '" but failed',
				'Security Breach'
			);
		}
	}

	unset( $admin1 );
}

if ( $admintest ) {
	$admincookie = explode( ':', base64_decode( $admin ) );
	$aid         = substr( $admincookie[0], 0,25 );
} else {
	$admintest = false;
}

// Force Cookie Reset
if ( ! isset( $admincookie[4] ) && $admintest ) {
	$cookieData = base64_encode( "$admincookie[0]:$admincookie[1]:$admincookie[2]:$admincookie[3]:old" );
	setcookie(
		'admin',
		$cookieData,
		array(
			'expires'  => time() + 2592000,
			'path'     => trailingslashit( get_board_option( 'cookie_path' ) ),
			'domain'   => untrailingslashit( get_board_option( 'cookie_domain' ) ),
			'secure'   => is_ssl() ?: false,
			'httponly' => true,
			'samesite' => is_ssl() ? 'None' : 'Strict'
		)
	);

	redirect( $admin_file . '.php' );
	exit;
}

if (!isset($op)){
	$op = 'adminMain';
} elseif (($op == 'mod_authors' || $op == 'modifyadmin' || $op == 'UpdateAuthor' || $op == 'AddAuthor' || $op == 'deladmin2' || $op == 'deladmin' || $op == 'assignstories' || $op == 'deladminconf') && $admdata['name'] != 'God'){
	die('Illegal Operation');
}

if ($admintest){
	if (!$admin) exit('Illegal Operation');
	switch($op){
		case "do_gfx":
			do_gfx();
			break;
		case "deleteNotice":
			deleteNotice($id);
			break;
		case "GraphicAdmin":
			if ( defined('BOOTSTRAP') ):
				administration_panel();
			else:
				GraphicAdmin();
			endif;
			break;
		case "adminMain":
			include_once NUKE_ADMIN_MODULE_DIR . 'index.php';
			adminMain();
			break;
		case "logout":
			setcookie(
				'admin',
				'',
				array(
					'expires'  => time() - 3600,
					'path'     => trailingslashit( get_board_option( 'cookie_path' ) ),
					'domain'   => untrailingslashit( get_board_option( 'cookie_domain' ) ),
					'secure'   => is_ssl() ?: false,
					'httponly' => true,
					'samesite' => is_ssl() ? 'None' : 'Strict'
				)
			);

			unset( $admin );
			header( "Refresh: 3; url=" . $admin_file . ".php" );
			DisplayError( "<span class=\"title\"><strong>" . $admlang['logged_out'] . "</strong></span>", true );
			break;
		case "login";
			unset( $op );
		default:
			if ( ! is_admin() ) {
				login();
			}

			define( 'ADMIN_POS', true );
			define( 'ADMIN_PROTECTION', true );
			$casedir = opendir( NUKE_ADMIN_DIR . 'case' );
			while( false !== ( $func = readdir( $casedir ) ) ) {
				if ( substr( $func, 0, 5 ) == "case." ) {
					include NUKE_ADMIN_DIR.'case/' . $func;
				}
			}
			closedir( $casedir );

			$result = $db->sql_query("SELECT title FROM ".$prefix."_modules ORDER BY title ASC");
			while(list($mod_title) = $db->sql_fetchrow($result)){
				if (is_mod_admin($mod_title) && (file_exists(NUKE_MODULES_DIR.$mod_title.'/admin/index.php') AND file_exists(NUKE_MODULES_DIR.$mod_title.'/admin/links.php') AND file_exists(NUKE_MODULES_DIR.$mod_title.'/admin/case.php'))){
					 include(NUKE_MODULES_DIR.$mod_title.'/admin/case.php');
				}
			}
			$db->sql_freeresult($result);

			/**
			 * Themes administration
			 */
			$result = $db->sql_query("SELECT theme_name FROM ".$prefix."_themes ORDER BY theme_name ASC");
			while(list($themes_name) = $db->sql_fetchrow($result)){
				if (is_mod_admin($themes_name) && (file_exists(NUKE_THEMES_DIR.$themes_name.'/admin/index.php') AND file_exists(NUKE_THEMES_DIR.$themes_name.'/admin/links.php') AND file_exists(NUKE_THEMES_DIR.$themes_name.'/admin/case.php'))){
					 include(NUKE_THEMES_DIR.$themes_name.'/admin/case.php');
				}
			}
			$db->sql_freeresult($result);
			break;
	}
} else {
	switch($op) {
		default:
			login();
			break;
	}
}
