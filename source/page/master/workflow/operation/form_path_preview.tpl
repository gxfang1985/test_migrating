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
    {grn_load_css file="grn/html/treeview.css"}
    {grn_load_css file="grn/html/print.css" media="print"}
    {grn_load_css file="grn/html/image_grn.css"}
    {grn_load_css file="grn/html/mail.css"}
    {grn_load_css file="grn/html/schedule.css"}
    {grn_load_css file="grn/html/workflow.css"}
    {grn_load_application_specific_header}
    {grn_load_search_css}

 <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">

    {if !$is_print_page}
        {if $kintone_dialog_mode}
            {grn_load_css file="grn/html/Design-mm.css"}
            {grn_load_css file="grn/html/Design_relation_style.css"}
        {else}
            {grn_design assign="design"}
            {if ! $design}
                {grn_load_css file="grn/html/Design-mm.css"}
            {else}
             <link href="{$app_path}/grn/html/{$design}.css?{$build_date}" rel="stylesheet" type="text/css">
            {/if}
        {/if}
    {else}
    {literal}
     <style>#headerimage { display:none; }</style>
    {/literal}
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
    {grn_load_javascript file="grn/html/com_header.js"}
    {grn_load_javascript file="grn/html/component/button.js"}

    {include file="grn/url_builder.tpl"}

    {grn_load_javascript file="grn/html/component/i18n.js"}
    {grn_load_javascript_resource}
    {include file="grn/component/ajax.tpl"}
    {include file="grn/_common_js.tpl"}

    {if $is_print_page}
        {grn_load_javascript file="grn/html/print.js"}
    {/if}

    {if ! $kintone_dialog_mode}
     <script type="text/javascript" language="javascript">
         var command_show_hide_applicationMenu_url ="{grn_pageurl page='grn/ajax_state_application_menu'}";
         var ajax_my_space_list_url = "{grn_pageurl page='grn/ajax_my_space_list'}";
         var ajax_app_menu_url = "{grn_pageurl page='grn/ajax_app_menu'}";
         var link_spiner = '{grn_image image="spinner.gif"}';

         var get_data_notification_url ="{grn_pageurl page='notification/ajax/page_header'}";
         var get_number_notification_url ="{grn_pageurl page='grn/ajax_get_number_notification'}";
         var get_favour_notify_list_url ="{grn_pageurl page='grn/ajax_get_favour_notify_list'}";

         var get_auto_data_url ="{grn_pageurl page='grn/get_data_auto_complete'}";

         grn.html.com_header.setNextUpdateNotification({grn_get_update_notification_time_header});

         {literal}
         jQuery(function () {
             var container_wrap_element = document.getElementById("container-wrap");
             if (container_wrap_element) {
                 container_wrap_element.focus();
             }
         });
         {/literal}

         grn.component.button.util.addEventListenerForAutoDisableButton();
     </script>
    {/if}
 <script type="text/javascript" language="javascript">
     {grn_common_data_for_javascript}
 </script>
    {include file="grn/_head_customization.tpl"}
 <script type="text/javascript" language="javascript">
     grn.html.com_header.addEventListenerForResizeWindow();
 </script>
</head>

<body {if isset($onunload)}onUnload="{$onunload}"{/if} {if isset($onBeforeUnload)}onBeforeUnload="{$onBeforeUnload}"{/if} {if isset($onload)}onload="{$onload}"{/if}>
<div id="container-wrap">
 <div id="content">
  <div id="body">
   <div class="mainarea">
       {include file="grn/popup_header.tpl"}
{assign var='form_name' value=$smarty.template|basename}

<!-- 見通しよくナビゲーション -->

<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow.system' key='w_select_app_form_y' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow.system' key='w_enter_contents_y' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow.system' key='w_route_setting_y' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow.system' key='w_confirm_contents_y' replace='true'}</td>
 </tr>
</table>
</center>

<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow.system' key='w_set_app_route_2_y' replace='true'}</p>
<p></p>
{cb_msg module='grn.workflow.system' key='w_quote_left' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.col_icon_type icon_id=$form.col_icon_id icon_url=$form.col_icon_url}{$form.col_name|escape}{cb_msg module='grn.workflow.system' key='key_105' replace='true'}</span>{cb_msg module='grn.workflow.system' key='w_quote_right' replace='true'}
<div class="border-partition-common-grn"></div>

{if $path}
{if $path.col_icon}
{capture name='grn_workflow_whats_this'}{cb_msg module='grn.workflow' key='whats_this' replace='true'}{/capture}
<span class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_y' replace='true'}</span>&nbsp;<span class="adjust_link"><small>{grn_link image='popup14.gif' page='workflow/popup_path_explain' caption=$smarty.capture.grn_workflow_whats_this target='_blank' cid=$cid fid=$fid}</small></span>

{else}
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_y' replace='true'}</div>
<div class="path_explanation">
{if $path.col_description && $path.col_richeditor}
<div class="adjust_link">{$path.col_description|grn_noescape}</div>
{else}
<small>
{grn_format body=$path.col_description}
</small>
{/if}
</div>
{/if}
{else}
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_y' replace='true'}</div>
{/if}
{grn_workflow_member_add form_name=$form_name sUID='sUID' CGID='CGID' CID='candidate_CID' path_step_list=$path_steps path_step_count=$path_step_count include_org=$show_organize is_preview=true access_plugin=$plugin}

<input class="margin" type="button" value="&lt;&lt; {cb_msg module='grn.workflow.system' key='w_back_to_prev_screen_y' replace='true'}">
<input class="button_bold margin" type="button" value="{cb_msg module='grn.workflow.system' key='w_do_confirm_contents_y' replace='true'} &gt;&gt;">
<input class="margin" type="button" value="{cb_msg module='grn.workflow.system' key='w_cancel' replace='true'}">
</div>

</div><!--body_end-->
