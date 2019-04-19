<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="itype" value="{$access_item.type}">
<input type="hidden" name="itid" value="{$access_item.tid}">

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-149' replace='true'}<br>
{grn_sentence caption=$node.name image='folder20.gif' class='bold'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.cabinet' key='GRN_CAB-150' replace='true'}</th>
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
<th>{cb_msg module='grn.cabinet' key='GRN_CAB-151' replace='true'}</th>
<td>
{if $security_model == 'grant'}
{assign var='data_read'   value=$access_item.data.read}
{assign var='data_write'  value=$access_item.data.write}
{else}
{if ! $access_item.data.read  }{assign var='data_read'   value=1}{/if}
{if ! $access_item.data.write }{assign var='data_write'  value=1}{/if}
{/if}

{if $data_read}
 {assign var="checked_read" value="checked"}
{else}
 {assign var="checked_read" value=""}
{/if}
<input type="checkbox" name="read" id="authority_read" value="1" {$checked_read} onClick="change_on_off(this)"><label for="authority_read" onMouseOver="this.style.color='#ff0000'" onMouseOut="this.style.color=''">{cb_msg module='grn.cabinet' key='GRN_CAB-152' replace='true'}</label>
{capture name='grn_cabinet_GRN_CAB_153'}{cb_msg module='grn.cabinet' key='GRN_CAB-153' replace='true'}{/capture}{grn_checkbox name='write'  id='authority_write'  value='1' checked=$data_write caption=$smarty.capture.grn_cabinet_GRN_CAB_153}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_cabinet_GRN_CAB_154'}{cb_msg module='grn.cabinet' key='GRN_CAB-154' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_154}
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
        e.form.elements["write"].disabled = false;
    }
    else
    {
        e.form.elements["write"].disabled = true;
        e.form.elements["write"].checked = false;
    }
}
function change_on_off_init()
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements["read"];
    if(e.checked)
    {
        e.form.elements["write"].disabled = false;
    }
    else
    {
        e.form.elements["write"].disabled = true;
    }
}
change_on_off_init();
//-->
</script>
{/literal}
