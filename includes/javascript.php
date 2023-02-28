<?php
/************************************************************************/
/* PHP-NUKE: Web Portal System                                          */
/* ===========================                                          */
/*                                                                      */
/* Copyright (c) 2002 by Francisco Burzi                                */
/* http://phpnuke.org                                                   */
/*                                                                      */
/* This program is free software. You can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 2 of the License.       */
/************************************************************************/

/***************************************************************************
 *   This file is part of the phpBB2 port to Nuke 6.0 (c) copyright 2002
 *   by Tom Nitzschner (tom@toms-home.com)
 *   http://bbtonuke.sourceforge.net (or http://www.toms-home.com)
 *
 *   As always, make a backup before messing with anything. All code
 *   release by me is considered sample code only. It may be fully
 *   functual, but you use it at your own risk, if you break it,
 *   you get to fix it too. No waranty is given or implied.
 *
 *   Please post all questions/request about this port on http://bbtonuke.sourceforge.net first,
 *   then on my site. All original header code and copyright messages will be maintained
 *   to give credit where credit is due. If you modify this, the only requirement is
 *   that you also maintain all original copyright messages. All my work is released
 *   under the GNU GENERAL PUBLIC LICENSE. Please see the README for more information.
 *
 ***************************************************************************/

if (realpath(__FILE__) == realpath($_SERVER['SCRIPT_FILENAME'])) {
	exit('Access Denied');
}

// global $sentineladmin;
// if ( ! defined( 'FORUM_ADMIN' ) ) {
// 	evo_include_script( 'nuke-sentinel-overlib', 'includes/nukesentinel/overlib.js', EVO_BUILD, true );
// 	evo_include_script( 'nuke-sentinel-overlib-hideform', 'includes/nukesentinel/overlib_hideform.js', EVO_BUILD, true );
// 	evo_include_script( 'nuke-sentinel-script-3', 'includes/nukesentinel/nukesentinel3.js', EVO_BUILD, true );
// }


// if (isset($userpage)) {
//     echo "<script type=\"text/javascript\">\n";
//     echo "<!--\n";
//     echo "function showimage() {\n";
//     echo "if (!document.images)\n";
//     echo "return\n";
//     echo "document.images.avatar.src=\n";
//     echo "'$nukeurl/modules/Forums/images/avatars/gallery/' + document.Register.user_avatar.options[document.Register.user_avatar.selectedIndex].value\n";
//     echo "}\n";
//     echo "//-->\n";
//     echo "</script>\n\n";
// }

// global $name;
// if (defined('MODULE_FILE') && !defined("HOME_FILE") AND file_exists("modules/".$name."/copyright.php")) {
//     echo "<script type=\"text/javascript\">\n";
//     echo "<!--\n";
//     echo "function openwindow(){\n";
//     echo "    window.open (\"modules/".$name."/copyright.php\",\"Copyright\",\"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,copyhistory=no,width=400,height=200\");\n";
//     echo "}\n";
//     echo "//-->\n";
//     echo "</script>\n\n";
// }


// if ( ! defined( 'ADMIN_FILE' ) ) {
//     addJSToHead( NUKE_JQUERY_SCRIPTS_DIR . 'javascript/anti-spam.js', 'file', true );
// }


/*****[BEGIN]******************************************
 [ Mod:     Advanced Security Code Control     v1.0.0 ]
 ******************************************************/
// if ( get_evo_option('recap_site_key') && get_evo_option('recap_priv_key') )
//     echo "<script src='https://www.google.com/recaptcha/api.js".(!empty(get_evo_option('recap_lang')) ? "?hl=".get_evo_option('recap_lang') : "")."' defer></script>";
 /*****[END]*******************************************
 [ Mod:     Advanced Security Code Control     v1.0.0 ]
 ******************************************************/


// global $admin_file;
// if(isset($name) && ($name == "Your Account" || $name == "Your_Account" || $name == "Profile" || defined('ADMIN_FILE'))) {
// 	echo '<script type="text/javascript">
// 	var pwd_strong = "'.PSM_STRONG.'";
// 	var pwd_stronger = "'.PSM_STRONGER.'";
// 	var pwd_strongest = "'.PSM_STRONGEST.'";
// 	var pwd_notrated = "'.PSM_NOTRATED.'";
// 	var pwd_med = "'.PSM_MED.'";
// 	var pwd_weak = "'.PSM_WEAK.'";
// 	var pwd_strength = "'.PSM_CURRENTSTRENGTH.'";
// </script>';
// echo "<script type=\"text/javascript\" src=\"".NUKE_JQUERY_SCRIPTS_DIR."javascript/password_strength.js\" defer></script>\n";
// }

// if (defined('ADMIN_FILE')) {
// 	echo "<script type=\"text/javascript\">\n";
// 	echo "<!--\n";
// 	echo "function themepreview(theme){\n";
// 	echo "window.open (\"index.php?tpreview=\" + theme + \"\",\"ThemePreview\",\"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,copyhistory=no,width=1000,height=800\");\n";
// 	echo "}\n";
// 	echo "//-->\n";
// 	echo "</script>\n\n";
// }

if (defined('ADMIN_FILE') && defined('USE_DRAG_DROP')) {
	global $element_ids, $Sajax;

	if ( isset( $Sajax ) && is_object( $Sajax ) ) {
		echo "<script>\n<!--\n";
		echo $Sajax->sajax_show_javascript();
		echo "//-->\n";
		echo "</script>\n";
	}

	$i          = 0;
	$script_out = '';

	if ( ! is_array( $element_ids ) ) {
		$element_ids = array();
	}

	foreach ( $element_ids as $id ) {
		if ( ! $i ) {
			$script_out .= "var list = document.getElementById(\"" . $id . "\");\n";
			++$i;
		} else {
			$script_out .= "list = document.getElementById(\"" . $id . "\");\n";
		}

		global $g2;
		$script_out .= ( ! $g2 ) ? "DragDrop.makeListContainer( list, 'g1' );\n" : "DragDrop.makeListContainer( list, 'g2' );\n";
		$script_out .= "list.onDragOut = function() {this.style[\"background\"] = \"none\"; };\n\n\n";
		$script_out .= "list.onDragDrop = function() {onDrop(); };\n";
	}

	//echo "<link rel=\"stylesheet\" href=\"includes/ajax/lists.css\" type=\"text/css\">";
	echo "<script src=\"includes/ajax/coordinates.js\" defer></script>\n";
	echo "<script src=\"includes/ajax/drag.js\" defer></script>\n";
	echo "<script src=\"includes/ajax/dragdrop.js\" defer></script>\n";
	echo "<script><!--
	function confirm(z) {
	  window.status = 'Sajax version updated';
	}

	function create_drag_drop() {";
		echo $script_out;
	echo "};

	if (window.addEventListener)
		window.addEventListener(\"load\", create_drag_drop, false)
	else if (window.attachEvent)
		window.attachEvent(\"onload\", create_drag_drop)
	else if (document.getElementById)
		womAdd('create_drag_drop()');
	//-->
</script>\n";
}

/**
 * Font Awesome
 *
 * JavaScript library for DOM operations
 *
 * @author  Fonticons, Inc
 * @version 6.1.1
 * @license MIT
 * @link    https://fontawesome.com
 */
evo_include_style( 'fontawesome', NUKE_CSS_DIR . 'fontawesome.css', '6.1.1' );

// global $analytics;
// if (!empty($analytics)) {
// 	echo "<script type=\"text/javascript\">
// 			var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");
// 			document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));
// 		  </script>
// 		  <script type=\"text/javascript\">
// 			var pageTracker = _gat._getTracker(\"".$analytics."\");
// 			pageTracker._initData();
// 			pageTracker._trackPageview();
// 		  </script>";
// }

// global $more_js;
// if (!empty($more_js)) {
//     echo $more_js;
// }
