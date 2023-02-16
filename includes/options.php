<?php

/**
 * Loads and caches all board options.
 *
 * @since 2.0.10
 *
 * @return array List of all options.
 */
function evo_load_all_board_options() {
	if ( ! evo_installing() ) {
		$alloptions = cache_load( 'board_config', 'config' );
	} else {
		$alloptions = false;
	}

	if ( ! $alloptions ) {

		$alloptions_db = dburowset( "SELECT config_name, config_value FROM " . CONFIG_TABLE . "" );

		$alloptions = array();
		foreach ( (array) $alloptions_db as $c ) {
			$alloptions[ $c['config_name'] ] = $c['config_value'];
		}

		if ( ! evo_installing() ) {
			cache_set( 'board_config', 'config', $alloptions );
		}
	}

	return $alloptions;
}

function get_board_option( $option, $default = false ) {
	if ( is_scalar( $option ) ) {
		$option = trim( $option );
	}

	if ( empty( $option ) ) {
		return false;
	}

	// Distinguish between `false` as a default, and not passing one.
	$passed_default = func_num_args() > 1;

	if ( ! evo_installing() ) {
		$alloptions = evo_load_all_board_options();
		$option = $alloptions[ $option ];
	}

	return $option;
}

/**
 * Loads the entire evo config
 *
 * @author JeFFb68CAM
 *
 * @return array
 */
function load_evoconfig() {
    global $db, $cache, $debugger;

    if ((($evoconfig = $cache->load('evoconfig', 'config')) === false) || empty($evoconfig)) {
        $evoconfig = array();
        $result = $db->sql_query('SELECT `evo_field`, `evo_value` FROM '._EVOCONFIG_TABLE.' WHERE `evo_field` != "cache_data"');
        while(list($evo_field, $evo_value) = $db->sql_fetchrow($result)) {
            if($evo_field != 'cache_data') {
                $evoconfig[$evo_field] = $evo_value;
            }
        }
        $sql = "SELECT `config_value` FROM " . _CNBYA_CONFIG_TABLE . " WHERE `config_name` = 'allowusertheme'";
        if( !($resultcnbya = $db->sql_query($sql))) {
            $debugger->handle_error("Could not query cnbya config information", 'Error');
        }
        $row = $db->sql_fetchrow($resultcnbya);
        $evoconfig['allowusertheme'] = $row['config_value'];
        $sql = 'SELECT `word`, `replacement` FROM `'.WORDS_TABLE.'`';
        if( !($resultwords = $db->sql_query($sql))) {
            $debugger->handle_error("Could not query bad words information", 'Error');
        }
        while(list($word, $replacement) = $db->sql_fetchrow($resultwords)) {
            $wordrow[$word] = $replacement;
        }
        $evoconfig['censor_words'] = $wordrow;

        $cache->save('evoconfig', 'config', $evoconfig);
        $db->sql_freeresult($result);
    }
    if(is_array($evoconfig)) {
        return $evoconfig;
    } else {
        $cache->delete('evoconfig', 'config');
        $debugger->handle_error('There is an error in your evoconfig data', 'Error');
        return array();
    }
}

/**
 * Grab a evolution core setting.
 *
 * @since 2.0.9e
 *
 * @param string  $name      The variable to wish to retrieve.
 * @param mixed   $type      This can be a mixed option, available "string" or "integer".
 * @return mixed  The requested database variable.
 */
function get_evo_option( $name, $type = 'string' ) {
	global $evoconfig;
	return ( 'string' === $type ) ? $evoconfig[ $name ] : (int) $evoconfig[ $name ];
}

/**
 * Loads all the nuke config options
 *
 * @author JeFFb68CAM
 *
 * @return array
 */
function load_nukeconfig() {
	global $db, $cache, $debugger;

	if ( ( ( $nukeconfig = cache_load( 'nukeconfig', 'config' ) ) === false ) || empty( $nukeconfig ) ) {
		$nukeconfig = dburow( "SELECT * FROM " . _NUKE_CONFIG_TABLE . "" );

		if ( ! $nukeconfig ) {
			if ( $prefix != 'nuke' ) {
				$nukeconfig = dburow( "SELECT * FROM " . _NUKE_CONFIG_TABLE ."" );
				if ( is_array( $nukeconfig ) ) {
					die ( "Please change your $prefix in config.php to 'nuke'.  You might have to do the same for the $user_prefix" );
				}
			}
		}

		$nukeconfig = str_replace('\\"', '"', $nukeconfig);
		cache_set( 'nukeconfig', 'config', $nukeconfig );
		dbfree( $nukeconfig );
	}

	if ( is_array( $nukeconfig ) ) {
		return $nukeconfig;
	} else {
		cache_delete( 'nukeconfig', 'config' );
		$debugger->handle_error(
			'There is an error in your nuke_config data',
			'Error'
		);
		return array();
	}
}
