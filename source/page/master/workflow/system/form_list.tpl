{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
    {if $category_id==GRN_WORKFLOW_CATEGORY_NONPARTY_ID}
        <span class="menu_item">{capture name='grn_workflow_system_w_do_add_app_form_y'}{cb_msg module='grn.workflow.system' key='w_do_add_app_form_y' replace='true'}{/capture}{grn_workflow_link page='workflow/system/form_add' caption=$smarty.capture.grn_workflow_system_w_do_add_app_form_y icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id element_id='workflow/system/form_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link page='workflow/system/form_separator_add' caption=$smarty.capture.grn_workflow_system_w_add_separator_line image='write20.gif' cid=$category_id element_id='workflow/system/form_separator_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_category'}{cb_msg module='grn.workflow.system' key='w_add_category' replace='true'}{/capture}{grn_link page='workflow/system/category_add' caption=$smarty.capture.grn_workflow_system_w_add_category image='category20.gif' cid=$category_id disabled=TRUE element_id='workflow/system/category_add'}</span>
    {elseif $category_id==GRN_WORKFLOW_CATEGORY_ROOT_ID}
        <span class="menu_item">{capture name='grn_workflow_system_w_do_add_app_form_y'}{cb_msg module='grn.workflow.system' key='w_do_add_app_form_y' replace='true'}{/capture}{grn_workflow_link page='workflow/system/form_add' caption=$smarty.capture.grn_workflow_system_w_do_add_app_form_y icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id disabled=TRUE element_id='workflow/system/form_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link page='workflow/system/form_separator_add' caption=$smarty.capture.grn_workflow_system_w_add_separator_line image='write20.gif' cid=$category_id disabled=TRUE element_id='workflow/system/form_separator_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_category'}{cb_msg module='grn.workflow.system' key='w_add_category' replace='true'}{/capture}{grn_link page='workflow/system/category_add' caption=$smarty.capture.grn_workflow_system_w_add_category image='category20.gif' cid=$category_id element_id='workflow/system/category_add'}</span>
    {else}
        <span class="menu_item">{capture name='grn_workflow_system_w_do_add_app_form_y'}{cb_msg module='grn.workflow.system' key='w_do_add_app_form_y' replace='true'}{/capture}{grn_workflow_link page='workflow/system/form_add' caption=$smarty.capture.grn_workflow_system_w_do_add_app_form_y icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id element_id='workflow/system/form_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_separator_line'}{cb_msg module='grn.workflow.system' key='w_add_separator_line' replace='true'}{/capture}{grn_link page='workflow/system/form_separator_add' caption=$smarty.capture.grn_workflow_system_w_add_separator_line image='write20.gif' cid=$category_id element_id='workflow/system/form_separator_add'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_add_category'}{cb_msg module='grn.workflow.system' key='w_add_category' replace='true'}{/capture}{grn_link page='workflow/system/category_add' caption=$smarty.capture.grn_workflow_system_w_add_category image='category20.gif' cid=$category_id element_id='workflow/system/category_add'}</span>
    {/if}
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_delete_application_form_in_category'}{cb_msg module='grn.workflow.system' key='w_delete_application_form_in_category' replace='true'}{/capture}{grn_link image='delete20.gif' page='workflow/system/form_delete_all' cid=$category_id caption=$smarty.capture.grn_workflow_system_w_delete_application_form_in_category disabled=$delete_disabled element_id='workflow/system/form_delete_all'}</span>
        <span class="menu_item">{if $category_id==GRN_WORKFLOW_CATEGORY_ROOT_ID}{assign var='is_not_manage' value='true'}{/if}{capture name='grn_workflow_system_w_input_XML'}{cb_msg module='grn.workflow.system' key='w_input_XML' replace='true'}{/capture}{grn_link image='import20.gif' page='workflow/system/form_import' cid=$category_id caption=$smarty.capture.grn_workflow_system_w_input_XML disabled=$is_not_manage element_id='workflow/system/form_import'}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_output_XML'}{cb_msg module='grn.workflow.system' key='w_output_XML' replace='true'}{/capture}{grn_link image='export20.gif' page='workflow/system/form_export' cid=$category_id caption=$smarty.capture.grn_workflow_system_w_output_XML disabled=$delete_disabled element_id='workflow/system/form_export'}</span>
    </div>
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
{capture name='grn_workflow_system_w_detail_y'}{cb_msg module='grn.workflow.system' key='w_detail_y' replace='true'}{/capture}{grn_link image='detail20.gif' page='workflow/system/category_view' cid=$category_id caption=$smarty.capture.grn_workflow_system_w_detail_y element_id="workflow/system/category_view"}
</div>
{if 0 < $category.memo|count_characters:true}
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}
</div>

   <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_form_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="1%">
     <col width="70%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>{include file='workflow/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
     <th nowrap>{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.workflow.system' key='w_valid_invalid_app_form_y' replace='true'}</th>
    </tr>
{foreach from=$form_list item=form}
    <tr valign="top">
     <td>
 {grn_checkbox name='ids[]' id="ids_`$form.fid`" value=$form.fid}
     </td>
 {if $form.type == 0}
     <td>
  {grn_workflow_link page='workflow/system/form_view' caption=$form.name truncated_caption=$config.subject_width icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id fid=$form.fid}
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
      <hr>
     </td>
 {/if}
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi.navi}
     </div>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" id="`$page_info.last`_submit_delete"}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
{cb_msg module='grn.workflow.system' key='key_109_1' replace='true'}{capture name='grn_workflow_system_key_109_2'}{cb_msg module='grn.workflow.system' key='key_109_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_key_109_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" id="`$page_info.last`_submit_copy"}{cb_msg module='grn.workflow.system' key='key_109_3' replace='true'}
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <input type="hidden" name="fid" value="{$form_id|escape}">
   <input type="hidden" name="cmd" value="">
  </form>

</td>
</tr>
</table>

{include file="grn/system_footer.tpl"}
