{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="charset" value="{$charset}">
<input type="hidden" name="skip" value="{$skip}">
<input type="hidden" name="file" value="{$file}">
<input type="hidden" name="cid" value="{$category_id}">

   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <tr>
 {foreach from=$lines.0 key=idx item=col}
     <th nowrap>{$idx+1}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-329' replace='true'}</th>
 {/foreach}
    </tr>
{foreach from=$lines item=line}
    <tr valign="top">
 {foreach from=$line item=col}
     <td>{$col|escape}</td>
 {/foreach}
    </tr>
{/foreach}
   </table>

<p>
{**
<table class="std_form">
{foreach name= columns from=$columns item=column}
 <tr>
  <th nowrap>{$smarty.foreach.columns.iteration}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-330' replace='true'}</th>
  <td>{$column|escape}</td>
 </tr>
{/foreach}
 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_331'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-331' replace='true'}{/capture}{grn_button_cancel class='margin' caption='<< $smarty.capture.grn_mail_system_GRN_MAIL_SY_331 page='mail/system/mailserver_import1' charset=$charset skip=$skip}
       {capture name='grn_mail_system_GRN_MAIL_SY_332'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-332' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_332}
       {grn_button_cancel class='margin' page='mail/system/import_index'}
  </td>
 </tr>
</table>
**}
{capture name='grn_mail_system_GRN_MAIL_SY_333'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-333' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_333 page='mail/system/mailserver_import1' charset=$charset skip=$skip}
{capture name='grn_mail_system_GRN_MAIL_SY_334'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-334' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_334}
{grn_button_cancel class='margin' page='mail/system/import_index'}

</form>
</p>

<hr>
<p>
{include file='mail/system/_mailserver_csv_columns.tpl'}
{include file='mail/system/_mailserver_csv_info.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='import' sub_explanation=$smarty.capture.sub_explanation}

{include file="grn/system_footer.tpl"}
