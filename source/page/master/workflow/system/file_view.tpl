{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
 <!--menubar-->
 <div id="main_menu_part">
{if $file.modifiable}
 {if $file.locked == 'other'}
   <input type="button" value="{cb_msg module='grn.workflow.system' key='w_update_files' replace='true'}" disabled="true">
 {else}
  {if $enable_lock}
   <input type="button" value="{cb_msg module='grn.workflow.system' key='w_update_files' replace='true'}" onclick="javascript:location.href='{grn_pageurl page=workflow/system/file_lock cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}';">
  {else}
   <input type="button" value="{cb_msg module='grn.workflow.system' key='w_update_files' replace='true'}" onclick="javascript:location.href='{grn_pageurl page=workflow/system/file_upload cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}';">
  {/if}
 {/if}
  <span class="menu_item">{capture name='grn_workflow_system_w_update_file_information'}{cb_msg module='grn.workflow.system' key='w_update_file_information' replace='true'}{/capture}{grn_link page='workflow/system/file_modify' caption=$smarty.capture.grn_workflow_system_w_update_file_information image='modify20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}</span>
{/if}
{if $file.deletable}
 {if $file.locked}
  <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link page='workflow/system/file_delete' caption=$smarty.capture.grn_workflow_system_w_do_delete image='delete20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid disabled=true frm=$frm}</span>
 {else}
  <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link page='workflow/system/file_delete' caption=$smarty.capture.grn_workflow_system_w_do_delete image='delete20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}</span>
 {/if}
{/if}
{grn_image image='spacer20.gif'}
 </div>
 <!--menubar_end-->
{if $enable_lock}
 {if $file.locked == 'other'}
<p>{cb_msg module='grn.workflow.system' key='key_150_1' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.workflow.system' key='key_150_2' replace='true'}</p>
 {elseif $file.locked == 'login'}
<form name="unlock" method="post" action='{grn_pageurl page="workflow/system/command_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm"  value="{$frm}">
<p><font color="green">{cb_msg module='grn.workflow.system' key='w_file_in_use' replace='true'}</font><input type="submit" value="{cb_msg module='grn.workflow.system' key='w_release_edit_lock_y' replace='true'}"></p>
</form>
 {/if}
{/if}
{include file="grn/file_view.tpl" download_page="workflow/system/file_download" linkparams=$linkparams}
{include file="grn/system_footer.tpl"}
