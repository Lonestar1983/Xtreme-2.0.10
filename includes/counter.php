<?php
/*=======================================================================
 Nuke-Evolution Basic: Enhanced PHP-Nuke Web Portal System
 =======================================================================*/

/************************************************************************
   Nuke-Evolution: Advanced Content Management System
   ============================================
   Copyright (c) 2005 by The Nuke-Evolution Team

   Filename      : counter.php
   Author        : Quake (www.nuke-evolution.com)
   Version       : 2.0.0
   Date          : 5/10/2005 (dd-mm-yyyy)

   Notes         : Counter for Stats module. Tracks with thanks to the Identify Class
				   Also tracks search bots.
************************************************************************/

if ( defined( 'COUNTER' ) ) {
	return;
}
define( 'COUNTER', 1 );

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

global $prefix, $db, $browser, $agent;

if ( ! empty( $agent['engine'] ) && $agent['engine'] == 'bot' ) {
	$browser = 'Bot';
} elseif ( ! empty( $agent['ua'] ) ) {
	$browser = $agent['ua'];
} else {
	$browser = 'Other';
}

if ( ! empty( $agent['os'] ) ) {
	$os = $agent['os'];
} else {
	$os = 'Other';
}

$now = explode( '-', date( 'd-m-Y-H' ) );
$result = dbquery( "UPDATE " . _COUNTER_TABLE . " SET count = count + 1 WHERE (var = '$browser' AND type = 'browser') OR (var = '$os' AND type = 'os') OR (type = 'total' AND var = 'hits')" );
dbfree( $result );

if ( ! dbquery( "UPDATE " . _STATS_HOUR_TABLE . " SET hits = hits + 1 WHERE (year = '$now[2]') AND (month = '$now[1]') AND (date = '$now[0]') AND (hour = '$now[3]')" ) || ! $db->sql_affectedrows() ) {
	dbquery( "INSERT INTO " . _STATS_HOUR_TABLE . " VALUES ('$now[2]', '$now[1]', '$now[0]', '$now[3]', '1')" );
}
dbfree( $result );
