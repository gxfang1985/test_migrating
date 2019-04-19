{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{cb_msg module='grn.grn' key='GRN_GRN-1292' replace='true'}</title>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/Design-admin.css"}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
<link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
{grn_load_javascript file="grn/html/std.js"}
{if $browser.type == "mobilesafari" || $browser.type == "android"}
    <link href="{$app_path}/grn/html/specific-{$browser.type}.css?{$build_date}" rel="stylesheet" type="text/css">
{/if}
</head>
<body class="bg_admin20">
<div id="body">
