<?php

/**
 * Shorten a URL, to be used as link text.
 *
 * @since 2.0.9e
 *
 * @param string $url    URL to shorten.
 * @param int    $length Optional. Maximum length of the shortened URL. Default 35 characters.
 * @return string Shortened URL.
 */
function url_shorten( $url, $length = 35 ) {
	$stripped  = str_replace( array( 'https://', 'http://', 'www.' ), '', $url );
	$short_url = untrailingslashit( $stripped );

	if ( strlen( $short_url ) > $length ) {
		$short_url = substr( $short_url, 0, $length - 3 ) . '&hellip;';
	}
	return $short_url;
}

/**
 * Appends a trailing slash.
 *
 * @since 2.0.9e
 *
 * Will remove trailing forward and backslashes if it exists already before adding
 * a trailing forward slash. This prevents double slashing a string or path.
 *
 * The primary use of this is for paths and thus should be used for paths. It is
 * not restricted to paths and offers no specific path support.
 *
 * @param  string $string What to add the trailing slash to.
 * @return string String with trailing slash added.
 */
function trailingslashit( $string ) {
	return untrailingslashit( $string ) . '/';
}

/**
 * Removes trailing forward slashes and backslashes if they exist.
 *
 * @since 2.0.9e
 *
 * The primary use of this is for paths and thus should be used for paths. It is
 * not restricted to paths and offers no specific path support.
 *
 * @param  string $string What to remove the trailing slashes from.
 * @return string String without the trailing slashes.
 */
function untrailingslashit( $string ) {
	return rtrim( $string, '/\\' );
}

/**
 *  Strip those annoying back slashes.
 *
 * @since 2.0.9e
 *
 * @param  string $string What to remove the back slashes from.
 * @return string String without the backslashes.
 */
function stripslashes_deep( $string ) {
	return str_replace( '\\', '', $string );
}

function convert_to_thousands( $num ) {
	$units = [ '', 'K', 'M', 'B', 'T' ];
	for ( $i = 0; $num >= 1000; $i++ ) {
		$num /= 1000;
	}
	return round ( $num, 1 ) . $units[ $i ];
}
