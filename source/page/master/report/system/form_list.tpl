{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
    {if $category_id==GRN_REPORT_CATEGORY_NONPARTY_ID}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_23'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-23' replace='true'}{/capture}{grn_link page='report/system/form_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_23 image='report20.gif' cid=$category_id element_id="report/system/form_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_24'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-24' replace='true'}{/capture}{grn_link page='report/system/form_separator_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_24 image='write20.gif' cid=$category_id element_id="report/system/form_separator_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_25'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-25' replace='true'}{/capture}{grn_link page='report/system/category_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_25 image='category20.gif' cid=$category_id disabled=TRUE element_id="report/system/category_add"}</span>
    {elseif $category_id==GRN_REPORT_CATEGORY_ROOT_ID}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_26'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-26' replace='true'}{/capture}{grn_link page='report/system/form_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_26 image='report20.gif' cid=$category_id disabled=TRUE element_id="report/system/form_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_27'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-27' replace='true'}{/capture}{grn_link page='report/system/form_separator_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_27 image='write20.gif' cid=$category_id disabled=TRUE element_id="report/system/form_separator_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_28'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-28' replace='true'}{/capture}{grn_link page='report/system/category_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_28 image='category20.gif' cid=$category_id element_id="report/system/category_add"}</span>
    {else}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_29'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-29' replace='true'}{/capture}{grn_link page='report/system/form_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_29 image='report20.gif' cid=$category_id element_id="report/system/form_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_30'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-30' replace='true'}{/capture}{grn_link page='report/system/form_separator_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_30 image='write20.gif' cid=$category_id element_id="report/system/form_separator_add"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_31'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-31' replace='true'}{/capture}{grn_link page='report/system/category_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_31 image='category20.gif' cid=$category_id element_id="report/system/category_add"}</span>
    {/if}
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_report_system_GRN_RPRT_SY_32'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-32' replace='true'}{/capture}{grn_link image='delete20.gif' page='report/system/form_delete_all' cid=$category_id caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_32 disabled=$delete_disabled element_id="report/system/form_delete_all"}</span>
        <span class="menu_item">{if $category_id==GRN_REPORT_CATEGORY_ROOT_ID}{assign var='is_not_manage' value='true'}{/if}{capture name='grn_report_system_GRN_RPRT_SY_33'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-33' replace='true'}{/capture}{grn_link image='import20.gif' page='report/system/form_import' cid=$category_id caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_33 disabled=$is_not_manage element_id="report/system/form_import"}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_34'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-34' replace='true'}{/capture}{grn_link image='export20.gif' page='report/system/form_export' cid=$category_id caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_34 disabled=$delete_disabled element_id="report/system/form_export"}</span>
    </div>
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
{capture name='grn_report_system_GRN_RPRT_SY_35'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-35' replace='true'}{/capture}{grn_link image='detail20.gif' page='report/system/category_view' cid=$category_id caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_35 element_id="report/system/category_view"}
</div>
{if 0 < $category.memo|count_characters:true}
 {include file='grn/memo.tpl' category_memo=$category.memo}
{/if}
</div>

   <div class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-36' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_form_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="1%">
     <col width="70%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>{include file='grn/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
     <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-39' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-40' replace='true'}</th>
    </tr>
{foreach from=$form_list item=form}
    <tr valign="top">
     <td>
 {grn_checkbox name='ids[]' id="ids_`$form.fid`" value=$form.fid}
     </td>
 {if $form.type == 0}
     <td>
  {grn_link page='report/system/form_view' caption=$form.name truncated_caption=$config.subject_width image='report20.gif' cid=$category_id fid=$form.fid}
     </td>
     <td>
{if $form.active}
      <span class="font_green">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-41' replace='true'}</span>
{else}
      <span class="font_red">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-42' replace='true'}</span>
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
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-43' replace='true'}{capture name='grn_report_system_GRN_RPRT_SY_44'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-44' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_44 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" id="`$page_info.last`_submit_delete"}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-45' replace='true'}{capture name='grn_report_system_GRN_RPRT_SY_46'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-46' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_46 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" id="`$page_info.last`_submit_copy"}
   <input type="hidden" name="cid" value="{$category_id|escape}">
   <input type="hidden" name="fid" value="{$form_id|escape}">
   <input type="hidden" name="cmd" value="">
  </form>

</td>
</tr>
</table>

{include file="grn/system_footer.tpl"}
