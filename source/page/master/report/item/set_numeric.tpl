{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-158' replace='true'}</div>
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
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/item/command_set_numeric'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/item/command_set_numeric'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_159'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-159' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_159}</th>
  <td>
      {grn_select name='data_type' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_160'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-160' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_160 necessary=true}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_161'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-161' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_161 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_162'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-162' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_162}</th>
  <td>
      {if $settings.input_numbers == 0}{assign var='input_numbers_0' value='1'}{else}{assign var='input_numbers_1' value='1'}{/if}
      {capture name='grn_report_item_GRN_RPRT_ITEM_163'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-163' replace='true'}{/capture}{grn_radio name='input_numbers' id='0' value='0' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_163 checked=$input_numbers_0}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_164'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-164' replace='true'}{/capture}{grn_radio name='input_numbers' id='1' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_164 checked=$input_numbers_1}
      {capture name='grn_report_item_GRN_RPRT_ITEM_165'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-165' replace='true'}{/capture}{validate form=$form_name field="max_input_number" criteria="grn_report_isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_165 append="validation_errors" empty=true}
      {capture name='grn_report_item_GRN_RPRT_ITEM_166'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-166' replace='true'}{/capture}{validate form=$form_name field="min_input_number" criteria="grn_report_isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_166 append="validation_errors" empty=true}
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-167' replace='true'}{grn_text name='max_input_number' size='5' disable_return_key=true value=$settings.max_input_number}<font color="#0000ff">#</font>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-168' replace='true'}{grn_text name='min_input_number' size='5' disable_return_key=true value=$settings.min_input_number}<font color="#0000ff">#</font>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-169' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_170'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-170' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_170}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_171'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-171' replace='true'}{/capture}{validate form=$form_name field="initial_value" criteria="grn_report_isNumber" message=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_171 append="validation_errors" empty=true}
      {grn_text name='initial_value' size='20' disable_return_key=true value=$settings.initial_value}<font color="#0000ff">#</font>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_172'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-172' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_172}</th>
  <td>
      {grn_select_numbers select_name='effective_figures' size='1' options=$effective_figures_options selected=$settings.effective_figures}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_173'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-173' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_173}</th>
  <td>
      {grn_select name='minus_type' size='1' options=$minus_type_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_174'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-174' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_174}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_175'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-175' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_175 checked=$item.description_type}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_176'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-176' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_176}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_177'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-177' replace='true'}{/capture}{grn_checkbox name='right_align' id='right_align' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_177 ' checked=$settings.right_align}<br>
      {capture name='grn_report_item_GRN_RPRT_ITEM_178'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-178' replace='true'}{/capture}{grn_checkbox name='split_rank' id='split_rank' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_178 ' checked=$settings.split_rank}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_179'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-179' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_179}</th>
  <td>
      {capture name='grn_report_item_GRN_RPRT_ITEM_180'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-180' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_180 checked=$item.required}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_item_GRN_RPRT_ITEM_181'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-181' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_181}</th>
  <td>
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-182' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-183' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-184' replace='true'}&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-185' replace='true'}\{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-186' replace='true'} </div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>\<input type=text value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-187' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-188' replace='true'}">
        {grn_button_cancel page='report/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-189' replace='true'}">
        {grn_button_cancel page='report/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-190' replace='true'}">
        {grn_button_cancel page='report/form_view' rid=$report_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-191' replace='true'}">
        {grn_button_cancel page='report/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-192' replace='true'}">
        {grn_button_cancel page='report/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-193' replace='true'}">
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

