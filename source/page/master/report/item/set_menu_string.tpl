{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-71' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

{if $display == 'add-system' || $display == 'modify-system'}
  {assign var='page_prefix' value='report/system/'}
{elseif $display == 'add-operation' || $display == 'modify-operation'}
  {assign var='page_prefix' value='report/operation/'}
{else}
  {assign var='page_prefix' value='report/'}
{/if}

{assign var="data_type_class" value="data_type_change"}
{include file="report/item/_set_type.tpl"}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_menu_string'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_menu_string'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_72'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-72' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_72}</th>
  <td>
      {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_73'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-73' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_73 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_74'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-74' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_74 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_75'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-75' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_75}<span class='attention' id='account' style="display:none">*</span></th>
{*
  <td>
     {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-76' replace='true'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-77' replace='true'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-78' replace='true'}<br>
      {grn_textarea name="menu_items" rows="5" value=$settings.menu_items}
  </td>
*}
  <td>
      {if $settings.menu_item_type == 0}{assign var='menu_item_type_0' value='1'}{else}{assign var='menu_item_type_1' value='1'}{/if}
      {capture name='grn_report_item_GRN_RPRT_ITEM_79'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-79' replace='true'}{/capture}{grn_radio name='menu_item_type' id='menu_item_type_0' value='0' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_79 checked=$menu_item_type_0 onclick="on_click_menu_item(this.form);"}<br>
      <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>{grn_textarea name="menu_items" rows="5" value=$settings.menu_items}<br>
      <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>{grn_text name='initial_value' size='50' disable_return_key=true value=$settings.initial_value} {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-82' replace='true'}<br>
      <div class="br">&nbsp;</div>
      <div>
      {capture name='grn_report_item_GRN_RPRT_ITEM_83'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-83' replace='true'}{/capture}{grn_radio name='menu_item_type' id='menu_item_type_1' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_83 checked=$menu_item_type_1 onclick="on_click_menu_item(this.form);"}
      </div>
      <span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-84' replace='true'}</span>
  </td>
 </tr>
{* 
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_85'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-85' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_85}</th>
  <td>
      {grn_text name='initial_value' size='50' disable_return_key=true value=$settings.initial_value}
  </td>
 </tr>
*}
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_86'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-86' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_86}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_87'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-87' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_87 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_88'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-88' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_88}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_89'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-89' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_89 checked=$item.required onclick="on_click_required(this.form);"}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_90'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-90' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_90}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-91' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-92' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-93' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-94' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-95' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-96' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-97' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-98' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-99' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-100' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-101' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-102' replace='true'}">
        {grn_button_cancel page='report/formlayout_view' rid=$report_id iid=$item.iid}
      {/if}
  </td>
 </tr>
</table>

{if $display != 'add' && $display != 'modify'}
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="fid" value="{$form_id}">
{else}
<input type="hidden" name="rid" value="{$report_id}">
{/if}
<input type="hidden" name="iid" value="{$item.iid}">
<input type="hidden" name="type" value="{$item.type}">
<input type="hidden" name="display" value="{$display}">

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function on_click_required(form)
{
  var status = form.elements['required'].checked;
  if (status)
  {
    document.getElementById('account').style.display = "";
  }
  else
  {
    document.getElementById('account').style.display = "none";
  }
}

function on_click_menu_item(form)
{
  var status = form.elements['menu_item_type_0'].checked;
  if (status)
  {
    document.getElementsByName('menu_items').item(0).disabled = false;
    document.getElementsByName('initial_value').item(0).disabled = false;
  }
  else
  {
    document.getElementsByName('menu_items').item(0).disabled = true;
    document.getElementsByName('initial_value').item(0).disabled = true;
  }
}

{/literal}
form = document.forms["{$form_name}"];
on_click_required(form);
on_click_menu_item(form);
{literal}
//-->
</script>
{/literal}

</form>

