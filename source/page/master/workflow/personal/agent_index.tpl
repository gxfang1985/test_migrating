{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
{if $substitute_application || $substitute_approval }
<span class="menu_item">{capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change_msg' replace='true'}{/capture}{grn_link page='workflow/personal/agent_modify' caption=$smarty.capture.grn_workflow_change image='modify20.gif'}</span>
{else}
<span class="menu_item"></span>
{/if}
</div>

<p>
<table class="view_table">
 <colgroup>
  <col width="30%">
  <col width="30%">
 </colgroup>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.workflow' key='col_agent_type_0' replace='true'}</th>
  <td >
   {if $substitute_application}
    {if $agent_list.0}
     {foreach from=$agent_list.0 key=agent_uid item=agent}
      <div>{if $agent}{grn_user_name uid=$agent.uid name=$agent.display_name}{else}{cb_msg module='grn.workflow.personal' key='unset' replace='true'}{/if}</div>
     {/foreach}
    {else}
     {cb_msg module='grn.workflow.personal' key='unset' replace='true'}
    {/if}
   {else}
    {cb_msg module='grn.workflow.personal' key='cannot_set' replace='true'}
   {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='col_agent_type_1' replace='true'}</th>
  <td>
   {if $substitute_approval}  
    {if $agent_list.1}
     {foreach from=$agent_list.1 key=agent_uid item=agent}
      <div>{if $agent}{grn_user_name uid=$agent.uid name=$agent.display_name}{else}{cb_msg module='grn.workflow.personal' key='unset' replace='true'}{/if}</div>
     {/foreach}
    {else}
     {cb_msg module='grn.workflow.personal' key='unset' replace='true'}
    {/if}
   {else}
    {cb_msg module='grn.workflow.personal' key='cannot_set' replace='true'}
   {/if}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
