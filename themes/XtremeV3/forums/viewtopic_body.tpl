<!--MOD GLANCE BEGIN -->{GLANCE_OUTPUT}<!-- MOD GLANCE END -->

<!-- PAGINATION START -->
<table style="width: 100%;" cellspacing="2" cellpadding="2">
  <tr>
	<td style="text-align: left; vertical-align: bottom" colspan="2"><a href="{U_VIEW_TOPIC}">{TOPIC_TITLE}</a><br />{PAGINATION}</td>
  </tr>
</table>
<!-- PAGINATION END -->

<!-- TOP BUTTONS START -->
<table style="width: 100%;" cellspacing="2" cellpadding="2">
  <tr>
	<td valign="bottom" nowrap="nowrap">
		<span class="nav">
			<!-- TOPIC BUTTON (NEW POST) --><a href="{U_POST_NEW_TOPIC}"><img src="{POST_IMG}" alt="{L_POST_NEW_TOPIC}" /></a><!-- TOPIC BUTTON (NEW POST) -->
			<!-- TOPIC BUTTON (REPLY POST) --><a href="{U_POST_REPLY_TOPIC}"><img src="{REPLY_IMG}" alt="{L_POST_REPLY_TOPIC}" /></a><!-- TOPIC BUTTON (REPLY POST) -->
			<!-- TOPIC BUTTON (PRINT POST) --><a target="_blank" href="{U_PRINTER_TOPIC}"><img src="{PRINTER_IMG}" alt="{L_PRINTER_TOPIC}" /></a><!-- TOPIC BUTTON (PRINT POST) -->
		<!-- TOPIC BUTTON (WHO HAS VIEWED THE POST) --><a href="{U_WHOVIEW_TOPIC}"><img src="{WHOVIEW_IMG}" alt="{L_WHOVIEW_ALT}" /></a><!-- TOPIC BUTTON (WHO HAS VIEWED THE POST) -->
			<!-- BEGIN thanks_button -->
			<!-- TOPIC BUTTON (THANK POST) --><a href="{thanks_button.U_THANK_TOPIC}"><img src="{thanks_button.THANK_IMG}" alt="{thanks_button.L_THANK_TOPIC}" /></a><!-- TOPIC BUTTON (THANK POST) -->
			<!-- END thanks_button -->
		</span>
	</td>
	<td style="width: 100%; text-align: left;"><a href="{U_INDEX}">{L_INDEX}</a><!-- IF PARENT_FORUM --> <i class="fas fa-arrow-right" style="font-size: 10px; color: #ccc;"></i> <a href="{U_VIEW_PARENT_FORUM}">{PARENT_FORUM_NAME}</a><!-- ENDIF --> <i class="fas fa-arrow-right" style="font-size: 10px; color: #ccc;"></i> <a href="{U_VIEW_FORUM}">{FORUM_NAME}</a></td>
  </tr>
</table>
<!-- TOP BUTTONS END -->

<!-- VIEWTOPIC POST START -->

<table class="forumline" cellspacing="1" cellpadding="3" style="width: 100%;">
  <!-- TOPIC PAGINATION START -->
  <tr style="text-align:right;">
	<td class="catHead" colspan="2">
	   <span style="float: left;">&larr; <a href="{U_VIEW_OLDER_TOPIC}">{L_VIEW_PREVIOUS_TOPIC}</a></span>
	   <span style="float: right;"><a href="{U_VIEW_NEWER_TOPIC}">{L_VIEW_NEXT_TOPIC}</a> &rarr;</span>
	</td>
  </tr>
  <!-- TOPIC PAGINATION END -->
  <!-- POLL DISPLAY START -->
  {POLL_DISPLAY}
  <!-- POLL DISPLAY END -->

  <!-- BEGIN postrow -->
  <tr>
	<td class="catHead">
	  <table cellspacing="0" cellpadding="0" style="width: 100%;">
		<tr>
		  <td><a href="{postrow.U_MINI_POST}"><img src="{postrow.MINI_POST_IMG}" width="12" height="9" alt="{postrow.L_MINI_POST_ALT}" title="{postrow.L_MINI_POST_ALT}" /></a>{L_POSTED}:&nbsp;{postrow.POST_DATE}</td>
		  <td style="text-align: right;">{postrow.QUOTE_IMG} {postrow.EDIT_IMG} {postrow.DELETE_IMG} {postrow.IP_IMG} {postrow.REPORT_IMG}</td>
		</tr>
	  </table>
	</td>
	<td class="catHead" style="width: 200px" nowrap="nowrap"><a name="{postrow.U_POST_ID}"></a>{postrow.POSTER_FROM_FLAG}<span class="viewtopic_username">{postrow.POSTER_NAME}</td>
  </tr>
  <tr>
  	<!-- POST MESSAGE START -->
  	<td class="{postrow.ROW_CLASS}" style="vertical-align: top;">
	  <table class="tfixed clear" cellspacing="1" cellpadding="3" style="width: 100%;">
		<tr>
		  <td colspan="2" height="100%" valign="top">
			<span class="postbody">{postrow.MESSAGE}</span>
			{postrow.ATTACHMENTS}
			<span class="postbody"></span>
		  </td>
		</tr>
		<tr>
		  <td colspan="2">
			<span class="postbody">{postrow.SIGNATURE}</span>
			<!-- IF postrow.EDITED_MESSAGE -->
			<div><br /><br /><i class="fa fa-pencil-square-o" aria-hidden="true" style="float: left;"></i><span style="float: left;">&nbsp;{postrow.EDITED_MESSAGE}</span></div>
			<!-- ENDIF -->
		  </td>
		</tr>
	  </table>
  	</td>
  	<!-- POST MESSAGE END -->
  	<!-- POSTER INFORMATION START -->
  	<td class="{postrow.ROW_CLASS}" style="padding: 8px; text-align: center; vertical-align: top;">
	  <!-- BEGIN switch_showavatars -->{postrow.POSTER_AVATAR}<!-- END switch_showavatars -->
	  <br />
	  {postrow.USER_RANK_01_IMG}
	  {postrow.USER_RANK_02_IMG}
	  {postrow.USER_RANK_03_IMG}
	  {postrow.USER_RANK_04_IMG}
	  {postrow.USER_RANK_05_IMG}
	  <br />

	  <!-- IF postrow.USER_RANK_01 -->
	  <div style="height: 19px">
		<span style="float: right; font-size: 12px;">{postrow.USER_RANK_01}</span>
	  </div>
	  <!-- ENDIF -->

	  <!-- IF postrow.USER_RANK_02 -->
	  <div style="height: 19px">
		<span style="float: right; font-size: 12px;">{postrow.USER_RANK_02}</span>
	  </div>
	  <!-- ENDIF -->
	  <!-- IF postrow.USER_RANK_03 -->
	  <div style="height: 19px">
		<span style="float: right; font-size: 12px;">{postrow.USER_RANK_03}</span>
	  </div>
	  <!-- ENDIF -->
	  <!-- IF postrow.USER_RANK_04 -->
	  <div style="height: 19px">
		<span style="float: right; font-size: 12px;">{postrow.USER_RANK_04}</span>
	  </div>
	  <!-- ENDIF -->
	  <!-- IF postrow.USER_RANK_05 -->
	  <div style="height: 19px">
		<span style="float: right; font-size: 12px;">{postrow.USER_RANK_05}</span>
	  </div>
	  <!-- ENDIF -->
	  <div class="topic-user-meta">
		<span>{L_POST_COUNT}</span>
		<span>{postrow.POSTER_POSTS}</span>
	  </div>
	  <!-- IF REPUTATION -->
	  <div class="topic-user-meta">
		<span>{L_REPUTATION}</span>
		<span>{postrow.REPUTATION}</span>
	  </div>
	  <!-- ENDIF -->
	  <div class="topic-user-meta">
		<span>{L_JOINED}</span>
		<span>{postrow.POSTER_JOINED}</span>
	  </div>
	  <div class="topic-user-meta">
		<span>{L_STATUS}</span>
		<span>{postrow.POSTER_ONLINE_STATUS}</span>
	  </div>
	  <!-- IF postrow.POSTER_GENDER -->
	  <div class="topic-user-meta">
		<span>{L_GENDER}</span>
		<span>{postrow.POSTER_GENDER}</span>
	  </div>
	  <!-- ENDIF -->
	  <!-- BEGIN xdata -->
	  <div class="topic-user-meta">
		<span>{postrow.xdata.NAME}</span>
		<span>{postrow.xdata.VALUE}</span>
	  </div>
	  <!-- END xdata -->
  	</td>
  	<!-- POSTER INFORMATION END -->
  </tr>
  <tr>
	<td class="catBottom" colspan="2">{postrow.PROFILE_IMG} {postrow.PM_IMG} {postrow.EMAIL_IMG} {postrow.WWW_IMG} {postrow.FACEBOOK_IMG} {postrow.SEARCH_IMG}</td>
  </tr>
  <!-- BEGIN switch_spacer -->
  </table>
  <br />
  <table class="forumline" cellspacing="1" cellpadding="3" style="width: 100%;">
  <!-- END switch_spacer -->

  <!-- BEGIN move_message -->
  <tr>
	<td class="row3" colspan="2"><span class="postdetails">{postrow.move_message.MOVE_MESSAGE}</span></td>
  </tr>
  <!-- END move_message -->
  <!-- BEGIN thanks -->
  <tr>
	<td colspan="2" class="row2">
	  <table class="forumline" cellspacing="1" cellpadding="3" width="100%">
		<tr>
		  <th class="thLeft">{postrow.thanks.THANKFUL}</th>
		</tr>
		<tr>
		  <td class="row2" valign="top" align="left">
			<span id="hide_thank" style="display: block;" class="gensmall"><a href="javascript:void(0);" onclick="postThank('show')">{postrow.thanks.THANKS_TOTAL}</a> {postrow.thanks.THANKED}</span>
			<span id="show_thank" style="display: none;" class="gensmall">{postrow.thanks.THANKS}<br /><br /><div align="right"><a href="javascript:void(0);" onclick="postThank('hide')">[ {postrow.thanks.HIDE} ]</a></div></span>
		  </td>
		</tr>
	  </table>
	</td>
  </tr>
  <!-- END thanks -->

  <!-- START Inline Banner Ad -->
  <!-- BEGIN switch_ad -->
  <!-- IF postrow.INLINE_AD -->
  <tr>
	<td class="inlinead row1" colspan="2" style="vertical-align: top;">{postrow.INLINE_AD}</td>
  </tr>
  <tr>
	<td class="spaceRow" colspan="2" style="height: 10px;">&nbsp;</td>
  </tr>
  <!-- END switch_ad -->
  <!-- BEGIN switch_ad_style2 -->
  <tr>
	<td colspan="2" class="row3" style="text-align: center;">
	  {postrow.INLINE_AD}
	</td>
  </tr>
  <!-- ENDIF -->
  <!-- END switch_ad_style2 -->
  <!-- END Inline Banner Ad -->
  <!-- END postrow -->
  <tr>
	<td class="catBottom" colspan="2" height="28">
	  <table cellspacing="0" cellpadding="0" style="float: right;">
		<tr>
		  <td>
			<form method="post" action="{S_POST_DAYS_ACTION}">
			  {L_DISPLAY_POSTS}: {S_SELECT_POST_DAYS}{S_SELECT_POST_ORDER} <input type="submit" value="{L_GO}" class="liteoption" name="submit" />
			</form>
		  </td>
		</tr>
	  </table>
	</td>
  </tr>
</table>

<table width="100%" cellspacing="2" cellpadding="2">
  <tr>
	<td align="left" valign="middle" nowrap="nowrap">
	  <span class="nav">
		<a href="{U_POST_NEW_TOPIC}"><img src="{POST_IMG}" alt="{L_POST_NEW_TOPIC}" /></a>
		<a href="{U_POST_REPLY_TOPIC}"><img src="{REPLY_IMG}" alt="{L_POST_REPLY_TOPIC}" /></a>
		<!-- BEGIN switch_quick_reply -->
		<a href="{U_POST_SQR_TOPIC}"><img src="{SQR_IMG}" alt="{L_POST_SQR_TOPIC}" /></a>
		<!-- END switch_quick_reply -->
		<a target="_blank" href="{U_PRINTER_TOPIC}"><img src="{PRINTER_IMG}" alt="{L_PRINTER_TOPIC}" /></a>
		<!-- TOPIC BUTTON (WHO HAS VIEWED THE POST) --><a href="{U_WHOVIEW_TOPIC}"><img src="{WHOVIEW_IMG}" alt="{L_WHOVIEW_ALT}" /></a><!-- TOPIC BUTTON (WHO HAS VIEWED THE POST) -->
		<!-- BEGIN thanks_button -->
		<a href="{thanks_button.U_THANK_TOPIC}"><img src="{thanks_button.THANK_IMG}" alt="{thanks_button.L_THANK_TOPIC}" /></a>
		<!-- END thanks_button -->

	  </span>
	</td>

	<td align="right" valign="top" nowrap="nowrap">{S_TIMEZONE}<br />{PAGINATION}</td>
  </tr>
  <tr>
	<td style="text-align: left;" colspan="2">{PAGE_NUMBER}</td>
  </tr>
</table>
<!-- BEGIN switch_quick_reply -->
{QRBODY}
<!-- END switch_quick_reply -->

<table width="100%" cellspacing="2" align="center">
  <tr>
	<td style="width: 50%; vertical-align: top">{S_WATCH_TOPIC}<br />{S_EMAIL_TOPIC}<br />&nbsp;<br />{S_TOPIC_ADMIN}</td>
	<td style="width: 50%; vertical-align: top; text-align: right;">{S_AUTH_LIST}</td>
  </tr>
</table>

<!-- VIEWTOPIC POST END -->