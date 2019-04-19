{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
<script language="JavaScript" type="text/javascript">
jQuery.noConflict();
</script>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/msgbox.css"}
{grn_load_css file="grn/html/image_grn.css"}
{grn_load_css file="grn/html/mail.css"}
{grn_load_css file="grn/html/mail_3pane.css"}

<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">

{grn_design assign="design"}
{if ! $design}
{grn_load_css file="grn/html/Design-mm.css"}
{else}
<link href="{$app_path}/grn/html/{$design}.css?{$build_date}" rel="stylesheet" type="text/css">
{/if}
{if $browser.type == "android"}
  {grn_load_css file="grn/html/android.css"}
{/if}
{if $browser.type === "msie" && $browser.ver_major <= 11}
    {grn_load_css file="grn/html/ie11.css"}
{/if}
<link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
{grn_load_javascript file="grn/common/base.js"}
{include file="grn/browser.tpl"}
{grn_load_javascript file="grn/html/std.js"}
{grn_load_prototype_js}
{grn_load_javascript file="grn/html/textarea.js"}
{grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
{grn_load_javascript file="fw/yui/build/event/event-min.js"}
{grn_load_javascript file="fw/yui/build/dom/dom-min.js"}
{grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
{grn_load_javascript file="fw/yui/build/treeview/treeview-min.js"}
{grn_load_javascript file="fw/yui/build/json/json-min.js"}
{grn_load_javascript file="grn/html/fag_tree_26.js"}
{grn_load_javascript file="grn/html/tree.js"}
{grn_load_javascript file="grn/html/tree-facilitygroup.js"}
{grn_load_javascript file="grn/html/tree-organization-item.js"}
{grn_load_javascript file="grn/html/text_multilanguage.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
{grn_load_javascript file="grn/html/msgbox.js"}
{grn_load_javascript file="grn/html/component/button.js"}
{include file="grn/url_builder.tpl"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file="grn/component/ajax.tpl"}
</head>
<body style="overflow: auto;">
  <div id="content">
    <div id="body" class="subwindow_grn">
