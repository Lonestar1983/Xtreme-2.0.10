<?php
/***************************************************************************
 *                              memberlist.php
 *                            -------------------
 *   begin                : Friday, May 11, 2001
 *   copyright            : (C) 2001 The phpBB Group
 *   email                : support@phpbb.com
 *
 *   $Id: memberlist.php,v 1.36.2.10 2004/07/11 16:46:15 acydburn Exp $
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 ***************************************************************************/

/**
 * ! Modifications made by Lonestar of <https://lonestar-modules.com>
 *
 * ? Several modifications made to make the module more responsive friendly,
 * ? until I rebuild the forums from scratch.
 */

defined( 'NUKE_EVO' ) || exit;

require NUKE_FORUMS_DIR . '/nukebb.php';

define( 'IN_PHPBB', true );
include $phpbb_root_path . 'extension.inc';
include $phpbb_root_path . 'common.' . $phpEx;

$userdata = session_pagestart( $user_ip, PAGE_VIEWMEMBERS );
init_userprefs( $userdata );

global $board_config;

/**
 * ? Set the page title.
 */
$page_title = $lang['Memberlist'];

/**
 * ? Pagination
 */
$page     = get_query_var('page', 'get', 'int', 1);
$calc     = $board_config['topics_per_page'] * $page;
$start    = $calc - $board_config['topics_per_page'];
$alphanum = get_query_var( 'alphanum', 'get' );
$query    = get_query_var( 'q', 'request' );
$field    = get_query_var( 'f', 'request', 'string', 'id' );

include NUKE_INCLUDE_DIR . 'page_header.php';

$template->set_filenames(
	array(
		'body' => 'memberlist_body.tpl'
	)
);

$where  = '';
$where .= isset( $query ) ? " && username LIKE '%" . $query . "%'" : "";

// ? Sort the users
$sorting = array(
	'id'        => ' ORDER BY user_id DESC',
	'lastvisit' => ' ORDER BY user_lastvisit DESC',
	'name'      => ' ORDER BY username ASC'
);

$order_by  = '';
$order_by .= isset( $field ) ? $sorting[ $field ] : '';

// ? Page queries are for use with pagination links.
$page_queries  = '';
$page_queries .= isset( $query ) ? "&q=" . $query : "";
$page_queries .= isset( $order_by ) ? "&f=" . $field : "";

$template->assign_vars(
	array(
		'L_AGE'                => $lang['Sort_Age'],
		'L_ABOUT_ME'           => $lang['Extra_Info'],
		'L_AVATAR'             => $lang['Avatar'],
		'L_BIRTHDAY'           => $lang['Birthday'],
		'L_EMAIL'              => $lang['Email'],
		'L_FIND_USERNAME'      => $lang['Find_username'],
		'L_FOLLOW'             => $lang['Follow_Me'],
		'L_GO'                 => $lang['Sort_Go'],
		'L_INTRODUCTION'       => $lang['introduction'],
		'L_JOINED'             => $lang['Joined'],
		'L_LAST_ACTIVE'        => $lang['last_active'],
		'L_LAST_VISIT'         => $lang['User_last_visit'],
		'L_LOCATION'           => $lang['Location'],
		'L_LOOK_UP'            => $lang['Look_up_User'],
		'L_MEMBERINFO'         => $lang['member_info'],
		'L_MEMBERLIST'         => $lang['Memberlist'],
		'L_NEWEST_REGISTERED'  => $lang['newest_registered'],
		'L_ORDER'              => $lang['Order'],
		'L_PAGE_TITLE'         => $lang['Memberlist'],
		'L_POSTS'              => $lang['Posts'],
		'L_REGISTERED'         => $lang['registered'],
		'L_RELATIONSHIP'       => $lang['relationship'],
		'L_YEARS_OLD'          => $lang['years'],
		'L_SORT_METHOD'        => $lang['Select_sort_method'],
		'L_STATUS'             => $lang['Online_status'],
		'L_WEBSITE'            => $lang['Website'],

		'L_STEAM'              => $lang['steam'],
		'L_FACEBOOK'           => $lang['facebook'],
		'L_INSTAGRAM'          => $lang['instagram'],
		'L_TWITTER'            => $lang['twitter'],
		'L_TWITCH'             => $lang['twitch'],
		'L_USERNAME'           => $lang['Username'],
		'L_YOUTUBE'            => $lang['youtube'],

		// ? Search queries
		'ORDER_USER_ID'        => isset( $field ) && $field == 'id' ? 'selected' : '',
		'ORDER_USER_LASTVISIT' => isset( $field ) && $field == 'lastvisit' ? 'selected' : '',
		'ORDER_USERNAME'       => isset( $field ) && $field == 'name' ? 'selected' : '',

		// ? Form action
		'S_MODE_ACTION'        => append_sid( "memberlist.$phpEx" )
	)
);

/**
 * ? Members loop
 *
 * todo: Modify query to no longer count the users marked as "DELETED", As they are no longer able to post, why count them?.
 */
$sql = "SELECT * FROM " . USERS_TABLE . " WHERE user_id <> " . ANONYMOUS . " && user_level != -1" . $where . $order_by . " LIMIT " . $start . ", " . $board_config['topics_per_page'];
if ( ! ( $result = dbquery( $sql ) ) ) :
	message_die( GENERAL_ERROR, 'Could not query users', '', __LINE__, __FILE__, $sql );
endif;

/**
 * ? Count the total users registered.
 */
$totalUsers = dbunumrows( "SELECT * FROM " . USERS_TABLE . " WHERE user_id <> " . ANONYMOUS ."  && user_level != -1" . $where );

$i = 0;
while ( $row = dbrow( $result ) ) :

	/**
	 * ? Show the users current status, whether they be Online, Offline or Hidden,
	 * ? Hidden users are only visible to those with permission.
	 *
	 * ? default status is "Offline".
	 */
	$status       = $lang['Offline'];
	$status_style = $offline_color;
	$status_class = 'class="__user-offline"';
	/**
	 * ? If the users session time is greater than the current timestamp + online time set in forum admin, the user is online.
	 */
	if ( $row['user_session_time'] >= ( time() - $board_config['online_time'] ) && $row['user_allow_viewonline'] ):
		$status       = $lang['Online'];
		$status_style = $online_color;
		$status_class = 'class="__user-online"';
	/**
	 * ? If the user has requested to hide their online status from the public eye,
	 * ? Administrators will always see their status.
	 */
	elseif ( $row['user_session_time'] >= ( time() - $board_config['online_time'] )
		&& $userdata['user_level'] == ADMIN
		|| $userdata['user_id'] == $row['user_id'] ):
		$status       = $lang['Hidden'];
		$status_style = $hidden_color;
		$status_class = 'class="__user-hidden"';
	endif;

	/*---------------------------------------------------------------------------------------------------------------------------------------------*/

	/**
	 * ? Calculate users birthday/age
	 */
	preg_match( '/(..)(..)(....)/', sprintf( '%08d', $userdata['user_birthday'] ), $bday_parts );

	$birthday = $birthday_age = $birthday_age_alt = '';
	if ( $bday_parts[3] != 0000 ) {
		if ( $userdata['user_birthday'] != 0
			&& $userdata['birthday_display'] != 1
			&& $userdata['birthday_display'] != 3
			|| $userdata['birthday_display'] == 0
		) {
			$bday_month_day   = floor( $userdata['user_birthday'] / 10000 );
			$bday_year_age    = ( $userdata['birthday_display'] != BIRTHDAY_NONE && $userdata['birthday_display'] != BIRTHDAY_DATE )
									? $userdata['user_birthday'] - 10000 * $bday_month_day
									: 0;
			$fudge            = ( gmdate('md') < $bday_month_day ) ? 1 : 0;
			$birthday_age     = ( $bday_year_age ) ? gmdate( 'Y' ) - $bday_year_age - $fudge : '';
			$birthday_age_alt = ' ( ' . $birthday_age . ' )';
		}

		if ( $userdata['user_birthday'] != 0 && $userdata['birthday_display'] != 3 ) {
			$bday_day   = date( 'jS', mktime( 0, 0, 0, 0, $bday_parts[2], 0 ) );
			$bday_month = date( 'F', mktime( 0, 0, 0, $bday_parts[1], 10 ) );
			$bday_year  = ( $userdata['birthday_display'] <> 1 && $bday_parts[3] != 0000 ) ? ', ' . $bday_parts[3] : '';
			$birthday   = $bday_month . ' ' . $bday_day . $bday_year . $birthday_age_alt;
		}
	}

	/**
	 * ? Calculate the number of days this user has been a member ($memberdays)
	 * ? Then calculate their posts per day
	 */
	$registration_date = $row['user_regdate'];
	$date_timestamp    = strtotime( $registration_date );
	$member_days       = max( 1, round( ( time() - $date_timestamp ) / 86400 ) );

	/*---------------------------------------------------------------------------------------------------------------------------------------------*/

	$row_class = ( ! ( $i % 2 ) ) ? 'row2' : 'row3';

	$timestamp = time();
	$lonestar  = date('m/d/Y H:i:s', $timestamp);

	$template->assign_block_vars(
		'row',
		array(
			'AVATAR'           => get_user_avatar( $row['user_id'], $row ),
			'AVATAR_ALLOWED'   => ( $row['user_avatar_type'] && $row['user_allowavatar'] ) ? true : false,
			'AVATAR_ATTR'      => 'style="--avatar-max-width: ' . get_board_option( 'avatar_max_width' ) . 'px; --avatar-max-height: ' . get_board_option( 'avatar_max_height' ) . 'px;"',
			'AVATAR_MAX_WIDTH' => get_board_option( 'avatar_max_width' ),
			'AVATAR_MAX_HEIGHT'=> get_board_option( 'avatar_max_height' ),
			'BIRTHDAY'         => $birthday,
			'BIRTHDAY_AGE'     => $birthday_age,
			'BIRTHDAY_DISPLAY' => $userdata['birthday_display'],
			'CLASS'            => ( ! ( $i % 2 ) ) ? 'isEven' : 'isOdd',
			// 'COVER'            => $row['cover'] ?: 'default-cover-image.jpg',
			// 'COVER_PATH'       => get_board_option( 'cover_path' ),
			'DAYS_BEEN_MEMBER' => $member_days,
			'FACEBOOK'         => stripslashes( parse_url( $row['user_facebook'], PHP_URL_PATH ) ),
			'FLAG'             => isset( $row['user_from_flag'] ) ? strtolower( get_file_basename( $row['user_from_flag'] ) ) : 'blank',
			'GENDER'           => $lang['gender-' . $row['user_gender'] ],
			'INTRODUCTION'     => $row['bio'],
			'JOINED'           => $row['user_regdate'],
			'JOINED_AGO'       => get_timeago( strtotime( $row['user_regdate'] ) ),

			'LAST_VISIT'       => ( $row['user_lastvisit'] && $row['user_lastvisit'] != 0 ) ? $row['user_lastvisit'] : 'Never',
			// 'LAST_VISIT_AGO'   => ( $row['user_lastvisit'] && $row['user_lastvisit'] != 0 ) ? get_timeago( $row['user_lastvisit'] ) : 'Never',

			'LAST_VISIT_AGO'   => $lonestar,

			'LAST_VISIT_DATE'  => ( $row['user_lastvisit'] && $row['user_lastvisit'] != 0 ) ? date( $board_config['default_dateformat'], $row['user_lastvisit'] ) : 'Never',

			'LOCATION'         => $row['user_from'],
			'NUM'              => $i + ( $start + 1 ),
			'PM_URL'           => append_sid( "privmsg.$phpEx?mode=post&amp;" . POST_USERS_URL . "=" . $row['user_id'] ),
			'POSTS'            => ( $row['user_posts'] ) ? convert_to_thousands( $row['user_posts'] ) : 0,
			'POSTS_SEARCH'     => append_sid( "search.$phpEx?search_author=" . urlencode( $row['username'] )."&amp;showresults=posts" ),
			'PROFILE_URL'      => "modules.php?name=Profile&amp;mode=viewprofile&amp;" . POST_USERS_URL . "=" . $row['user_id'],
			'RELATIONSHIP_STATUS' => ucfirst( $row['relationship'] ),
			'ROW_CLASS'        => $row_class, // (Kept in for backwards compatibility with legacy themes).
			'ROW_NUMBER'       => $i + ( $start + 1 ),
			'STATUS'           => $status,
			'STATUS_STYLE'     => $status_style,
			'STATUS_CLASS'     => $status_class,
			'STATUS_URL'       => append_sid( "viewonline.$phpEx" ),
			'USERNAME'         => $row['username'],
			'USERNAME_COLORED' => color_username( $row['username'], $row['user_color_gc'] ),
			'USER_AUC'         => isset( $row['user_color_gc'] ) ? '--auc-group-color: #' . $row['user_color_gc'] . ';' : '',
			'USER_ID'          => (int) $row['user_id'],
			'USER_LVL'         => (int) $row['user_level'],
			'WEBSITE'          => $row['user_website'],
			'WEBSITE_HOST'     => parse_url( $row['user_website'], PHP_URL_HOST ),
			'WEBSITE_SCHEME'   => parse_url( $row['user_website'], PHP_URL_SCHEME ),

			/**
			 * Todo: There is a much better way to do this, but since this is just the start of the socials use,
			 * Todo: I will be rebuilding the "Your_Account" module for version 2.0.12,
			 * Todo: So the variables below are just temporary and may error out, if the URL used is not correct.
			 *
			 * ? You may be asking why I am using a full URL to get the social ID's,
			 * ? I do this because social website's are constantly changing the way they use URL's.
			 * ? So using the full URL is the best way, and we just break it down.
			 */
			'STEAM'           => $row['steam'],
			'FACEBOOK'        => $row['user_facebook'],
			'INSTAGRAM'       => $row['instagram'],
			'TWITTER'         => $row['twitter'],
			'TWITCH'          => $row['twitch'],
			'YOUTUBE'         => $row['youtube'],
		)
	);

	++$i;

endwhile;
dbfree( $result );

// $template->assign_block_vars(
// 	'pagination',
// 	array(
// 		'PAGINATION' => get_pagination(
// 			array(
// 				'url'           => 'modules.php?name=Members_List' . $page_queries,
// 				'total'         => $totalUsers,
// 				'per-page'      => $board_config['topics_per_page'],
// 				'next-previous' => true,
// 				'first-last'    => true,
// 				'adjacents'     => 1
// 			)
// 		)
// 	)
// );

$template->pparse( 'body' );
include NUKE_INCLUDE_DIR . 'page_tail.php';
