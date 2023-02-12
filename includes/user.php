<?php
/**
 * Core User
 *
 * @package EvolutionXtreme
 * @subpackage Users
 */

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

/**
 * Determines whether the current user is logged in.
 *
 * Does not check if the user is an administrator; use is_admin()
 *
 * @since 1.0.5
 *
 * @return bool True, If current user is logged in, False otherwise.
 */
function is_user() {
	static $userstatus;

	if ( isset( $userstatus ) ) {
		return $userstatus;
	}

	$usercookie = isset( $_COOKIE['user'] ) ? $_COOKIE['user'] : false;

	if ( ! $usercookie ) {
		return $userstatus = false;
	}

	$usercookie = ( ! is_array( $usercookie ) ) ? explode( ':', base64_decode( $usercookie ) ) : $usercookie;
	$uid        = $usercookie[0];
	$pwd        = $usercookie[2];
	$uid        = (int) $uid;

	if ( ! empty( $uid ) AND ! empty( $pwd ) ) {
		$user_password = get_user_field( 'user_password', $uid );
		if ( $user_password == $pwd && ! empty( $user_password ) ) {
			return $userstatus = true;
		}
	}

	return $userstatus = false;
}

/**
 * Determines whether the current request is for an administrative interface page.
 *
 * Does not check if the user is an administrator; use is_user()
 *
 * @since 1.0.5
 *
 * @return string Blog Author username.
 */
function get_author( $aid ) {
	// static $users;

	// if ( is_array( $users[ $aid ] ) ) {
	// 	$row = $users[ $aid ];
	// } else {
	// 	$row           = get_admin_field( '*', $aid );
	// 	$users[ $aid ] = $row;
	// }
	// $result = dbquery( "SELECT user_id from " . USERS_TABLE . " WHERE username = '" . $aid . "'" );
	// $userid = dbrow( $result );
	// dbfree( $result );

	// if ( isset( $userid[0] ) ) {
	// 	$aid = '<a href="' . ACCOUNT_PROFILE_URL . $userid[0] . '">' . UsernameColor( $aid ) . '</a>';
	// } elseif ( isset( $row['url'] ) && $row['url'] != 'http://' ) {
	// 	$aid = '<a href="' . $row['url'] . '">' . UsernameColor( $aid ) . '</a>';
	// } else {
	// 	$aid = UsernameColor( $aid );
	// }
	return $aid;
}

/**
 * Determines whether the current request is for an administrative interface page.
 *
 * Does not check if the user is an administrator; use is_user()
 *
 * @since 1.0.5
 *
 * @param string  $username   User username
 * @param string  $old_name   Users old uncolored name.
 * @return string Colored Username
 */
function UsernameColor( $username, $old_name = false ) {
	global $db, $user_prefix, $use_colors, $cache;
	static $cached_names;

	if ( $old_name ) {
		$username = $old_name;
	}

	if ( ! $use_colors ) {
		return $username;
	}

	$plain_username = strtolower( $username );

	if ( isset( $cached_names[ $plain_username ] ) ) {
		return $cached_names[ $plain_username ];
	}

	if ( ! is_array( $cached_names ) ) {
		$cached_names = cache_load( 'UserColors', 'config' );
	}

	if ( ! isset( $cached_names[ $plain_username ] ) ) {
		list( $user_color, $uname ) = dburow( "SELECT user_color_gc, username FROM " . USERS_TABLE . " WHERE `username` = '" . str_replace( "'", "\'", $username ) . "'" );
		$uname    = ( ! empty( $uname ) ) ? $uname : $username;
		$username = ( strlen( $user_color ) == 6 ) ? '<span style="color: #' . $user_color . '">'. $uname .'</span>' : $uname;
		$cached_names[ $plain_username ] = $username;
		cache_set( 'UserColors', 'config', $cached_names );
	}
	return $cached_names[ $plain_username ];
}

/**
 * Determines whether the current request is for an administrative interface page.
 *
 * Does not check if the user is logged in; use is_user()
 *
 * @since 1.0.5
 *
 * @return bool True if inside administration interface, false otherwise.
 */
function is_admin() {
	static $adminstatus;

	if ( isset( $adminstatus ) ) {
		return $adminstatus;
	}

	$admincookie = isset( $_COOKIE['admin'] ) ? $_COOKIE['admin'] : false;
	if ( ! $admincookie ) {
		return $adminstatus = 0;
	}

	$admincookie = ( ! is_array( $admincookie ) ) ? explode( ':', base64_decode( $admincookie ) ) : $admincookie;
	$aid         = $admincookie[0];
	$pwd         = $admincookie[1];
	$aid         = substr( addslashes( $aid ), 0, 25 );
	if ( ! empty( $aid ) && ! empty( $pwd ) ) {
		if ( ! function_exists( 'get_admin_field' ) ) {
			global $db, $prefix;
			$pass = dburow("SELECT pwd FROM " . _AUTHOR_TABLE . " WHERE aid = '" .  str_replace( "\'", "''", $aid ) . "'" );
			$pass = ( isset( $pass['pwd'] ) ) ? $pass['pwd'] : '';
		} else {
			$pass = get_admin_field( 'pwd', $aid );
		}

		if ( $pass == $pwd && ! empty( $pass ) ) {
			return $adminstatus = 1;
		}
	}
	return $adminstatus = 0;
}

/**
 * Determines whether the current user is a god administrator.
 *
 * @since 1.0.5
 *
 * @return bool True if a god administrator, false otherwise.
 */
function is_god_admin() {
	static $godadminstatus;

	if ( isset( $godadminstatus ) ) {
		return $godadminstatus;
	}

	$godadmincookie = isset( $_COOKIE['admin'] ) ? $_COOKIE['admin'] : false;
	if ( ! $godadmincookie ) {
		return $godadminstatus = 0;
	}

	$godadmincookie = ( ! is_array( $godadmincookie ) ) ? explode( ':', base64_decode( $godadmincookie ) ) : $godadmincookie;
	$aid    = $godadmincookie[0];
	$pwd    = $godadmincookie[1];
	$godaid = substr( addslashes( $aid ), 0, 25 );

	if ( ! empty( $godaid ) && ! empty( $pwd ) ) {
		if ( ! function_exists( 'get_admin_field' ) ) {
			global $db;
			$godaid_replace = str_replace( "\'", "''", $godaid );
			$pass           = dburow( "SELECT `pwd` FROM `" . _AUTHOR_TABLE . "` WHERE `aid` = '" . $godaid_replace . "'" );
			$godname        = dburow( "SELECT `name` FROM `" . _AUTHOR_TABLE . "` WHERE `aid` = '" . $godaid_replace . "'" );
			$pass           = ( isset( $pass['pwd'] ) ) ? $pass['pwd'] : '';
			$godname        = ( isset( $godname['name'] ) ) ? $godname['name'] : '';
		} else {
			$pass           = get_admin_field( 'pwd', $godaid );
			$godname        = get_admin_field( 'name', $godaid );
		}

		if ( ( $pass == $pwd && ! empty( $pass ) ) && ( $godname == 'God' ) )  {
			return $godadminstatus = true;
		}
	}
	return $godadminstatus = false;
}