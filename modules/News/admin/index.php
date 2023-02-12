<?php
/*=======================================================================
 Nuke-Evolution Basic: Enhanced PHP-Nuke Web Portal System
 =======================================================================*/

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
/*         Additional security & Abstraction layer conversion           */
/*                           2003 chatserv                              */
/*      http://www.nukefixes.com -- http://www.nukeresources.com        */
/************************************************************************/
/********************************************************/
/* NSN News                                             */
/* By: NukeScripts Network (webmaster@nukescripts.net)  */
/* http://www.nukescripts.net                           */
/* Copyright (c) 2000-2005 by NukeScripts Network         */
/********************************************************/

/*****[CHANGES]**********************************************************
-=[Base]=-
      Nuke Patched                             v3.1.0       06/26/2005
      Caching System                           v1.0.0       10/31/2005
-=[Other]=-
      News Fix                                 v1.0.0       06/26/2005
-=[Mod]=-
      Advanced Username Color                  v1.0.5       06/11/2005
      Display Topic Icon                       v1.0.0       06/27/2005
      News BBCodes                             v1.0.0       08/19/2005
      Display Writes                           v1.0.0       10/14/2005
      Custom Text Area                         v1.0.0       11/23/2005
 ************************************************************************/

if (!defined('ADMIN_FILE')) {
   die('Access Denied');
}

global $prefix, $db, $admdata;
$module_name = basename(dirname(dirname(__FILE__)));

if(is_mod_admin($module_name)) {

include_once(NUKE_INCLUDE_DIR.'nsnne_func.php');

$ne_config = ne_get_configs();

$ok = get_query_var( 'ok', 'get', 'int', 0 );


function topicicon($topic_icon) {
    echo "<br /><strong>"._DISPLAY_T_ICON."</strong>&nbsp;&nbsp;";
    if (($topic_icon == 0) OR (empty($topic_icon))) {
        $sel1 = "checked";
        $sel2 = "";
    }
    if ($topic_icon == 1) {
        $sel1 = "";
        $sel2 = "checked";
    }
    echo "<input type=\"radio\" name=\"topic_icon\" value=\"0\" $sel1>"._YES."&nbsp;"
        ."<input type=\"radio\" name=\"topic_icon\" value=\"1\" $sel2>"._NO;
}

function writes($writes) {
    echo "<br /><strong>"._DISPLAY_WRITES."</strong>&nbsp;&nbsp;";
    if (($writes == 1) || (!is_int($writes))) {
        $sel1 = "";
        $sel2 = "checked";
    } else if (($writes == 0)) {
        $sel1 = "checked";
        $sel2 = "";
    }
    echo "<input type=\"radio\" name=\"writes\" value=\"0\" $sel1>"._YES."&nbsp;"
        ."<input type=\"radio\" name=\"writes\" value=\"1\" $sel2>"._NO;
}

function puthome($ihome, $acomm) {
    echo "<br /><strong>"._PUBLISHINHOME."</strong>&nbsp;&nbsp;";
    if (($ihome == 0) OR (empty($ihome))) {
        $sel1 = "checked";
        $sel2 = "";
    }
    if ($ihome == 1) {
        $sel1 = "";
        $sel2 = "checked";
    }
    echo "<input type=\"radio\" name=\"ihome\" value=\"0\" $sel1>"._YES."&nbsp;"
        ."<input type=\"radio\" name=\"ihome\" value=\"1\" $sel2>"._NO.""
        ."&nbsp;&nbsp;<span class=\"content\">[ "._ONLYIFCATSELECTED." ]</span><br />";

    echo "<br /><strong>"._ACTIVATECOMMENTS."</strong>&nbsp;&nbsp;";
    if (($acomm == 0) OR (empty($acomm))) {
        $sel1 = "checked";
        $sel2 = "";
    }
    if ($acomm == 1) {
        $sel1 = "";
        $sel2 = "checked";
    }
    echo "<input type=\"radio\" name=\"acomm\" value=\"0\" $sel1>"._YES."&nbsp;"
        ."<input type=\"radio\" name=\"acomm\" value=\"1\" $sel2>"._NO."</font><br /><br />";

}

function deleteStory($qid) {
    global $prefix, $db, $admin_file, $cache;
    $qid = intval($qid);
    $result = $db->sql_query("delete from ".$prefix."_queue where qid='$qid'");
    if (!$result) {
        return;
    }
    $cache->delete('numwaits', 'submissions');
    redirect($admin_file.".php?op=submissions");
}

function SelectCategory($cat) {
    global $prefix, $db, $admin_file;
    $selcat = $db->sql_query("select catid, title from ".$prefix."_stories_cat order by title");
    $a = 1;
    echo "<strong>"._CATEGORY."</strong> ";
    echo "<select name=\"catid\">";
    if ($cat == 0) {
        $sel = "selected";
    } else {
        $sel = "";
    }
    echo "<option name=\"catid\" value=\"0\" $sel>"._ARTICLES."</option>";
    while(list($catid, $title) = $db->sql_fetchrow($selcat)) {
        $catid = intval($catid);
        if ($catid == $cat) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"catid\" value=\"$catid\" $sel>$title</option>";
        $a++;
    }
    echo "</select> [ <a href=\"".$admin_file.".php?op=AddCategory\">"._ADD."</a> | <a href=\"".$admin_file.".php?op=EditCategory\">"._EDIT."</a> | <a href=\"".$admin_file.".php?op=DelCategory\">"._DELETE."</a> ]";
}

function putpoll($pollTitle, $optionText) {
    OpenTable();
    echo "<div style=\"text-align: center\"><span class=\"title\"><strong>"._ATTACHAPOLL."</strong></span><br />"
        ."<span class=\"tiny\">"._LEAVEBLANKTONOTATTACH."</span><br />"
        ."<br /><br />"._POLLTITLE.": <input type=\"text\" name=\"pollTitle\" size=\"50\" maxlength=\"100\" value=\"$pollTitle\"><br /><br />"
        ."<font class=\"content\">"._POLLEACHFIELD."</font><br />"
        ."<table border=\"0\" style=\"margin:auto;\">";
    for($i = 1; $i <= 12; $i++)        {
        $optional = isset($optionText[$i]) ? $optionText[$i] : '';
        echo "<tr>"
            ."<td>"._OPTION." $i:</td><td><input type=\"text\" name=\"optionText[$i]\" size=\"50\" maxlength=\"50\" value=\"".$optional."\"></td>"
            ."</tr>";
    }
    echo "</table>";
    echo "</div>";
    CloseTable();
}

function AddCategory () {
    global $admin_file;
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"option\"><strong>"._CATEGORYADD."</strong></span><br /><br /><br />"
        ."<form action=\"".$admin_file.".php\" method=\"post\">"
        ."<strong>"._CATNAME.":</strong> "
        ."<input type=\"text\" name=\"title\" size=\"22\" maxlength=\"20\"> "
        ."<input type=\"hidden\" name=\"op\" value=\"SaveCategory\">"
        ."<input type=\"submit\" value=\""._SAVE."\">"
        ."</form></center>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function EditCategory($catid) {
    global $prefix, $db, $admin_file;
    $catid = intval($catid);
    $result = $db->sql_query("select title from ".$prefix."_stories_cat where catid='$catid'");
    list($title) = $db->sql_fetchrow($result);
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"option\"><strong>"._EDITCATEGORY."</strong></span><br />";
    if (!$catid) {
        $selcat = $db->sql_query("select catid, title from ".$prefix."_stories_cat");
        echo "<form action=\"".$admin_file.".php\" method=\"post\">";
        echo "<strong>"._ASELECTCATEGORY."</strong>";
        echo "<select name=\"catid\">";
        echo "<option name=\"catid\" value=\"0\" $sel>Articles</option>";
        while(list($catid, $title) = $db->sql_fetchrow($selcat)) {
            $catid = intval($catid);
            echo "<option name=\"catid\" value=\"$catid\" $sel>$title</option>";
        }
        echo "</select>";
        echo "<input type=\"hidden\" name=\"op\" value=\"EditCategory\">";
        echo "<input type=\"submit\" value=\""._EDIT."\"><br /><br />";
        echo ""._NOARTCATEDIT."";
    } else {
        echo "<form action=\"".$admin_file.".php\" method=\"post\">";
        echo "<strong>"._CATEGORYNAME.":</strong> ";
        echo "<input type=\"text\" name=\"title\" size=\"22\" maxlength=\"20\" value=\"$title\"> ";
        echo "<input type=\"hidden\" name=\"catid\" value=\"$catid\">";
        echo "<input type=\"hidden\" name=\"op\" value=\"SaveEditCategory\">";
        echo "<input type=\"submit\" value=\""._SAVECHANGES."\"><br /><br />";
        echo ""._NOARTCATEDIT."";
        echo "</form>";
    }
    echo "</center>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function DelCategory($cat) {
    global $prefix, $db, $admin_file;
    $cat = intval($cat);
    $result = $db->sql_query("select title from ".$prefix."_stories_cat where catid='$cat'");
    list($title) = $db->sql_fetchrow($result);
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"option\"><strong>"._DELETECATEGORY."</strong></span><br />";
    if (!$cat) {
        $selcat = $db->sql_query("select catid, title from ".$prefix."_stories_cat");
        echo "<form action=\"".$admin_file.".php\" method=\"post\">"
            ."<strong>"._SELECTCATDEL.": </strong>"
            ."<select name=\"cat\">";
        while(list($catid, $title) = $db->sql_fetchrow($selcat)) {
            $catid = intval($catid);
            echo "<option name=\"cat\" value=\"$catid\">$title</option>";
        }
        echo "</select>"
            ."<input type=\"hidden\" name=\"op\" value=\"DelCategory\">"
            ."<input type=\"submit\" value=\"Delete\">"
            ."</form>";
    } else {
        $result2 = $db->sql_query("select * from ".$prefix."_stories where catid='$cat'");
        $numrows = $db->sql_numrows($result2);
        if ($numrows == 0) {
            $db->sql_query("delete from ".$prefix."_stories_cat where catid='$cat'");
            echo "<br /><br />"._CATDELETED."<br /><br />"._GOTOADMIN."";
        } else {
            echo "<br /><br /><strong>"._WARNING.":</strong> "._THECATEGORY." <strong>$title</strong> "._HAS." <strong>$numrows</strong> "._STORIESINSIDE."<br />"
                .""._DELCATWARNING1."<br />"
                .""._DELCATWARNING2."<br /><br />"
                .""._DELCATWARNING3."<br /><br />"
                ."<strong>[ <a href=\"".$admin_file.".php?op=YesDelCategory&amp;catid=$cat\">"._YESDEL."</a> | "
                ."<a href=\"".$admin_file.".php?op=NoMoveCategory&amp;catid=$cat\">"._NOMOVE."</a> ]</strong>";
        }
    }
    echo "</center>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function YesDelCategory($catid) {
    global $prefix, $db, $admin_file;
    $catid = intval($catid);
    $db->sql_query("delete from ".$prefix."_stories_cat where catid='$catid'");
    $result = $db->sql_query("select sid from ".$prefix."_stories where catid='$catid'");
    while(list($sid) = $db->sql_fetchrow($result)) {
        $sid = intval($sid);
        $db->sql_query("delete from ".$prefix."_stories where catid='$catid'");
        $db->sql_query("delete from ".$prefix."_comments where sid='$sid'");
    }
    redirect($admin_file.".php?op=adminStory");
}

function NoMoveCategory($catid, $newcat) {
    global $prefix, $db, $admin_file;
    $catid = intval($catid);
    $result = $db->sql_query("select title from ".$prefix."_stories_cat where catid='$catid'");
    list($title) = $db->sql_fetchrow($result);
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"option\"><strong>"._MOVESTORIES."</strong></span><br /><br />";
    if (!$newcat) {
        echo ""._ALLSTORIES." <strong>$title</strong> "._WILLBEMOVED."<br /><br />";
        $selcat = $db->sql_query("select catid, title from ".$prefix."_stories_cat");
        echo "<form action=\"".$admin_file.".php\" method=\"post\">";
        echo "<strong>"._SELECTNEWCAT.":</strong> ";
        echo "<select name=\"newcat\">";
        echo "<option name=\"newcat\" value=\"0\">"._ARTICLES."</option>";
        while(list($newcat, $title) = $db->sql_fetchrow($selcat)) {
                echo "<option name=\"newcat\" value=\"$newcat\">$title</option>";
        }
        echo "</select>";
        echo "<input type=\"hidden\" name=\"catid\" value=\"$catid\">";
        echo "<input type=\"hidden\" name=\"op\" value=\"NoMoveCategory\">";
        echo "<input type=\"submit\" value=\""._OK."\">";
        echo "</form>";
    } else {
        $resultm = $db->sql_query("select sid from ".$prefix."_stories where catid='$catid'");
        while(list($sid) = $db->sql_fetchrow($resultm)) {
        $sid = intval($sid);
            $db->sql_query("update ".$prefix."_stories set catid='$newcat' where sid='$sid'");
        }
        $db->sql_query("delete from ".$prefix."_stories_cat where catid='$catid'");
        echo ""._MOVEDONE."";
    }
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function SaveEditCategory($catid, $title) {
    global $prefix, $db, $admin_file;
    $title = str_replace("\"","",$title);
    $result = $db->sql_query("select catid from ".$prefix."_stories_cat where title='$title'");
    $catid = intval($catid);
        $check = $db->sql_numrows($result);
    if ($check) {
        $what1 = _CATEXISTS;
        $what2 = _GOBACK;
    } else {
        $what1 = _CATSAVED;
        $what2 = "[ <a href=\"".$admin_file.".php\">"._GOTOADMIN."</a> ]";
        $result = $db->sql_query("update ".$prefix."_stories_cat set title='$title' where catid='$catid'");
        if (!$result) {
            return;
        }
    }
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"content\"><strong>$what1</strong></span><br /><br />";
    echo "$what2</center>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function SaveCategory($title) {
    global $prefix, $db, $admin_file;
    $title = str_replace("\"","",$title);
    $result = $db->sql_query("select catid from ".$prefix."_stories_cat where title='$title'");
        $check = $db->sql_numrows($result);
    if ($check) {
        $what1 = _CATEXISTS;
        $what2 = _GOBACK;
    } else {
        $what1 = _CATADDED;
        $what2 = _GOTOADMIN;
        $result = $db->sql_query("insert into ".$prefix."_stories_cat values (NULL, '$title', '0')");
        if (!$result) {
            return;
        }
    }
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._CATEGORIESADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    echo "<center><span class=\"content\"><strong>$what1</strong></span><br /><br />";
    echo "$what2</center>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function autodelete($anid) {
    global $prefix, $db, $admin_file;
    $anid = intval($anid);
    $db->sql_query("delete from ".$prefix."_autonews where anid='$anid'");
    redirect($admin_file.".php?op=adminStory");
}

function autoEdit($anid) {
    global $aid, $bgcolor1, $bgcolor2, $prefix, $db, $multilingual, $admin_file, $module_name;
    $sid = intval($sid);
    $aid = substr($aid, 0,25);
    list($aaid) = $db->sql_ufetchrow("select aid from ".$prefix."_stories where sid='$sid'");
    $aaid = substr($aaid, 0,25);
    if (is_mod_admin($module_name)) {
    include(NUKE_BASE_DIR.'header.php');

    $result = $db->sql_query("select catid, aid, title, time, hometext, bodytext, topic, informant, notes, ihome, alanguage, acomm, ticon, writes FROM ".$prefix."_autonews where anid='$anid'");

    list($catid, $aid, $title, $time, $hometext, $bodytext, $topic, $informant, $notes, $ihome, $alanguage, $acomm, $topic_icon, $writes) = $db->sql_fetchrow($result);

    $catid = intval($catid);
    $aid = substr($aid, 0,25);
    $informant = substr($informant, 0,25);
    $ihome = intval($ihome);
    $acomm = intval($acomm);
    $topic_icon = intval($topic_icon);
    $writes = intval($writes);

    preg_match ("/([0-9]{4})\-([0-9]{1,2})\-([0-9]{1,2}) ([0-9]{1,2})\:([0-9]{1,2})\:([0-9]{1,2})/", $time, $datetime);
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
    $today = getdate();
    $tday = $today[mday];
    if ($tday < 10){
        $tday = "0$tday";
    }
    $tmonth = $today[month];
    $tyear = $today[year];
    $thour = $today[hours];
    if ($thour < 10){
        $thour = "0$thour";
    }
    $tmin = $today[minutes];
    if ($tmin < 10){
        $tmin = "0$tmin";
    }
    $tsec = $today[seconds];
    if ($tsec < 10){
        $tsec = "0$tsec";
    }
    $date = "$tmonth $tday, $tyear @ $thour:$tmin:$tsec";
    echo "<center><span class=\"option\"><strong>"._AUTOSTORYEDIT."</strong></span></center><br /><br />"
        ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">";
    $title = stripslashes($title);
    $hometext = stripslashes($hometext);
    $bodytext = stripslashes($bodytext);
    $notes = stripslashes($notes);
    $result=$db->sql_query("select topicimage from ".$prefix."_topics where topicid='$topic'");
    list($topicimage) = $db->sql_fetchrow($result);
    echo "<table border=\"0\" width=\"75%\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"$bgcolor2\" align=\"center\"><tr><td>"
        ."<table border=\"0\" width=\"100%\" cellpadding=\"8\" cellspacing=\"1\" bgcolor=\"$bgcolor1\"><tr><td>";

        if ($topic_icon == 0) {
            echo "<img src=\"images/topics/$topicimage\" border=\"0\" align=\"right\" alt=\"\">";
        }

    $hometext_bb = decode_bbcode(set_smilies(stripslashes($hometext)), 1, true);
    $bodytext_bb = decode_bbcode(set_smilies(stripslashes($bodytext)), 1, true);
    $hometext_bb = evo_img_tag_to_resize($hometext_bb);
    $bodytext_bb = evo_img_tag_to_resize($bodytext_bb);
    themepreview($subject, $hometext_bb, $bodytext_bb);

    echo "</td></tr></table></td></tr></table>"
        ."<br /><br /><strong>"._TITLE."</strong><br />"
        ."<input type=\"text\" name=\"title\" size=\"50\" value=\"$title\"><br /><br />"
        ."<strong>"._TOPIC."</strong> <select name=\"topic\">";
    $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
    echo "<option value=\"\">"._ALLTOPICS."</option>\n";
    while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
        $topicid = intval($topicid);
    if ($topicid==$topic) { $sel = "selected "; }
        echo "<option $sel value=\"$topicid\">$topics</option>\n";
        $sel = "";
    }
    echo "</select><br /><br />";
    $cat = $catid;
    SelectCategory($cat);

    echo '<br />';
    topicicon($topic_icon);
    echo '<br />';
    writes($writes);

    echo "<br />";
    puthome($ihome, $acomm);
    if ($multilingual == 1) {
        echo "<br /><strong>"._LANGUAGE.": </strong>"
            ."<select name=\"alanguage\">";
        $languages = lang_list();
        echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
        for ($i=0, $j = count($languages); $i < $j; $i++) {
            if ($languages[$i] != '') {
                echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
            }
        }
        echo '</select>';
    } else {
        echo "<input type=\"hidden\" name=\"alanguage\" value=\"\">";
    }
    echo "<br /><br /><strong>"._STORYTEXT."</strong>";

    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', $hometext, 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', $bodytext, 'postnews');
    echo "<span class=\"content\">"._ARESUREURL."</span><br /><br />";

    if ($aid != $informant) {
            echo "<strong>"._NOTES."</strong><br />
        <textarea style=\"wrap:virtual\" cols=\"50\" rows=\"4\" name=\"notes\">$notes</textarea><br /><br />";
    }
    echo "<br /><strong>"._CHNGPROGRAMSTORY."</strong><br /><br />"
        .""._NOWIS.": $date<br /><br />";
    $xday = 1;
    echo ""._DAY.": <select name=\"day\">";
    while ($xday <= 31) {
        if ($xday == $datetime[3]) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"day\" $sel>$xday</option>";
        $xday++;
    }
    echo "</select>";
    $xmonth = 1;
    echo ""._UMONTH.": <select name=\"month\">";
    while ($xmonth <= 12) {
        if ($xmonth == $datetime[2]) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"month\" $sel>$xmonth</option>";
        $xmonth++;
    }
    echo "</select>";
    echo ""._YEAR.": <input type=\"text\" name=\"year\" value=\"$datetime[1]\" size=\"5\" maxlength=\"4\">";
    echo "<br />"._HOUR.": <select name=\"hour\">";
    $xhour = 0;
    $cero = "0";
    while ($xhour <= 23) {
        $dummy = $xhour;
        if ($xhour < 10) {
            $xhour = "$cero$xhour";
        }
        if ($xhour == $datetime[4]) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"hour\" $sel>$xhour</option>";
        $xhour = $dummy;
        $xhour++;
    }
    echo "</select>";
    echo ": <select name=\"min\">";
    $xmin = 0;
    while ($xmin <= 59) {
        if (($xmin == 0) OR ($xmin == 5)) {
            $xmin = "0$xmin";
        }
        if ($xmin == $datetime[5]) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"min\" $sel>$xmin</option>";
        $xmin = $xmin + 5;
    }
    echo "</select>";
    echo ": 00<br /><br />
    <input type=\"hidden\" name=\"anid\" value=\"$anid\">
    <input type=\"hidden\" name=\"op\" value=\"autoSaveEdit\">
    <input type=\"submit\" value=\""._SAVECHANGES."\">
    </form>";
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
    } else {
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        OpenTable();
        echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
        CloseTable();
        echo "<br />";
        OpenTable();
        echo "<center><strong>"._NOTAUTHORIZED1."</strong><br /><br />"
            .""._NOTAUTHORIZED2."<br /><br />"
            .""._GOBACK."";
        CloseTable();
        include(NUKE_BASE_DIR.'footer.php');
    }
}


function autoSaveEdit($anid, $year, $day, $month, $hour, $min, $title, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes) {
    global $aid, $ultramode, $prefix, $db, $admin_file, $module_name;
    $sid = intval($sid);
    $aid = substr($aid, 0,25);
    list($aaid) = $db->sql_ufetchrow("select aid from ".$prefix."_stories where sid='$sid'");
    $aaid = substr($aaid, 0,25);
    if (is_mod_admin($module_name)) {
    if ($day < 10) {
        $day = "0$day";
    }
    if ($month < 10) {
        $month = "0$month";
    }
    $sec = "00";
    $date = "$year-$month-$day $hour:$min:$sec";
    $title = Fix_Quotes($title);
    $hometext = Fix_Quotes($hometext);
    $bodytext = Fix_Quotes($bodytext);
    $notes = Fix_Quotes($notes);

    $result = $db->sql_query("update ".$prefix."_autonews set catid='$catid', title='$title', time='$date', hometext='$hometext', bodytext='$bodytext', topic='$topic', notes='$notes', ihome='$ihome', alanguage='$alanguage', acomm='$acomm', ticon='$topic_icon', writes='$writes' where anid='$anid'");

    if (!$result) {
        exit();
    }
    if ($ultramode) {
        ultramode();
    }
    redirect($admin_file.".php?op=adminStory");
    } else {
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        OpenTable();
        echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
        CloseTable();
        echo "<br />";
        OpenTable();
        echo "<center><strong>"._NOTAUTHORIZED1."</strong><br /><br />"
            .""._NOTAUTHORIZED2."<br /><br />"
            .""._GOBACK."";
        CloseTable();
        include(NUKE_BASE_DIR.'footer.php');
    }
}

function displayStory($qid) {
    global $user, $admin_file, $subject, $story, $bgcolor1, $bgcolor2, $anonymous, $user_prefix, $prefix, $db, $multilingual;
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._SUBMISSIONSADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    $today = getdate();
    $tday = $today[mday];
    if ($tday < 10){
        $tday = "0$tday";
    }
    $tmonth = $today[month];
    $ttmon = $today[mon];
    if ($ttmon < 10){
        $ttmon = "0$ttmon";
    }
    $tyear = $today[year];
    $thour = $today[hours];
    if ($thour < 10){
        $thour = "0$thour";
    }
    $tmin = $today[minutes];
    if ($tmin < 10){
        $tmin = "0$tmin";
    }
    $tsec = $today[seconds];
    if ($tsec < 10){
        $tsec = "0$tsec";
    }
    $date = "$tmonth $tday, $tyear @ $thour:$tmin:$tsec";
    $qid = intval($qid);
    $result = $db->sql_query("SELECT qid, uid, uname, subject, story, storyext, topic, alanguage FROM ".$prefix."_queue where qid='$qid'");
    list($qid, $uid, $uname, $subject, $story, $storyext, $topic, $alanguage) = $db->sql_fetchrow($result);
        $qid = intval($qid);
        $uid = intval($uid);
    $subject = stripslashes($subject);
    $story = stripslashes($story);
    $storyext = stripslashes($storyext);

    $storyext_bb = decode_bbcode(set_smilies(stripslashes($storyext)), 1, true);
    $story_bb = decode_bbcode(set_smilies(stripslashes($story)), 1, true);
    $storyext_bb = evo_img_tag_to_resize($storyext_bb);
    $story_bb = evo_img_tag_to_resize($story_bb);

    OpenTable();
    echo "<font class=\"content\">"
        ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">"
        ."<strong>"._NAME."</strong><br />"
        ."<input type=\"text\" NAME=\"author\" size=\"25\" value=\"$uname\">";

    if ($uname != $anonymous) {
        $res = $db->sql_query("select user_email from ".$user_prefix."_users where username='$uname'");
        list($email) = $db->sql_fetchrow($res);
        echo "&nbsp;&nbsp;<span class=\"content\">[ <a href=\"mailto:$email?Subject=Re: $subject\">"._EMAILUSER."</a> | <a href='modules.php?name=Your_Account&op=userinfo&username=$uname'>"._USERPROFILE."</a> | <a href=\"modules.php?name=Private_Messages&amp;mode=post&amp;u=$uid\">"._SENDPM."</a> ]</span>";
    }
    echo "<br /><br /><strong>"._TITLE."</strong><br />"
        ."<input type=\"text\" name=\"subject\" size=\"50\" value=\"$subject\"><br /><br />";
    if(empty($topic)) {
        $topic = 1;
    }
    $result = $db->sql_query("select topicimage from ".$prefix."_topics where topicid='$topic'");
    list($topicimage) = $db->sql_fetchrow($result);
    echo "<table border=\"0\" width=\"70%\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"$bgcolor2\" align=\"center\"><tr><td>"
        ."<table border=\"0\" width=\"100%\" cellpadding=\"8\" cellspacing=\"1\" bgcolor=\"$bgcolor1\"><tr><td>";

        if ($topic_icon == 0) {
             echo "<img src=\"images/topics/$topicimage\" border=\"0\" align=\"right\" alt=\"\">";
        }

    $storypre = "$story_bb<br /><br />$storyext_bb";

    themepreview($subject, $storypre);
    echo "</td></tr></table></td></tr></table>"
        ."<br /><strong>"._TOPIC."</strong> <select name=\"topic\">";
    $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
    echo "<option value=\"\">"._SELECTTOPIC."</option>\n";
    while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
    $topicid = intval($topicid);
        if ($topicid==$topic) {
            $sel = "selected ";
        }
        echo "<option $sel value=\"$topicid\">$topics</option>\n";
        $sel = "";
    }
    echo "</select>";
    echo "<br /><br />";
    echo "<table border='0' width='100%' cellspacing='0'><tr><td width='20%'><strong>"._ASSOTOPIC."</strong></td><td width='100%'>"
        ."<table border='1' cellspacing='3' cellpadding='8'><tr>";
    $sql = "SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext";
    $result = $db->sql_query($sql);
    $a = 0;
    while ($row = $db->sql_fetchrow($result)) {
        if ($a == 3) {
            echo "</tr><tr>";
            $a = 0;
        }
        echo "<td><input type='checkbox' name='assotop[]' value='".intval($row["topicid"])."'>".$row["topictext"]."</td>";
        $a++;
    }
    echo "</tr></table></td></tr></table><br /><br />";
    SelectCategory($cat);

    echo '<br />';
    topicicon($topic_icon);
    echo '<br />';
    writes($writes);

    echo "<br />";
    puthome($ihome, $acomm);
    if ($multilingual == 1) {
        echo "<br /><strong>"._LANGUAGE.": </strong>"
            ."<select name=\"alanguage\">";
        $languages = lang_list();
        echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
        for ($i=0, $j = count($languages); $i < $j; $i++) {
            if ($languages[$i] != '') {
                echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
            }
        }
        echo '</select>';
    } else {
        echo "<input type=\"hidden\" name=\"alanguage\" value=\"\">";
    }
    echo "<br /><br /><strong>"._STORYTEXT."</strong>";

    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', $story, 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', $storyext, 'postnews');
    echo "<span class=\"content\">"._ARESUREURL."</span><br /><br />";

    echo "<span class=\"content\">"._AREYOUSURE."</span><br /><br />"
        ."<strong>"._NOTES."</strong><br />"
        ."<textarea style=\"wrap:virtual\" cols=\"50\" rows=\"4\" name=\"notes\"></textarea><br />"
        ."<input type=\"hidden\" NAME=\"qid\" size=\"50\" value=\"$qid\">"
        ."<input type=\"hidden\" NAME=\"uid\" size=\"50\" value=\"$uid\">"
        ."<br /><strong>"._PROGRAMSTORY."</strong>&nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"1\">"._YES." &nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"0\" checked>"._NO."<br /><br />"
        .""._NOWIS.": $date<br /><br />";
    $day = 1;
    echo ""._DAY.": <select name=\"day\">";
    while ($day <= 31) {
        if ($tday==$day) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"day\" $sel>$day</option>";
        $day++;
    }
    echo "</select>";
    $month = 1;
    echo ""._UMONTH.": <select name=\"month\">";
    while ($month <= 12) {
        if ($ttmon==$month) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"month\" $sel>$month</option>";
        $month++;
    }
    echo "</select>";
    $date = getdate();
    $year = $date[year];
    echo ""._YEAR.": <input type=\"text\" name=\"year\" value=\"$year\" size=\"5\" maxlength=\"4\">";
    echo "<br />"._HOUR.": <select name=\"hour\">";
    $hour = 0;
    $cero = "0";
    while ($hour <= 23) {
        $dummy = $hour;
        if ($hour < 10) {
            $hour = "$cero$hour";
        }
        echo "<option name=\"hour\">$hour</option>";
        $hour = $dummy;
        $hour++;
    }
    echo "</select>";
    echo ": <select name=\"min\">";
    $min = 0;
    while ($min <= 59) {
        if (($min == 0) OR ($min == 5)) {
            $min = "0$min";
        }
        echo "<option name=\"min\">$min</option>";
        $min = $min + 5;
    }
    echo "</select>";
    echo ": 00<br /><br />"
        ."<select name=\"op\">"
        ."<option value=\"DeleteStory\">"._DELETESTORY."</option>"
        ."<option value=\"PreviewAgain\" selected>"._PREVIEWSTORY."</option>"
        ."<option value=\"PostStory\">"._POSTSTORY."</option>"
        ."</select>"
        ."<input type=\"submit\" value=\""._OK."\">&nbsp;&nbsp;[ <a href=\"".$admin_file.".php?op=DeleteStory&qid=$qid\">"._DELETE."</a> ]";
        CloseTable();
    echo "<br />";
    putpoll($pollTitle, $optionText);
    echo "</form>";
    include(NUKE_BASE_DIR.'footer.php');
}


function previewStory($automated, $year, $day, $month, $hour, $min, $qid, $uid, $author, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop) {

    global $user, $admin_file, $boxstuff, $anonymous, $bgcolor1, $bgcolor2, $user_prefix, $prefix, $db, $multilingual, $Version_Num;
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    $today = getdate();
    $tday = $today[mday];
    if ($tday < 10){
        $tday = "0$tday";
    }
    $tmonth = $today[month];
    $tyear = $today[year];
    $thour = $today[hours];
    if ($thour < 10){
        $thour = "0$thour";
    }
    $tmin = $today[minutes];
    if ($tmin < 10){
        $tmin = "0$tmin";
    }
    $tsec = $today[seconds];
    if ($tsec < 10){
        $tsec = "0$tsec";
    }
    $date = "$tmonth $tday, $tyear @ $thour:$tmin:$tsec";
    $subject = stripslashes($subject);
    $hometext = stripslashes($hometext);
    $bodytext = stripslashes($bodytext);
    $notes = stripslashes($notes);
    OpenTable();

    echo "<font class=\"content\">"
        ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">"
        ."<strong>"._NAME."</strong><br />"
        ."<input type=\"text\" name=\"author\" size=\"25\" value=\"$author\">";

    if ($author != $anonymous) {
        $res = $db->sql_query("select user_id, user_email from ".$user_prefix."_users where username='$author'");
        list($pm_userid, $email) = $db->sql_fetchrow($res);
        $pm_userid = intval($pm_userid);
        echo "&nbsp;&nbsp;<span class=\"content\">[ <a href=\"mailto:$email?Subject=Re: $subject\">"._EMAILUSER."</a> | <a href='modules.php?name=Your_Account&op=userinfo&username=$author'>"._USERPROFILE."</a> | <a href=\"modules.php?name=Private_Messages&amp;mode=post&amp;u=$uid\">"._SENDPM."</a> ]</span>";
    }
    echo "<br /><br /><strong>"._TITLE."</strong><br />"
        ."<input type=\"text\" name=\"subject\" size=\"50\" value=\"$subject\"><br /><br />";
    $result = $db->sql_query("select topicimage from ".$prefix."_topics where topicid='$topic'");
    list($topicimage) = $db->sql_fetchrow($result);
    echo "<table width=\"70%\" bgcolor=\"$bgcolor2\" cellpadding=\"0\" cellspacing=\"1\" border=\"0\"align=\"center\"><tr><td>"
        ."<table width=\"100%\" bgcolor=\"$bgcolor1\" cellpadding=\"8\" cellspacing=\"1\" border=\"0\"><tr><td>";

        if ($topic_icon == 0) {
            echo "<img src=\"images/topics/$topicimage\" border=\"0\" align=\"right\" alt=\"\">";
        }


    $bodytext_bb = decode_bbcode(set_smilies(stripslashes($bodytext)), 1, true);
    $hometext_bb = decode_bbcode(set_smilies(stripslashes($hometext)), 1, true);
    $hometext_bb = evo_img_tag_to_resize($hometext_bb);
    $bodytext_bb = evo_img_tag_to_resize($bodytext_bb);
    themepreview($subject, $hometext_bb, $bodytext_bb, $notes);

    echo "</td></tr></table></td></tr></table>"
        ."<br /><strong>"._TOPIC."</strong> <select name=\"topic\">";
    $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
    echo "<option value=\"\">"._ALLTOPICS."</option>\n";
    while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
            $topicid = intval($topicid);
        if ($topicid==$topic) {
            $sel = "selected ";
        }
        echo "<option $sel value=\"$topicid\">$topics</option>\n";
        $sel = "";
    }
    echo "</select>";
    echo "<br /><br />";
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($Version_Num >= 6.6) {
        for ($i=0; $i<count($assotop); $i++) { $associated .= "$assotop[$i]-"; }
        $asso_t = explode("-", $associated);
        echo "<table border='0' width='100%' cellspacing='0'><tr><td width='20%'><strong>"._ASSOTOPIC."</strong></td><td width='100%'>"
            ."<table border='1' cellspacing='3' cellpadding='8'><tr>";
        $sql = "SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext";
        $result = $db->sql_query($sql);
        $a = 0;
        while ($row = $db->sql_fetchrow($result)) {
            if ($a == 3) {
                echo "</tr><tr>";
                $a = 0;
            }
            for ($i=0; $i<count($asso_t); $i++) {
                if ($asso_t[$i] == $row["topicid"]) {
                    $checked = "CHECKED";
                    break;
                }
            }
            echo "<td><input type='checkbox' name='assotop[]' value='".intval($row["topicid"])."' $checked>".$row["topictext"]."</td>";
            $checked = "";
            $a++;
        }
        echo "</tr></table></td></tr></table><br /><br />";
    }
    // Copyright (c) 2000-2005 by NukeScripts Network
    $cat = $catid;
    SelectCategory($cat);
    echo '<br />';
    topicicon($topic_icon);
    echo '<br />';
    writes($writes);
    echo "<br />";
    puthome($ihome, $acomm);
    if ($multilingual == 1) {
        echo "<br /><strong>"._LANGUAGE.": </strong>"
            ."<select name=\"alanguage\">";
        $languages = lang_list();
        echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
        for ($i=0, $j = count($languages); $i < $j; $i++) {
            if ($languages[$i] != '') {
                echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
            }
        }
        echo '</select>';
    } else {
        echo "<input type=\"hidden\" name=\"alanguage\" value=\"$language\">";
    }
    echo "<br /><br /><strong>"._STORYTEXT."</strong>";
    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', $hometext, 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', $bodytext, 'postnews');
    echo "<span class=\"content\">"._ARESUREURL."</span><br /><br />";

    echo "<strong>"._NOTES."</strong><br />"
        ."<textarea style=\"wrap:virtual\" cols=\"50\" rows=\"4\" name=\"notes\">$notes</textarea><br /><br />"
        ."<input type=\"hidden\" NAME=\"qid\" size=\"50\" value=\"$qid\">"
        ."<input type=\"hidden\" NAME=\"uid\" size=\"50\" value=\"$uid\">";

    if ($automated == 1) {
        $sel1 = "checked";
        $sel2 = "";
    } else {
        $sel1 = "";
        $sel2 = "checked";
    }
    echo "<strong>"._PROGRAMSTORY."</strong>&nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"1\" $sel1>"._YES." &nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"0\" $sel2>"._NO."<br /><br />"
        .""._NOWIS.": $date<br /><br />";
    $xday = 1;
    echo ""._DAY.": <select name=\"day\">";
    while ($xday <= 31) {
        if ($xday == $day) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"day\" $sel>$xday</option>";
        $xday++;
    }
    echo "</select>";
    $xmonth = 1;
    echo ""._UMONTH.": <select name=\"month\">";
    while ($xmonth <= 12) {
        if ($xmonth == $month) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"month\" $sel>$xmonth</option>";
        $xmonth++;
    }
    echo "</select>";
    echo ""._YEAR.": <input type=\"text\" name=\"year\" value=\"$year\" size=\"5\" maxlength=\"4\">";
    echo "<br />"._HOUR.": <select name=\"hour\">";
    $xhour = 0;
    $cero = "0";
    while ($xhour <= 23) {
        $dummy = $xhour;
        if ($xhour < 10) {
            $xhour = "$cero$xhour";
        }
        if ($xhour == $hour) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"hour\" $sel>$xhour</option>";
        $xhour = $dummy;
        $xhour++;
    }
    echo "</select>";
    echo ": <select name=\"min\">";
    $xmin = 0;
    while ($xmin <= 59) {
        if (($xmin == 0) OR ($xmin == 5)) {
            $xmin = "0$xmin";
        }
        if ($xmin == $min) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"min\" $sel>$xmin</option>";
        $xmin = $xmin + 5;
    }
    echo "</select>";
    echo ": 00<br /><br />"
        ."<select name=\"op\">"
        ."<option value=\"DeleteStory\">"._DELETESTORY."</option>"
        ."<option value=\"PreviewAgain\" selected>"._PREVIEWSTORY."</option>"
        ."<option value=\"PostStory\">"._POSTSTORY."</option>"
        ."</select>"
        ."<input type=\"submit\" value=\""._OK."\">";
    CloseTable();
    echo "<br />";
    putpoll($pollTitle, $optionText);
    echo "</form>";
    include(NUKE_BASE_DIR.'footer.php');
}

function postStory($automated, $year, $day, $month, $hour, $min, $qid, $uid, $author, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop) {

    global $aid, $admin_file, $ultramode, $prefix, $db, $user_prefix, $Version_Num, $ne_config, $adminmail, $sitename, $nukeurl, $cache;
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($Version_Num >= 6.6) { for ($i=0; $i<count($assotop); $i++) { $associated .= "$assotop[$i]-"; }  }
    // Copyright (c) 2000-2005 by NukeScripts Network

    if ($automated == 1) {
        if ($day < 10) {
            $day = "0$day";
        }
        if ($month < 10) {
            $month = "0$month";
        }
        $sec = "00";
        $date = "$year-$month-$day $hour:$min:$sec";
        if ($uid == 1) $author = "";
        if ($hometext == $bodytext) $bodytext = "";
        $subject = Fix_Quotes($subject);
        $hometext = Fix_Quotes($hometext);
        $bodytext = Fix_Quotes($bodytext);
        $notes = Fix_Quotes($notes);
        $new_sql  = "insert into ".$prefix."_autonews values (NULL, '$catid', '$aid', '$subject', '$date', '$hometext', '$bodytext', '$topic', '$author', '$notes', '$ihome', '$alanguage', '$acomm', '$topic_icon', '$writes'";

        $new_sql .= ", '$associated'";
        $new_sql .= ")";
        $result = $db->sql_query($new_sql);
        // Copyright (c) 2000-2005 by NukeScripts Network
        if (!$result) { return; }
        $result = $db->sql_query("select sid from ".$prefix."_stories WHERE title='$subject' order by time DESC limit 0,1");
        list($artid) = $db->sql_fetchrow($result);
        $artid = intval($artid);
        if ($uid != 1) {
            $db->sql_query("update ".$user_prefix."_users set counter=counter+1 where user_id='$uid'");
            // Copyright (c) 2000-2005 by NukeScripts Network
            if($ne_config["notifyauth"] == 1) {
                $urow = $db->sql_fetchrow($db->sql_query("SELECT username, user_email FROM ".$user_prefix."_users WHERE user_id='$uid'"));
                $Mto = $urow["username"]." <".$urow["user_email"].">";
                $Msubject = _NE_ARTPUB;
                $Mbody = _NE_HASPUB."\n$nukeurl/modules.php?name=News&file=article&sid=$artid";
                $Mheaders  = "From: ".$sitename." <$adminmail>\r\n";
                $Mheaders .= "Reply-To: $adminmail\r\n";
                $Mheaders .= "Return-Path: $adminmail\r\n";
                $Mheaders .= "Organization: $sitename\r\n";
                $Mheaders .= "MIME-Version: 1.0\r\n";
                $Mheaders .= "Content-Type: text/plain\r\n";
                $Mheaders .= "Content-Transfer-Encoding: 8bit\r\n";
                $Mheaders .= "X-MSMail-Priority: High\r\n";
                $Mheaders .= "X-Mailer: NSN News          \r\n";
                @evo_mail($Mto, $Msubject, $Mbody, $Mheaders);
            }
            // Copyright (c) 2000-2005 by NukeScripts Network
        }
        $db->sql_query("update ".$prefix."_authors set counter=counter+1 where aid='$aid'");
        if ($ultramode) { ultramode(); }
        $qid = intval($qid);
        $db->sql_query("delete from ".$prefix."_queue where qid='$qid'");

        $cache->delete('numwaits', 'submissions');

        redirect($admin_file.".php?op=submissions");
    } else {
        if ($uid == 1) $author = "";
        if ($hometext == $bodytext) $bodytext = "";
        $subject = Fix_Quotes($subject);
        $hometext = Fix_Quotes($hometext);
        $bodytext = Fix_Quotes($bodytext);
        $notes = Fix_Quotes($notes);
        if ((!empty($pollTitle)) AND (!empty($optionText[1])) AND (!empty($optionText[2]))) {
            $haspoll = 1;
            $timeStamp = time();
            $pollTitle = Fix_Quotes($pollTitle);
            if(!$db->sql_query("INSERT INTO ".$prefix."_poll_desc VALUES (NULL, '$pollTitle', '$timeStamp', '0', '$alanguage', '0')")) {
                return;
            }
            $object = $db->sql_fetchrow($db->sql_query("SELECT pollID FROM ".$prefix."_poll_desc WHERE pollTitle='$pollTitle'"));
            $id = $object["pollID"];
            $id = intval($id);
            for($i = 1, $maxi = count($optionText); $i <= $maxi; $i++) {
                if(!empty($optionText[$i])) {
                    $optionText[$i] = Fix_Quotes($optionText[$i]);
                }
                if(!$db->sql_query("INSERT INTO ".$prefix."_poll_data (pollID, optionText, optionCount, voteID) VALUES ('$id', '$optionText[$i]', '0', '$i')")) {
                    return;
                }
            }
        } else {
            $haspoll = 0;
            $id = 0;
        }
        // Copyright (c) 2000-2005 by NukeScripts Network
        $new_sql  = "insert into ".$prefix."_stories values (NULL, '$catid', '$aid', '$subject', now(), '$hometext', '$bodytext', '0', '0', '$topic', '$author', '$notes', '$ihome', '$alanguage', '$acomm', '$haspoll', '$id', '0', '0'";
        $new_sql .= ", '$associated'";
        $new_sql .= ",'$topic_id', '$writes')";
        $result = $db->sql_query($new_sql);
        // Copyright (c) 2000-2005 by NukeScripts Network
        $result = $db->sql_query("select sid from ".$prefix."_stories WHERE title='$subject' order by time DESC limit 0,1");
        list($artid) = $db->sql_fetchrow($result);
        $artid = intval($artid);
        $db->sql_query("UPDATE ".$prefix."_poll_desc SET artid='$artid' WHERE pollID='$id'");
        if (!$result) { return; }
        if ($uid != 1) {
            $db->sql_query("update ".$user_prefix."_users set counter=counter+1 where user_id='$uid'");
            // Copyright (c) 2000-2005 by NukeScripts Network
            if($ne_config["notifyauth"] == 1) {
                $urow = $db->sql_fetchrow($db->sql_query("SELECT username, user_email FROM ".$user_prefix."_users WHERE user_id='$uid'"));
                $Mto = $urow["username"]." <".$urow["user_email"].">";
                $Msubject = _NE_ARTPUB;
                $Mbody = _NE_HASPUB."\n$nukeurl/modules.php?name=News&file=article&sid=$artid";
                $Mheaders  = "From: ".$sitename." <$adminmail>\r\n";
                $Mheaders .= "Reply-To: $adminmail\r\n";
                $Mheaders .= "Return-Path: $adminmail\r\n";
                $Mheaders .= "Organization: $sitename\r\n";
                $Mheaders .= "MIME-Version: 1.0\r\n";
                $Mheaders .= "Content-Type: text/plain\r\n";
                $Mheaders .= "Content-Transfer-Encoding: 8bit\r\n";
                $Mheaders .= "X-MSMail-Priority: High\r\n";
                $Mheaders .= "X-Mailer: NSN News          \r\n";
                @evo_mail($Mto, $Msubject, $Mbody, $Mheaders);
            }
            // Copyright (c) 2000-2005 by NukeScripts Network
            $db->sql_query("update ".$user_prefix."_users set counter=counter+1 where user_id='$uid'");
        }
        $db->sql_query("update ".$prefix."_authors set counter=counter+1 where aid='$aid'");
        if ($ultramode) { ultramode(); }
        deleteStory($qid);
    }
}

function editStory($sid) {
    global $user, $admin_file, $bgcolor1, $bgcolor2, $aid, $prefix, $db, $multilingual, $Version_Num, $module_name;
    $aid = substr($aid, 0,25);
    $sid = intval($sid);
    list($aaid) = $db->sql_ufetchrow("select aid from ".$prefix."_stories where sid='$sid'");
    $aaid = substr($aaid, 0,25);
    if (is_mod_admin($module_name)) {
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        OpenTable();
        echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
        CloseTable();
        echo "<br />";

        $result = $db->sql_query("SELECT catid, title, hometext, bodytext, topic, notes, ihome, alanguage, acomm, ticon, writes, aid, informant, time, sid FROM ".$prefix."_stories where sid='$sid'");
        list($catid, $subject, $hometext, $bodytext, $topic, $notes, $ihome, $alanguage, $acomm, $topic_icon, $writes, $aid, $informant, $time, $sid) = $db->sql_fetchrow($result);

        $catid = intval($catid);
        $subject = stripslashes($subject);
        $hometext = stripslashes($hometext);
        $bodytext = stripslashes($bodytext);
        $notes = stripslashes($notes);
        $ihome = intval($ihome);
        $acomm = intval($acomm);
        $aid = $aid;
        $topic_icon = intval($topic_icon);
        $writes = intval($writes);
        $result2=$db->sql_query("select topicimage from ".$prefix."_topics where topicid='$topic'");
        list($topicimage) = $db->sql_fetchrow($result2);
        OpenTable();
        echo "<center><span class=\"option\"><strong>"._EDITARTICLE."</strong></span></center><br />";

        $hometext_bb = decode_bbcode(set_smilies(stripslashes(nl2br($hometext))), 1, true);
        $bodytext_bb = decode_bbcode(set_smilies(stripslashes(nl2br($bodytext))), 1, true);
        $hometext_bb = evo_img_tag_to_resize($hometext_bb);
        $bodytext_bb = evo_img_tag_to_resize($bodytext_bb);
        if($writes == 0) {
            define_once('WRITES', true);
        }
        getTopics($sid);
        global $topicname, $topicimage, $topictext;
        if ($topic_icon != 0) {
           $topicimage = $topicname = $topictext = '';
        }
        $informant = UsernameColor($informant);
        themearticle($aid, $informant, $time, $subject, $hometext_bb, $topic, $topicname, $topicimage, $topictext);
        echo "<br /><br />"
            ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">"
            ."<strong>"._TITLE."</strong><br />"
            ."<input type=\"text\" name=\"subject\" size=\"50\" value=\"$subject\"><br /><br />"
            ."<strong>"._TOPIC."</strong> <select name=\"topic\">";

        $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
        echo "<option value=\"\">"._ALLTOPICS."</option>\n";
        while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
            $topicid = intval($topicid);
                if ($topicid==$topic) { $sel = "selected "; }
                echo "<option $sel value=\"$topicid\">$topics</option>\n";
                $sel = "";
        }
        echo "</select>";
        echo "<br /><br />";
        // Copyright (c) 2000-2005 by NukeScripts Network
        if($Version_Num >= 6.6) {
            $asql = "SELECT associated FROM ".$prefix."_stories WHERE sid='$sid'";
            $aresult = $db->sql_query($asql);
            $arow = $db->sql_fetchrow($aresult);
            $asso_t = explode("-", $arow['associated']);
            echo "<table border='0' width='100%' cellspacing='0'><tr><td width='20%'><strong>"._ASSOTOPIC."</strong></td><td width='100%'>"
                ."<table border='1' cellspacing='3' cellpadding='8'><tr>";
            $sql = "SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext";
            $result = $db->sql_query($sql);
            $a = 0;
            while ($row = $db->sql_fetchrow($result)) {
                if ($a == 3) {
                    echo "</tr><tr>";
                    $a = 0;
                }
                $checked = '';
                for ($i=0; $i<count($asso_t); $i++) {
                    if ($asso_t[$i] == $row["topicid"]) {
                        $checked = "CHECKED";
                        break;
                    }
                }
                echo "<td><input type='checkbox' name='assotop[]' value='".intval($row["topicid"])."' $checked>".$row["topictext"]."</td>";
                $checked = "";
                $a++;
            }
            echo "</tr></table></td></tr></table><br /><br />";
        }
        // Copyright (c) 2000-2005 by NukeScripts Network
        $cat = $catid;
        SelectCategory($cat);

       echo '<br />';
       topicicon($topic_icon);
       echo '<br />';
       writes($writes);

        echo "<br />";
        puthome($ihome, $acomm);
        if ($multilingual == 1) {
            echo "<br /><strong>"._LANGUAGE.": </strong>"
                ."<select name=\"alanguage\">";
            $languages = lang_list();
            echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
            for ($i=0, $j = count($languages); $i < $j; $i++) {
                if ($languages[$i] != '') {
                    echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
                }
            }
            echo '</select>';
        } else {
            echo "<input type=\"hidden\" name=\"alanguage\" value=\"\">";
        }
        echo "<br /><br /><strong>"._STORYTEXT."</strong>";

    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', $hometext, 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', $bodytext, 'postnews');

        echo "<span class=\"content\">"._AREYOUSURE."</span><br /><br />"
            ."<strong>"._NOTES."</strong><br />"
            ."<textarea style=\"wrap:virtual\" cols=\"50\" rows=\"4\" name=\"notes\">$notes</textarea><br /><br />"
            ."<input type=\"hidden\" NAME=\"sid\" size=\"50\" value=\"$sid\">"
            ."<input type=\"hidden\" name=\"op\" value=\"ChangeStory\">"
            ."<input type=\"submit\" value=\""._SAVECHANGES."\">"
            ."</form>";
        CloseTable();
        include(NUKE_BASE_DIR.'footer.php');
    } else {
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        OpenTable();
        echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
        CloseTable();
        echo "<br />";
        OpenTable();
        echo "<center><strong>"._NOTAUTHORIZED1."</strong><br /><br />"
            .""._NOTAUTHORIZED2."<br /><br />"
            .""._GOBACK."";
        CloseTable();
        include(NUKE_BASE_DIR.'footer.php');
    }
}

function removeStory($sid, $ok = 0) {
    global $ultramode, $aid, $prefix, $db, $admin_file, $module_name;
    $sid = intval($sid);
    $aid = substr($aid, 0,25);
    list($aaid) = $db->sql_ufetchrow("select aid from ".$prefix."_stories where sid='$sid'");
    $aaid = substr($aaid, 0,25);
    if (is_mod_admin($module_name)) {
        if($ok) {
            $counter--;
                $db->sql_query("DELETE FROM ".$prefix."_stories where sid='$sid'");
            $db->sql_query("DELETE FROM ".$prefix."_comments where sid='$sid'");
            $db->sql_query("update ".$prefix."_poll_desc set artid='0' where artid='$sid'");
            $result = $db->sql_query("update ".$prefix."_authors set counter='$counter' where aid='$aid'");
            if ($ultramode) {
                ultramode();
            }
            redirect($admin_file.".php?op=adminStory");
        } else {
            include(NUKE_BASE_DIR.'header.php');
            OpenTable();
	        echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
            echo "<br /><br />";
	        echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	        CloseTable();
	        echo "<br />";
            OpenTable();
            echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
            CloseTable();
            echo "<br />";
            OpenTable();
            echo "<center>"._REMOVESTORY." $sid "._ANDCOMMENTS."";
           	echo "<br /><br />[ <a href=\"".$admin_file.".php?op=adminStory\">"._NO."</a> | <a href=\"".$admin_file.".php?op=RemoveStory&amp;sid=$sid&amp;ok=1\">"._YES."</a> ]</center>";
                CloseTable();
            include(NUKE_BASE_DIR.'footer.php');
        }
    } else {
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        OpenTable();
        echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
        CloseTable();
        echo "<br />";
        OpenTable();
        echo "<center><strong>"._NOTAUTHORIZED1."</strong><br /><br />"
            .""._NOTAUTHORIZED2."<br /><br />"
            .""._GOBACK."";
        CloseTable();
        @include(NUKE_BASE_DIR.'footer.php');
    }
}


function changeStory($sid, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $assotop) {
    global $aid, $ultramode, $prefix, $db, $Version_Num, $admin_file, $module_name;
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($version_Num >= 6.6) { for ($i=0; $i<count($assotop); $i++) { $associated .= "$assotop[$i]-"; } }
    // Copyright (c) 2000-2005 by NukeScripts Network
    $sid = intval($sid);
    $aid = substr($aid, 0,25);
    list($aaid) = $db->sql_ufetchrow("select aid from ".$prefix."_stories where sid='$sid'");
    $aaid = substr($aaid, 0,25);
    if (is_mod_admin($module_name)) {
        $subject = Fix_Quotes($subject);
        $hometext = Fix_Quotes($hometext);
        $bodytext = Fix_Quotes($bodytext);
        $notes = Fix_Quotes($notes);
        $topic = (empty($topic)) ? '1' : $topic;
        // Copyright (c) 2000-2005 by NukeScripts Network

        $db->sql_query("update ".$prefix."_stories set catid='$catid', title='$subject', hometext='$hometext', bodytext='$bodytext', topic='$topic', notes='$notes', ihome='$ihome', alanguage='$alanguage', acomm='$acomm', ticon='$topic_icon', writes='$writes' where sid='$sid'");

        $db->sql_query("update ".$prefix."_stories set associated='$associated' where sid='$sid'");
        // Copyright (c) 2000-2005 by NukeScripts Network
        if ($ultramode) { ultramode(); }
        redirect($admin_file.".php?op=adminStory");
    }
}

function adminStory() {
    global $prefix, $db, $language, $multilingual, $Version_Num, $admin_file, $aid, $module_name, $bgcolor1;
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();

	echo "<br />";

    OpenTable();
    echo '<div class="acenter">'._ARTICLEADMIN.'</div>';
    CloseTable();

    echo "<br />";

    OpenTable();
    echo '<div style="width: 100%; text-align: center">';
    echo '	<div style="width: 33.3%; float: left"><a href="'.$admin_file.'.php?op=topicsmanager">'._TOPICS.'</a></div>';
    echo '	<div style="width: 33.3%; float: left"><a href="'.$admin_file.'.php?op=submissions">'._SUBMISSIONS.'</a></div>';
    echo '	<div style="width: 33.3%; float: left"><a href="'.$admin_file.'.php?op=NENewsConfig">'._NE_NEWSCONFIG.'</a></div>';
    echo '</div>';
    CloseTable();

    echo "<br />";

    OpenTable();
    echo "<center><strong>"._LAST." 20 "._ARTICLES."</strong></center><br />";
    $result6 = $db->sql_query("SELECT sid, aid, title, time, topic, informant, alanguage FROM ".$prefix."_stories ORDER BY time DESC LIMIT 0,20");
    echo "<center><table border=\"1\" width=\"100%\">";
    while ($row6 = $db->sql_fetchrow($result6)) {
        $sid = intval($row6["sid"]);
        $aid = $row6["aid"];
        $said = substr("$aid", 0,25);
        $title = $row6["title"];
        $time = $row6["time"];
        $topic = $row6["topic"];
        $informant = $row6["informant"];
        $alanguage = $row6["alanguage"];
        $row7 = $db->sql_fetchrow($db->sql_query("SELECT topicname FROM ".$prefix."_topics WHERE topicid='$topic'"));
        $topicname = $row7["topicname"];
        if (empty($alanguage)) {
            $alanguage = ""._ALL."";
        }
        formatTimestamp($time);
        echo "<tr><td align=\"right\"><strong>$sid</strong>"
            ."</td><td align=\"left\" width=\"100%\"><a href=\"modules.php?name=News&amp;file=article&amp;sid=$sid\">$title</a>"
            ."</td><td align=\"center\">$alanguage"
            ."</td><td align=\"right\">$topicname";
        if (is_mod_admin('News')) {
            if ($aid == $said) {
                echo "</td><td align=\"right\" nowrap>(<a href=\"".$admin_file.".php?op=EditStory&amp;sid=$sid\">"._EDIT."</a>-<a href=\"".$admin_file.".php?op=RemoveStory&amp;sid=$sid\">"._DELETE."</a>)"
                     ."</td></tr>";
            } else {
                echo "</td><td align=\"right\" nowrap><span class=\"content\"><i>("._NOFUNCTIONS.")</i></span>"
                    ."</td></tr>";
            }
        } else {
            echo "</td></tr>";
        }
    }
    echo "</table>";

    if (is_mod_admin($module_name)) {
    echo "<center>"
        ."<form action=\"".$admin_file.".php\" method=\"post\">"
        .""._STORYID.": <input type=\"text\" NAME=\"sid\" SIZE=\"10\">"
        ."<select name=\"op\">"
        ."<option value=\"EditStory\" SELECTED>"._EDIT."</option>"
        ."<option value=\"RemoveStory\">"._DELETE."</option>"
        ."</select>"
        ."<input type=\"submit\" value=\""._GO."\">"
        ."</form></center>";
    }
    CloseTable();
    echo "<br />";

    if (!empty($admlanguage)) {
        $queryalang = "WHERE alanguage='$admlanguage' ";
    } else {
        $queryalang = "";
    }

    if (is_active("News"))
    {
        OpenTable();
        echo "<center><strong>"._AUTOMATEDARTICLES."</strong></center><br />";
        $count = 0;
        $result5 = $db->sql_query("SELECT anid, aid, title, time, alanguage FROM ".$prefix."_autonews $queryalang ORDER BY time ASC");
        while (list($anid, $aid, $listtitle, $time, $alanguage) = $db->sql_fetchrow($result5)) {
            $anid = intval($anid);
            $said = substr($aid, 0,25);
            $title = $listtitle;
            if (empty($alanguage)) {
                $alanguage = ""._ALL."";
            }
            if (!empty($anid)) {
                if ($count == 0) {
                    echo "<table border=\"1\" width=\"100%\">";
                    $count = 1;
                }
                $time = str_replace(" ", "@", $time);
                if (is_mod_admin('News')) {
                    if ($aid == $said) {
                        echo "<tr><td nowrap>&nbsp;(<a href=\"".$admin_file.".php?op=autoEdit&amp;anid=$anid\">"._EDIT."</a>-<a href=\"".$admin_file.".php?op=autoDelete&amp;anid=$anid\">"._DELETE."</a>)&nbsp;</td><td width=\"100%\">&nbsp;$title&nbsp;</td><td align=\"center\">&nbsp;$alanguage&nbsp;</td><td nowrap>&nbsp;$time&nbsp;</td></tr>"; /* Multilingual Code : added column to display language */
                    } else {
                        echo "<tr><td>&nbsp;("._NOFUNCTIONS.")&nbsp;</td><td width=\"100%\">&nbsp;$title&nbsp;</td><td align=\"center\">&nbsp;$alanguage&nbsp;</td><td nowrap>&nbsp;$time&nbsp;</td></tr>"; /* Multilingual Code : added column to display language */
                    }
                } else {
                    echo "<tr><td width=\"100%\">&nbsp;$title&nbsp;</td><td align=\"center\">&nbsp;$alanguage&nbsp;</td><td nowrap>&nbsp;$time&nbsp;</td></tr>"; /* Multilingual Code : added column to display language */
                }
            }
        }
        if ((empty($anid)) AND ($count == 0)) {
            echo "<center><i>"._NOAUTOARTICLES."</i></center>";
        }
        if ($count == 1) {
            echo "</table>";
        }
        CloseTable();
        echo "<br />";
    }

    $today = getdate();
    $tday = $today['mday'];
    if ($tday < 10){ $tday = "0$tday"; }
    $tmonth = $today['month'];
    $ttmon = $today['mon'];
    if ($ttmon < 10){ $ttmon = "0$ttmon"; }
    $tyear = $today['year'];
    $thour = $today['hours'];
    if ($thour < 10){ $thour = "0$thour"; }
    $tmin = $today['minutes'];
    if ($tmin < 10){ $tmin = "0$tmin"; }
    $tsec = $today['seconds'];
    if ($tsec < 10){ $tsec = "0$tsec"; }
    $date = "$tmonth $tday, $tyear @ $thour:$tmin:$tsec";
    OpenTable();

    echo "<center><span class=\"option\"><strong>"._ADDARTICLE."</strong></span></center><br /><br />"
            ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">"
        ."<strong>"._TITLE."</strong><br />"
        ."<input type=\"text\" name=\"subject\" size=\"50\"><br /><br />"
        ."<strong>"._TOPIC."</strong> ";

    $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
    echo "<select name=\"topic\">";
    echo "<option value=\"\">"._SELECTTOPIC."</option>\n";
    while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
            $topicid = intval($topicid);
        if ($topicid == $topic) {
            $sel = "selected ";
        }
            echo "<option $sel value=\"$topicid\">$topics</option>\n";
        $sel = "";
    }
    echo "</select><br /><br />";
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($Version_Num >= 6.6) {
        echo "<table border='0' width='100%' cellspacing='0'><tr><td width='20%'><strong>"._ASSOTOPIC."</strong></td><td width='100%'>"
            ."<table border='1' cellspacing='3' cellpadding='8'><tr>";
        $sql = "SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext";
        $result = $db->sql_query($sql);
        $a = 0;
        while ($row = $db->sql_fetchrow($result)) {
            if ($a == 3) {
                echo "</tr><tr>";
                $a = 0;
            }
            echo "<td><input type='checkbox' name='assotop[]' value='".intval($row["topicid"])."'>".$row["topictext"]."</td>";
            $a++;
        }
        echo "</tr></table></td></tr></table><br /><br />";
    }
    // Copyright (c) 2000-2005 by NukeScripts Network

    $cat = 0;
    SelectCategory($cat);
    echo "<br />";
    topicicon('');
    echo '<br />';
    writes('');
    echo '<br />';
    puthome('', '');
    if ($multilingual == 1) {
        echo "<br /><strong>"._LANGUAGE.": </strong>"
            ."<select name=\"alanguage\">";
        $languages = lang_list();
        echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
        for ($i=0, $j = count($languages); $i < $j; $i++) {
            if ($languages[$i] != '') {
                echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
            }
        }
        echo '</select>';
    } else {
        echo "<input type=\"hidden\" name=\"alanguage\" value=\"$language\">";
    }
    echo "<br /><br /><strong>"._STORYTEXT."</strong>";
    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', '', 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', '', 'postnews');
    echo "<span class=\"content\">"._ARESUREURL."</span>"
        ."<br /><br /><strong>"._PROGRAMSTORY."</strong>&nbsp;&nbsp;"
        ."<input type=radio name=automated value=1>"._YES." &nbsp;&nbsp;"
        ."<input type=radio name=automated value=0 checked>"._NO."<br /><br />"
        .""._NOWIS.": $date<br /><br />";
    $day = 1;
    echo ""._DAY.": <select name=\"day\">";
    while ($day <= 31) {
        if ($tday==$day) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"day\" $sel>$day</option>";
        $day++;
    }
    echo "</select>";
    $month = 1;
    echo ""._UMONTH.": <select name=\"month\">";
    while ($month <= 12) {
        if ($ttmon==$month) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"month\" $sel>$month</option>";
        $month++;
    }
    echo "</select>";
    $date = getdate();
    $year = $date['year'];
    echo _YEAR.": <input type=\"text\" name=\"year\" value=\"$year\" size=\"5\" maxlength=\"4\">"
        ."<br />"._HOUR.": <select name=\"hour\">";
    $hour = 0;
    $cero = "0";
    while ($hour <= 23) {
        $dummy = $hour;
        if ($hour < 10) {
            $hour = "$cero$hour";
        }
        echo "<option name=\"hour\">$hour</option>";
        $hour = $dummy;
        $hour++;
    }
    echo "</select>"
        .": <select name=\"min\">";
    $min = 0;
    while ($min <= 59) {
        if (($min == 0) OR ($min == 5)) {
            $min = "0$min";
        }
        echo "<option name=\"min\">$min</option>";
        $min = $min + 5;
    }
    echo "</select>";
    echo ": 00<br /><br />"
        ."<select name=\"op\">"
        ."<option value=\"PreviewAdminStory\" selected>"._PREVIEWSTORY."</option>"
        ."<option value=\"PostAdminStory\">"._POSTSTORY."</option>"
        ."</select>"
        ."<input type=\"submit\" value=\""._OK."\">";
    CloseTable();
    echo "<br />";
    putpoll('', '');
    echo "</form>";
    include(NUKE_BASE_DIR.'footer.php');
}

function previewAdminStory($automated, $year, $day, $month, $hour, $min, $subject, $hometext, $bodytext, $topic, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop) {
    global $user, $admin_file, $bgcolor1, $bgcolor2, $prefix, $db, $alanguage, $multilingual, $Version_Num;
    include(NUKE_BASE_DIR.'header.php');
    if ($topic<1) {
        $topic = 1;
    }
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=adminStory\">" . _NEWS_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._ARTICLEADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    $today = getdate();
    $tday = $today['mday'];
    if ($tday < 10){ $tday = "0$tday"; }
    $tmonth = $today['month'];
    $tyear = $today['year'];
    $thour = $today['hours'];
    if ($thour < 10){ $thour = "0$thour"; }
    $tmin = $today['minutes'];
    if ($tmin < 10){ $tmin = "0$tmin"; }
    $tsec = $today['seconds'];
    if ($tsec < 10){ $tsec = "0$tsec"; }
    $date = "$tmonth $tday, $tyear @ $thour:$tmin:$tsec";
    OpenTable();

    echo "<center><span class=\"option\"><strong>"._PREVIEWSTORY."</strong></span></center><br /><br />"
        ."<form action=\"".$admin_file.".php\" method=\"post\" name=\"postnews\">"
        ."<input type=\"hidden\" name=\"catid\" value=\"$catid\">";

    $subject = stripslashes($subject);
    $subject = str_replace("\"", "''", $subject);
    $hometext = stripslashes($hometext);
    $bodytext = stripslashes($bodytext);
    $result=$db->sql_query("select topicimage, topicname, topictext  from ".$prefix."_topics where topicid='$topic'");
    list($topicimage, $topicname, $topictext) = $db->sql_fetchrow($result);

    $hometext_bb = decode_bbcode(set_smilies(stripslashes($hometext)), 1, true);
    $bodytext_bb = decode_bbcode(set_smilies(stripslashes($bodytext)), 1, true);
    $hometext_bb = evo_img_tag_to_resize($hometext_bb);
    $bodytext_bb = evo_img_tag_to_resize($bodytext_bb);
    if($writes == 0) {
        define_once('WRITES', true);
    }
    getTopics($sid);
    if ($topic_icon != 0) {
       $topicimage = $topicname = $topictext = '';
    }
    $informant = UsernameColor($informant);
    themearticle($aid, $informant, $time, $subject, $hometext_bb, $topic, $topicname, $topicimage, $topictext);

    echo "<br /><br /><strong>"._TITLE."</strong><br />"
        ."<input type=\"text\" name=\"subject\" size=\"50\" value=\"$subject\"><br /><br />"
        ."<strong>"._TOPIC."</strong><select name=\"topic\">";
    $toplist = $db->sql_query("select topicid, topictext from ".$prefix."_topics order by topictext");
    echo "<option value=\"\">"._ALLTOPICS."</option>\n";
    while(list($topicid, $topics) = $db->sql_fetchrow($toplist)) {
            $topicid = intval($topicid);
        if ($topicid==$topic) {
            $sel = "selected ";
        }
        echo "<option $sel value=\"$topicid\">$topics</option>\n";
        $sel = "";
    }
    echo "</select><br /><br />";
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($Version_num >= 6.6) {
        for ($i=0; $i<count($assotop); $i++) { $associated .= "$assotop[$i]-"; }
        $asso_t = explode("-", $associated);
        echo "<table border='0' width='100%' cellspacing='0'><tr><td width='20%'><strong>"._ASSOTOPIC."</strong></td><td width='100%'>"
            ."<table border='1' cellspacing='3' cellpadding='8'><tr>";
        $sql = "SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext";
        $result = $db->sql_query($sql);
        while ($row = $db->sql_fetchrow($result)) {
            if ($a == 3) {
                echo "</tr><tr>";
                $a = 0;
            }
            for ($i=0; $i<count($asso_t); $i++) {
                if ($asso_t[$i] == $row["topicid"]) {
                    $checked = "CHECKED";
                    break;
                }
            }
            echo "<td><input type='checkbox' name='assotop[]' value='".intval($row["topicid"])."' $checked>".$row["topictext"]."</td>";
            $checked = "";
            $a++;
        }
        echo "</tr></table></td></tr></table><br /><br />";
    }
    // Copyright (c) 2000-2005 by NukeScripts Network
    $cat = $catid;
    SelectCategory($cat);
    echo '<br />';
    topicicon($topic_icon);
    echo '<br />';
    writes($writes);
    echo "<br />";
    puthome($ihome, $acomm);
    if ($multilingual == 1) {
        echo "<br /><strong>"._LANGUAGE.": </strong>"
            ."<select name=\"alanguage\">";
        $languages = lang_list();
        echo '<option value=""'.(($alanguage == '') ? ' selected="selected"' : '').'>'._ALL."</option>\n";
        for ($i=0, $j = count($languages); $i < $j; $i++) {
            if ($languages[$i] != '') {
                echo '<option value="'.$languages[$i].'"'.(($alanguage == $languages[$i]) ? ' selected="selected"' : '').'>'.ucfirst($languages[$i])."</option>\n";
            }
        }
        echo '</select>';
    } else {
        echo "<input type=\"hidden\" name=\"alanguage\" value=\"$language\">";
    }
    echo "<br /><br /><strong>"._STORYTEXT."</strong>";

    global $wysiwyg_buffer;
    $wysiwyg_buffer = 'hometext,bodytext';
    Make_TextArea('hometext', $hometext, 'postnews');
    echo "<strong>"._EXTENDEDTEXT."</strong>";
    Make_TextArea('bodytext', $bodytext, 'postnews');

    if ($automated == 1) {
        $sel1 = "checked";
        $sel2 = "";
    } else {
        $sel1 = "";
        $sel2 = "checked";
    }
    echo "<br /><strong>"._PROGRAMSTORY."</strong>&nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"1\" $sel1>"._YES." &nbsp;&nbsp;"
        ."<input type=\"radio\" name=\"automated\" value=\"0\" $sel2>"._NO."<br /><br />"
        .""._NOWIS.": $date<br /><br />";
    $xday = 1;
    echo ""._DAY.": <select name=\"day\">";
    while ($xday <= 31) {
        if ($xday == $day) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"day\" $sel>$xday</option>";
        $xday++;
    }
    echo "</select>";
    $xmonth = 1;
    echo ""._UMONTH.": <select name=\"month\">";
    while ($xmonth <= 12) {
        if ($xmonth == $month) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"month\" $sel>$xmonth</option>";
        $xmonth++;
    }
    echo "</select>";
    echo ""._YEAR.": <input type=\"text\" name=\"year\" value=\"$year\" size=\"5\" maxlength=\"4\">";
    echo "<br />"._HOUR.": <select name=\"hour\">";
    $xhour = 0;
    $cero = "0";
    while ($xhour <= 23) {
        $dummy = $xhour;
        if ($xhour < 10) {
            $xhour = "$cero$xhour";
        }
        if ($xhour == $hour) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"hour\" $sel>$xhour</option>";
        $xhour = $dummy;
        $xhour++;
    }
    echo "</select>";
    echo ": <select name=\"min\">";
    $xmin = 0;
    while ($xmin <= 59) {
        if (($xmin == 0) OR ($xmin == 5)) {
            $xmin = "0$xmin";
        }
        if ($xmin == $min) {
            $sel = "selected";
        } else {
            $sel = "";
        }
        echo "<option name=\"min\" $sel>$xmin</option>";
        $xmin = $xmin + 5;
    }
    echo "</select>";
    echo ": 00<br /><br />"
        ."<select name=\"op\">"
        ."<option value=\"PreviewAdminStory\" selected>"._PREVIEWSTORY."</option>"
        ."<option value=\"PostAdminStory\">"._POSTSTORY."</option>"
        ."</select>"
        ."<input type=\"submit\" value=\""._OK."\">";
    CloseTable();
    echo "<br />";
    putpoll($pollTitle, $optionText);
    echo "</form>";
    include(NUKE_BASE_DIR.'footer.php');
}

function postAdminStory($automated, $year, $day, $month, $hour, $min, $subject, $hometext, $bodytext, $topic, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop) {
    global $ultramode, $aid, $prefix, $db, $Version_Num, $admin_file;
    // Copyright (c) 2000-2005 by NukeScripts Network
    if($Version_Num >= 6.6) { for ($i=0; $i<count($assotop); $i++) { $associated .= "$assotop[$i]-"; } }
    // Copyright (c) 2000-2005 by NukeScripts Network
    if ($automated == 1) {
        if ($day < 10) {
            $day = "0$day";
        }
        if ($month < 10) {
            $month = "0$month";
        }
        $sec = "00";
        $date = "$year-$month-$day $hour:$min:$sec";
        $notes = "";
        $author = $aid;
        $subject = Fix_Quotes($subject);
        $subject = str_replace("\"", "''", $subject);
        $hometext = Fix_Quotes($hometext);
        $bodytext = Fix_Quotes($bodytext);
        $notes = Fix_Quotes($notes);
        // Copyright (c) 2000-2005 by NukeScripts Network
        $new_sql  = "insert into ".$prefix."_autonews values (NULL, '$catid', '$aid', '$subject', '$date', '$hometext', '$bodytext', '$topic', '$author', '$notes', '$ihome', '$alanguage', '$acomm'";
        $new_sql .= ", '$associated'";
        $new_sql .= ", '$topic_icon', '$writes')";
        $result = $db->sql_query($new_sql);
        // Copyright (c) 2000-2005 by NukeScripts Network
        if (!$result) { exit(); }
        $result = $db->sql_query("update ".$prefix."_authors set counter=counter+1 where aid='$aid'");
        if ($ultramode) {
            ultramode();
        }
        redirect($admin_file.".php?op=adminStory");
    } else {
        $subject = Fix_Quotes($subject);
        $hometext = Fix_Quotes($hometext);
        $bodytext = Fix_Quotes($bodytext);
        if ((!empty($pollTitle)) AND (!empty($optionText[1])) AND (!empty($optionText[2]))) {
            $haspoll = 1;
            $timeStamp = time();
            $pollTitle = Fix_Quotes($pollTitle);

            if(!$db->sql_query("INSERT INTO ".$prefix."_poll_desc VALUES (NULL, '$pollTitle', '$timeStamp', '0', '$alanguage', '0')")) {
                return;
            }
            $object = $db->sql_fetchrow($db->sql_query("SELECT pollID FROM ".$prefix."_poll_desc WHERE pollTitle='$pollTitle'"));
            $id = $object["pollID"];
            $id = intval($id);
            for($i = 1, $maxi = count($optionText); $i <= $maxi; $i++) {
                if(!empty($optionText[$i])) {
                    $optionText[$i] = Fix_Quotes($optionText[$i]);
                }
                if(!$db->sql_query("INSERT INTO ".$prefix."_poll_data (pollID, optionText, optionCount, voteID) VALUES ('$id', '$optionText[$i]', '0', '$i')")) {
                    return;
                }
            }
        } else {
            $haspoll = 0;
            $id = 0;
        }
        // Copyright (c) 2000-2005 by NukeScripts Network
        $new_sql  = "insert into ".$prefix."_stories values (NULL, '$catid', '$aid', '$subject', now(), '$hometext', '$bodytext', '0', '0', '$topic', '$aid', '$notes', '$ihome', '$alanguage', '$acomm', '$haspoll', '$id', '0', '0'";
        $new_sql .= ", '$associated'";
        $new_sql .= ", '$topic_icon', '$writes')";
        $result = $db->sql_query($new_sql);
        // Copyright (c) 2000-2005 by NukeScripts Network
        $result = $db->sql_query("select sid from ".$prefix."_stories WHERE title='$subject' order by time DESC limit 0,1");
        list($artid) = $db->sql_fetchrow($result);
        $artid = intval($artid);
        $db->sql_query("UPDATE ".$prefix."_poll_desc SET artid='$artid' WHERE pollID='$id'");
        if (!$result) {
            exit();
        }
        $result = $db->sql_query("update ".$prefix."_authors set counter=counter+1 where aid='$aid'");
        if ($ultramode) {
            ultramode();
        }
        redirect($admin_file.".php?op=adminStory");
    }
}

function submissions() {
    global $admin, $admin_file, $bgcolor1, $bgcolor2, $prefix, $db, $anonymous, $multilingual, $module_name;
    $dummy = 0;
    include(NUKE_BASE_DIR.'header.php');
    OpenTable();
	echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=submissions\">" . _NEWSSUBMISSION_ADMIN_HEADER . "</a></div>\n";
    echo "<br /><br />";
	echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	CloseTable();
	echo "<br />";
    OpenTable();
    echo "<center><span class=\"title\"><strong>"._SUBMISSIONSADMIN."</strong></span></center>";
    CloseTable();
    echo "<br />";
    OpenTable();
        $result = $db->sql_query("SELECT qid, uid, uname, subject, timestamp, alanguage FROM ".$prefix."_queue order by timestamp DESC");
        if($db->sql_numrows($result) == 0) {
            echo "<table width=\"100%\"><tr><td align=\"center\"><strong>"._NOSUBMISSIONS."</strong></td></tr></table>\n";
        } else {
            echo "<center><span class=\"content\"><strong>"._NEWSUBMISSIONS."</strong></span><form action=\"".$admin_file.".php\" method=\"post\"><table width=\"100%\" border=\"1\" bgcolor=\"$bgcolor2\"><tr><td><strong>&nbsp;"._TITLE."&nbsp;</strong></td>";
            if ($multilingual == 1) {
                  echo "<td><center><strong>&nbsp;"._LANGUAGE."&nbsp;</strong></center></td>";
            }
                echo "<td><center><strong>&nbsp;"._AUTHOR."&nbsp;</strong></center></td><td><center><strong>&nbsp;"._DATE."&nbsp;</strong></center></td><td><center><strong>&nbsp;"._FUNCTIONS."&nbsp;</strong></center></td></tr>\n";
            while (list($qid, $uid, $uname, $subject, $timestamp, $alanguage) = $db->sql_fetchrow($result)) {
                $qid = intval($qid);
                $uid = intval($uid);

                echo "<tr>\n";
                echo "<td width=\"100%\"><span class=\"content\">\n";
                if (empty($subject)) {
                    echo "&nbsp;<a href=\"".$admin_file.".php?op=DisplayStory&amp;qid=$qid\">"._NOSUBJECT."</a></span>\n";
                } else {
                    echo "&nbsp;<a href=\"".$admin_file.".php?op=DisplayStory&amp;qid=$qid\">$subject</a></span>\n";
                }
                if ($multilingual == 1) {
                        if (empty($alanguage)) {
                                    $alanguage = _ALL;
                        }
                        echo "</td><td align=\"center\"><font size=\"2\">&nbsp;$alanguage&nbsp;</font>\n";
                }
                if ($uname != $anonymous) {
                        $uname_color = UsernameColor($uname);
                        echo "</td><td align=\"center\" nowrap><font size=\"2\">&nbsp;<a href='modules.php?name=Your_Account&op=userinfo&username=$uname'>$uname_color</a>&nbsp;</font>\n";
                } else {
                        echo "</td><td align=\"center\" nowrap><font size=\"2\">&nbsp;$uname&nbsp;</font>\n";
                }
                $timestamp = explode(" ", $timestamp);
                echo "</td><td align=\"right\" nowrap><span class=\"content\">&nbsp;$timestamp[0]&nbsp;</span></td><td align=\"center\"><font class=\"content\">&nbsp;<a href=\"".$admin_file.".php?op=DeleteStory&amp;qid=$qid\">"._DELETE."</a>&nbsp;</td></tr>\n";
                $dummy++;
            }
            if ($dummy < 1) {
                echo "<tr><td bgcolor=\"$bgcolor1\" align=\"center\"><strong>"._NOSUBMISSIONS."</strong></form></td></tr></table>\n";
            } else {
                echo "</table></form>\n";
            }
        }
    if (is_mod_admin($module_name)) {
        echo "<br /><center>"
            ."[ <a href=\"".$admin_file.".php?op=subdelete\">"._DELETE."</a> ]"
            ."</center><br />";
    }
    CloseTable();
    include(NUKE_BASE_DIR.'footer.php');
}

function subdelete() {
    global $prefix, $db, $admin_file, $cache;
    $db->sql_query("delete from ".$prefix."_queue");
    $cache->delete('numwaits', 'submissions');
    redirect($admin_file.".php?op=adminStory");
}

switch($op) {

    case "EditCategory":
    EditCategory($catid);
    break;

    case "subdelete":
    subdelete();
    break;

    case "DelCategory":
    DelCategory($cat);
    break;

    case "YesDelCategory":
    YesDelCategory($catid);
    break;

    case "NoMoveCategory":
    NoMoveCategory($catid, $newcat);
    break;

    case "SaveEditCategory":
    SaveEditCategory($catid, $title);
    break;

    case "SelectCategory":
    SelectCategory($cat);
    break;

    case "AddCategory":
    AddCategory();
    break;

    case "SaveCategory":
    SaveCategory($title);
    break;

    case "DisplayStory":
    displayStory($qid);
    break;

    case "PreviewAgain":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    previewStory($automated, $year, $day, $month, $hour, $min, $qid, $uid, $author, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "PostStory":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    postStory($automated, $year, $day, $month, $hour, $min, $qid, $uid, $author, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "EditStory":
    editStory($sid);
    break;

    case "RemoveStory":
    removeStory( $sid, $ok );
    break;

    case "ChangeStory":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    changeStory($sid, $subject, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $assotop);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "DeleteStory":
    deleteStory($qid);
    break;

    case "adminStory":
    adminStory();
    break;

    case "PreviewAdminStory":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    previewAdminStory($automated, $year, $day, $month, $hour, $min, $subject, $hometext, $bodytext, $topic, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "PostAdminStory":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    postAdminStory($automated, $year, $day, $month, $hour, $min, $subject, $hometext, $bodytext, $topic, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes, $pollTitle, $optionText, $assotop);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "autoDelete":
    autodelete($anid);
    break;

    case "autoEdit":
    autoEdit($anid);
    break;

    case "autoSaveEdit":
/*****[BEGIN]******************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    autoSaveEdit($anid, $year, $day, $month, $hour, $min, $title, $hometext, $bodytext, $topic, $notes, $catid, $ihome, $alanguage, $acomm, $topic_icon, $writes);
/*****[END]********************************************
 [ Mod:    Display Topic Icon                  v1.0.0 ]
 [ Mod:    Display Writes                      v1.0.0 ]
 ******************************************************/
    break;

    case "submissions":
    submissions();
    break;

    case "NENewsConfig":
        $pagetitle = ": "._NE_NEWSCONFIG;
        include(NUKE_BASE_DIR.'header.php');
        OpenTable();
	    echo "<div align=\"center\">\n<a href=\"$admin_file.php?op=NENewsConfig\">" . _NEWSCONFIG_ADMIN_HEADER . "</a></div>\n";
        echo "<br /><br />";
	    echo "<div align=\"center\">\n[ <a href=\"$admin_file.php\">" . _NEWS_RETURNMAIN . "</a> ]</div>\n";
	    CloseTable();
	    echo "<br />";
        $ne_config = ne_get_configs();
        title(_NE_NEWSCONFIG);
        OpenTable();
        echo "<form action='".$admin_file.".php?op=NENewsConfigSave' method='post'>\n";
        echo "<center>\n<table border='0' cellpadding='2' cellspacing='2'>\n";

        echo "<tr>\n<td align='right'><strong>"._NE_DISPLAYTYPE.":</strong></td>\n<td><select name='xcolumns'>";
        if ($ne_config["columns"] == 0) { $ck1 = " selected"; $ck2 = ""; } else { $ck1 = ""; $ck2 = " selected"; }
        echo "<option value='0'$ck1>"._NE_SINGLE."</option>\n<option value='1'$ck2>"._NE_DUAL."</option>\n</select></td>\n</tr>\n";

        echo "<tr>\n<td align='right'><strong>"._NE_READLINK.":</strong></td>\n<td><select name='xreadmore'>";
        if ($ne_config["readmore"] == 0) { $ck1 = " selected"; $ck2 = ""; } else { $ck1 = ""; $ck2 = " selected"; }
        echo "<option value='0'$ck1>"._NE_PAGE."</option>\n<option value='1'$ck2>"._NE_POPUP."</option>\n</select></td>\n</tr>\n";

        echo "<tr>\n<td align='right'><strong>"._NE_TEXTTYPE.":</strong></td>\n<td><select name='xtexttype'>";
        if ($ne_config["texttype"] == 0) { $ck1 = " selected"; $ck2 = ""; } else { $ck1 = ""; $ck2 = " selected"; }
        echo "<option value='0'$ck1>"._NE_COMPLETE."</option>\n<option value='1'$ck2>"._NE_TRUNCATE."</option>\n</select></td>\n</tr>\n";

        echo "<tr>\n<td align='right' valign='top'><strong>"._NE_NOTIFYAUTH.":</strong></td>\n<td><select name='xnotifyauth'>";
        if ($ne_config["notifyauth"] == 0) { $ck1 = " selected"; $ck2 = ""; } else { $ck1 = ""; $ck2 = " selected"; }
        echo "<option value='0'$ck1>"._NE_NO."</option>\n<option value='1'$ck2>"._NE_YES."</option>\n</select><br />\n("._NE_NOTIFYAUTHNOTE.")</td>\n</tr>\n";

        echo "<tr>\n<td align='right'><strong>"._NE_HOMETOPIC.":</strong></td>\n<td><select name='xhometopic'>";
        echo "<option value='0'";
        if ($ne_config["hometopic"] == 0) { echo " selected"; }
        echo ">"._NE_ALLTOPICS."</option>\n";
        $result = $db->sql_query("SELECT topicid, topictext FROM ".$prefix."_topics ORDER BY topictext");
        while(list($topicid, $topicname) = $db->sql_fetchrow($result)) {
            echo "<option value='$topicid'";
            if ($ne_config["hometopic"] == $topicid) { echo " selected"; }
            echo">$topicname</option>\n";
        }
        echo "</select></td>\n</tr>\n";

        echo "<tr>\n<td align='right' valign='top'><strong>"._NE_HOMENUMBER.":</strong></td>\n<td><select name='xhomenumber'>\n";
        echo "<option value='0'";
        if ($ne_config["homenumber"] == 0) { echo " selected"; }
        echo ">"._NE_NUKEDEFAULT."</option>\n";
        $i = 1;
        while ($i <= 10) {
            $k = $i * 5;
            echo "<option value='$k'";
            if ($ne_config["homenumber"] == $k) { echo " selected"; }
            echo">$k "._NE_ARTICLES."</option>\n";
            $i++;
        }
        echo "</select><br />\n("._NE_HOMENUMNOTE.")</td>\n</tr>\n";

        echo "<tr><td align='center' colspan='2'><input type='submit' value='"._NE_SAVECHANGES."'></td></tr>";
        echo "</table>\n</center>\n</form>\n";
        CloseTable();
        include(NUKE_BASE_DIR.'footer.php');
    break;

    case "NENewsConfigSave":
        ne_save_config('columns', $xcolumns);
        ne_save_config('readmore', $xreadmore);
        ne_save_config('texttype', $xtexttype);
        ne_save_config('notifyauth', $xnotifyauth);
        ne_save_config('homenumber', $xhomenumber);
        ne_save_config('hometopic', $xhometopic);
/*****[BEGIN]******************************************
 [ Base:    Caching System                     v3.0.0 ]
 ******************************************************/
        global $cache;
        $cache->delete('news', 'config');
/*****[END]********************************************
 [ Base:    Caching System                     v3.0.0 ]
 ******************************************************/
        redirect($admin_file.".php?op=NENewsConfig");
    break;

}

} else {
    DisplayError("<strong>"._ERROR."</strong><br /><br />You do not have administration permission for module \"$module_name\"");
}

?>