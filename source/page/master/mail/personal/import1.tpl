{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-211' replace='true'}</th>
  <td>{grn_select name='naccount' options=$user_account onchange="changeAccount(this,'change_folder_','ncid')"}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-212' replace='true'}</th>
  <td>
{foreach name=folder_data from=$folder_list.data item=folder}
 {if $folder_list.selected == $folder.aid}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}">{grn_mail_select_folders select_name="ncid" account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder='1' hide_garbage_folder='1'}</span>
 {else}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}" style="display:none">{grn_mail_select_folders select_name='ncid'|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder='1' hide_garbage_folder='1'}</span>
 {/if}
{/foreach}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-213' replace='true'}</th>
  <td>
{if $format eq 'eml'}
      {capture name='grn_mail_personal_GRN_MAIL_PE_214'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-214' replace='true'}{/capture}{grn_radio name='format' id='format_mbox' value='mbox' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_214}<br>
      {capture name='grn_mail_personal_GRN_MAIL_PE_215'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-215' replace='true'}{/capture}{grn_radio name='format' id='format_eml' value='eml' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_215}
{else}
      {capture name='grn_mail_personal_GRN_MAIL_PE_218'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-218' replace='true'}{/capture}{grn_radio name='format' id='format_mbox' value='mbox' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_218 checked=TRUE}<br>
      {capture name='grn_mail_personal_GRN_MAIL_PE_219'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-219' replace='true'}{/capture}{grn_radio name='format' id='format_eml' value='eml' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_219}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_personal_GRN_MAIL_PE_222'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-222' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_222 necessary=1}</th>
  <td>{capture name='grn_mail_personal_GRN_MAIL_PE_223'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-223' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_223 append="validation_errors"}{grn_file name='file' size='50' disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_mail_personal_GRN_MAIL_PE_224'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-224' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_224}
      {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>
{/if}

{include file='grn/personal_footer.tpl'}
