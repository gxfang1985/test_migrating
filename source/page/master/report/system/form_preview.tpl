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
    {grn_load_css file="grn/html/treeview.css"}
    {grn_load_css file="grn/html/std.css"}
    {grn_load_css file="grn/html/workflow.css"}
    {grn_load_css file="grn/html/print.css" media="print"}
    {grn_load_css file="grn/html/image_grn.css"}
    {grn_load_application_specific_header}
    {grn_load_css file="grn/html/Design-admin.css"}
 <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
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
    {grn_load_javascript file="grn/html/msgbox.js"}
    {grn_load_css file="grn/html/msgbox.css"}
    {grn_load_javascript file="grn/html/component/button.js"}

    {grn_load_javascript file="grn/html/com_header.js"}

    {grn_load_javascript file="grn/html/component/autofit.js"}
    {include file="grn/url_builder.tpl"}
    {grn_load_javascript file="grn/html/component/i18n.js"}
    {grn_load_javascript file="grn/html/component/string.js"}
    {grn_load_javascript_resource}
    {include file="grn/component/ajax.tpl"}
    {include file="grn/_common_js.tpl"}
    {if $browser.type == "mobilesafari" || $browser.type == "android"}
     <link href="{$app_path}/grn/html/specific-{$browser.type}.css?{$build_date}" rel="stylesheet" type="text/css">
    {/if}
 <script type="text/javascript" language="javascript">
     {grn_common_data_for_javascript}
     var command_show_hide_applicationMenu_url ="{grn_pageurl page='grn/ajax_state_application_menu'}";
     var ajax_my_space_list_url = "{grn_pageurl page='grn/ajax_my_space_list'}";
     var ajax_app_menu_url = "{grn_pageurl page='grn/system/ajax_app_menu'}";
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
</head>
<body class="bg_admin20" {if $onunload}onUnload="{$onunload}"{/if} {if $onload}onload="{$onload}"{/if}>
<div id="container-wrap">
 <div id="content">
  <div id="body">
   <div class="mainarea">
       {include file="grn/popup_header.tpl"}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/report.js"}
<form name="{$form_name}" method="get" onsubmit='return false;'>

{* Start Navigation *}
<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-3' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-5' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-7' replace='true'}</td>
 </tr>
</table>
</center>
{* End Navigation *}

<p class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-9' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-10' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$form.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-11' replace='true'}
<p></p>

<table class="std_form">
{include file='report/_item_section.tpl' item_list=$item_list category_id=$category_id form_id=$form_id login=$login form=$form plugin=$plugin send_form=true creator_is_login=true}
</form>
 <tr>
  <td></td>
  <td>
<form>
<input class="button_bold margin" type="button" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-19' replace='true'} &gt;&gt;">
<input class="margin" type="button" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-20' replace='true'}">
<input class="margin" type="button" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-21' replace='true'}">
</form>
  </td>
 </tr>
</table>
   </div>

</div><!--body_end-->
