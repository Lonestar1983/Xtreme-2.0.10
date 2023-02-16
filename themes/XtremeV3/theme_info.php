<?php

/*-----------------------------------------------------------*/
/* Realm Designz Advanced Theme Features                     */
/* =====================================                     */
/* Copyright (c) 2019 By The RealmDesignz Designers Team     */
/*                                                           */
/* Theme Name: XtremeV3                                      */
/* Author    : The Mortal (www.RealmDesignz.com)             */
/* Version   : v3.0                                          */
/* Created On: 25th December, 2018                           */
/* Purpose   : Evolution-Xtreme v3 CMS                       */
/*                                                           */
/* Notes     : Very Nice Grey Style Design.                  */
/*-----------------------------------------------------------*/

if (realpath(__FILE__) == realpath($_SERVER['SCRIPT_FILENAME']))
	exit('Quit trying to hack my website!');

$current_theme = basename(dirname(__FILE__));

global $ThemeInfo, $param_names, $params, $default;

$param_names = array(
	'Theme Width<br /><span class="textmed">90% = 90% | 1280 = 1280px | 1368 = 1368px</span>',
	'Text Color 1',
	'Text Color 2',
	'Foot Message 1',
	'Foot Message 2',
	'Scroll to Top Hover Color',
	'reCaptcha Skin<br /><span class="textmed">white | dark</span>'
);

$params = array(
	'themewidth',
	'textcolor1',
	'textcolor2',
	'fms1',
	'fms2',
	'uitotophover',
	'recaptcha_skin'
);

$default = array(
	'1368',
	'#ccc',
	'#ccc',
	'Go to Theme Options to Edit Footer Message Line 1',
	'Go to Theme Options to Edit Footer Message Line 2',
	'#D29A2B',
	'dark'
);

$ThemeInfo = LoadThemeInfo( $current_theme );
