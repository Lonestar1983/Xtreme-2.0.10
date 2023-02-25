<?php

get_header();

global $adminmail;

$to        = 'crazycoder@live.co.uk';
$subject   = 'Big Bang Theory';
$message   = 'This is the email message';
$headers   = array();
$headers[] = 'From: ' . $adminmail;
$headers[] = 'Reply-To: ' . $adminmail;
$headers[] = 'Content-Type: text/html; charset=utf-8';
$headers[] = 'X-Mailer: PHP/' . phpversion();

$attachments = array();
// if ( $attachment_mod['pm']->num_attachments > 0 ) {
// 	$attachment_setting = get_config();
// 	foreach ( $attachment_mod['pm']->attachment_list as $filename ) {
// 		$attachments[] = ABSPATH . trailingslashit( $attachment_setting['upload_dir'] ) . $filename;
// 	}
// }

evo_phpmailer( $to, $subject, $message, $headers, $attachments );

get_footer(); ?>
