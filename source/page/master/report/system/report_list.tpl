{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="menu_part">
    <span class="menu_item">
        {if $navi.count < 1}{assign var='export_disabled' value='true'}{/if}{capture name='grn_report_operation_r_output_CSV'}{cb_msg module='grn.report' key='r_output_CSV' replace='true'}{/capture}{grn_link page='report/system/export' caption=$smarty.capture.grn_report_operation_r_output_CSV image='export20.gif' cid=$category_id fid=$form_id disabled=$export_disabled}
    </span>
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_report_system_GRN_RPRT_SY_366'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-366' replace='true'}{/capture}{grn_link page='report/system/report_delete_all' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_366 image='delete20.gif' cid=$category_id fid=$form_id disabled=$delete_disabled}</span>
    </div>
</div>
<!--menubar_end-->

<!--category_path-->
{if !$form_id}{assign var='search_disabled' value='true'}{/if}
{capture name='grn_report_system_GRN_RPRT_SY_367'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-367' replace='true'}{/capture}{include file="report/_category_path.tpl" search_action='report/system/report_search' app_name=$smarty.capture.grn_report_system_GRN_RPRT_SY_367 search_disabled=$search_disabled}
<!--category_path_end-->

<!--category_tree-->
<table width="100%">
 <tr valign="top">
  <td id="tree_part" width="30%">
{include file="report/_category_structure.tpl" no_extra=1}
<!--category_tree_end-->
<!--form_list-->
   <div class="border-partition-common-grn"></div>
   <div class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-368' replace='true'}</div>
{foreach from=$form_list item=form}
   <div class="tree_item">
 {capture name='suffix'}
  {if $form.deleted == 1}
   {cb_msg module='grn.report' key='[deleted]'}
  {elseif $form.active == 0}
   {cb_msg module='grn.report' key='[deactive]'}
  {/if}
 {/capture}
 {if $form.fid == $form_id}
   <nobr>{grn_image image='report20.gif'}<span style="background:#bbbbff"><span class="bold">{grn_sentence caption=$form.name|cat:$smarty.capture.suffix}</span></span>
   </nobr>
 {else}
  {if $form.type == 0}
    <nobr>{grn_link page='report/system/report_list' caption=$form.name|cat:$smarty.capture.suffix image='report20.gif' cid=$category_id fid=$form.fid}</nobr>
  {/if}
 {/if}
   </div>
{/foreach}
  </td>
<!--form_list_end-->

<!--report_list-->
  <td id="view_part" width="70%">
   {assign var="current_form" value=$form_list.$form_id}
   {if $current_form}
   <div class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$current_form.name}</div>
   {/if}
   <div class="margin_vert">
    <form name="{$form_name}_list_item" method="get" action="{grn_pageurl page='report/system/report_list'}">
     <input type="hidden" name="cid" value="{$category_id|escape}">
     <input type="hidden" name="fid" value="{$form_id|escape}">
     <span class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-369' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
    </form>
   </div>

   <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/report_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
     <colgroup>
      <col width="1%">
      <col width="1%">
      <col width="25%">
      <col width="40%">
      <col width="25%">
     </colgroup>
     <tr>
      <th>{include file='report/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
      <th>
          {grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
      </th>
      <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-372' replace='true'}</th>
{if $sort == 'unu'}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_373'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-373' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_373 page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 reverse=1}</th>
{elseif $sort == 'und'}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_374'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-374' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_374 page=$page_info.all cid=$category_id fid=$form_id sort='unu' sp=0 sf=2}</th>
{else}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_375'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-375' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_375 page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 disable=1}</th>
{/if}
{if $sort == 'mtu'}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_376'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-376' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_376 page=$page_info.all cid=$category_id fid=$form_id sort='mtd' sp=0 sf=2 reverse=1}</th>
{elseif $sort == 'mtd'}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_377'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-377' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_377 page=$page_info.all cid=$category_id fid=$form_id sort='mtu' sp=0 sf=2}</th>
{else}
      <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_378'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-378' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_system_GRN_RPRT_SY_378 page=$page_info.all cid=$category_id fid=$form_id sort='mtd' sp=0 sf=2 disable=1}</th>
{/if}
     </tr>
{foreach from=$report_list item=report}
     <tr valign="top">
      <td nowrap>{grn_checkbox name='ids[]' id="ids_`$report.rid`" value=$report.rid}</td>
      <td nowrap="" style="width: 1%; text-align: center;">
        {if $report.private}
          {grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
        {/if}
      </td>
      <td nowrap>
        {grn_link page='report/system/report_view' image='report20.gif' caption=$report.name truncated_caption=$subject_width cid=$category_id fid=$form_id rid=$report.rid}
      </td>
      <td nowrap>{grn_user_name uid=$report.creator name=$report.creator_name truncated=$name_width users_info=$creators_info}</td>
      <td nowrap>{grn_date_format date=$report.mtime}</td>
     </tr>
{/foreach}
    </table>
    <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-379' replace='true'}{capture name='grn_report_system_GRN_RPRT_SY_380'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-380' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_380 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}
    <input type="hidden" name="cid" value="{$category_id|escape}">
    <input type="hidden" name="fid" value="{$form_id|escape}">
   </form>
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
