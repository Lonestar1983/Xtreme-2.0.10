<?php

function evo_img_tag_to_resize( $text ) {
    global $img_resize;
    if ( ! $img_resize ) {
		return $text;
	}

    if ( empty( $text ) ) {
		return $text;
	}

    if ( preg_match( '/<NO RESIZE>/', $text ) ) {
        $text = str_replace( '<NO RESIZE>', '', $text );
        return $text;
    }

    $text = preg_replace( '/<\s*?img/',"<div class=\"reimg-loading\"></div><img class=\"reimg\" onload=\"reimg(this);\" onerror=\"reimg(this);\" ", $text );
    return $text;
}