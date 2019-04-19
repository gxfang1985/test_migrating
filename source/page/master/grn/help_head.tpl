{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/msgbox.css"}
{grn_load_css file="grn/html/image.css"}
{grn_load_css file="grn/html/help.css"}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
{grn_load_css file="grn/html/Designsimple-white.css"}
{if $browser.type == "android"}
    {grn_load_css file="grn/html/android.css"}
{/if}
{if $browser.type === "msie" && $browser.ver_major <= 11}
    {grn_load_css file="grn/html/ie11.css"}
{/if}
<link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
{grn_load_javascript file="grn/html/std.js"}
{grn_load_prototype_js}
{grn_load_javascript file="grn/common/base.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
</head>
<body>
<div id="body">
