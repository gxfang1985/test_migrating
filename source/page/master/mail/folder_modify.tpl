{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<div class="mainarea-mail">
<form name="{$form_name}" method="POST" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-171' replace='true'}</div></p>
 {include file='grn/show_validation_errors.tpl'}
{if $category.type eq '5'}
 {include file='grn/indispensable.tpl'}
{/if}
 {capture name='grn_mail_GRN_MAIL_172'}{cb_msg module='grn.mail' key='GRN_MAIL-172' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_mail_GRN_MAIL_172 transform="cb_trim" append="validation_errors"}
 <table class="std_form">
{if $category.type eq '5'}
  <tr>
   <th>{capture name='grn_mail_GRN_MAIL_173'}{cb_msg module='grn.mail' key='GRN_MAIL-173' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_GRN_MAIL_173 necessary=TRUE}</th>
   <td>{grn_text name='title' size='30' value=$category.title}</td>
  </tr>
{else}
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-174' replace='true'}</th>
   <td>{$category.title|escape}</td>
  </tr>
{/if}
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-175' replace='true'}</th>
   <td>
{if $category.type eq '5'}
       {grn_select name='user_account' options=$user_account onchange="changeAccount(this,'change_folder_','pid')"}
{else}
       {$account.title|escape}
{/if}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-176' replace='true'}</th>
   <td>
{if $category.type eq '5'}
 {foreach name=folder_data from=$folder_list.data item=folder}
  {if $folder_list.selected == $folder.aid}
<span class="float_left" id="change_folder_{$smarty.foreach.folder_data.iteration}">{grn_mail_select_folders select_name='pid' account_id=$folder.aid selected_folder_id=$folder.cid hide_special_folder=1 parent_folder_id=$category.parent_id hide_selected_folder=$folder.hflag}</span>
  {else}
<span class="float_left" id="change_folder_{$smarty.foreach.folder_data.iteration}" style="display:none">{grn_mail_select_folders select_name='pid'|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid selected_folder_id=$category.cid hide_special_folder=1 hide_selected_folder=$folder.hflag}</span>
  {/if}
 {/foreach}
{else}
       {grn_mail_show_folder_position folder_id=$category.cid}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-177' replace='true'}</th>
   <td>{grn_textarea name="memo" rows="9" value=$category.memo}</td>
  </tr>
  <tr>
   <td></td>
   <td>
       {strip}
           <div class="mTop10">
               {capture name='grn_mail_GRN_MAIL_178'}{cb_msg module='grn.mail' key='GRN_MAIL-178' replace='true'}{/capture}
               {grn_button action="submit" caption=$smarty.capture.grn_mail_GRN_MAIL_178 ui="main" spacing="normal" id="mail_button_save"}
               {grn_button action="cancel" page="mail/folder_view" page_param_aid=$category.aid page_param_cid=$category.cid  id="mail_button_cancel"}
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
