<?php

defined( 'NUKE_EVO' ) || exit;

/**
 * Send mail, similar to PHP's mail
 *
 * @since 2.0.9e
 *
 * A true return value does not automatically mean that the user received the
 * email successfully. It just only means that the method used was able to
 * process the request without any errors.
 *
 * @global PHPMailer $phpmailer
 *
 * @param string|array $to          Array or comma-separated list of email addresses to send message.
 * @param string       $subject     Email subject
 * @param string       $message     Message contents
 * @param string|array $headers     Optional. Additional headers.
 * @param string|array $attachments Optional. Files to attach.
 * @return bool Whether the email contents were sent successfully.
 */
function evo_phpmailer( $to, $subject, $message, $headers = '', $attachments = array() ) {
	/**
	 * Filters the evo_phpmailer() arguments.
	 *
	 * @since 2.0.10
	 *
	 * @param array $args {
	 *     Array of the `evo_phpmailer()` arguments.
	 *
	 *     @type string|string[] $to          Array or comma-separated list of email addresses to send message.
	 *     @type string          $subject     Email subject.
	 *     @type string          $message     Message contents.
	 *     @type string|string[] $headers     Additional headers.
	 *     @type string|string[] $attachments Paths to files to attach.
	 * }
	 */
	$atts = compact( 'to', 'subject', 'message', 'headers', 'attachments' );

	if ( isset( $atts['to'] ) ) {
		$to = $atts['to'];
	}

	if ( ! is_array( $to ) ) {
		$to = explode( ',', $to );
	}

	if ( isset( $atts['subject'] ) ) {
		$subject = $atts['subject'];
	}

	if ( isset( $atts['message'] ) ) {
		$message = $atts['message'];
	}

	if ( isset( $atts['headers'] ) ) {
		$headers = $atts['headers'];
	}

	if ( isset( $atts['attachments'] ) ) {
		$attachments = $atts['attachments'];
	}

	if ( ! is_array( $attachments ) ) {
		$attachments = explode( "\n", str_replace( "\r\n", "\n", $attachments ) );
	}
	global $phpmailer;

	// (Re)create it, if it's gone missing.
	if ( ! ( $phpmailer instanceof PHPMailer\PHPMailer\PHPMailer ) ) {
		require_once VENDOR_DIRECTORY . '/PHPMailer/PHPMailer.php';
		require_once VENDOR_DIRECTORY . '/PHPMailer/SMTP.php';
		require_once VENDOR_DIRECTORY . '/PHPMailer/Exception.php';
		$phpmailer = new PHPMailer\PHPMailer\PHPMailer( true );
	}

	// Headers.
	$cc       = array();
	$bcc      = array();
	$reply_to = array();

	if ( empty( $headers ) ) {
		$headers = array();
	} else {
		if ( ! is_array( $headers ) ) {
			// Explode the headers out, so this function can take
			// both string headers and an array of headers.
			$tempheaders = explode( "\n", str_replace( "\r\n", "\n", $headers ) );
		} else {
			$tempheaders = $headers;
		}
		$headers = array();

		// If it's actually got contents.
		if ( ! empty( $tempheaders ) ) {
			// Iterate through the raw headers.
			foreach ( (array) $tempheaders as $header ) {
				if ( strpos( $header, ':' ) === false ) {
					if ( false !== stripos( $header, 'boundary=' ) ) {
						$parts    = preg_split( '/boundary=/i', trim( $header ) );
						$boundary = trim( str_replace( array( "'", '"' ), '', $parts[1] ) );
					}
					continue;
				}
				// Explode them out.
				list( $name, $content ) = explode( ':', trim( $header ), 2 );

				// Cleanup crew.
				$name    = trim( $name );
				$content = trim( $content );

				switch ( strtolower( $name ) ) {
					// Mainly for legacy -- process a "From:" header if it's there.
					case 'from':
						$bracket_pos = strpos( $content, '<' );
						if ( false !== $bracket_pos ) {
							// Text before the bracketed email is the "From" name.
							if ( $bracket_pos > 0 ) {
								$from_name = substr( $content, 0, $bracket_pos );
								$from_name = str_replace( '"', '', $from_name );
								$from_name = trim( $from_name );
							}

							$from_email = substr( $content, $bracket_pos + 1 );
							$from_email = str_replace( '>', '', $from_email );
							$from_email = trim( $from_email );

							// Avoid setting an empty $from_email.
						} elseif ( '' !== trim( $content ) ) {
							$from_email = trim( $content );
						}
						break;
					case 'content-type':
						if ( strpos( $content, ';' ) !== false ) {
							list( $type, $charset_content ) = explode( ';', $content );
							$content_type                   = trim( $type );
							if ( false !== stripos( $charset_content, 'charset=' ) ) {
								$charset = trim( str_replace( array( 'charset=', '"' ), '', $charset_content ) );
							} elseif ( false !== stripos( $charset_content, 'boundary=' ) ) {
								$boundary = trim( str_replace( array( 'BOUNDARY=', 'boundary=', '"' ), '', $charset_content ) );
								$charset  = '';
							}

							// Avoid setting an empty $content_type.
						} elseif ( '' !== trim( $content ) ) {
							$content_type = trim( $content );
						}
						break;
					case 'cc':
						$cc = array_merge( (array) $cc, explode( ',', $content ) );
						break;
					case 'bcc':
						$bcc = array_merge( (array) $bcc, explode( ',', $content ) );
						break;
					case 'reply-to':
						$reply_to = array_merge( (array) $reply_to, explode( ',', $content ) );
						break;
					default:
						// Add it to our grand headers array.
						$headers[ trim( $name ) ] = trim( $content );
						break;
				}
			}
		}
	}

	// Empty out the values that may be set.
	$phpmailer->clearAllRecipients();
	$phpmailer->clearAttachments();
	$phpmailer->clearCustomHeaders();
	$phpmailer->clearReplyTos();
	$phpmailer->Body    = '';
	$phpmailer->AltBody = '';

	// Set "From" name and email.

	// If we don't have a name from the input headers.
	if ( ! isset( $from_name ) ) {
		$from_name = $GLOBALS['sitename'];
	}

	if ( ! isset( $from_email ) ) {
		$sitename   = $GLOBALS['sitename'];
		$from_email = $GLOBALS['adminmail'];
	}

	try {
		$phpmailer->setFrom( $from_email, $from_name, false );
	} catch ( PHPMailer\PHPMailer\Exception $e ) {
		$mail_error_data                             = compact( 'to', 'subject', 'message', 'headers', 'attachments' );
		$mail_error_data['phpmailer_exception_code'] = $e->getCode();
		log_write( 'error', $e->getMessage(), 'PHPMailer Error' );

		return false;
	}

	// Set mail's subject and body.
	$phpmailer->Subject = $subject;
	$phpmailer->Body    = $message;

	// Set destination addresses, using appropriate methods for handling addresses.
	$address_headers = compact( 'to', 'cc', 'bcc', 'reply_to' );

	foreach ( $address_headers as $address_header => $addresses ) {
		if ( empty( $addresses ) ) {
			continue;
		}

		foreach ( (array) $addresses as $address ) {
			try {
				// Break $recipient into name and address parts if in the format "Foo <bar@baz.com>".
				$recipient_name = '';

				if ( preg_match( '/(.*)<(.+)>/', $address, $matches ) ) {
					if ( count( $matches ) == 3 ) {
						$recipient_name = $matches[1];
						$address        = $matches[2];
					}
				}

				switch ( $address_header ) {
					case 'to':
						$phpmailer->addAddress( $address, $recipient_name );
						break;
					case 'cc':
						$phpmailer->addCc( $address, $recipient_name );
						break;
					case 'bcc':
						$phpmailer->addBcc( $address, $recipient_name );
						break;
					case 'reply_to':
						$phpmailer->addReplyTo( $address, $recipient_name );
						break;
				}
			} catch ( PHPMailer\PHPMailer\Exception $e ) {
				continue;
			}
		}
	}

	// Set to use PHP's mail().
	if ( true == get_board_option( 'smtp_delivery' ) ) {
		$phpmailer->Host       = get_board_option( 'smtp_host' );
		$phpmailer->Port       = get_board_option( 'smtp_port' );
		$phpmailer->SMTPSecure = get_board_option( 'smtp_encryption' );
		$phpmailer->isSMTP();

		if ( 'none' == get_board_option( 'smtp_encryption' )  ) {
			$phpmailer->SMTPSecure  = '';
			$phpmailer->SMTPAutoTLS = false;
		}

		if ( true == get_board_option( 'smtp_auth' ) ) {
			$phpmailer->SMTPAuth = true;
			$phpmailer->Username = get_board_option( 'smtp_username' );
			$phpmailer->Password = get_board_option( 'smtp_password' );
		} else {
			$phpmailer->SMTPAuth = false;
		}

	} else {
		$phpmailer->isMail();
	}

	// Set Content-Type and charset.

	// If we don't have a content-type from the input headers.
	if ( ! isset( $content_type ) ) {
		$content_type = 'text/plain';
	}

	$phpmailer->ContentType = $content_type;

	// Set whether it's plaintext, depending on $content_type.
	if ( 'text/html' === $content_type ) {
		$phpmailer->isHTML( true );
	}

	// Set custom headers.
	if ( ! empty( $headers ) ) {
		foreach ( (array) $headers as $name => $content ) {
			// Only add custom headers not added automatically by PHPMailer.
			if ( ! in_array( $name, array( 'MIME-Version', 'X-Mailer' ), true ) ) {
				try {
					$phpmailer->addCustomHeader( sprintf( '%1$s: %2$s', $name, $content ) );
				} catch ( PHPMailer\PHPMailer\Exception $e ) {
					continue;
				}
			}
		}

		if ( false !== stripos( $content_type, 'multipart' ) && ! empty( $boundary ) ) {
			$phpmailer->addCustomHeader( sprintf( 'Content-Type: %s; boundary="%s"', $content_type, $boundary ) );
		}
	}

	if ( ! empty( $attachments ) ) {
		foreach ( $attachments as $attachment ) {
			try {
				$phpmailer->addAttachment( $attachment );
			} catch ( PHPMailer\PHPMailer\Exception $e ) {
				log_write( 'error', 'attachment error', 'PHPMailer Attachment Error' );
				continue;
			}
		}
	}

	$mail_data = compact( 'to', 'subject', 'message', 'headers', 'attachments' );

	// Send!
	try {
		$send = $phpmailer->send();
		return $send;
	} catch ( PHPMailer\PHPMailer\Exception $e ) {
		$mail_data['phpmailer_exception_code'] = $e->getCode();
		log_write( 'error', $e->getMessage(), 'PHPMailer Error' );
		return false;
	}
}

/**
 * Gets the variable and runs all the proper sub functions
 *
 * @since 2.0.9e
 *
 * @param string $var the variable to check
 * @param string $loc the location to retrieve the variable
 * @param string $type the type to check against the variable
 * @param string $default the default value to give the variable if there is a failure
 * @param string $minlen the min length to check against variable
 * @param string $maxlen the max length to check against variable
 * @param string $regex the regex to check against the variable
 *
 * @return mixed
 */
function get_query_var( $var, $loc, $type = 'string', $default = null, $minlen = '', $maxlen = '', $regex = '' ) {
	global $_GETVAR;
	return $_GETVAR->get( $var, $loc, $type, $default, $minlen, $maxlen, $regex );
}

function get_user_IP() {
	global $identify;
	return $identify->get_ip();
}

function get_user_agent() {
	global $identify;
	return $identify->identify_agent();
}

/**
 * Retrieve the "admin.php" file name
 *
 * @global admin_file $admin_file Evolution Xtreme "admin.php" filename.
 */
function get_admin_filename() {
	global $admin_file;
	return $admin_file;
}

/**
 * Used for grabbing the module name global.
 *
 * @since 2.0.9e
 */
function the_module() {
	global $module_name;
	return $module_name;
}

/**
 * Customize function: This function will grab the required image from an image sprite.
 *
 * @since 2.0.9e
 *
 * @param string $class    Add the class of the sprite icon you wish to use.
 * @param string $title    Text to be shown in the title.
 * @param bool   $onclick  An onlclick javascript can be provided.
 * @return string Displays a CSS sprite icon.
 */
function get_evo_icon( $class, $title = '', $onclick = false ) {
	$spriteIcon = '<span'.(($onclick != false) ? ' onclick="'.$onclick.'"' : '').' class="'.$class.'"'.(($title) ? ' title="'.$title.'"' : '').'></span>';
	return $spriteIcon;
}

/**
 * Customize function: This will be the new way to add copyright info to modules, instead of the need to copyright.php in the folder.
 *
 * @since 2.0.9e
 *
 * @param string $file The file you wish to retrieve the comment block header from.
 * @return array Display block comment copyright headers.
 */
function get_copyright_comments( $file ) {
	$file_headers = array(
		'Author'          => 'Author',
		'AuthorEmail'     => 'Author Email',
		'AuthorURI'       => 'Author URI',
		'CopyrightHeader' => 'Copyright Header',
		'Description'     => 'Module Description',
		'DownloadPath'    => 'Module Download Path',
		'License'         => 'Module License',
		'ModuleName'      => 'Module Name',
		'Modifications'   => 'Modifications',
		'Version'         => 'Module Version',
		'ThemeName'       => 'Theme Name',
		'ThemeDesription' => 'Theme Desription',
		'ThemeCopyright'  => 'Theme Copyright',
		'ThemeVersion'    => 'Theme Version',
		'ThemeLicense'    => 'Theme License',
		'Core'            => 'Core',
		'Engine'          => 'Engine',
		'PoweredBy'       => 'Powered By',
		'MenuName'        => 'Plugin Name',
		'MenuLink'        => 'Plugin URL',
		'MenuIcon'        => 'Plugin Icon',
		'MenuVisible'     => 'Plugin Visible'
	);

	$fp          = fopen( $file, 'r' );
	$file_data   = fread( $fp, 8192 );
	fclose( $fp );
	$file_data   = str_replace( "\r", "\n", $file_data );
	$all_headers = $file_headers;

	foreach ( $all_headers as $field => $regex ) {
		if ( preg_match( '/^[ \t\/*#@]*' . preg_quote( $regex, '/' ) . ':(.*)$/mi', $file_data, $match ) && $match[1] ) {
			$all_headers[ $field ] = trim( preg_replace( "/\s*(?:\*\/|\?>).*/", '', $match[1] ) );
		} else {
			$all_headers[ $field ] = '';
		}
	}

	return $all_headers;
}

/**
 * Customize function: Trims text to a certain number of words.
 *
 * @since 2.0.9e
 *
 * @param string $input         Text to trim.
 * @param int    $length        Number of words. Default 55.
 * @param string $ellipses      Optional. What to append if $input needs to be trimmed. Default '&hellip;'.
 * @param bool   $strip_html    Optional. Strip any HTML the $input may have. Default: true.
 * @return string Trimmed text.
 */
function trim_words( $input, $length = 55, $ellipses = '&hellip;', $strip_html = true ) {
	//strip tags, if desired
	if ( $strip_html ) {
		$input = strip_tags( $input );
	}

	//no need to trim, already shorter than trim length
	if ( strlen( $input ) <= $length ) {
		return $input;
	}

	//find last space within length
	$last_space = strrpos( substr( $input, 0, $length ), ' ' );
	if ( false !== $last_space ):
		$trimmed_text = substr( $input, 0, $last_space );
	else:
		$trimmed_text = substr( $input, 0, $length );
	endif;

	if ( $ellipses ) {
		$trimmed_text .= $ellipses;
	}

	return $trimmed_text;
}

/**
 * Customize function: Check if request is an AJAX call
 *
 * @since 2.0.9e
 */
function check_is_ajax() {
	return isset( $_SERVER['HTTP_X_REQUESTED_WITH'] ) AND strtolower( $_SERVER['HTTP_X_REQUESTED_WITH'] ) === 'xmlhttprequest';
}

/**
 * Customize function: Just a more simple way to include the header.php.
 * Will also do a check to see if there is an ajax request, if there is the header will not be included.
 *
 * @since 2.0.9e
 */
function get_header() {
	if ( ! check_is_ajax() ) {
		include_once NUKE_BASE_DIR . 'header.php';
	}
}

/**
 * Customize function: Just a more simple way to include the footer.php.
 * Will also do a check to see if there is an ajax request, if there is the header will not be included.
 *
 * @since 2.0.9e
 */
function get_footer() {
	if ( ! check_is_ajax() ) {
		include_once NUKE_BASE_DIR . 'footer.php';
	}
}

/**
 * Customize function: Globalize the image viewing script throughout the site.
 *
 * Lonestar: I plan on adding a more easier way to add new scripts into this function. This will be in the 2.0.12 update.
 *
 * @since 2.0.9e
 *
 * @param string $input  You can provide a unique slideshow gallery name.
 * @param string $length The caption you wish to display.
 * @return string The lightbox data "attr" that jQuery will look for and use the correct lightbox.
 */
function get_image_viewer( $slideshow = '', $caption = '' ) {
	switch( get_evo_option( 'img_viewer' ) ) {
		case 'colorbox':
			/**
			 * jQuery lightbox and modal window plugin.
			 *
			 * @package jquery-colorbox
			 * @author  Jack Moore <hello@jacklmoore.com>
			 * @version 1.6.4
			 * @license GPL-3.0
			 * @link    http://www.jacklmoore.com/colorbox
			 */
			$colorbox  = ' data-colorbox';
			$colorbox .= ( ( $slideshow ) ? ' rel="' . $slideshow . '"' : '' );
			$colorbox .= ( ( $caption ) ? ' title="' . $caption . '"' : '' );
			return $colorbox;
			break;

		case 'fancybox':
			/**
			 * Touch enabled, responsive and fully customizable jQuery lightbox script.
			 *
			 * @package @fancyapps/fancybox
			 * @author  fancyApps
			 * @version 3.5.7
			 * @license GPL-3.0
			 * @link    https://fancyapps.com/fancybox/3/
			 */
			$fancybox  = ' data-fancybox';
			$fancybox .= ( ( $slideshow ) ? '="' . $slideshow . '"' : '' );
			$fancybox .= ( ( $caption ) ? ' data-caption="' . $caption . '"' : '' );
			return $fancybox;
			break;

		case 'lightbox':
			/**
			 * The original Lightbox script.
			 *
			 * @package Lightbox2
			 * @author  Lokesh Dhakar <lokesh.dhakar@gmail.com>
			 * @version 2.10.0
			 * @license https://raw.githubusercontent.com/lokesh/lightbox2/master/LICENSE  MIT
			 * @link    https://lokeshdhakar.com/projects/lightbox2/
			 *
			 * This lightbox script require a slideshow name to be provided at all times, so i have used gallery as the default,
			 * Can still be changes via the function call.
			 */
			$lightbox  = ' data-lightbox="' . ( ( $slideshow ) ? $slideshow : 'gallery' ) . '"';
			$lightbox .= ( ( $slideshow ) ? ' data-title="' . $caption . '"' : '' );
			return $lightbox;
			break;

		case 'lightbox-evo':
			/**
			 * jQuery Lightbox Evolution.
			 *
			 * @package Lightbox Evolution
			 * @author  Eduardo Daniel Sada
			 * @version 1.8.1
			 * @license GPL
			 * @link    http://codecanyon.net/item/jquery-lightbox-evolution/115655?ref=aeroalquimia
			 *
			 * This lightbox does not come installed by default, So the required files are not missing.
			 * This script needs to be purchased from the link above.
			 */
			$lightbox_evolution  = ' data-lightbox-evo';
			$lightbox_evolution .= ( ( $slideshow ) ? ' data-rel="' . $slideshow . '"' : '' );
			return $lightbox_evolution;
			break;

		case 'lightbox-lite':
			/**
			 * Lightweight, accessible and responsive lightbox.
			 *
			 * @package lity
			 * @author  Jan Sorgalla
			 * @version 2.3.1
			 * @license MIT
			 * @link    http://sorgalla.com/lity/
			 */
			$lightbox_lite  = ' data-lightbox-lite';
			$lightbox_lite .= ( ( $slideshow ) ? ' rel="' . $slideshow . '"' : '' );
			$lightbox_lite .= ( ( $caption ) ? ' title="' . $caption . '"' : '' );
			return $lightbox_lite;
			break;
	}
}

/**
 * Customize function: Add a help icon to explain something.
 * @since 2.0.9e
 */
function display_help_icon( $text, $mode=false )
{
	if ($mode == false):
		return '<span class="tooltip icon-sprite icon-info" title="'.$text.'"></span>';
	elseif ($mode == 'html'):
		return '<span class="tooltip-html icon-sprite icon-info" title="'.$text.'"></span>';
	elseif ($mode == 'interact'):
		return '<span class="tooltip-interact icon-sprite icon-info" title="'.$text.'"></span>';
	endif;
}

/**
 * Customize function: Globally used rating image function.
 *
 * @since 2.0.9e
 *
 * @param string $size      There are two sizes available. large & small.
 * @param int    $rating    There are multiple values for this setting, Settings are as follows "0, 1, 1-5, 2, 2-5, 3, 3-5, 4, 4-5 & 5"
 * @param string $msg       Text to be set as the title.
 * @return string Displays the progress bar.
 */
function the_rating( $size, $rating, $msg = false )
{
	return '<span class="star-rating '.$size.'-stars-'.$rating.'"'.(($msg) ? '  alt="'.$msg.'" title="'.$msg.'"' : '').'></span>';
}

/**
 * Customize function: Used for dynamic page titles, This replaces the old Dynamic Titles mod, which required multiple database queries.
 *
 * @since 2.0.9e
 */
function the_pagetitle()
{
	global $sitename;
	$item_delim         = "&raquo;";
	// $module_name        = $_GET['name'];
	$module_name 		= get_query_var( 'name', 'get', 'string', '' );
	$module_name_str    = str_replace(array('-','_'),' ',$module_name);

	# if the user is in the administration panel, simply change the page title to administration.
	if (defined('ADMIN_FILE')):
		$newpagetitle = $item_delim.' Administration';

	# if the user is visiting a module, change the page title to the module name.
	else:
		$newpagetitle = ($module_name) ? $item_delim .' '.$module_name_str : '';
	endif;
	echo '<title>'.$sitename.' '.$newpagetitle.'</title>';
}

/**
 * Do a quick check to see if the logged in users has new or unread private messages.
 *
 * @since 2.0.10
 *
 * @return int
 */
function get_user_new_message_count() {
	global $userinfo;
	if ( (int) $userinfo['user_new_privmsg'] > 0 && (int) $userinfo['user_unread_privmsg'] > 0 ) {
		return ( (int) $userinfo['user_new_privmsg'] + (int) $userinfo['user_unread_privmsg'] );
	}

	if ( 0 == (int) $userinfo['user_new_privmsg'] && (int) $userinfo['user_unread_privmsg'] > 0 ) {
		return (int) $userinfo['user_unread_privmsg'];
	}

	if ( 0 == (int) $userinfo['user_unread_privmsg'] && (int) $userinfo['user_new_privmsg'] > 0 ) {
		return (int) $userinfo['user_new_privmsg'];
	}

	return (int) 0;
}

/**
 * Check or set whether WordPress is in "installation" mode.
 *
 * If the `EVO_INSTALLING` constant is defined during the installation, `evo_installing()` will default to `true`.
 *
 * @since 2.0.10
 *
 * @param bool $is_installing
 * @return bool True if WP is installing, otherwise false. When a `$is_installing` is passed, the function will
 *              report whether EVO was in installing mode prior to the change to `$is_installing`.
 */
function evo_installing( $is_installing = null ) {
	static $installing = null;

	// Support for the `EVO_INSTALLING` constant, defined before EVO is loaded.
	if ( is_null( $installing ) ) {
		$installing = defined( 'EVO_INSTALLING' ) && EVO_INSTALLING;
	}

	if ( ! is_null( $is_installing ) ) {
		$old_installing = $installing;
		$installing     = $is_installing;
		return (bool) $old_installing;
	}

	return (bool) $installing;
}

/**
 * This will be used quite alot throughout the site, For such things as CMS, Block, Module & Theme version chekcing.
 *
 * @since 2.0.9e
 *
 * @param string  $version_check_url     The url to the json file containing the version information.
 * @param string  $local_cache_location  The local json file storage folder
 * @param bool    $force_refresh         Choose whether to force an update, Default: false.
 * @return array  Return a json object with all the version information.
 */
function cache_json_data( $version_check_url, $local_cache_location, $force_refresh = false, $headers = [], $cache_time = 86400 ) {
	$url 	= $version_check_url;
	$cache 	= $local_cache_location;

	if ( file_exists( $cache ) ) {
		if ( ( time() - filemtime( $cache ) ) > ( $cache_time ) || 0 == filesize( $cache ) ) {
			$force_refresh = true;
		}
	}

	if ( $force_refresh || ! file_exists( $cache ) ) {

		# create a new cURL resource
		$ch = curl_init();

		# set URL and other appropriate options
		curl_setopt( $ch, CURLOPT_URL, $url );
		curl_setopt( $ch, CURLOPT_FAILONERROR, true );
		curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, true );
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
		curl_setopt( $ch, CURLOPT_SSL_VERIFYPEER, false );
		curl_setopt( $ch, CURLOPT_TIMEOUT, 7 );

		if ( !empty( $headers ) || $headers == null ):
			curl_setopt( $ch, CURLOPT_HTTPHEADER, $headers );
		endif;

		# grab URL and pass it to the browser
		$response = curl_exec( $ch );

		# close cURL resource, and free up system resources
		curl_close( $ch );

		if ( get_file_extension( $version_check_url ) == 'xml' && ini_get('allow_url_fopen') == true ):
			$xml = simplexml_load_file( $version_check_url );
			$jsoncache = json_encode( $xml );
		else:
			$jsoncache  = $response;
		endif;

		# Insert json information into a locally stored file, This will prevent slow page load time from slow hosts.
		$handle = fopen( $cache, 'wb' ) or die( 'no fopen' );
		fwrite( $handle, $jsoncache );
		fclose( $handle );

	} else {
		# Retrieve the json cache from the locally stored file
		$jsoncache = file_get_contents( $cache );
	}

	return json_decode( $jsoncache, true );
}

/**
 * Custom function: Changes a timestamp from a date string to exactly how many "seconds, minutes, hours, days, months or years" the user posted or visited.
 *
 * @since 2.0.9e
 *
 * @param string $ptime The timestamp you wish to be converted.
 * @return string Return modified timestamp.
 */
function get_timeago( $ptime ) {
	$estimate_time = time() - $ptime;

	if ( $estimate_time < 1 ) {
		return 'Just now';
	}

	$condition = array(
		12 * 30 * 24 * 60 * 60  =>  'year',
		30 * 24 * 60 * 60       =>  'month',
		24 * 60 * 60            =>  'day',
		60 * 60                 =>  'hour',
		60                      =>  'min',
		1                       =>  'sec'
	);

	foreach( $condition as $secs => $str ) {
		$d = $estimate_time / $secs;

		if( $d >= 1 ) {
			$r = round( $d );
			return $r . ' ' . $str . ( $r > 1 ? 's' : '' ) . ' ago';
		}
	}
}

/**
 * Escapes data for use in a MySQL query.
 *
 * @since 2.0.9e
 *
 * @global db $db Evolution Xtreme database abstraction object.
 *
 * @param string|array $data Unescaped data
 * @return string|array Escaped data
 */
function esc_sql( $data ) {
	global $db;
	return $db->sql_escapestring( $data );
}

/**
 * Retrieve the users avatar info from the database.
 *
 * @since 2.0.9e
 *
 * @global db $db Evolution Xtreme database abstraction object.
 * @global board_config $board_config Forum configuration variable.
 * @global userinfo $userinfo Get the logged in users account information.
 */
function get_user_avatar( $user_id, $data = null ) {
	global $db, $board_config, $userinfo, $ThemeSel;
	static $avatarData;

	// if ( isset( $avatarData ) && is_array( $avatarData[ $user_id ] ) && ! empty( $avatarData[ $user_id ] ) ) {
	// 	return $avatarData[ $user_id ];
	// }

	if ( $user_id == $userinfo['user_id'] ) {
		$user_avatar       = $userinfo['user_avatar'];
		$user_avatar_type  = $userinfo['user_avatar_type'];
		$user_avatar_allow = $userinfo['user_allowavatar'];
		$user_avatar_show  = $userinfo['user_showavatars'];
	} else {
		/**
		 * Check to see if there is any data been passed to the function, If a database object is passed,
		 * We can get the relevant avatar info from the object, Will save mulitple database queries.
		 */
		if ( $data != null ) {
			$user_avatar       = $data['user_avatar'];
			$user_avatar_type  = $data['user_avatar_type'];
			$user_avatar_allow = $data['user_allowavatar'];
			$user_avatar_show  = $data['user_showavatars'];
		} else {
			list( $user_avatar, $user_avatar_type, $user_avatar_allow, $user_avatar_show ) = dburow("SELECT user_avatar, user_avatar_type, user_allowavatar, user_showavatars FROM ".USERS_TABLE." WHERE user_id = '" . $user_id . "' LIMIT 1");
		}
	}
	$poster_avatar = '';
	if ( $user_avatar_type && $user_id != ANONYMOUS && $user_avatar_allow && $user_avatar_show && !empty($user_avatar)) {
		switch( $user_avatar_type ) {
			case USER_AVATAR_UPLOAD:
				$poster_avatar = ( $board_config['allow_avatar_upload'] ) ? avatar_resize($board_config['avatar_path'] . '/' . $user_avatar) : '';
				break;
			case USER_AVATAR_REMOTE:
				$poster_avatar = avatar_resize($user_avatar);
				break;
			case USER_AVATAR_GALLERY:
				$poster_avatar = ( $board_config['allow_avatar_local'] ) ? avatar_resize($board_config['avatar_gallery_path'] . '/' . $user_avatar) : '';
				break;
		}
	}

	if ( empty( $poster_avatar ) && $user_id != ANONYMOUS ) {
		$poster_avatar = str_replace(
			'{THEME_NAME}',
			$ThemeSel,
			$board_config['default_avatar_users_url']
		);
	}

	if ( $user_id == ANONYMOUS ) {
		$poster_avatar = str_replace(
			'{THEME_NAME}',
			$ThemeSel,
			$board_config['default_avatar_guests_url']
		);
	}
	$avatarData[ $user_id ] = $poster_avatar;
	return $avatarData[ $user_id ];
}

/**
 * Administration URL.
 *
 * @return string User registration URL.
 */
function get_mod_admin_uri() {
	global $admin_file;
	$op = get_query_var( 'op', 'get', 'string' );
	return $admin_file . '.php?op=' . $op;
}

if ( ! function_exists( '__' ) ) {
	/**
	 * Gets the translated string from the language definition.
	 *
	 * @global $admlang, $customlang
	 *
	 * @param string    $lang         Language define you wish to have translated.
	 * @param string    $var          Variable name of the language locale.
	 * @return string   Translated string.
	 */
	function __( $lang, $var = 'customlang', $module_name = '' ) {
		global $$var;
		if ( empty( $module_name ) ) {
			return $$var[ the_module() ][ $lang ];
		} else {
			return $$var[ $module_name ][ $lang ];
		}
	}
}

/**
 * echo the translated text
 *
 * @param string $text Text to be translated.
 * @return string
 */
function _e( $lang, $var = 'customlang', $module_name = '' ) {
	echo __( $lang, $var, $module_name );
}

function sprintf__( $lang, $var = 'customlang', $module_name = '', $replacement = '' ) {
	$sprintf__ = vsprintf(
		__($lang, $var, $module_name ),
		$replacement
	);
	return $sprintf__;
}

function sprintf_e( $lang, $var = 'customlang', $module_name = '', $replacement = '' ) {
	$sprintf__ = vsprintf(
		__( $lang, $var, $module_name ),
		$replacement
	);
	echo $sprintf__;
}

/**
 * Filters for content to remove unnecessary slashes.
 *
 * @param string $content The content to modify.
 * @return string The de-slashed content.
 */
if ( ! function_exists( 'deslash' ) ) {
	function deslash( $content ) {
		/**
		 * Replace one or more backslashes followed by a single quote with
		 * a single quote.
		 */
		$content = preg_replace( "/\\\+'/", "'", $content );

		/**
		 * Replace one or more backslashes followed by a double quote with
		 * a double quote.
		 */
		$content = preg_replace( '/\\\+"/', '"', $content );

		// Replace one or more backslashes with one backslash.
		$content = preg_replace( '/\\\+/', '\\', $content );

		return $content;
	}
}

/**
 * Get the file extension.
 *
 * @param mixed $file
 *
 * @return string[]|string
 */
function get_file_extension( $file ) {
	$extension = pathinfo( $file, PATHINFO_EXTENSION );
	return $extension;
}

/**
 * Get the file basename.
 *
 * @param mixed $file
 *
 * @return string[]|string
 */
function get_file_basename( $file ) {
	$basename = pathinfo( $file, PATHINFO_FILENAME );
	return $basename;
}

/**
 * Get the file directory name.
 *
 * @param mixed $file
 *
 * @return string[]|string
 */
function get_file_directory( $file ) {
	$dirname = pathinfo( $file, PATHINFO_DIRNAME );
	return $dirname;
}

/**
 * Get the filename.
 *
 * @param mixed $file
 *
 * @return string[]|string
 */
function get_file_name( $file ) {
	$filename = pathinfo( $file, PATHINFO_FILENAME );
	return $filename;
}

function get_bootstrap_pagination() {
    global $board_config;

    $page = get_query_var( 'page', 'get', 'int', 1 );
    $args = func_get_args();
    foreach ( $args as &$a ) {
        $url           = $a['url'];
        $total         = $a['total'];
        $per_page      = $a['per-page'];
        $next_previous = $a['next-previous'];
        $first_last    = $a['first-last'];
        $adjacents     = $a['adjacents'];
	}

    if ( $total > $a['per-page'] ) {
        $total_pages = ceil( $total / $a['per-page'] );

        if ( $total_pages <= ( 1 + ( $adjacents * 2 ) ) ) {
            $start = 1;
            $end   = $total_pages;
        } else {
            if ( ( $page - $adjacents ) > 1 ) {
                if ( ( $page + $adjacents ) < $total_pages ) {
                    $start = ( $page - $adjacents );
                    $end   = ( $page + $adjacents );
                } else {
                    $start = ( $total_pages - ( 1 + ( $adjacents * 2 ) ) );
                    $end   = $total_pages;
                }
            } else {
                $start = 1;
                $end   = ( 1 + ( $adjacents * 2 ) );
            }
        }

        $pagination  = '<nav class="bootstrap_pagination" aria-label="bootstrap_pagination">';
        $pagination .= '<ul class="pagination justify-content-center">';

        if ( $first_last == true ):
            // Link of the first page
            $pagination .= '  <li class="page-item'.(( $page <= 1 ) ? ' disabled' : '').'"><a class="page-link" href="'.$url.'&amp;page=1">&lt;&lt;</a></li>';
        endif;

        if ( $next_previous == true ):
            // Link of the previous page
            $pagination .= '  <li class="page-item'.(( $page <= 1 ) ? ' disabled' : '').'"><a class="page-link" href="'.$url.'&amp;page='.(( $page > 1 ) ? $page-1 : 1).'">&lt;</a></li>';
        endif;

        // Links of the pages with page number
        for($i=$start; $i<=$end; $i++):
            $pagination .= '  <li class="page-item'.(( $page == $i ) ? ' active' : '').'"><a class="page-link" href="'.$url.'&amp;page='.$i.'">'.$i.'</a></li>';
        endfor;

        if ( $next_previous == true ):
            // Link of the next page
            $pagination .= '  <li class="page-item'.(( $page >= $total_pages ) ? ' disabled' : '').'"><a class="page-link" href="'.$url.'&amp;page='.(( $page < $total_pages ) ? $page+1 : $total_pages).'">&gt;</a></li>';
        endif;

        if ( $first_last == true ):
            // Link of the last page
            $pagination .= '  <li class="page-item'.(( $page >= $total_pages ) ? ' disabled' : '').'"><a class="page-link" href="'.$url.'&amp;page='.$total_pages.'">&gt;&gt;</a>';
        endif;

        $pagination .= '</ul>';
        $pagination .= '</nav>';
        return $pagination;
	} else {
        return;
	}
}

function bootstrap_pagination() {

    global $board_config;

    $page      = get_query_var('page', 'get', 'int', 1);
    // $adjacents = 2;

    // $calc           = $board_config['topics_per_page'] * $page;
    // $start          = $calc - $board_config['topics_per_page'];

    $args = func_get_args();
    foreach ($args as &$a):

        $table = $a['table'];
        $where = $a['where'];
        $next_previous = $a['next-previous'];
        $first_last = $a['first-last'];
        $adjacents = $a['adjacents'];

    endforeach;

    $result = _db()->sql_ufetchrow("SELECT COUNT(*) AS total FROM $table WHERE $where");

    $request_uri = ( strpos($_SERVER['REQUEST_URI'], "&") !== false ) ? strstr($_SERVER['REQUEST_URI'], '&', true) : $_SERVER['REQUEST_URI'];

    if($result['total'] > $board_config['topics_per_page']):

        $total_pages = ceil($result['total'] / $board_config['topics_per_page']);

        if($total_pages <= (1+($adjacents * 2)))
        {
            $start = 1;
            $end   = $total_pages;
        }
        else
        {
            if(($page - $adjacents) > 1)
            {
                //Checking if the current page minus adjacent is greateer than one.
                if(($page + $adjacents) < $total_pages) {  //Checking if current page plus adjacents is less than total pages.
                    $start = ($page - $adjacents);         //If true, then we will substract and add adjacent from and to the current page number
                    $end   = ($page + $adjacents);         //to get the range of the page numbers which will be display in the pagination.
                } else {                                   //If current page plus adjacents is greater than total pages.
                    $start = ($total_pages - (1+($adjacents*2)));  //then the page range will start from total pages minus 1+($adjacents*2)
                    $end   = $total_pages;                         //and the end will be the last page number that is total pages number.
                }
            } else {                                       //If the current page minus adjacent is less than one.
                $start = 1;                                //then start will be start from page number 1
                $end   = (1+($adjacents * 2));             //and end will be the (1+($adjacents * 2)).
            }
        }

        $pagination  = '<nav class="bootstrap_pagination" aria-label="bootstrap_pagination">';
        // $pagination .= '<ul class="pagination pagination-sm justify-content-center">';
        $pagination .= '<ul class="pagination justify-content-center">';

        if ( $first_last == true ):
            // Link of the first page
            $pagination .= '  <li class="page-item'.(( $page <= 1 ) ? ' disabled' : '').'"><a class="page-link" href="'.$request_uri.'&amp;page=1">&lt;&lt;</a></li>';
        endif;

        if ( $next_previous == true ):
            // Link of the previous page
            $pagination .= '  <li class="page-item'.(( $page <= 1 ) ? ' disabled' : '').'"><a class="page-link" href="'.$request_uri.'&amp;page='.(( $page > 1 ) ? $page-1 : 1).'">&lt;</a></li>';
        endif;

        // Links of the pages with page number
        for($i=$start; $i<=$end; $i++):
            $pagination .= '  <li class="page-item'.(( $page == $i ) ? ' active' : '').'"><a class="page-link" href="'.$request_uri.'&amp;page='.$i.'">'.$i.'</a></li>';
        endfor;

        if ( $next_previous == true ):
            // Link of the next page
            $pagination .= '  <li class="page-item'.(( $page >= $total_pages ) ? ' disabled' : '').'"><a class="page-link" href="'.$request_uri.'&amp;page='.(( $page < $total_pages ) ? $page+1 : $total_pages).'">&gt;</a></li>';
        endif;

        if ( $first_last == true ):
            // Link of the last page
            $pagination .= '  <li class="page-item'.(( $page >= $total_pages ) ? ' disabled' : '').'"><a class="page-link" href="'.$request_uri.'&amp;page='.$total_pages.'">&gt;&gt;</a>';
        endif;

        $pagination .= '</ul>';
        $pagination .= '</nav>';

        return $pagination;

    else:

        return '';

    endif;

}

/**
 * Outputs the HTML selected attribute.
 *
 * Compares the first two arguments and if identical marks as selected.
 *
 * @since 2.0.10
 *
 * @param mixed $selected One of the values to compare.
 * @param mixed $current  Optional. The other value to compare if not just true.
 *                        Default true.
 * @param bool  $echo     Optional. Whether to echo or just return the string.
 *                        Default true.
 * @return string HTML attribute or empty string.
 */
function selected( $selected, $current = true, $echo = true ) {
	return __checked_selected_helper( $selected, $current, $echo, 'selected' );
}

/**
 * Outputs the HTML checked attribute.
 *
 * Compares the first two arguments and if identical marks as checked.
 *
 * @since 2.0.10
 *
 * @param mixed $checked One of the values to compare.
 * @param mixed $current Optional. The other value to compare if not just true.
 *                       Default true.
 * @param bool  $echo    Optional. Whether to echo or just return the string.
 *                       Default true.
 * @return string HTML attribute or empty string.
 */
function checked( $checked, $current = true, $echo = true ) {
	return __checked_selected_helper( $checked, $current, $echo, 'checked' );
}

/**
 * Outputs the HTML disabled attribute.
 *
 * Compares the first two arguments and if identical marks as disabled.
 *
 * @since 2.0.10
 *
 * @param mixed $disabled One of the values to compare.
 * @param mixed $current  Optional. The other value to compare if not just true.
 *                        Default true.
 * @param bool  $echo     Optional. Whether to echo or just return the string.
 *                        Default true.
 * @return string HTML attribute or empty string.
 */
function disabled( $disabled, $current = true, $echo = true ) {
	return __checked_selected_helper( $disabled, $current, $echo, 'disabled' );
}

/**
 * Outputs the HTML readonly attribute.
 *
 * Compares the first two arguments and if identical marks as readonly.
 *
 * @since 2.0.10
 *
 * @param mixed $readonly One of the values to compare.
 * @param mixed $current  Optional. The other value to compare if not just true.
 *                        Default true.
 * @param bool  $echo     Optional. Whether to echo or just return the string.
 *                        Default true.
 * @return string HTML attribute or empty string.
 */
function readonly( $readonly, $current = true, $echo = true ) {
	return __checked_selected_helper( $readonly, $current, $echo, 'readonly' );
}

/**
  * Private helper function for checked, selected, disabled and readonly.
 *
 * Compares the first two arguments and if identical marks as `$type`.
 *
 * @since 2.0.10
 * @access private
 *
 * @param mixed  $helper  One of the values to compare.
 * @param mixed  $current The other value to compare if not just true.
 * @param bool   $echo    Whether to echo or just return the string.
 * @param string $type    The type of checked|selected|disabled|readonly we are doing.
 * @return string HTML attribute or empty string.
 */
function __checked_selected_helper( $helper, $current, $echo, $type ) {
	if ( (string) $helper === (string) $current ) {
		$result = " $type='$type'";
	} else {
		$result = '';
	}

	if ( $echo ) {
		echo $result;
	}

	return $result;
}

/**
 * Determines if SSL is used.
 *
 * @since 2.0.10
 *
 * @return bool True if SSL, otherwise false.
 */
function is_ssl() {
	if ( isset( $_SERVER['HTTPS'] ) ) {
		if ( 'on' === strtolower( $_SERVER['HTTPS'] ) ) {
			return true;
		}

		if ( '1' == $_SERVER['HTTPS'] ) {
			return true;
		}
	} elseif ( isset( $_SERVER['SERVER_PORT'] ) && ( '443' == $_SERVER['SERVER_PORT'] ) ) {
		return true;
	}
	return false;
}

/**
 * Determines if current user is a group.
 *
 * @since 2.0.10
 *
 * @return bool
 */
function is_user_in_group( $groups, $allow_admin_bypass = true ) {
	//If the user is an admin, bypass the check altogether.
	if ( is_admin() && true === $allow_admin_bypass ) {
		return true;
	}

	if ( ! is_array( $groups ) ) {
		return false;
	}

	$total_user_count = 0;
	$user_in_group    = false;

	foreach ( $groups as $group ) {
		if ( isset( $GLOBALS['userinfo']['groups'][ $group ] ) ) {
			++$total_user_count;
		}
	}

	if ( $total_user_count > 0 ) {
		$user_in_group = true;
	}

	return $user_in_group;
}

/**
 * Determines whether the current visitor is a logged in user.
 *
 * @since 2.0.10
 *
 * @return bool True if user is logged in, false if not logged in.
 */
function is_user_logged_in() {
	$user = is_user() ?: false;
	return $user;
}
