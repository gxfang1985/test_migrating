{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="itype" value="{$access_item.type}">
<input type="hidden" name="itid" value="{$access_item.tid}">

<div class="explanation">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-47' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-48' replace='true'}
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-49' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-50' replace='true'}</th>
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
<th>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-51' replace='true'}</th>
<td>
{if $security_model == GRN_ADDRESS_SECURITYMODEL_GRANT}
{assign var='data_browse'   value=$access_item.data.browse}
{assign var='data_editing'  value=$access_item.data.editing}
{else}
{if ! $access_item.data.browse  }{assign var='data_browse'  value=true}{/if}
{if ! $access_item.data.editing }{assign var='data_editing' value=true}{/if}
{/if}

{if $data_browse}
 {assign var="checked_browse" value="checked"}
{else}
 {assign var="checked_browse" value=""}
{/if}
<input type="checkbox" name="browse" id="authority_browse" value="1" {$checked_browse} onClick="change_on_off(this)"><label for="authority_browse" onMouseOver="this.style.color='#ff0000'" onMouseOut="this.style.color=''">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-52' replace='true'}</label>
{capture name='grn_address_operation_GRN_ADDR_OP_53'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-53' replace='true'}{/capture}{grn_checkbox name='editing'  id='authority_editing'  value='1' checked=$data_editing caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_53}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_address_operation_GRN_ADDR_OP_54'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-54' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_54}
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
        e.form.elements["editing"].disabled = false;
    }
    else
    {
        e.form.elements["editing"].disabled = true;
        e.form.elements["editing"].checked = false;
    }
}
function change_on_off_init()
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements["browse"];
    if(e.checked)
    {
        e.form.elements["editing"].disabled = false;
    }
    else
    {
        e.form.elements["editing"].disabled = true;
    }
}
change_on_off_init();
//-->
</script>
{/literal}

</form>

{include file='grn/footer.tpl'}
