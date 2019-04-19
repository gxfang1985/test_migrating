{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $page_prefix}{assign var='page_prefix' value='report/operation'}{/if}
 <!--menubar-->
 <div id="main_menu_part">
{if $file.modifiable}
 {if $file.locked == 'other'}
   <input type="button" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-250' replace='true'}" disabled="true">
 {else}
  {if $lockable}
   {include file="report/_file_update.tpl" page=$page_prefix|cat:'/file_update' fid=$fid cid=$cid rid=$rid follow_id=$follow_id iid=$iid csrf_ticket=$csrf_ticket}
   <input type="button" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-251' replace='true'}" onclick="javascript:document.forms.form_file_update.submit();">
  {else}
   <input type="button" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-252' replace='true'}" onclick="javascript:location.href='{grn_pageurl page=$page_prefix|cat:'/file_upload' fid=$fid cid=$cid frm=$form_id rid=$rid follow_id=$follow_id iid=$iid}';">
  {/if}
 {/if}
  <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_253'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-253' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/file_modify' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_253 image='modify20.gif' fid=$fid cid=$cid frm=$form_id rid=$rid follow_id=$follow_id iid=$iid}</span>
{/if}
{if $file.deletable}
 {if $file.locked == 'other'}
  <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_254'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-254' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/file_delete' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_254 image='delete20.gif' fid=$fid cid=$cid frm=$form_id rid=$rid follow_id=$follow_id iid=$iid disabled=true}</span>
 {else}
  <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_255'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-255' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/file_delete' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_255 image='delete20.gif' fid=$fid cid=$cid frm=$form_id rid=$rid follow_id=$follow_id iid=$iid}</span>
 {/if}
{/if}
{grn_image image='spacer20.gif'}
 </div>
 <!--menubar_end-->
 {if $file.locked == 'other'}
<form name="unlock" method="post" action='{grn_pageurl page=$page_prefix|cat:"/command_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fid" value="{$fid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="frm" value="{$form_id}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="iid" value="{$iid}">
<p><font color="green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-256' replace='true'}</font>&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-257' replace='true'}<input type="submit" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-259' replace='true'}"></p>
</form>
 {elseif $file.locked == 'login'}
<form name="unlock" method="post" action='{grn_pageurl page=$page_prefix|cat:"/command_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fid" value="{$fid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="frm" value="{$form_id}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="iid" value="{$iid}">
<p><font color="green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-258' replace='true'}</font><input type="submit" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-259' replace='true'}"></p>
</form>
 {/if}
{include file="grn/file_view.tpl" download_page=$page_prefix|cat:"/file_download" restore_page=$page_prefix|cat:"/file_restore" linkparams=$linkparams}
{include file="grn/footer.tpl"}
