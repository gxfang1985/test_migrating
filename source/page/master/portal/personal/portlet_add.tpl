{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$portal_id}">
<input type="hidden" name="position" value="{$portal_position}">
<input type="hidden" name="index" value="{$index|escape}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-31' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr valign="top">
<th>{capture name='grn_portal_personal_GRN_POT_PE_32'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-32' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_32 necessary=1}</th>
<td>
{if $group}{literal}
<script language="JavaScript" type="text/javascript">
<!--
function ChangeCGID( form )
{
    var a = form.elements["s_CID[]"].options;
    var o = new Option(a[a.length-1].text, "");
    for(i = a.length-1; i > 0; i--) a[i] = null;
    a[0] = o;
    var nGID = form.CGID.value
{/literal}{foreach from=$group key=pgid item=select}
    if( nGID == "{$pgid}" )
{literal}    {{/literal}
 {foreach from=$select.portlet key=id item=portlet}
        ag(a,"{$id}","{$portlet|escape:"javascript"}");
 {/foreach}
{literal}   }{/literal}
{/foreach}
{literal}    if( nGID == "" )
    {
{/literal}
 {foreach from=$all_portlet key=id item=portlet}
        ag(a,"{$id}","{$portlet|escape:"javascript"}");
 {/foreach}
{literal}
    }
    return;
}
//-->
</script>{/literal}{/if}
<select class="margin_bottom" id="groupSelect" name="CGID" onChange="ChangeCGID( this.form )">
<option value="">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-33' replace='true'}</option>
{foreach from=$group key=pgid item=select}
<option value="{$pgid}" >{$select.title|escape}</option>
{/foreach}
</select><br>
{capture name='grn_portal_personal_GRN_POT_PE_34'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-34' replace='true'}{/capture}{validate form="$form_name" field="s_CID" criteria="notEmpty" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_34 append="validation_errors"}
<select name="s_CID[]" size="10" multiple>
{foreach from=$all_portlet key=id item=portlet}
<option value="{$id}">{$portlet|escape}</option>
{/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
</select>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_portal_personal_GRN_POT_PE_35'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-35' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_35}
{grn_button_cancel page='portal/personal/view' pid=$portal_id}
</td>
</tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
