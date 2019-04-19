{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
{if $category_id==GRN_REPORT_CATEGORY_ROOT_ID}
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_23'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-23' replace='true'}{/capture}{grn_link page='report/operation/form_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_23 image='report20.gif' cid=$category_id disabled=TRUE element_id="report/operation/form_add"}</span>
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_24'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-24' replace='true'}{/capture}{grn_link page='report/operation/form_separator_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_24 image='write20.gif' cid=$category_id disabled=true element_id="report/operation/form_separator_add"}</span>
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_25'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-25' replace='true'}{/capture}{grn_link page='report/operation/category_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_25 image='category20.gif' cid=$category_id disabled=$is_not_manage element_id="report/operation/category_add"}</span>
{else}
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_26'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-26' replace='true'}{/capture}{grn_link page='report/operation/form_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_26 image='report20.gif' cid=$category_id disabled=$is_not_manage element_id="report/operation/form_add"}</span>
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_27'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-27' replace='true'}{/capture}{grn_link page='report/operation/form_separator_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_27 image='write20.gif' cid=$category_id disabled=$is_not_manage element_id="report/operation/form_separator_add"}</span>
<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_28'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-28' replace='true'}{/capture}{grn_link page='report/operation/category_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_28 image='category20.gif' cid=$category_id disabled=$is_not_manage element_id="report/operation/category_add"}</span>
{/if}
<span class="menu_item">
{include file='report/operation/_form_display_options.tpl'}
</span>
</div>

{include file="report/_category_path.tpl" no_search=1}

<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">

 {include file="report/_category_structure.tpl" no_extra=1}

</td>
<td id="view_part" width="70%">

<div class="margin_bottom">
<div>
<span class="bold">{$category.name|escape}</span>
{capture name='grn_report_operation_GRN_RPRT_OP_32'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-32' replace='true'}{/capture}{grn_link image='detail20.gif' page='report/operation/category_view' cid=$category_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_32 element_id="report/operation/category_view"}
</div>
{if 0 < $category.memo|count_characters:true}
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}
</div>

   <div class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-33' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_form_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <div class="rp_list">
   <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="70%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>{include file='grn/checkall.tpl' form_name=$form_name elem_name='ids[]' checkall_disabled=$is_not_manage}</th>
     <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-36' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-37' replace='true'}</th>
    </tr>
{foreach from=$form_list item=form}
    <tr valign="top">
     <td>
 {grn_checkbox name='ids[]' id="ids_`$form.fid`" value=$form.fid checkall_disabled=$is_not_manage}
     </td>
 {if $form.type == 0}
     <td>
  {grn_link page='report/operation/form_view' caption=$form.name truncated_caption=$config.subject_width image='report20.gif' cid=$category_id fid=$form.fid}
     </td>
     <td>
{if $form.active}
      <span class="font_green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-38' replace='true'}</span>
{else}
      <span class="font_red">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-39' replace='true'}</span>
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
   </div>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi.navi}
     </div>
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-40' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_41'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-41' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_41 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" disabled=$is_not_manage id="`$page_info.last`_submit_delete"}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-42' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_43'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-43' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_43 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" disabled=$is_not_manage id="`$page_info.last`_submit_copy"}
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <input type="hidden" name="fid" value="{$form_id|escape}">
   <input type="hidden" name="cmd" value="">
  </form>

</td>
</tr>
</table>

{include file="grn/footer.tpl"}
