{assign var='form_name' value=$smarty.template|basename}
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
      {cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-9' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-10' replace='true'}
  </th>
  <td>
{assign var='with_explanation' value=true}
{include file='address/personal/_user_item_display.tpl'}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-11' replace='true'}
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
{capture name='grn_address_portlet_GRN_ADDR_PTLT_12'}{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-12' replace='true'}{/capture}{grn_radio name='group' id='all' value='all' caption=$smarty.capture.grn_address_portlet_GRN_ADDR_PTLT_12 checked=$check_all}<br>
{if $with_primary_group}
<div class="margin_top">
{capture name='grn_address_portlet_GRN_ADDR_PTLT_13'}{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-13' replace='true'}{/capture}{grn_radio name='group' id='primary_group' value='primary_group' caption=$smarty.capture.grn_address_portlet_GRN_ADDR_PTLT_13 checked=$check_primary_organization}<br>
</div>
{/if}
{if 0 < count( $mygroup_list ) && 'set-system' != $display && 'set-operation' != $display}
 {literal}
<script language="JavaScript" type="text/javascript"><!--
function on_enter_other( form )
{
    form.elements['group'][2].checked=true;
}
//--></script>
 {/literal}
<div class="margin_top">
{capture name='grn_address_portlet_GRN_ADDR_PTLT_14'}{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-14' replace='true'}{/capture}{grn_radio name='group' id='other' value='other' caption=$smarty.capture.grn_address_portlet_GRN_ADDR_PTLT_14 checked=$check_other}
<select name="ItemID" onChange="on_enter_other( this.form )">
 {foreach from=$mygroup_list key=key item=item}
<option value="{$key|escape}"{if $key == $portlet.settings.gid} selected{/if}>{$item|escape}</option>
 {/foreach}
</select>
</div>
</div>
{/if}

<div class="margin_top">
{if ! $set_organization_id}{assign var='org_disabled' value=1}{/if}
{capture name='grn_address_portlet_GRN_ADDR_PTLT_15'}{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-15' replace='true'}{/capture}{grn_radio name='group' id='organization' value='org' caption=$smarty.capture.grn_address_portlet_GRN_ADDR_PTLT_15 checked=$check_organization disabled=$org_disabled}
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
{include file="grn/org_select.tpl" async_page='address/portlet/org_json'}

  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" name="apply" value="{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-16' replace='true'}">
       <input class="margin" type="submit" name="cancel" value="{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-17' replace='true'}">
  </td>
 </tr>
</table>

</form>
