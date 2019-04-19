{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-103' replace='true'}</div>
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
{include file='report/_initial_minute.tpl'}

{assign var="data_type_class" value="data_type_change"}
{include file="report/item/_set_type.tpl"}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_time'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_time'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_104'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-104' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_104}</th>
  <td>
      {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_105'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-105' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_105 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_106'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-106' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_106 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.report.item' key='time_unit' replace='true'}</th>
  <td>
       <select name="unit" onchange="GRN_ReportInitialMinute.changeInterval('initial_minute', this[this.selectedIndex].value, true);">
        <option value="1"{if $settings.unit == 1} selected{/if}>{cb_msg module='grn.report.item' key='1_minute_unit' replace='true'}</option>
        <option value="5"{if $settings.unit == 5} selected{/if}>{cb_msg module='grn.report.item' key='5_minute_unit' replace='true'}</option>
        <option value="10"{if $settings.unit == 10} selected{/if}>{cb_msg module='grn.report.item' key='10_minute_unit' replace='true'}</option>
        <option value="15"{if $settings.unit == 15} selected{/if}>{cb_msg module='grn.report.item' key='15_minute_unit' replace='true'}</option>
        <option value="30"{if $settings.unit == 30} selected{/if}>{cb_msg module='grn.report.item' key='30_minute_unit' replace='true'}</option>
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_107'}{cb_msg module='grn.report.item' key='initial_time' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_107}</th>
  <td>
     {if $settings.initial_type == 0}
      {assign var='initial_type_0' value='1'}
     {elseif $settings.initial_type == 1}
      {assign var='initial_type_1' value='1'}
     {else}
      {assign var='initial_type_2' value='1'}
     {/if}
     <div>{capture name='grn_report_item_GRN_RPRT_ITEM_108'}{cb_msg module='grn.report.item' key='default_current_time' replace='true'}{/capture}{grn_radio name='initial_type' id='1' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_108 checked=$initial_type_1}</div>
     <div>{capture name='grn_report_item_GRN_RPRT_ITEM_109'}{cb_msg module='grn.report.item' key='default_specified_time' replace='true'}{/capture}{grn_radio name='initial_type' id='2' value='2' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_109 checked=$initial_type_2}{grn_select_time prefix='initial_' time=$initial_time form_name=$form_name minute_interval=$settings.unit}</div>
     <div>{capture name='grn_report_item_GRN_RPRT_ITEM_110'}{cb_msg module='grn.report.item' key='leave_it_blank' replace='true'}{/capture}{grn_radio name='initial_type' id='0' value='0' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_110 checked=$initial_type_0}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_111'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-111' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_111}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_112'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-112' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_112 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_113'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-113' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_113}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_114'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-114' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_114 checked=$item.required}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_115'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-115' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_115}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-116' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-117' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-118' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-119' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-120' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-121' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-122' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-123' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-124' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-125' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-126' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-127' replace='true'}">
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
</form>

