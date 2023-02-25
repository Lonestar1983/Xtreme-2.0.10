<?php
/**
 * PHP-NUKE: Web Portal System
 *
 * Copyright (c) 2002 by Francisco Burzi
 * http://phpnuke.org
 *
 * This program is free software. You can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License.
 */

if ( ! defined( 'NUKE_EVO' ) ) {
	die( "You can't access this file directly..." );
}

global $db, $prefix, $cache;

if ( ( $metatags = $cache->load( 'metatags', 'config' ) ) === false ) {
	$metatags = array();
	$result   = dbquery( "SELECT meta_name, meta_content FROM " . $prefix . "_meta" );
	$i        = 0;
	while( list( $meta_name, $meta_content ) = dbrow( $result ) ) {
		$metatags[ $i ]                 = array();
		$metatags[ $i ]['meta_name']    = $meta_name;
		$metatags[ $i ]['meta_content'] = $meta_content;
		++$i;
	}
	unset( $i );
	dbfree( $result );
	cache_set( 'metatags', 'config', $metatags );
}

?>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="<?php echo _LANGCODE; ?>">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<?php
for( $i = 0, $j = count( $metatags ); $i < $j; ++$i ) {
	$metatag = $metatags[ $i ];
	?>
	<meta name="<?php echo $metatag['meta_name']; ?>" content="<?php echo $metatag['meta_content']; ?>">
	<?php
}
?>

<meta name="generator" content="PHP-Nuke Copyright (c) 2006 by Francisco Burzi. This is free software, and you may redistribute it under the GPL (http://phpnuke.org/files/gpl.txt). PHP-Nuke comes with absolutely no warranty, for details, see the license (http://phpnuke.org/files/gpl.txt). Powered by Nuke-Evolution (http://www.nuke-evolution.com).">
