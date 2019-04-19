{assign var="is_print_page" value=true}
{capture name="print_page_name"}{grn_appname app_id='report'} {cb_msg module='grn.report' key='GRN_RPRT-266' replace='true'}{/capture}
{assign var="page_title" value=$smarty.capture.print_page_name}
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

<body {if isset($onunload)}onUnload="{$onunload}"{/if} {if isset($onBeforeUnload)}onBeforeUnload="{$onBeforeUnload}"{/if} {if isset($onload)}onload="{$onload}"{/if} class="print_body_grn">
{if !$is_print_page}
    {include file="grn/_head_common.tpl"}
{/if}
<div id="body">
  <table class="layout" id="headerimage" width="100%"><tr><td class="seasonHeader"><br></td></table>
  <div id="div_print_setting">
    <table class="table_plain_grn print_action_base_grn">
      <tbody>
        <tr>
          <td nowrap="">
            <table border="0" cellspacing="0" cellpadding="4" width="100%">
              <tbody>
                <tr>
                  <td nowrap="">
                    <font size="+1">{cb_msg module="grn.report" key="PRINT_SETTING" replace="true"}</font>
                    <font size="-1">{cb_msg module="grn.report" key="THIS_AREA_WILL_NOT_BE_PRINTED" replace="true"}</font>
                  </td>
                </tr>
              </tbody>
            </table>
              <br />
            <table class="formTable">
              <colgroup>
                <col nowrap>
                <col nowrap>
              </colgroup>
              <tbody>
                <tr>
                  <td align="right">{cb_msg module="grn.report" key="FONT_SIZE" replace="true"}</td>
                  <td>
                    <select onchange="setFontSize(this.value)" id="FontSize">
                      <option value="8pt">8pt</option>
                      <option value="9pt">9pt</option>
                      <option value="10pt">10pt</option>
                      <option value="11pt">11pt</option>
                      <option value="12pt" selected="">12pt</option>
                      <option value="13pt">13pt</option>
                      <option value="14pt">14pt</option>
                      <option value="15pt">15pt</option>
                      <option value="16pt">16pt</option>
                      <option value="17pt">17pt</option>
                      <option value="18pt">18pt</option>
                      <option value="19pt">19pt</option>
                      <option value="20pt">20pt</option>
                    </select>
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td align="right">{cb_msg module="grn.report" key="LOCALE_SETTING" replace="true"}</td>
                  <td>
                    <select onchange="setLocale(this.value)" id="Locale">
                      <option value="user">{cb_msg module="grn.report" key="USER_SETTING" replace="true"}</option>
                      <option value="system">{cb_msg module="grn.report" key="SYSTEM_SETTING" replace="true"}</option>
                    </select>
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td align="right"></td>
                  <td>
                    {strip}
                      <div class="mTop10 mBottom5">
                        {capture name='grn_report_PRINT'}{cb_msg module="grn.report" key="PRINT" replace="true"}{/capture}
                        {capture name='grn_report_BACK'}{cb_msg module="grn.report" key="BACK" replace="true"}{/capture}
                        {grn_button id="report_button_print" ui="main" spacing="normal" caption=$smarty.capture.grn_report_PRINT onclick="doPrint()"}
                        {grn_button id="report_button_back" action="cancel" page=$view_page page_param_cid=$cid page_param_fid=$fid page_param_rid=$rid caption=$smarty.capture.grn_report_BACK}
                      </div>
                    {/strip}
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>      
  </div>
  <div id="view">
<p>
<div class="marginHalf">
  <span class="report_title"><font size="+1" style="font-size:100%;"><b>{$report.form_name|escape}</b></font>{grn_msg_switch module='grn.report' key='GRN_RPRT-267'}{$report.name|escape}{grn_msg_switch module='grn.report' key='GRN_RPRT-268' }</span>
</div>
</p>
<div class="marginHalf">
  <span ><font style="font-size:100%;">&nbsp;<b>{grn_msg_switch module='grn.report' key='GRN_RPRT-82'}</b></font>&nbsp;&nbsp;{grn_user_name uid=$report.creator name=$report.creator_name noimage=true nolink=true}</span>
</div>
<table class="view_table_for_print" style="border-collapse:collapse;" width="100%">
{* Start Item Section *}
  {if $event}
    <tr valign="top">
      <th class="border" align="left">{grn_msg_switch module='grn.report' key='GRN_RPRT-270' }</th>
      <td class="border" nowrap>
          {$event->getTitle()}
      </td>
    </tr>
  {/if}
  {if $report.enable_member}
    <tr valign="top">
      <th class="border" rowspan="1" align="left">{grn_msg_switch module='grn.report' key='GRN_RPRT-271' }</th>
      <td class="border">
        {foreach from=$members_info item=member name='members'}
          <span>{grn_user_name uid=$member._id users_info=$members_info noimage=true name=$member.name nolink=true}{if $smarty.foreach.members.total >= 2 && !($smarty.foreach.members.last)},{/if}</span>
        {/foreach}
      </td>
    </tr>
  {/if}
  {if $report.enable_partner}
    <tr valign="top">
      <th id="report_partner_header" class="border" rowspan="1" align="left">{grn_msg_switch module='grn.report' key='outside_parties' }</th>
      <td id="report_partner_list" class="border">
        {foreach from=$partners item=partner name='partners'}
          <span><span>{$partner->getSubject()|escape}{if strlen($partner->getCompanyName()) > 0}({$partner->getCompanyName()|escape}){/if}</span>{if $smarty.foreach.partners.total >= 2 && !($smarty.foreach.partners.last)},{/if}</span>
        {/foreach}
      </td>
    </tr>
  {/if}
  {assign var=view_mode value='print'}
  {foreach from=$item_data_list item=item_data_line}
    {if $item_data_line.type == 2}
</table>
<table width="100%">
  <tr valign="top">
    <td>
      <div class="view_table_for_print_emptyline"></div>
    </td>
  </tr>
</table>
<table class="view_table_for_print" style="border-collapse:collapse;" width="100%">
    {elseif $item_data_line.type != 1}
  <tr valign="top">
    <th class="border" rowspan="1" align="left">
      {$item_data_line.display_name|escape}
    </th>
    {assign var='item_class' value='border'}
    {grn_report_include_item report_id=$rid iid=$item_data_line.iid item=$item_data_line display="view"}
  </tr>
    {/if}
  {/foreach}
{* End Item Section *}
</table>
</div>
{include file="grn/print_footer.tpl"}
