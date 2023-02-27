<?php

defined( 'NUKE_EVO' ) || exit;

/**
 * Loads a template part into a template.
 *
 * Provides a simple mechanism for child themes to overload reusable sections of code
 * in the theme.
 *
 * Includes the named template part for a theme or if a name is specified then a
 * specialised part will be included. If the theme contains no {slug}.php file
 * then no template will be included.
 *
 * The template is included using require, not require_once, so you may include the
 * same template part multiple times.
 *
 * For the $name parameter, if the file is called "{slug}-special.php" then specify
 * "special".
 *
 ** @origin WordPress - Nuke Evolution Xtreme developers take no credit for this code.
 *
 * @since 2.0.10
 *
 * @param string $slug The slug name for the generic template.
 * @param string $name The name of the specialised template.
 * @param array  $args Optional. Additional arguments passed to the template.
 *                     Default empty array.
 * @return void|false Void on success, false if the template does not exist.
 */
function get_template_part( $slug, $name = null, $args = array() ) {
	$templates = array();
	$name      = (string) $name;
	if ( '' !== $name ) {
		$templates[] = "{$slug}-{$name}.php";
	}

	$templates[] = "{$slug}.php";

	if ( ! locate_template( $templates, true, false, $args ) ) {
		return false;
	}
}

/**
 * Retrieve the name of the highest priority template file that exists.
 *
 * ? Searches in the STYLESHEETPATH before TEMPLATEPATH and wp-includes/theme-compat
 * ? so that themes which inherit from a parent theme can just overload one file.
 *
 ** @origin WordPress - Nuke Evolution Xtreme developers take no credit for this code.
 *
 * @since 2.0.10
 *
 * @param string|array $template_names Template file(s) to search for, in order.
 * @param bool         $load           If true the template file will be loaded if it is found.
 * @param bool         $require_once   Whether to require_once or require. Has no effect if `$load` is false.
 *                                     Default true.
 * @param array        $args           Optional. Additional arguments passed to the template.
 *                                     Default empty array.
 * @return string The template filename if one is located.
 */
function locate_template( $template_names, $load = false, $require_once = true, $args = array() ) {
	global $module_name, $ThemeSel;
	define_once( 'TEMPLATEPATH', 'themes/' . $ThemeSel );
	$located = '';
	foreach ( (array) $template_names as $template_name ) {

		if ( ! $template_name ) {
			continue;
		}

		if ( file_exists( TEMPLATEPATH . '/' . $template_name ) ) {
			$located = TEMPLATEPATH . '/' . $template_name;
			break;
		}
		elseif ( file_exists( NUKE_MODULES_DIR . $module_name . '/' . $template_name ) ) {
			$located = NUKE_MODULES_DIR . $module_name . '/' . $template_name;
			break;
		}
		elseif ( file_exists( NUKE_INCLUDE_DIR . 'theme-compat/' . $template_name ) ) {
			$located = NUKE_INCLUDE_DIR . 'theme-compat/' . $template_name;
			break;
		}
	}

	if ( $load && '' !== $located ) {
		load_template( $located, $require_once, $args );
	}
}

/**
 * Require the template file with WordPress environment.
 *
 * The globals are set up for the template file to ensure that the WordPress
 * environment is available from within the function. The query variables are
 * also available.
 *
 * @origin WordPress - Nuke Evolution Xtreme developers take no credit for this code.
 *
 * @since 2.0.10
 *
 * @param string $_template_file Path to template file.
 * @param bool   $require_once   Whether to require_once or require. Default true.
 * @param array  $args           Optional. Additional arguments passed to the template.
 *                               Default empty array.
 */
function load_template( $_template_file, $require_once = true, $args = array() ) {
	if ( $require_once ) {
		require_once $_template_file;
	} else {
		require $_template_file;
	}
}