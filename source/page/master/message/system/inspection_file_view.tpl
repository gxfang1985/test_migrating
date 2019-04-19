{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

 <!--menubar-->
 <div id="main_menu_part">

 {if $file.locked == 'other'}
   <input type="button" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-47' replace='true'}" disabled="true">
 {else}
  {if $enable_lock}
   {include file="message/_file_update.tpl" page='message/system/inspection_file_update' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm csrf_ticket=$csrf_ticket}
   <input type="button" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-48' replace='true'}" onclick="javascript:document.forms.form_file_update.submit();">
  {else}
   <input type="button" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-49' replace='true'}" onclick="javascript:location.href='{grn_pageurl page=message/system/inspection_file_upload cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}';">
  {/if}
 {/if}
  <span class="menu_item">{capture name='grn_message_system_GRN_MSG_SY_50'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-50' replace='true'}{/capture}{grn_link page='message/system/inspection_file_modify' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_50 image='modify20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}</span>

 {if $file.locked}
  <span class="menu_item">{capture name='grn_message_system_GRN_MSG_SY_51'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-51' replace='true'}{/capture}{grn_link page='message/system/inspection_file_delete' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_51 image='delete20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid disabled=true frm=$frm}</span>
 {else}
  <span class="menu_item">{capture name='grn_message_system_GRN_MSG_SY_52'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-52' replace='true'}{/capture}{grn_link page='message/system/inspection_file_delete' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_52 image='delete20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}</span>
 {/if}

{grn_image image='spacer20.gif'}
 </div><br />
 <!--menubar_end-->
{if $enable_lock}
 {if $file.locked == 'other'}
<form name="unlock" method="post" action='{grn_pageurl page="message/system/command_inspection_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm"  value="{$frm}"> 
<p>{cb_msg module='grn.message.system' key='GRN_MSG_SY-53' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-54' replace='true'}
<input type="submit" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-55' replace='true'}"></p>
 {elseif $file.locked == 'login'}
<form name="unlock" method="post" action='{grn_pageurl page="message/system/command_inspection_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm"  value="{$frm}">
<p>{cb_msg module='grn.message.system' key='GRN_MSG_SY-56' replace='true'}<input type="submit" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-57' replace='true'}"></p>
</form>
 {/if}
{/if}

<div>
{include file="grn/file_view.tpl" download_page="message/system/inspection_file_download" restore_page="message/system/inspection_file_restore" linkparams=$linkparams }
</div>
{include file="grn/system_footer.tpl"}
