 {assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-313' replace='true'}</div>
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

{if $item.type != 1}
 {assign var="data_type_class" value="data_type_change"}
 {include file="report/item/_set_type.tpl"}
{/if}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_string_single'}" enctype="multipart/form-data">
     {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_string_single'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_314'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-314' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_314}</th>
  <td>
      {if $item.type == 1}
        {$item.display_type|escape}
        <input type="hidden" name="data_type" value="{$selected_data_type}">
      {else}
        {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_315'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-315' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_315 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_316'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-316' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_316 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_317'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-317' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_317 necessary=true}</th>
  <td>
        {capture name='grn_report_item_GRN_RPRT_ITEM_318'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-318' replace='true'}{/capture}{validate form=$form_name field="size" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_318 append="validation_errors"}
        {capture name='grn_report_item_GRN_RPRT_ITEM_319'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-319' replace='true'}{/capture}{validate form=$form_name field="size" criteria="isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_319 append="validation_errors" empty=true}
        {capture name='grn_report_item_GRN_RPRT_ITEM_320'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-320' replace='true'}{/capture}{validate form=$form_name field="size" criteria="grn_report_isRangeMin" min='1' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_320 append="validation_errors" empty=true}
        {grn_text name='size' size='5' value=$settings.size}<font color="#0000ff">#</font><div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-321' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_322'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-322' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_322}</th>
  <td>
        {capture name='grn_report_item_GRN_RPRT_ITEM_323'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-323' replace='true'}{/capture}{validate form=$form_name field="max_input_size" criteria="isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_323 append="validation_errors" empty=true}
        {capture name='grn_report_item_GRN_RPRT_ITEM_324'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-324' replace='true'}{/capture}{validate form=$form_name field="max_input_size" criteria="grn_report_isRangeMin" min='1' message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_324 append="validation_errors" empty=true}
        {grn_text name='max_input_size' size='5' value=$settings.max_input_size}<font color="#0000ff">#</font>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_325'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-325' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_325}</th>
  <td>
        {if $settings.input_chars == 0}
          {assign var='input_chars_0' value='1'}
        {elseif  $settings.input_chars == 1}
          {assign var='input_chars_1' value='1'}
        {else}
          {assign var='input_chars_2' value='1'}
        {/if}
        {capture name='grn_report_item_GRN_RPRT_ITEM_326'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-326' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_0' value='0' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_326 checked=$input_chars_0}
        {capture name='grn_report_item_GRN_RPRT_ITEM_327'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-327' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_1' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_327 checked=$input_chars_1}
        {capture name='grn_report_item_GRN_RPRT_ITEM_328'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-328' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_2' value='2' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_328 checked=$input_chars_2}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_329'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-329' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_329}</th>
  <td>
        {if $settings.initial_type == 0}{assign var='initial_type_0' value='1'}{else}{assign var='initial_type_1' value='1'}{/if}
        {capture name='grn_report_item_GRN_RPRT_ITEM_330'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-330' replace='true'}{/capture}{grn_radio name='initial_type' id='initial_type_0' value='0' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_330 checked=$initial_type_0}
        {grn_text name='initial_text_value' size='50' disable_return_key=true value=$settings.initial_text_value}<br>
        {capture name='grn_report_item_GRN_RPRT_ITEM_331'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-331' replace='true'}{/capture}{grn_radio name='initial_type' id='initial_type_1' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_331 checked=$initial_type_1}
        {grn_select name='initial_user_value' size='1' options=$user_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_332'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-332' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_332}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_333'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-333' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_333 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_334'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-334' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_334}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_335'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-335' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_335 checked=$item.required}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_336'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-336' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_336}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-337' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-338' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-339' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-340' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-341' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-342' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-343' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-344' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-345' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-346' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-347' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-348' replace='true'}">
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

