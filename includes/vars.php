<?php
/**
 * Creates common globals for the rest of Evolution Xtreme
 *
 * @package EvolutionXtreme
 */

global $pagenow,
	$is_lynx, $is_gecko, $is_winIE, $is_macIE, $is_opera, $is_NS4, $is_safari, $is_chrome, $is_iphone, $is_IE, $is_edge,
	$is_apache, $is_IIS, $is_iis7, $is_nginx;

// Simple browser detection.
$is_lynx   = false;
$is_gecko  = false;
$is_winIE  = false;
$is_macIE  = false;
$is_opera  = false;
$is_NS4    = false;
$is_safari = false;
$is_chrome = false;
$is_iphone = false;
$is_edge   = false;

if ( isset( $_SERVER['HTTP_USER_AGENT'] ) ) {
	if ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Lynx' ) !== false ) {
		$is_lynx = true;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Edg' ) !== false ) {
		$is_edge = true;
	} elseif ( stripos( $_SERVER['HTTP_USER_AGENT'], 'chrome' ) !== false ) {
		if ( stripos( $_SERVER['HTTP_USER_AGENT'], 'chromeframe' ) !== false ) {
			$is_admin = is_admin();
			/**
			 * Filters whether Google Chrome Frame should be used, if available.
			 *
			 * @since 2.0.10
			 *
			 * @param bool $is_admin Whether to use the Google Chrome Frame. Default is the value of is_admin().
			 */
			$is_chrome = $is_admin;
			if ( $is_chrome ) {
				header( 'X-UA-Compatible: chrome=1' );
			}
			$is_winIE = ! $is_chrome;
		} else {
			$is_chrome = true;
		}
	} elseif ( stripos( $_SERVER['HTTP_USER_AGENT'], 'safari' ) !== false ) {
		$is_safari = true;
	} elseif ( ( strpos( $_SERVER['HTTP_USER_AGENT'], 'MSIE' ) !== false || strpos( $_SERVER['HTTP_USER_AGENT'], 'Trident' ) !== false ) && strpos( $_SERVER['HTTP_USER_AGENT'], 'Win' ) !== false ) {
		$is_winIE = true;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'MSIE' ) !== false && strpos( $_SERVER['HTTP_USER_AGENT'], 'Mac' ) !== false ) {
		$is_macIE = true;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Gecko' ) !== false ) {
		$is_gecko = true;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Opera' ) !== false ) {
		$is_opera = true;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Nav' ) !== false && strpos( $_SERVER['HTTP_USER_AGENT'], 'Mozilla/4.' ) !== false ) {
		$is_NS4 = true;
	}
}

if ( $is_safari && stripos( $_SERVER['HTTP_USER_AGENT'], 'mobile' ) !== false ) {
	$is_iphone = true;
}

$is_IE = ( $is_macIE || $is_winIE );

// Server detection.

/**
 * Whether the server software is Apache or something else
 *
 * @global bool $is_apache
 */
$is_apache = ( strpos( $_SERVER['SERVER_SOFTWARE'], 'Apache' ) !== false || strpos( $_SERVER['SERVER_SOFTWARE'], 'LiteSpeed' ) !== false );

/**
 * Whether the server software is Nginx or something else
 *
 * @global bool $is_nginx
 */
$is_nginx = ( strpos( $_SERVER['SERVER_SOFTWARE'], 'nginx' ) !== false );

/**
 * Whether the server software is IIS or something else
 *
 * @global bool $is_IIS
 */
$is_IIS = ! $is_apache && ( strpos( $_SERVER['SERVER_SOFTWARE'], 'Microsoft-IIS' ) !== false || strpos( $_SERVER['SERVER_SOFTWARE'], 'ExpressionDevServer' ) !== false );

/**
 * Whether the server software is IIS 7.X or greater
 *
 * @global bool $is_iis7
 */
$is_iis7 = $is_IIS && (int) substr( $_SERVER['SERVER_SOFTWARE'], strpos( $_SERVER['SERVER_SOFTWARE'], 'Microsoft-IIS/' ) + 14 ) >= 7;

/**
 * Test if the current browser runs on a mobile device (smart phone, tablet, etc.)
 *
 * @since 2.0.10
 *
 * @return bool
 */
function evo_is_mobile() {
	if ( empty( $_SERVER['HTTP_USER_AGENT'] ) ) {
		$is_mobile = false;
	} elseif ( strpos( $_SERVER['HTTP_USER_AGENT'], 'Mobile' ) !== false // Many mobile devices (all iPhone, iPad, etc.)
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'Android' ) !== false
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'Silk/' ) !== false
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'Kindle' ) !== false
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'BlackBerry' ) !== false
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'Opera Mini' ) !== false
		|| strpos( $_SERVER['HTTP_USER_AGENT'], 'Opera Mobi' ) !== false ) {
			$is_mobile = true;
	} else {
		$is_mobile = false;
	}

	/**
	 * Filters whether the request should be treated as coming from a mobile device or not.
	 *
	 * @since 4.9.0
	 *
	 * @param bool $is_mobile Whether the request is from a mobile device or not.
	 */
	return $is_mobile;
}
