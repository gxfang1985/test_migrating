<p class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-167' replace='true'}</p>

<p></p>
{cb_msg module='grn.report' key='GRN_RPRT-168' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$form.name|escape}{cb_msg module='grn.report' key='GRN_RPRT-169' replace='true'}{$form.subject|escape}{cb_msg module='grn.report' key='GRN_RPRT-170' replace='true'}</span>{cb_msg module='grn.report' key='GRN_RPRT-171' replace='true'}
<p></p>

<table width="100%">
 <tr>
  <td>
   <span class="sub_title">{cb_msg module='grn.report' key='GRN_RPRT-172' replace='true'}</span>
   <table class="view_table" width="100%">
{* Start Item Section *}
{foreach from=$item_list item=item_line}
 {if $item_line.type == 2}
   </table>
    <table width="100%">
     <tr valign="top">
      <td>
       <div class="wf_empty_row"></div>
      </td>
     </tr>
    </table>
   <table class="view_table" width="100%">
 {else}
   {if $item_line.list_index == 0 && $event}
    <tr valign="top">
     <th rowspan="1" align="left" width="20%" nowrap>{cb_msg module='grn.report' key='GRN_RPRT-174' replace='true'}</th>
     <td><a href="{grn_pageurl page='schedule/view' event=$event_id bdate=$event_date}">{$event->getTitle()}</a></td>
    </tr>
  {/if}
    <tr valign="top">
     <th rowspan="1" align="left">
  {$item_line.display_name|escape}
     </th>
    {grn_report_include_item category_id=$category_id form_id=$form_id iid=$item_line.iid item=$item_line display="view-confirm"}
    </tr>
  {if $item_line.type == 1}
    <tr valign="top">
     <th rowspan="1" align="left">{cb_msg module='grn.report' key='GRN_RPRT-175' replace='true'}{cb_msg module='grn.report' key='notify.target' replace='true'}</th>
     <td nowrap>{grn_user_name uid=$login.id name=$login.name}</td>
    </tr>
   {if $form.enable_member}
    <tr valign="top">
     <th rowspan="1" align="left">{cb_msg module='grn.report' key='GRN_RPRT-176' replace='true'}{cb_msg module='grn.report' key='notify.target' replace='true'}</th>
     <td>
      {grn_report_member members=$members}
     </td>
    </tr>
   {/if}
   {if $form.enable_partner}
    <tr valign="top">
     <th id="report_partner_header" rowspan="1" align="left">{cb_msg module='grn.report' key='outside_parties' replace='true'}</th>
     <td id="report_partner_list">
      {include file='report/_view_partner.tpl' partners=$partners blank=true available_address=$available_address}
     </td>
    </tr>
   {/if}
  {/if}
 {/if}
{/foreach}
    <tr valign="top">
     <th rowspan="1" align="left">{if $form.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-86' replace='true'}{else}{cb_msg module='grn.report' key='GRN_RPRT-27' replace='true'}{/if}</th>
     <td>
       {grn_report_notification users=$notificationUsers}
     </td>
    </tr>
    <tr valign="top">
     <th id="allow_operator" rowspan="1" align="left">{cb_msg module='grn.report' key='allow_operator' replace='true'}</th>
     <td id="report_operator_list">
       {grn_report_operator operators=$operators operator_set=$operator_set}
     </td>
    </tr>
{* End Item Section *}
   </table>
  </td>
 </tr>
</table>

{strip}
    <div class="mTop15 mBottom15">
        {capture name='grn_report_GRN_RPRT_179'}{cb_msg module='grn.report' key='GRN_RPRT-179' replace='true'}{/capture}
        {capture name='grn_report_GRN_RPRT_180'}{cb_msg module='grn.report' key='GRN_RPRT-180' replace='true'}{/capture}
        {capture name='grn_report_GRN_RPRT_181'}{cb_msg module='grn.report' key='GRN_RPRT-181' replace='true'}{/capture}
        {grn_button id="report_button_back" spacing="tight" auto_disable=true caption=$smarty.capture.grn_report_GRN_RPRT_179 onclick="jQuery(this).closest('form')[0].cmd.value='back';grn.component.button.util.submit(this);"}
        {grn_button id="report_button_send" ui="main" spacing="loose" auto_disable=true caption=$smarty.capture.grn_report_GRN_RPRT_180 onclick="jQuery(this).closest('form')[0].cmd.value='send';grn.component.button.util.submit(this);"}
        {if $properties.draft == '1'}
            {grn_button id="report_button_cancel" caption=$smarty.capture.grn_report_GRN_RPRT_181 onclick="jQuery(this).closest('form')[0].cmd.value='cancel_draft_reuse';grn.component.button.util.submit(this);"}
        {else}
            {grn_button id="report_button_cancel" caption=$smarty.capture.grn_report_GRN_RPRT_181 onclick="jQuery(this).closest('form')[0].cmd.value='cancel';grn.component.button.util.submit(this);"}
        {/if}
    </div>
{/strip}
<input type="hidden" name="cmd" value="">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="eid" value="{$event_id|escape}">
<input type="hidden" name="date" value="{$str_date|escape}">
<input type="hidden" name="rid" value="{$report_id|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
