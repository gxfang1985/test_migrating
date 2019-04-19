{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
<script language="JavaScript" type="text/javascript">
jQuery.noConflict();
</script>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/msgbox.css"}
{grn_load_css file="grn/html/treeview.css"}
{grn_load_css file="grn/html/print.css" media="print"}
{grn_load_css file="grn/html/image_grn.css"}
{grn_load_css file="grn/html/mail.css"}
{grn_load_application_specific_header}

<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">

{grn_design assign="design"}
{if ! $design}
{grn_load_css file="grn/html/Design-mm.css"}
{else}
<link href="{$app_path}/grn/html/{$design}.css?{$build_date}" rel="stylesheet" type="text/css">
{/if}
{if $browser.type == "mobilesafari" || $browser.type == "android"}
    <link href="{$app_path}/grn/html/specific-{$browser.type}.css?{$build_date}" rel="stylesheet" type="text/css">
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
{grn_load_javascript file="grn/html/msgbox.js"}
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
{grn_load_javascript file="grn/html/com_header.js"}
{grn_load_javascript file="grn/html/component/button.js"}
{include file="grn/url_builder.tpl"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file="grn/component/ajax.tpl"}
{include file="grn/_common_js.tpl"}

<script type="text/javascript" language="javascript">
    {grn_common_data_for_javascript}

    var command_show_hide_applicationMenu_url ="{grn_pageurl page='grn/ajax_state_application_menu'}";
    var ajax_my_space_list_url = "{grn_pageurl page='grn/ajax_my_space_list'}";
    var ajax_app_menu_url = "{grn_pageurl page='grn/ajax_app_menu'}";
    var link_spiner = '{grn_image image="spinner.gif"}';
    
    var get_data_notification_url ="{grn_pageurl page='notification/ajax/page_header'}";
    var get_number_notification_url ="{grn_pageurl page='grn/ajax_get_number_notification'}";
    var get_favour_notify_list_url ="{grn_pageurl page='grn/ajax_get_favour_notify_list'}";

    grn.html.com_header.setNextUpdateNotification({grn_get_update_notification_time_header});

    jQuery(function () {ldelim}
        document.getElementById("container-wrap").focus();
    {rdelim});
</script>
{include file="grn/_head_customization.tpl"}
<script type="text/javascript" language="javascript">
    grn.html.com_header.addEventListenerForResizeWindow();
</script>
</head>

<body class="bg_personal20" {if $onunload}onUnload="{$onunload}"{/if} {if $onload}onload="{$onload}"{/if}>
{include file="grn/_head_common.tpl"}
<div id="body">
<table class="layout" id="headerimage" width="100%"><tr><td class="seasonHeader" height="64"><br></td></table>
