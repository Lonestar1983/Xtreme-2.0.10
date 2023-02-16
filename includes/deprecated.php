<?php
/************************************************************************
   Nuke-Evolution: Deprecated Functions
   ============================================
   Copyright (c) 2005 by The Nuke-Evolution Team

   Filename      : functions_deprecated.php
   Author        : Quake (www.Nuke-Evolution.com)
   Version       : 1.0.0
   Date          : 11.21.2005 (mm.dd.yyyy)

   Notes         : Deprecated Functions
************************************************************************/

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

// Here go the deprecated functions

$mainfile = true;
$nukeuser = ( isset( $_COOKIE['user'] ) ) ? explode( ':', addslashes( base64_decode( $_COOKIE['user'] ) ) ) : '';

require_once NUKE_INCLUDE_DIR . 'sql_layer.php';

function is_group( $user, $name ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
}

function update_points( $id ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
}

function public_message() {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
}

function stripos_clone( $haystack, $needle, $offset = 0 ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return stristr( $haystack, $needle );
}

function formatAidHeader( $aid ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	echo get_author( $aid );
}

function FixQuotes( $what = '' ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	$what = Fix_Quotes( $what );
	return $what;
}

function selectlanguage() {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return;
}

function userblock() {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return;
}

function loginbox() {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return;
}

function adminblock() {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return;
}

function delQuotes( $string ) {
	global $debugger;
	$debugger->handle_error( "Use of deprecated function <strong>" . __FUNCTION__ . "</strong>" );
	return $string;
}

function getusrinfo( $trash = 0, $force = false ) {
	global $userinfo, $debugger;
	return $userinfo;
}

/**
 * Determines whether the current request is for an administrative interface page.
 *
 * Does not check if the user is an administrator; use is_user()
 *
 * @since 1.0.5
 * @deprecated 2.0.10
 *
 * @return string Random generated password.
 */
function makePass() {
	$cons = 'bcdfghjklmnpqrstvwxyz';
	$vocs = 'aeiou';

	for ( $x = 0; $x < 6; ++$x ) {
		mt_srand ( (double) microtime() * 1000000 );
		$con[ $x ] = substr( $cons, mt_rand( 0, strlen( $cons ) - 1 ), 1 );
		$voc[ $x ] = substr( $vocs, mt_rand( 0, strlen( $vocs ) - 1 ), 1 );
	}

	mt_srand( (double) microtime() * 1000000 );
	$num1     = mt_rand( 0, 9 );
	$num2     = mt_rand( 0, 9 );
	$makepass = $con[0] . $voc[0] .$con[2] . $num1 . $num2 . $con[3] . $voc[3] . $con[4];
	return $makepass;
}

/**
 * add a Stylesheet into the header.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
// function add_css_to_head( $filename, $type = 'file', $version = false ) {
// 	$stylesheet_prefix = strtolower( $GLOBALS['ThemeSel'] );
// 	$filename_basename = strtolower( get_file_basename( $filename ) );
// 	$handle            = $stylesheet_prefix . '-' . $filename_basename;

// 	if ( 'inline' == $type ) {
// 		evo_add_inline_style( $handle, $filename );
// 	} else {
// 		evo_include_style( $handle, $filename, $version );
// 	}
// }

/**
 * add a JavaScript file into the header.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
// function add_js_to_head( $filename, $type = 'file', $version = null ) {
// 	$stylesheet_prefix = strtolower( $GLOBALS['ThemeSel'] );
// 	$filename_basename = strtolower( get_file_basename( $filename ) );
// 	$handle            = $stylesheet_prefix . '-' . $filename_basename;

// 	if ( 'inline' == $type ) {
// 		evo_add_inline_script( $handle, $filename );
// 	} else {
// 		evo_include_script( $handle, $filename, $version );
// 	}
// }

/**
 * add a Javscript into the body.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
// function add_js_to_body( $filename, $type = 'file', $version = null ) {
// 	$stylesheet_prefix = strtolower( $GLOBALS['ThemeSel'] );
// 	$filename_basename = strtolower( get_file_basename( $filename ) );
// 	$handle            = $stylesheet_prefix . '-' . $filename_basename;

// 	if ( 'inline' == $type ) {
// 		evo_add_inline_script( $handle, $filename, true );
// 	} else {
// 		evo_include_script( $handle, $filename, $version, true );
// 	}
// }

/**
 * Custom function: do a quick check to see if the logged in users has new or unread private messages.
 *
 * @since 2.0.9e
 * @deprecated 2.0.10
 */
function has_new_or_unread_private_messages() {
	return get_user_new_message_count();
}

/*
 * functions added to support dynamic and ordered loading of CSS and JS in <HEAD> and before </BODY>
 * Code origin Raven Nuke CMS (http://www.ravenphpscripts.com)
 */
function addCSSToHead( $filename, $type = 'file' ) {
	$stylesheet_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );
	$handle            = $stylesheet_prefix . '-' . $filename_basename;

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_style( $handle, $filename );
	} else {
		$handle = $stylesheet_prefix . '-' . $filename_basename;
		evo_include_style( $handle, $filename, EVO_BUILD );
	}
}

function addJSToHead( $filename, $type = 'file' ) {
	$javascript_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_script( $handle, $filename );
	} else {
		$handle = $javascript_prefix . '-' . $filename_basename;
		evo_include_script( $handle, $filename, EVO_BUILD );
	}
}

function addJSToBody( $filename, $type = 'file' ) {
	$javascript_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_script( $handle, $filename, true );
	} else {
		$handle = $javascript_prefix . '-' . $filename_basename;
		evo_include_script( $handle, $filename, EVO_BUILD, true );
	}
}

/**
 * add a Stylesheet into the header.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
function add_css_to_head( $filename, $type = 'file', $version = false ) {
	$stylesheet_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_style( $handle, $filename );
	} else {
		$handle            = $stylesheet_prefix . '-' . $filename_basename;
		evo_include_style( $handle, $filename, EVO_BUILD );
	}
}

/**
 * add a JavaScript file into the header.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
function add_js_to_head( $filename, $type = 'file', $version = null ) {
	$javascript_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_script( $handle, $filename );
	} else {
		$handle = $javascript_prefix . '-' . $filename_basename;
		evo_include_script( $handle, $filename, EVO_BUILD );
	}
}

/**
 * add a Javscript into the body.
 *
 * @param mixed   $filename
 * @param string  $type
 * @param bool    $version
 *
 * @since 2.0.9F
 * @deprecated 2.0.10
 *
 * @return void
 */
function add_js_to_body( $filename, $type = 'file', $version = null ) {
	$javascript_prefix = strtolower( $GLOBALS['ThemeSel'] );
	$filename_basename = strtolower( get_file_basename( $filename ) );

	if ( 'inline' == $type ) {
		$handle = md5( microtime( true ) . mt_Rand() );
		evo_add_inline_script( $handle, $filename, true );
	} else {
		$handle = $javascript_prefix . '-' . $filename_basename;
		evo_include_script( $handle, $filename, EVO_BUILD, true );
	}
}

/**
 * Loads the phpbb board config
 *
 * @author JeFFb68CAM
 *
 * @since 1.0.5
 * @deprecated 2.0.10
 *
 * @return array
 */
function load_board_config() {
    return evo_load_all_board_options();
}

/**
 * Customize function: Will display a CSS3 or HTML5 progress bar depending on what options you choose.
 *
 * @since 2.0.9e
 * @deprecated 2.0.10
 *
 * @param string $type          Choose the type of progress bar to show, CSS | HTML5.
 * @param string $class         Provide custom class for the progress bar. Default: "progress-bar blue stripes".
 * @param int    $value         Provide the the lowest set value.
 * @param int    $strip_html    Provide the maximum value.
 * @return string Displays the progress bar.
 */
function display_progress_bar( $type='css3',$class='progress-bar blue stripes', $value='0', $max='100' )
{
	if ($type == 'css3'):
		$progress_bar  = '<div class="'.$class.'">';
		$progress_bar .= '  <span data-percentage="'.$value.'" style="max-width:100%;"></span>';
		$progress_bar .= '</div>';
	else:
		$progress_bar = '<progress class="'.$class.'" data-percentage="'.$value.'" value="'.$value.'" max="'.$max.'"></progress>';
	endif;
	return $progress_bar;
}