{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cbwebsrv/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="view">
  <span class="bold">{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-25' replace='true'}<br>
{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-26' replace='true'}{capture name='grn_cbwebsrv_system_GRN_WBS_SY_27'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-27' replace='true'}{/capture}{grn_link page='index' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_27}&nbsp;{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-28' replace='true'}
  </span>
<script language="JavaScript">
<!--
interval("{$page_info.all}", 0);
//-->
</script>
 </div>
 <!--action_end--->
</div>
{foreach from=$event_ids item=id}
<input type='hidden' name='event_ids[]' value="{$id}">
{/foreach}
</form>
</div>
{include file='grn/system_footer.tpl'}
