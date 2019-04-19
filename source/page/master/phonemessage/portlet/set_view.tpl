{assign var="form_name" value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="refresh" value="">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
<input type="hidden" name="gid" value="{$set_organization_id}">

<table class="std_form" width="100%">
 <colgroup>
  <col width="10%">
  <col width="90%">
 </colgroup>
 <tr>
  <th nowrap>
      {cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-16' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-17' replace='true'}
  </th>
  <td class="tvw">
{if 'all' == $group_type}
    {assign var='check_all' value=true}
{elseif 'organization' == $group_type}
    {assign var='check_organization' value=true}
{elseif 'primary_organization' == $group_type}
    {assign var='check_primary_organization' value=true}
{else}
    {assign var='check_other' value=true}
{/if}
<div>
{capture name='grn_phonemessage_portlet_GRN_PHM_PO_18'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-18' replace='true'}{/capture}{grn_radio name='group' id='all' value='all' caption=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_18 checked=$check_all}
</div>
{if $with_primary_group}
<div class="margin_top">
{capture name='grn_phonemessage_portlet_GRN_PHM_PO_19'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-19' replace='true'}{/capture}{grn_radio name='group' id='primary_group' value='primary_group' caption=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_19 checked=$check_primary_organization}<br
>
</div>
{/if}

{if 0 < count( $mygroup_list ) && 'set-system' != $display && 'set-operation' != $display}
 {literal}
<script language="JavaScript" type="text/javascript"><!--
function on_enter_other( form )
{
    form.elements['group'][{/literal}{if $with_primary_group}2{else}1{/if}{literal}].checked=true;
}
//--></script>
 {/literal}
<div class="margin_top">
 {capture name='grn_phonemessage_portlet_GRN_PHM_PO_20'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-20' replace='true'}{/capture}{grn_radio name='group' id='other' value='other' caption=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_20 checked=$check_other}
<select name="ItemID" onChange="on_enter_other( this.form )">
 {foreach from=$mygroup_list key=key item=item}
<option value="{$key|escape}"{if $key == $portlet.settings.gid} selected{/if}>{$item|escape}</option>
 {/foreach}
</select>
</div>
 {* include file='grn/item_add.tpl' item_group=$others_list enteritem_javascript='on_enter_other( this.form );' initialize_item=$initialize_item no_pulldown=true *}
{/if}

<div class="margin_top">
{if ! $set_organization_id}{assign var='org_disabled' value=1}{/if}
{capture name='grn_phonemessage_portlet_GRN_PHM_PO_21'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-21' replace='true'}{/capture}{grn_radio name='group' id='organization' value='org' caption=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_21 checked=$check_organization disabled=$org_disabled}
</div>
{literal}
<script language="JavaScript" type="text/javascript"><!--
function on_change_organization( hid )
{
    f = document.forms["{/literal}{$form_name}{literal}"];
    e = f.elements["gid"];
    e.value = hid;
    if(!hid)
    {
        var top = document.createElement("input");
        top.type = "hidden";
        top.name = "top";
        top.value = "1";
        f.appendChild(top);
    }
    f.submit();
}
//--></script>
{/literal}
{include file="grn/org_select.tpl" async_page='phonemessage/portlet/org_json' app_id='phonemessage'}

  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" name="apply" value="{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-22' replace='true'}">
       <input class="margin" type="submit" name="cancel" value="{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-23' replace='true'}">
  </td>
 </tr>
</table>

</form>
