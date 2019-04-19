{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="fagid" value="{$fgroup_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="rid" value="{$role_id|escape}">
<input type="hidden" name="faid" value="{$facility_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="itype" value="{$access_item.type}">
<input type="hidden" name="itid" value="{$access_item.tid}">

<div class="explanation">
{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-54' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-55' replace='true'}</th>
<td>
{if $access_item.type == 'user'}
 {grn_user_name uid=$access_item.tid}
{elseif $access_item.type == 'group'}
 {grn_organize_name gid=$access_item.tid}
{elseif $access_item.type == 'static_role'}
 {grn_image image='role20.gif'}{grn_role_name rid=$access_item.tid}
{elseif $access_item.type == 'dynamic_role'}
 {grn_image image='role20.gif'}{$access_item.tid|escape}
{/if}
</td>
</tr>
<tr>
<th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-56' replace='true'}</th>
<td>
{if $security_model == 'grant'}
{assign var='data_read'   value=$access_item.data.read}
{assign var='data_add'    value=$access_item.data.add}
{assign var='data_modify' value=$access_item.data.modify}
{assign var='data_delete' value=$access_item.data.delete}
{else}
{if ! $access_item.data.read  }{assign var='data_read'   value=1}{/if}
{if ! $access_item.data.add   }{assign var='data_add'    value=1}{/if}
{if ! $access_item.data.modify}{assign var='data_modify' value=1}{/if}
{if ! $access_item.data.delete}{assign var='data_delete' value=1}{/if}
{/if}

{if $data_read}
 {assign var="checked_read" value="checked"}
{else}
 {assign var="checked_read" value=""}
{/if}
<input type="checkbox" name="read" id="authority_read" value="1" {$checked_read} onClick="change_on_off(this)"><label for="authority_read" onMouseOver="this.style.color='#ff0000'" onMouseOut="this.style.color=''">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-57' replace='true'}</label>
{capture name='grn_schedule_operation_GRN_SCH_OP_58'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-58' replace='true'}{/capture}{grn_checkbox name='add'    id='authority_add'    value='1' checked=$data_add caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_58}
{capture name='grn_schedule_operation_GRN_SCH_OP_59'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-59' replace='true'}{/capture}{grn_checkbox name='modify' id='authority_modify' value='1' checked=$data_modify caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_59}
{capture name='grn_schedule_operation_GRN_SCH_OP_60'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-60' replace='true'}{/capture}{grn_checkbox name='delete' id='authority_delete' value='1' checked=$data_delete caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_60}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_schedule_operation_GRN_SCH_OP_61'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-61' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_61}
{grn_button_cancel}
</td>
</tr>
</table>

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function change_on_off(e)
{
    if(e.checked)
    {
        e.form.elements["add"].disabled = false;
        e.form.elements["modify"].disabled = false;
        e.form.elements["delete"].disabled = false;
    }
    else
    {
        e.form.elements["add"].disabled = true;
        e.form.elements["modify"].disabled = true;
        e.form.elements["delete"].disabled = true;
        e.form.elements["add"].checked = false;
        e.form.elements["modify"].checked = false;
        e.form.elements["delete"].checked = false;
    }
}
function change_on_off_init()
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements["read"];
    if(e.checked)
    {
        e.form.elements["add"].disabled = false;
        e.form.elements["modify"].disabled = false;
        e.form.elements["delete"].disabled = false;
    }
    else
    {
        e.form.elements["add"].disabled = true;
        e.form.elements["modify"].disabled = true;
        e.form.elements["delete"].disabled = true;
    }
}
change_on_off_init();
//-->
</script>
{/literal}

</form>

{include file='grn/footer.tpl'}
