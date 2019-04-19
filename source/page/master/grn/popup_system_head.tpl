{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/treeview.css"}
{grn_load_css file="grn/html/msgbox.css"}
{grn_load_css file="grn/html/image.css"}
{grn_load_css file="grn/html/image_grn.css"}
{if $popup_facility_list}
{grn_load_css file="grn/html/schedule.css"}
{/if}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
{grn_load_css file="grn/html/Designsimple-white.css"}
{if $browser.type == "android"}
    {grn_load_css file="grn/html/android.css"}
{/if}
{if $browser.type === "msie" && $browser.ver_major <= 11}
    {grn_load_css file="grn/html/ie11.css"}
{/if}
{grn_load_javascript file="grn/common/base.js"}
{include file="grn/browser.tpl"}
{grn_load_javascript file="grn/html/std.js"}
{grn_load_prototype_js}
{grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
{grn_load_javascript file="fw/yui/build/event/event-min.js"}
{grn_load_javascript file="fw/yui/build/dom/dom-min.js"}
{grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
{grn_load_javascript file="fw/yui/build/treeview/treeview-min.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{include file="grn/url_builder.tpl"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{include file="grn/component/ajax.tpl"}
{grn_load_javascript_resource}
<script language="JavaScript" type="text/javascript">
    jQuery.noConflict();
</script>
</head>
<body class="bg_admin20">
<div id="body">
