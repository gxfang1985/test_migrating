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
      {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-123' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-124' replace='true'}
  </th>
  <td class='tvw'>
     {if $group_type == "mygroup"}
      {assign var="check_mygroup" value=true}
     {elseif $group_type == "facility_group"}
      {assign var="check_facility_group" value=true}
     {elseif $group_type == "organization" && $set_organization_id && ! $is_candidate_organization}
      {assign var="check_organization" value=true}
     {else}
      {assign var="check_login" value=true}
     {/if}
<div>
{capture name='grn_schedule_portlet_GRN_SCH_PO_125'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-125' replace='true'}{/capture}{grn_radio name='group' id='login_user' value='login' caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_125 checked=$check_login}
</div>

{if $facility_group_list}
<div class="margin_top">
<div class="mBottom7">
    <span class="v_align_middle_grn">
        {capture name='grn_schedule_GRN_SCH_27'}{cb_msg module='grn.schedule' key='GRN_SCH-27' replace='true'}{/capture}{grn_radio name='group' id='facility_group' value='facility_group' caption=$smarty.capture.grn_schedule_GRN_SCH_27 checked=$check_facility_group}
    </span>
<table cellspacing="0" cellpadding="0" border="0" class="inline_block_grn v_align_middle_grn">
  <tbody>
    <tr>
      <td>
        {include file="schedule/_item_add_dropdown_part.tpl" prefer_fg_button=1}
      </td>
    </tr>
  </tbody>
</table>

{* {include file="schedule/_select_group.tpl" is_set_portlet=true} *}
<script type="text/javascript">
<!--
{literal}

function ChangeITEM( form_name, obj )
{
    setFacilityGroupId( obj.fagid );
}

function setFacilityGroupId( fagid ) {
    document.getElementById( 'facility_group_id' ).value = 'f'+fagid;
}

{/literal}
-->
</script>
<input type="hidden" name="facility_group_id" id="facility_group_id" value="{$portlet.settings.gid}"></input>
</div>

{/if}

{if $mygroup_list}
<div class="margin_top" style="clear:left;">
{capture name='grn_schedule_portlet_GRN_SCH_PO_127'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-127' replace='true'}{/capture}{grn_radio name='group' id='mygroup' value='mygroup' caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_127 checked=$check_mygroup}
<select name="mygroup_id" onChange="this.form.elements['group']['mygroup'].checked=true">
 {foreach from=$mygroup_list key=key item=item}
<option value="{$key|escape}"{if $key == $portlet.settings.gid} selected{/if}>{$item|escape}</option>
 {/foreach}
</select>
</div>
{/if}

<div class="margin_top" style="clear:left;">
{if ! $set_organization_id || $is_candidate_organization}{assign var='disabled_organization' value=1}{/if}
{capture name='grn_schedule_portlet_GRN_SCH_PO_128'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-128' replace='true'}{/capture}{grn_radio name='group' id='organization' value='org' caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_128 checked=$check_organization disabled=$disabled_organization}
</div>

{literal}
<script language="JavaScript" type="text/javascript"><!--
function on_change_organization( hid )
{
    f = document.forms["{/literal}{$form_name}{literal}"];
    e = f.elements["gid"];
    e.value = hid;
    f.submit();
}
//--></script>
{/literal}
{include file="schedule/portlet/_organization_select.tpl"}

  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" name="apply" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-129' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-130' replace='true'}">
  </td>
 </tr>
</table>

</form>
