{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}

{if $private}
{assign var='public_tab_status' value='off'}
{assign var='private_tab_status' value='on'}
{capture name='public_tab_caption'}<a href="{grn_pageurl page='workflow/system/path_list'}">{grn_image image='public_path20.gif'}{cb_msg module='grn.workflow.system' key='w_shared_pathway' replace='true'}</a>{/capture}
{capture name='private_tab_caption'}{grn_image image='private_path20.gif'}{cb_msg module='grn.workflow.system' key='w_private_route_y' replace='true'}{/capture}
{else}
{assign var='public_tab_status' value='on'}
{assign var='private_tab_status' value='off'}
{capture name='public_tab_caption'}{grn_image image='public_path20.gif'}{cb_msg module='grn.workflow.system' key='w_shared_pathway' replace='true'}{/capture}
{capture name='private_tab_caption'}<a href="{grn_pageurl page='workflow/system/path_list' private=true}">{grn_image image='private_path20.gif'}{cb_msg module='grn.workflow.system' key='w_private_route_y' replace='true'}</a>{/capture}
{/if}
<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_workflow_system_w_add_shared_pathway'}{cb_msg module='grn.workflow.system' key='w_add_shared_pathway' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_add_shared_pathway page='workflow/system/path_add' image='write20.gif' disabled=$private}</span>
    <span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_add_separator_line page='workflow/system/path_separator_add' image='write20.gif' disabled=$private}</span>
    {if $private || 1 >= $path_count}
        {assign var='disabled' value=true}
    {/if}
    <span class="menu_item">{capture name='grn_workflow_system_w_move_pathway_separator_line'}{cb_msg module='grn.workflow.system' key='w_move_pathway_separator_line' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_move_pathway_separator_line page='workflow/system/path_order' image='order20.gif' disabled=$disabled}</span>
    {assign var='disabled' value=false}
    <div id="rare_menu_part_under">
        {if $private}
            {assign var='disabled' value=true}
        {/if}
            <span class="menu_item">{capture name='grn_workflow_system_w_input_XML'}{cb_msg module='grn.workflow.system' key='w_input_XML' replace='true'}{/capture}{grn_link page='workflow/system/path_import' caption=$smarty.capture.grn_workflow_system_w_input_XML image='import20.gif' disabled=$disabled}</span>
            {assign var='disabled' value=false}
        {if $private || 0 >= $path_count}
            {assign var='disabled' value=true}
        {/if}
        <span class="menu_item">{capture name='grn_workflow_system_w_output_XML'}{cb_msg module='grn.workflow.system' key='w_output_XML' replace='true'}{/capture}{grn_link page='workflow/system/path_export' caption=$smarty.capture.grn_workflow_system_w_output_XML image='export20.gif' disabled=$disabled}</span>
        {assign var='disabled' value=false}
    </div>
</div>
<div class="tab_menu">
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
   <td class="tab_left_{$public_tab_status}">&nbsp;</td>
   <td class="tab_{$public_tab_status}" style="font-size:11pt" nowrap>{$smarty.capture.public_tab_caption|grn_noescape}</td>
   <td class="tab_right_{$public_tab_status}" nowrap></td>
   <td>&nbsp;</td>
  </tr>
 </table>
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
   <td class="tab_left_{$private_tab_status}">&nbsp;</td>
   <td class="tab_{$private_tab_status}" style="font-size:11pt" nowrap>{$smarty.capture.private_tab_caption|grn_noescape}</td>
   <td class="tab_right_{$private_tab_status}" nowrap></td>
   <td>&nbsp;</td>
  </tr>
 </table>
</div>
<div class="tab_menu_end">&nbsp;</div>
<div class="clear_both_1px">&nbsp;</div>

<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/path_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="list_column" width="100%">
 <colgroup>
  <col width="1%">
  <col width="25%">
  <col width="15%">
  <col width="45%">
  <col width="15%">
 </colgroup>
 <tr>
  <th>{include file='workflow/checkall.tpl' form_name=$form_name elem_name='pids[]' disabled=$private}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_name_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_code' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_number_of_app_form_used_y' replace='true'}</th>
 </tr>
{foreach from=$paths key=path_id item=path}
 <tr valign="top">
  <td>{grn_checkbox name='pids[]' id="pids_`$path._id`" value=$path._id disabled=$private}</td>
 {if GRN_WORKFLOW_SEPARATOR == $path.col_type}
  <td colspan="4"><hr></td>
 {else}
  <td nowrap>
   {grn_link caption=$path.col_name page='workflow/system/path_view' pid=$path._id}
  </td>
  <td nowrap>{$path.col_foreign_key|escape}</td>
  <td nowrap>{$path.col_admin_memo|cb_mb_truncate:30|escape:"html"}</td>
  <td nowrap>{if ! $form_counts.$path_id}0{else}{$form_counts.$path_id}{/if}</td>
 {/if}
 </tr>
{/foreach}
</table>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'pids[]')) return false;" disabled=$private}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</form>

{include file='grn/system_footer.tpl'}
