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

/**
 * Serialize data, if needed.
 *
 * @since 2.0.10
 *
 * @param string|array|object $data Data that might be serialized.
 *
 * @return mixed A scalar data.
 */
function maybe_serialize( $data ) {
	if ( is_array( $data ) || is_object( $data ) ) {
		return serialize( $data );
	}

	return $data;
}

/**
 * Unserialize data only if it was serialized.
 *
 * @since 2.0.10
 *
 * @param string $data Data that might be unserialized.
 *
 * @return mixed Unserialized data can be any type.
 */
function maybe_unserialize( $data ) {
	if ( is_serialized( $data ) ) { // Don't attempt to unserialize data that wasn't serialized going in.
		return @unserialize( trim( $data ) );
	}

	return $data;
}

/**
 * Check value to find if it was serialized.
 *
 * If $data is not an string, then returned value will always be false.
 * Serialized data is always a string.
 *
 * @since 2.0.10
 *
 * @param string $data   Value to check to see if was serialized.
 * @param bool   $strict Optional. Whether to be strict about the end of the string. Default true.
 *
 * @return bool False if not serialized and true if it was.
 */
function is_serialized( $data, $strict = true ) {
	// If it isn't a string, it isn't serialized.
	if ( ! is_string( $data ) ) {
		return false;
	}

	$data = trim( $data );
	if ( 'N;' === $data ) {
		return true;
	}

	if ( strlen( $data ) < 4 ) {
		return false;
	}

	if ( ':' !== $data[1] ) {
		return false;
	}

	if ( $strict ) {
		$lastc = substr( $data, -1 );
		if ( ';' !== $lastc && '}' !== $lastc ) {
			return false;
		}
	} else {
		$semicolon = strpos( $data, ';' );
		$brace     = strpos( $data, '}' );
		// Either ; or } must exist.
		if ( false === $semicolon && false === $brace ) {
			return false;
		}
		// But neither must be in the first X characters.
		if ( false !== $semicolon && $semicolon < 3 ) {
			return false;
		}
		if ( false !== $brace && $brace < 4 ) {
			return false;
		}
	}

	$token = $data[0];
	switch ( $token ) {
		case 's':
			if ( $strict ) {
				if ( '"' !== substr( $data, -2, 1 ) ) {
					return false;
				}
			} elseif ( false === strpos( $data, '"' ) ) {
				return false;
			}
			// Or else fall through.
		case 'a':
		case 'O':
			return (bool) preg_match( "/^{$token}:[0-9]+:/s", $data );
		case 'b':
		case 'i':
		case 'd':
			$end = $strict ? '$' : '';
			return (bool) preg_match( "/^{$token}:[0-9.E+-]+;$end/", $data );
	}
	return false;
}

/**
 * Check whether serialized data is of string type.
 *
 * @since 2.0.10
 *
 * @param string $data Serialized data.
 *
 * @return bool False if not a serialized string, true if it is.
 */
function is_serialized_string( $data ) {
	// if it isn't a string, it isn't a serialized string.
	if ( ! is_string( $data ) ) {
		return false;
	}

	$data = trim( $data );
	if ( strlen( $data ) < 4 ) {
		return false;
	} elseif ( ':' !== $data[1] ) {
		return false;
	} elseif ( ';' !== substr( $data, -1 ) ) {
		return false;
	} elseif ( 's' !== $data[0] ) {
		return false;
	} elseif ( '"' !== substr( $data, -2, 1 ) ) {
		return false;
	} else {
		return true;
	}
}

function removecrlf( $str ) {
    return strtr( $str, '\015\012', ' ' );
}

// Function to translate Datestrings
function translate( $phrase ) {
    switch( $phrase ) {
        case 'xdatestring':
            $tmp = '%A, %B %d @ %T %Z';
            break;
        case 'linksdatestring':
            $tmp = '%d-%b-%Y';
            break;
        case 'xdatestring2':
            $tmp = '%A, %B %d';
            break;
        default:
        $tmp = $phrase;
    }

    return $tmp;
}