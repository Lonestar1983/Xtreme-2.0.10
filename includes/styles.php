<?php
/**
 *	Nuke-Evolution: Evolution CSS
 *	============================================
 *	Copyright (c) 2005 - 2023 by The Nuke-Evolution Team
 *
 *	Filename      : styles.php
 *	Author        : The Nuke-Evolution Team
 *	Version       : 1.5.0
 *	Date          : 12.14.2005 (mm.dd.yyyy)
 *
 *	Notes         : Miscellaneous CSS
 */

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

global $ThemeInfo;

if ( defined( 'ADMIN_FILE' ) ) {
	evo_include_style( 'admin-blocks', NUKE_CSS_DIR . 'admin-blocks.css', EVO_BUILD );
}

/**
 * Added most of the icons that are used in Evolution Xtreme into a sprite.
 *
 * @since 2.0.9e
 */
evo_include_style( 'evo-miscellaneous-styles', NUKE_CSS_DIR . 'miscellaneous-styles.min.css', EVO_BUILD );
evo_include_style( 'evo-images-core', NUKE_CSS_DIR . 'images-core.min.css', EVO_BUILD );
evo_include_style( 'evo-images-flags', NUKE_CSS_DIR . 'images-flags.min.css', EVO_BUILD );
evo_include_style( 'evo-images-rating-stars', NUKE_CSS_DIR . 'images-rating-stars.min.css', EVO_BUILD );
