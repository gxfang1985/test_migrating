{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="main_menu_part">
    {if $category_id==GRN_REPORT_CATEGORY_ROOT_ID}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_306'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-306' replace='true'}{/capture}{grn_link page='report/system/filter_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_306 image='filter20.gif' cid=$category_id disabled=TRUE}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_307'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-307' replace='true'}{/capture}{grn_link page='report/system/filter_order' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_307 image='order20.gif' cid=$category_id disabled=TRUE}</span>
    {else}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_308'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-308' replace='true'}{/capture}{grn_link page='report/system/filter_add' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_308 image='filter20.gif' cid=$category_id}</span>
        {if $enableOrderChange}
            <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_309'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-309' replace='true'}{/capture}{grn_link page='report/system/filter_order' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_309 image='order20.gif' cid=$category_id}</span>
        {else}
            <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_310'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-310' replace='true'}{/capture}{grn_link page='report/system/filter_order' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_310 image='order20.gif' cid=$category_id disabled=TRUE}</span>
        {/if}
    {/if}
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_report_system_GRN_RPRT_SY_311'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-311' replace='true'}{/capture}{grn_link page='report/system/filter_delete_all' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_311 image='delete20.gif' cid=$category_id disabled=$delete_disabled}</span>
    </div>
</div>
<!--menubar_end-->

{include file="report/_category_path.tpl" no_search=1}

<table width="100%">
  <tr valign="top">
    <td id="tree_part" width="30%">
      <!--category_tree-->
      {include file="report/_category_structure.tpl" no_extra=1}
      <!--category_tree_end-->
    </td>
    <td id="view_part" width="70%">
      <!--report_list-->
      <div class="margin_vert">
        <span class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-312' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
      </div>

      <form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_filter_index'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
          <colgroup>
            <col width="1%">
            <col width="70%">
            <col width="30%">
          </colgroup>
          <tr>
            <th>{include file='grn/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
            <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-315' replace='true'}</th>
            <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-318' replace='true'}</th>
          </tr>
             {foreach from=$filters item=filter}
          <tr>
            <td>{grn_checkbox name='ids[]' id="ids_`$filter.fid`" value=$filter.fid}</td>
            <td>{grn_link page='report/system/filter_view' caption=$filter.name fid=$filter.fid}</td>
             <td>
              {if $filter.active}
              <span class="font_green">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-319' replace='true'}</span>
              {else}
              <span class="font_red">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-320' replace='true'}</span>
              {/if}
            </td>
          </tr>
          {/foreach}
        </table>
        <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
        {cb_msg module='grn.report.system' key='GRN_RPRT_SY-321' replace='true'}{capture name='grn_report_system_GRN_RPRT_SY_322'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-322' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_322 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';"}
        {cb_msg module='grn.report.system' key='GRN_RPRT_SY-323' replace='true'}{capture name='grn_report_system_GRN_RPRT_SY_324'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-324' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_324 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';"}
        <input type="hidden" name="cid" value="{$category_id|escape}">
        <input type="hidden" name="cmd" value="">
      </form>
    </td>
  </tr>
</table>  

{include file="grn/system_footer.tpl"}
