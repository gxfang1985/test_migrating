{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-440' replace='true'}</div>
<p>
{assign var='half_width_number' value='1'}
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
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_string_multiple'}" enctype="multipart/form-data">
 {else}
 <form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_string_multiple'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_441'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-441' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_441}</th>
  <td>
      {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_442'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-442' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_442 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_443'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-443' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_443 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_444'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-444' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_444 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_445'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-445' replace='true'}{/capture}{validate form=$form_name field="col_size" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_445 append="validation_errors"}
      {capture name='grn_report_item_GRN_RPRT_ITEM_446'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-446' replace='true'}{/capture}{validate form=$form_name field="col_size" criteria="isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_446 append="validation_errors" empty=true}
      {grn_text name='col_size' size='5' value=$settings.col_size}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-447' replace='true'}<font color="#0000ff">#</font>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-448' replace='true'}
      {capture name='grn_report_item_GRN_RPRT_ITEM_449'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-449' replace='true'}{/capture}{validate form=$form_name field="row_size" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_449 append="validation_errors"}
      {capture name='grn_report_item_GRN_RPRT_ITEM_450'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-450' replace='true'}{/capture}{validate form=$form_name field="row_size" criteria="isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_450 append="validation_errors" empty=true}
      {grn_text name='row_size' size='5' value=$settings.row_size}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-451' replace='true'}<font color="#0000ff">#</font>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_452'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-452' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_452}</th>
  <td>
      {grn_textarea name="initial_value" rows="5" value=$settings.initial_value}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_453'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-453' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_453}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_454'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-454' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_454 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_455'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-455' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_455}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_456'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-456' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_456 checked=$item.required}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_457'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-457' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_457}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-458' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-459' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-460' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-461' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-462' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-463' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-464' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-465' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-466' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-467' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-468' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-469' replace='true'}">
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

