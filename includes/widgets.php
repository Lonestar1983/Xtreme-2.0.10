<?php
/**
 * Core Widgets
 *
 * @package EvolutionXtreme
 * @subpackage Widgets
 */

if ( realpath( __FILE__ ) == realpath( $_SERVER['SCRIPT_FILENAME'] ) ) {
	exit( 'Access Denied' );
}

/**
 * Determines whether an installed module is currently active.
 *
 * @since 1.0.5
 *
 * @param string  $module    Module to be checked.
 * @return string True, If module is active, False otherwise.
 */
function is_active( $module ) {
	static $active_modules;

	if ( is_array( $active_modules ) ) {
		return isset( $active_modules[ $module ] ) ? true : false;
	}

	if ( ( ( $active_modules = cache_load( 'active_modules', 'config' ) ) === false ) || empty( $active_modules ) ) {
		$active_modules = array();
		$result         = dbquery( "SELECT title FROM " . _MODULES_TABLE . " WHERE active = '1'" );
		while( list( $title ) = dbrow( $result ) ) {
			$active_modules[ $title ] = true;
		}
		dbfree( $result );
		cache_set( 'active_modules', 'config', $active_modules );
	}

	return isset( $active_modules[ $module ] ) ? true : false;
}

/**
 * Determines whether an installed module is currently active.
 *
 * @since 1.0.5
 *
 * @param string  $side     Side the block has been placed.
 * @param array   $block    Block data.
 * @return mixed
 */
function render_blocks( $side, $block ) {
	global $plus_minus_images, $currentlang, $collapse, $collapsetype;

	define_once( 'BLOCK_FILE', true );

	if ( file_exists( NUKE_LANGUAGE_DIR . 'blocks/lang-' . $currentlang . '.php' ) ) {
		include_once NUKE_LANGUAGE_DIR . 'blocks/lang-' . $currentlang . '.php';
	} else {
		include_once NUKE_LANGUAGE_DIR . 'blocks/lang-english.php';
	}

	if ( empty( $block['url'] ) ) {
		if ( empty( $block['blockfile'] ) ) {
			if ( $side == 'c' || $side == 'd' ) {
				themecenterbox(
					$block['title'],
					decode_bbcode( $block['content'], 1, true )
				);
			} else {
				themesidebox(
					$block['title'],
					decode_bbcode( $block['content'], 1, true ),
					$block['bid']
				);
			}
		} else {
			blockfileinc( $block['title'], $block['blockfile'], $side, $block['bid'] );
		}
	} else {
		headlines( $block['bid'], $side, $block );
	}
}

/**
 * Determines whether an active block is visible.
 *
 * @since 1.0.5
 *
 * @param string  $side     Side the block has been placed.
 * @return bool True, If block is visible, False otherwise.
 */
function blocks_visible( $side ) {
	global $showblocks;

	$showblocks = ( $showblocks == null ) ? 3 : $showblocks;
	$side       = strtolower( $side[0] );

	// If there are no blocks for this module && not admin file
	if ( ! $showblocks && ! defined( 'ADMIN_FILE' ) ) {
		return false;
	}

	// If in the admin show l blocks
	if ( defined( 'ADMIN_FILE' ) ) {
		return true;
	}

	// If set to 3 its all blocks
	if ( $showblocks == 3 ) {
		return true;
	}

	// Count the blocks on the side
	$blocks = blocks( $side, true );

	// If there are no blocks
	if ( ! $blocks ) {
		return false;
	}

	// Check for blocks to show
	if ( ( $showblocks == 1 && $side == 'l' ) || ( $showblocks == 2 && $side == 'r' ) ) {
		return true;
	}

	return false;
}

/**
 * Determines whether an active block is visible.
 *
 * @since 1.0.5
 *
 * @param string  $side     Side the block has been placed.
 * @param array   $count    count the number of blocks.
 * @return bool True, If block is visible, False otherwise.
 */
function blocks( $side, $count = false ) {
	global $prefix, $multilingual, $currentlang, $db, $userinfo, $cache;
	static $blocks;

	$querylang = ( $multilingual ) ? 'AND (blanguage = "' . $currentlang . '" OR blanguage = "")' : '';
	$side      = strtolower( $side[0] );

	if ( ( ( $blocks = cache_load( 'blocks', 'config' ) ) === false ) || ! isset( $blocks ) ) {
		$result = dbquery( "SELECT * FROM " . _BLOCKS_TABLE . " WHERE active = '1' " . $querylang . " ORDER BY weight ASC" );
		while( $row = dbrow( $result ) ) {
			$blocks[ $row['bposition'] ][] = $row;
		}
		dbfree( $result );
		cache_set( 'blocks', 'config', $blocks );
	}

	if ( $count ) {
		return isset($blocks[ $side ] ) ? count( $blocks[ $side ] ) : 0;
	}

	$blockrow = ( isset( $blocks[ $side ] ) ) ? $blocks[ $side ] : array();
	for( $i = 0, $j = count( $blockrow ); $i < $j; ++$i ) {
		$bid  = (int) $blockrow[ $i ]['bid'];
		$view = (int) $blockrow[ $i ]['view'];

		if ( isset( $blockrow[ $i ]['expire'] ) ) {
			$expire = (int) $blockrow[ $i ]['expire'];
		} else {
			$expire = '';
		}

		if ( isset( $blockrow[ $i ]['action'] ) ) {
			$action = $blockrow[ $i ]['action'];
			$action = substr( $action, 0, 1 );
		} else {
			$action = '';
		}

		$now = time();
		if ( $expire != 0 AND $expire <= $now ) {
			if ( $action == 'd' ) {
				dbquery( "UPDATE " . _BLOCKS_TABLE . " SET active = '0', expire = '0' WHERE bid = '" . $bid . "'" );
				cache_delete( 'blocks', 'config' );
				return;
			} elseif ($action == 'r') {
				dbquery( "DELETE FROM " . _BLOCKS_TABLE . " WHERE bid = '" . $bid . "'" );
				cache_delete( 'blocks', 'config' );
				return;
			}
		}

		if ( empty( $blockrow[ $i ]['bkey'] ) ) {
			if ( ( $view == '0' || $view == '1') ||
			   ( ( $view == '3' AND is_user()) ) ||
			   ( $view == '4' AND is_admin()) ||
			   ( ( $view == '2' AND !is_user() ) ) ) {
				render_blocks( $side, $blockrow[ $i ] );
			} else {
				if ( substr( $view, strlen( $view ) -1 ) == '-' ) {
					$ingroups = explode( '-', $view );
					if ( is_array( $ingroups ) ) {
						$cnt = 0;
						foreach ( $ingroups as $group ) {
							if ( isset( $userinfo['groups'][ $group ] ) ) {
								++$cnt;
							}
						}

						if ( $cnt != 0 ) {
							render_blocks( $side, $blockrow[ $i ] );
						}
					}
				}
			}
		}
	}
	return;
}

function blockfileinc( $blockfiletitle, $blockfile, $side = 1, $bid ) {
	global $collapse;

	if ( ! file_exists( NUKE_BLOCKS_DIR . $blockfile ) ) {
		$content = _BLOCKPROBLEM;
	} else {
		include NUKE_BLOCKS_DIR . $blockfile;
	}

	if ( empty( $content ) ) {
		$content = _BLOCKPROBLEM2;
	}

	if ( $side == 'r' || $side == 'l' ) {
		themesidebox( $blockfiletitle, $content, $bid );
	} else {
		themecenterbox( $blockfiletitle, $content );
	}
}

function headlines($bid, $side=0, $row='') {
	global $prefix, $db, $my_headlines, $cache;
	if(!$my_headlines) return;
	$bid = intval($bid);
	if (!is_array($row)) {
		$row = $db->sql_ufetchrow('SELECT `title`, `content`, `url`, `refresh`, `time` FROM `'.$prefix.'_blocks` WHERE `bid`='.$bid);
	}
	$content =& trim($row['content']);
	if ($row['time'] < (time()-$row['refresh']) || empty($content)) {
		$content = rss_content($row['url']);
		$btime = time();
		$db->sql_query("UPDATE `".$prefix."_blocks` SET `content`='".Fix_Quotes($content)."', `time`='$btime' WHERE `bid`='$bid'");
		$cache->delete('blocks', 'config');
	}
	if (empty($content)) {
		$content = _RSSPROBLEM.' ('.$row['title'].')';
	}
	$content = '<span class="content">'.$content.'</span>';
	if ($side == 'c' || $side == 'd') {
		themecenterbox($row['title'], $content);
	} else {
		themesidebox($row['title'], $content, $bid);
	}
}