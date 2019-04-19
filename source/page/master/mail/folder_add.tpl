{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<div class="mainarea-mail">
<form name="{$form_name}" method="POST" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-248' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{capture name='grn_mail_GRN_MAIL_249'}{cb_msg module='grn.mail' key='GRN_MAIL-249' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_mail_GRN_MAIL_249 transform="cb_trim" append="validation_errors"}
 <table class="std_form">
  <tr>
   <th>{capture name='grn_mail_GRN_MAIL_250'}{cb_msg module='grn.mail' key='GRN_MAIL-250' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_GRN_MAIL_250 necessary=TRUE}</th>
   <td>{grn_text name="title" size="30" value=$category.title}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-251' replace='true'}</th>
   <td>{$account.title|escape}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-252' replace='true'}</th>
   <td>{grn_mail_select_folders select_name="dcid" selected_folder_id=$category.cid account_id=$category.aid hide_special_folder=1}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-253' replace='true'}</th>
   <td>{grn_textarea name="memo" rows="9" value=$category.memo}</td>
  </tr>
  <tr>
   <td></td>
   <td>
       {strip}
           <div class="mTop10">
               {capture name='grn_mail_GRN_MAIL_254'}{cb_msg module='grn.mail' key='GRN_MAIL-254' replace='true'}{/capture}
               {grn_button caption=$smarty.capture.grn_mail_GRN_MAIL_254 action="submit" ui="main" spacing="normal" id="mail_button_save"}
               {grn_button action="cancel" page="mail/index" page_param_aid=$category.aid page_param_cid=$category.cid id="mail_button_cancel"}
           </div>
       {/strip}
   </td>
  </tr>
 </table>
 <input type="hidden" name="aid" value="{$category.aid}">
 <input type="hidden" name="cid" value="{$category.cid}">
</form>
</div>
{include file="grn/footer.tpl"}
