<form method="post" action="{S_MODE_ACTION}" name="post">
<table style="width: 100%;" cellpadding="4" cellspacing="1" class="forumline">
  <tr>
	<td class="catHead">
	  <table style="width: 100%;" cellpadding="4" cellspacing="1" class="forumline">
		<tr>
		  <td class="row1" style="text-align: center; width: 33.3%;">{L_SELECT_SORT_METHOD}&nbsp;{S_MODE_SELECT}&nbsp;{S_ORDER_SELECT}&nbsp;<input type="submit" name="submit" value="{L_GO}" style="cursor: pointer;" class="liteoption" /></td>
		  <td class="catHead" style="text-align: center; width: 33.3%;">{L_PAGE_TITLE}</td>
		  <td class="row1" style="width: 33.3%;">
		  <span>
			<span class="tooltip icon-sprite icon-info" style="float: left; margin-top: 2px;" title="{U_SEARCH_EXPLAIN}"></span><input type="text" class="post" name="username" maxlength="25" size="20" tabindex="1" value="" />&nbsp;<input type="submit" name="submituser" value="{L_LOOK_UP}" style="cursor: pointer;" class="mainoption" /></td>
		  </span>
		</tr>
	  </table>
	</td>
  </tr>
  <tr>
	<td class="row1" style="width: 100%;">
	  <table style="width:100%;" cellpadding="0" cellspacing="1" class="forumline">
		<tr>
		  <!-- BEGIN alphanumsearch -->
		  <td class="row3" style="text-align: center; width: {alphanumsearch.SEARCH_SIZE};"><a href="{alphanumsearch.SEARCH_LINK}">{alphanumsearch.SEARCH_TERM}</a></td>
		  <!-- END alphanumsearch -->
		</tr>
	  </table>
	</td>
  </tr>
  <tr>
	<td class="row3" style="width: 100%;">
	  <table style="width:100%;" cellpadding="0" cellspacing="0" class="forumline">
		<tr>
		  <td valign="top">
			<table style="width:100%;" cellpadding="0" cellspacing="1" class="forumline">
			  <tr>
				<td class="catHead acenter" style="width: 5%;">#</td>
				<td class="catHead acenter" style="width: 25%;">{L_USERNAME}</td>
				<td class="catHead acenter" style="width: 25%;">{L_FROM}</td>
				<td class="catHead acenter" style="width: 5%;">{L_AGE}</td>
				<td class="catHead acenter" style="width: 10%;">{L_POSTS}</td>
				<td class="catHead acenter" style="width: 10%;">{L_JOINED}</td>
				<td class="catHead acenter" style="width: 10%;">{L_LAST_VISIT}</td>
				<td class="catHead acenter" style="width: 10%;">{L_ONLINE_STATUS}</td>
			  </tr>
			  <!-- BEGIN no_username -->
			  <tr>
				<td class="row1" colspan="8" style="text-align: center; text-transform: uppercase;">{no_username.NO_USER_ID_SPECIFIED}</td>
			  </tr>
			  <!-- END no_username -->
			  <!-- BEGIN row -->
			  <tr>
				<td class="{row.ROW_CLASS} acenter">{row.ROW_NUMBER}</td>
				<td class="{row.ROW_CLASS}">
				  <span style="float: left; margin: 2px;"><a href="{row.U_VIEWPROFILE}">{row.USERNAME_COLORED}</a></span>
				  <span style="float: right;">{row.GENDER}{row.WWW}{row.FACEBOOK}{row.PM}</span>
				</td>
				<td class="{row.ROW_CLASS}">{row.FLAG}{row.FROM}</td>
				<td class="{row.ROW_CLASS} acenter">{row.BIRTHDAY_AGE}</td>
				<td class="{row.ROW_CLASS} acenter">{row.POSTS}</td>
				<td class="{row.ROW_CLASS} acenter">{row.JOINED}</td>
				<td class="{row.ROW_CLASS} acenter">{row.LAST_VISIT_AGO}</td>
				<td class="{row.ROW_CLASS} acenter">{row.STATUS}</td>
			  </tr>
			  <!-- END row -->
			</table>
		  </td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr>
	<td class="catBottom" style="font-size: 13px; text-align: right;"><!-- BEGIN pagination --> <!-- IF pagination.TOTAL < pagination.PERPAGE --><!-- ELSE -->{pagination.PAGINATION}<!-- ENDIF --><!-- END pagination --></td>
  </tr>
</table>
</form>