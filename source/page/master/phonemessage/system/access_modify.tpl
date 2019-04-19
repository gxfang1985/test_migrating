{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="rid" value="{$role_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="itype" value="{$access_item.type}">
<input type="hidden" name="itid" value="{$access_item.tid}">

<div class="explanation">
{include file='phonemessage/system/_access_object_name.tpl'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-21' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-22' replace='true'}</th>
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
<th>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-23' replace='true'}</th>
<td>
{if $security_model == 'grant'}
{assign var='data_browse'   value=$access_item.data.browse}
{assign var='data_add'    value=$access_item.data.add}
{else}
{if ! $access_item.data.browse  }{assign var='data_browse'   value=1}{/if}
{if ! $access_item.data.add }{assign var='data_add'  value=1}{/if}
{/if}

{if $data_browse}
 {assign var="checked_browse" value="checked"}
{else}
 {assign var="checked_browse" value=""}
{/if}

{if $auth_disable_change_on_off != true }
<input type="checkbox" name="browse" id="authority_browse" value="1" {$checked_browse} onClick="change_on_off(this)"><label for="authority_browse" onMouseOver="this.style.color='#ff0000'" onMouseOut="this.style.color=''">{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-24' replace='true'}</label>
{else}
<input type="checkbox" name="browse" id="authority_browse" value="1" {$checked_browse}><label for="authority_browse" onMouseOver="this.style.color='#ff0000'" onMouseOut="this.style.color=''">{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-25' replace='true'}</label>
{/if}
{capture name='grn_phonemessage_system_GRN_PHM_SY_26'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-26' replace='true'}{/capture}{grn_checkbox name='add'  id='authority_add'  value='1' checked=$data_add caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_26}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_phonemessage_system_GRN_PHM_SY_27'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-27' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_27}
{grn_button_cancel}
</td>
</tr>
</table>

{if $auth_disable_change_on_off != true }
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function change_on_off(e)
{
    if(e.checked)
    {
        e.form.elements["add"].disabled = false;
    }
    else
    {
        e.form.elements["add"].disabled = true;
        e.form.elements["add"].checked = false;
    }
}
function change_on_off_init()
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements["browse"];
    if(e.checked)
    {
        e.form.elements["add"].disabled = false;
    }
    else
    {
        e.form.elements["add"].disabled = true;
    }
}
change_on_off_init();
//-->
</script>
{/literal}
{/if}
</form>

{include file='grn/system_footer.tpl'}
