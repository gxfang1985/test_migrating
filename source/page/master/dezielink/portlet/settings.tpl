{if $error}
    {if $display eq 'set-personal'}
        {include file="grn/personal_head.tpl"}
        {include file="grn/personal_header.tpl"}
    {elseif $display eq 'set-operation'}
        {include file="grn/head.tpl"}
        {include file="grn/header.tpl"}
	{else}
        {include file='grn/system_head.tpl'}
        {include file='grn/system_header.tpl'}
    {/if}
    {grn_title title=$page_title class=$page_info.parts[0]}
    {assign var="form_name" value=$smarty.template|basename}
{/if}
<div class="explanation">{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-3' replace='true'}</div>
<p>
<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
{include file='grn/show_validation_errors.tpl'}
{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-4' replace='true'}<span class="attention">*</span>{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-5' replace='true'} 
<table class="std_form">
 <tr valign="top">
  <th nowrap valign="top">{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-6' replace='true'}<span class="attention">*</span></th>
  <td>
  {capture name='grn_dezielink_portlet_GRN_DZL_PO_7'}{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-7' replace='true'}{/capture}{validate form="dezielink/portlet/settings" field="params_url" criteria="notEmpty" message=$smarty.capture.grn_dezielink_portlet_GRN_DZL_PO_7 append="validation_errors"}
  {capture name='grn_dezielink_portlet_GRN_DZL_PO_8'}{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-8' replace='true'}{/capture}{validate form="dezielink/portlet/settings" field="params_url" criteria="isRegExp" expression="/\bpage=GRNTotalingView\b|\bpage=GRNView\b/i" message=$smarty.capture.grn_dezielink_portlet_GRN_DZL_PO_8 append="validation_errors"}
  {grn_text name="params_url" size=80  value=$portlet.settings maxlength="255" disable_return_key=true}<br>
  <div class="sub_explanation">
       {cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-9' replace='true'}</br>
            {cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-10' replace='true'}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input type="submit" name="apply" value="{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-11' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.dezielink.portlet' key='GRN_DZL_PO-12' replace='true'}">
  </td>
 </tr>
</table>
</form>
{if $error}
    {if $display eq 'set-personal'}
        {include file='grn/personal_footer.tpl'}
    {elseif $display eq 'set-operation'}
        {include file="grn/footer.tpl"}
    {else}
        {include file='grn/system_footer.tpl'}
    {/if}
{/if}