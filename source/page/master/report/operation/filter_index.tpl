{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="main_menu_part">
{if $category_id==GRN_REPORT_CATEGORY_ROOT_ID}
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_279'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-279' replace='true'}{/capture}{grn_link page='report/operation/filter_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_279 image='filter20.gif' cid=$category_id disabled=TRUE}</span>
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_280'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-280' replace='true'}{/capture}{grn_link page='report/operation/filter_order' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_280 image='order20.gif' cid=$category_id disabled=TRUE}</span>
{else}
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_281'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-281' replace='true'}{/capture}{grn_link page='report/operation/filter_add' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_281 image='filter20.gif' cid=$category_id disabled=$is_not_manage}</span>
    {if $enableOrderChange}
        <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_282'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-282' replace='true'}{/capture}{grn_link page='report/operation/filter_order' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_282 image='order20.gif' cid=$category_id disabled=$is_not_manage}</span>
    {else}
        <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_283'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-283' replace='true'}{/capture}{grn_link page='report/operation/filter_order' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_283 image='order20.gif' cid=$category_id disabled=TRUE}</span>
    {/if}
{/if}
<span class="menu_item">
{include file='report/operation/_filter_display_options.tpl'}
</span>
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
    <!--filter_list-->
        <div class="margin_vert">
          <form name="{$form_name}_list_item" method="get" action="{grn_pageurl page='report/operation/filter_index'}">
            <input type="hidden" name="cid" value="{$category_id|escape}">
            <input type="hidden" name="fid" value="{$form_id|escape}">
            <span class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-285' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
          </form>
        </div>

        <form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_filter_index'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
          <table class="list_column" width="100%" cellspacing="0" cellpadding="2">
            <colgroup>
              <col width="1%">
              <col width="60%">
              <col width="40%">
            </colgroup>
            <tr>
              <th>{include file='grn/checkall.tpl' form_name=$form_name elem_name='ids[]' checkall_disabled=$is_not_manage}</th>
              <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-288' replace='true'}</th>
              <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-291' replace='true'}</th>
            </tr>
               {foreach from=$filters item=filter}
            <tr class="{cycle values='linetwo,lineone'}">
              <td>{grn_checkbox name='ids[]' id="ids_`$filter.fid`" value=$filter.fid checkall_disabled=$is_not_manage}</td>
              <td>{grn_link page='report/operation/filter_view' caption=$filter.name fid=$filter.fid}</td>
               <td>
                  {if $filter.active}
                <span class="font_green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-292' replace='true'}</span>
                {else}
                <span class="font_red">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-293' replace='true'}</span>
                {/if}
               </td>
            </tr>
            {/foreach}
          </table>
          <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
          {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-294' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_295'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-295' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_295 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" disabled=$is_not_manage}
          {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-296' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_297'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-297' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_297 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" disabled=$is_not_manage}
          <input type="hidden" name="cid" value="{$category_id|escape}">
          <input type="hidden" name="fid" value="{$form_id|escape}">
          <input type="hidden" name="cmd" value="">
        </form>
    <!--filter_list-->
    </td>
  </tr>
</table>  

{include file="grn/footer.tpl"}
