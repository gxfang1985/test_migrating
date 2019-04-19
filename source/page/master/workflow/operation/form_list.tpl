{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
{if $category_id==GRN_WORKFLOW_CATEGORY_ROOT_ID}
<span class="menu_item">{capture name='grn_workflow_system_w_do_add_app_form_y'}{cb_msg module='grn.workflow.system' key='w_do_add_app_form_y' replace='true'}{/capture}{grn_workflow_link page='workflow/operation/form_add' caption=$smarty.capture.grn_workflow_system_w_do_add_app_form_y icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id disabled=true}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link page='workflow/operation/form_separator_add' caption=$smarty.capture.grn_workflow_system_w_add_separator_line image='write20.gif' cid=$category_id disabled=true}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_add_category'}{cb_msg module='grn.workflow.system' key='w_add_category' replace='true'}{/capture}{grn_link page='workflow/operation/category_add' caption=$smarty.capture.grn_workflow_system_w_add_category image='category20.gif' cid=$category_id disabled=$is_not_manage}</span>
{else}
<span class="menu_item">{capture name='grn_workflow_system_w_do_add_app_form_y'}{cb_msg module='grn.workflow.system' key='w_do_add_app_form_y' replace='true'}{/capture}{grn_workflow_link page='workflow/operation/form_add' caption=$smarty.capture.grn_workflow_system_w_do_add_app_form_y icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id disabled=$is_not_manage}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link page='workflow/operation/form_separator_add' caption=$smarty.capture.grn_workflow_system_w_add_separator_line image='write20.gif' cid=$category_id disabled=$is_not_manage}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_add_category'}{cb_msg module='grn.workflow.system' key='w_add_category' replace='true'}{/capture}{grn_link page='workflow/operation/category_add' caption=$smarty.capture.grn_workflow_system_w_add_category image='category20.gif' cid=$category_id disabled=$is_not_manage}</span>
{/if}
<span class="menu_item">
{include file='workflow/operation/_form_display_options.tpl'}
</span>
</div>

{include file="workflow/_category_path.tpl" no_search=1}

<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">

 {include file="workflow/_category_structure.tpl" no_extra=1}

</td>
<td id="view_part" width="70%">

<div class="margin_bottom">
<div>
<span class="bold">{$category.name|escape}</span>
{capture name='grn_workflow_system_w_detail_y'}{cb_msg module='grn.workflow.system' key='w_detail_y' replace='true'}{/capture}{grn_link image='detail20.gif' page='workflow/operation/category_view' cid=$category_id caption=$smarty.capture.grn_workflow_system_w_detail_y}
</div>
{if 0 < $category.memo|count_characters:true}
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}
</div>

   <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_form_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <div class="wf_path_table">
   <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="70%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>{include file='workflow/checkall.tpl' form_name=$form_name elem_name='ids[]' checkall_disabled=$is_not_manage}</th>
     <th nowrap>{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.workflow.system' key='w_valid_invalid_app_form_y' replace='true'}</th>
    </tr>
{foreach from=$form_list item=form}
    <tr valign="top">
     <td>
 {grn_checkbox name='ids[]' id="ids_`$form.fid`" value=$form.fid checkall_disabled=$is_not_manage}
     </td>
 {if $form.type == 0}
     <td>
  {grn_workflow_link page='workflow/operation/form_view' caption=$form.name truncated_caption=$config.subject_width icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id fid=$form.fid}
     </td>
     <td>
{if $form.active}
      <span class="font_green">{cb_msg module='grn.workflow.system' key='w_valid_y' replace='true'}</span>
{else}
      <span class="font_red">{cb_msg module='grn.workflow.system' key='w_invalid_y' replace='true'}</span>
{/if}
     </td>
 {else}
     <td colspan="2">
      <div class="border-partition-common-grn"></div>
     </td>
 {/if}
    </tr>
{/foreach}
   </table>
   </div>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi.navi}
     </div>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
{cb_msg module='grn.workflow.system' key='key_109_1' replace='true'}{capture name='grn_workflow_system_key_109_2'}{cb_msg module='grn.workflow.system' key='key_109_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_key_109_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='key_109_3' replace='true'}
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <input type="hidden" name="fid" value="{$form_id|escape}">
   <input type="hidden" name="cmd" value="">
  </form>

</td>
</tr>
</table>

{include file="grn/footer.tpl"}
