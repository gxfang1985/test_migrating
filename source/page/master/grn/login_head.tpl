{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{cb_msg module='grn.grn' key='GRN_GRN-1264' replace='true'}</title>
{grn_load_css file="grn/html/std.css" media="all"}
{grn_load_css file="grn/html/mobile_login_grn.css" media="screen and (max-width: 480px)"}

<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
{grn_load_css file="grn/html/Design-mm.css"}
<link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
{grn_load_javascript file="grn/html/std.js"}
{grn_load_prototype_js}
{grn_load_javascript file="grn/common/base.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
{if $browser.type == "mobilesafari" || $browser.type == "android"}
    <link href="{$app_path}/grn/html/specific-{$browser.type}.css?{$build_date}" rel="stylesheet" type="text/css">
{/if}
<script language="JavaScript" type="text/javascript"><!--
function init()
{literal}{{/literal}
{if $login_cookie}
    document.{$page_info.last}._password.focus();
{else}
    document.{$page_info.last}._account.focus();
{/if}
    window.document.forms.{$page_info.last}.action = window.location.pathname + window.location.search + window.location.hash;
{literal}}{/literal}
//--> </script>
</head>
<body onLoad="init()" class="login_base">
<div id="body">
