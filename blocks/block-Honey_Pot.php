<?php
/************************************************************************/
/* Nuke HoneyPot - Antibot Script                                       */
/* ==============================                                       */
/*                                                                      */
/* Copyright (c) 2013 coRpSE			                                */
/* http://www.headshotdomain.net                                        */
/*                                                                      */
/* This program is free software. You can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation; either version 2 of the License.       */
/************************************************************************/

defined( 'NUKE_EVO' ) || exit;

global $db, $prefix, $admin_file, $blockslang;

function block_Honeypot_cache( $block_cachetime ) {
	if ( ( ( $blockcache = cache_load( 'honeypot', 'blocks' ) ) === false) || empty( $blockcache ) || (int) $blockcache[0]['stat_created'] < (time() - (int) $block_cachetime ) ) {
		$result = dburow( "SELECT COUNT(id) AS count FROM " . _HONEYPOT_TABLE );
		$blockcache[0]['stat_created'] = time();
		$blockcache[1]['count']        = $result['count'];
		dbfree( $result );
		cache_set( 'honeypot', 'blocks', $blockcache );
	}
	return $blockcache;
}

$blocksession = block_Honeypot_cache( $evoconfig['block_cachetime'] );

$content  = '<div class="center">';

if ( $side == 'c' || $side == 'd' ) {
	$content .= '  <img src="images/honeypot/hp_banner.png" style="height: 110px; width: 369px" alt="'.$blockslang['honeypot']['bots_in_pot'].'" title="'.$blockslang['honeypot']['bots_in_pot'].'" />';
} else {
	$content .= '  <img src="images/honeypot/hp_banner2.png" style="height: 109px; width: 120px" alt="'.$blockslang['honeypot']['bots_in_pot'].'" title="'.$blockslang['honeypot']['bots_in_pot'].'" />';
}

if ( $blocksession[1]['count'] > 0 && is_admin() ) {
	$content .= '  <hr>'.sprintf( $blockslang['honeypot']['bots_stopped'], '<span class="textbold">', '<a href="' . get_admin_filename() . '.php?op=honeypot">' . $blocksession[1]['count'] . '</a>', '</span>');
} else {
	$content .= '  <hr>'.sprintf( $blockslang['honeypot']['bots_stopped'], '<span class="textbold">', $blocksession[1]['count'], '</span>');
}

$content .= '  <hr><a href="https://www.headshotdomain.net" target="_blank">HeadShotDomain</a>';
$content .= '</div>';
