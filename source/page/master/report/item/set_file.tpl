{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-2' replace='true'}</div>
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
{literal}
<script language="Javascript" type="text/javascript">
<!--
function changeInline(form)
{
  if (!form.inline.checked)
  {
      form.thumbnail.checked = false;
  }
  return;
}
function changeThumbnail(form)
{
  if (form.thumbnail.checked)
  {
      form.inline.checked = true;
  }
  return;
}
//--->
</script>
{/literal}

{assign var="data_type_class" value="data_type_change"}
{include file="report/item/_set_type.tpl"}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_file'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_file'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_3'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-3' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_3}</th>
  <td>
      {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_4'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-4' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_4 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_5'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-5' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_5 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_6'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-6' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_6}</th>
  <td>
      {grn_select_numbers select_name='max_files' size='1' options=$max_files_options selected=$settings.max_files}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_7'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-7' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_7}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_8'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-8' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_8 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_9'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-9' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_9}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_10'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-10' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_10 checked=$item.required}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_11'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-11' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_11}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_12'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-12' replace='true'}{/capture}{grn_checkbox name='inline' id='inline' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_12 checked=$settings.inline onclick='changeInline(this.form);'}<br>
      &nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-13' replace='true'}{capture name='grn_report_item_GRN_RPRT_ITEM_14'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-14' replace='true'}{/capture}{grn_checkbox name='thumbnail' id='thumbnail' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_14 checked=$settings.thumbnail onclick='changeThumbnail(this.form);'}
      {capture name='grn_report_item_GRN_RPRT_ITEM_15'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-15' replace='true'}{/capture}{validate form=$form_name field="thumbnail_xsize" criteria="grn_report_isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_15 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_16'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-16' replace='true'}{/capture}{validate form=$form_name field="thumbnail_ysize" criteria="grn_report_isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_16 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_17'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-17' replace='true'}{/capture}{validate form=$form_name field="thumbnail_xsize" criteria="grn_report_isRangeMax" max='999' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_17 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_18'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-18' replace='true'}{/capture}{validate form=$form_name field="thumbnail_ysize" criteria="grn_report_isRangeMax" max='999' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_18 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_19'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-19' replace='true'}{/capture}{validate form=$form_name field="thumbnail_xsize" criteria="grn_report_isRangeMin" min='0' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_19 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_20'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-20' replace='true'}{/capture}{validate form=$form_name field="thumbnail_ysize" criteria="grn_report_isRangeMin" min='0' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_20 append="validation_errors" empty=true}
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-21' replace='true'}{grn_text name='thumbnail_xsize' size='3' maxlength='3' disable_return_key=true value=$settings.thumbnail_xsize}px/
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-22' replace='true'}{grn_text name='thumbnail_ysize' size='3' maxlength='3' disable_return_key=true value=$settings.thumbnail_ysize}px
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_23'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-23' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_23}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-24' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-25' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-26' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-27' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-28' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-29' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-30' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-31' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-32' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-33' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-34' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-35' replace='true'}">
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

