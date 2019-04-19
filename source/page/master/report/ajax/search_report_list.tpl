{if $link}
<div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item">
            {if $count_reports < 1}{assign var='export_disabled' value='true'}{/if}{capture name='grn_report_operation_r_output_CSV'}{cb_msg module='grn.report' key='r_output_CSV' replace='true'}{/capture}{grn_link page=$link caption=$smarty.capture.grn_report_operation_r_output_CSV image='export20.gif' cid=$category_id fid=$form_id disabled=$export_disabled tmp_key=$tmp_key}
        </span>
    </div>
</div>
{/if}
<div class="sub_title">
    {cb_msg module='grn.report' key='search_result' replace='true'}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}
</div>
<div class="navi">
    <div class="contents_navi">{include file="report/ajax/word_navi.tpl" navi=$navi.navi callback_func="pagingOnSearch" }</div>
</div>

<table class="list_column" width="100%" cellspacing="0" cellpadding="2">
    <colgroup>
        <col width="1%">
        <col width="25%">
        <col width="25%">
        <col width="14%">
        <col width="35%">
    </colgroup>
    <tr>
        <th></th>
        {if $sort == 'rnd'}
            {assign var=sort_image value="sortdown16.gif"}
            {assign var=sort_param value="rnu"}
        {elseif $sort == 'rnu'}
            {assign var=sort_image value="sortup16.gif"}
            {assign var=sort_param value="rnd"}
        {else}
            {assign var=sort_image value="sortdown16_n.gif"}
            {assign var=sort_param value="rnd"}
        {/if}
        <th>{cb_msg module='grn.report' key='GRN_RPRT-64' replace='true'}<a href="javascript:;" onclick="sortOnSearch('{$sort_param}');">{grn_image image=$sort_image}</a></th>
        {if $sort == 'cnd'}
            {assign var=sort_image value="sortdown16.gif"}
            {assign var=sort_param value="cnu"}
        {elseif $sort == 'cnu'}
            {assign var=sort_image value="sortup16.gif"}
            {assign var=sort_param value="cnd"}
        {else}
            {assign var=sort_image value="sortdown16_n.gif"}
            {assign var=sort_param value="cnd"}
        {/if}
        <th>{cb_msg module='grn.report' key='GRN_RPRT-65' replace='true'}<a href="javascript:;" onclick="sortOnSearch('{$sort_param}');">{grn_image image=$sort_image}</a></th>
        {if $sort == 'mtd'}
            {assign var=sort_image value="sortdown16.gif"}
            {assign var=sort_param value="mtu"}
        {elseif $sort == 'mtu'}
            {assign var=sort_image value="sortup16.gif"}
            {assign var=sort_param value="mtd"}
        {else}
            {assign var=sort_image value="sortdown16_n.gif"}
            {assign var=sort_param value="mtd"}
        {/if}
        <th>{cb_msg module='grn.report' key='GRN_RPRT-350' replace='true'}<a href="javascript:;" onclick="sortOnSearch('{$sort_param}');">{grn_image image=$sort_image}</a></th>
        <th>{cb_msg module='grn.report' key='GRN_RPRT-67' replace='true'}</th>
    </tr>
    {foreach from=$reports item=report}
        <tr>
            <td>
                {if $report.col_private}
                       {grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
                {/if}
               </td>
            <td>
                {if $from == 'system'}
                    {grn_link page='report/system/report_view' image='report20.gif' caption=$report.col_name cid=$report.col_category fid=$report.col_form rid=$report._id target="_blank"}
                {elseif $from == 'operation'}
                    {grn_link page='report/operation/report_view' image='report20.gif' caption=$report.col_name cid=$report.col_category fid=$report.col_form rid=$report._id target="_blank"}
                {else}
                    {if $report.col_draft == 0}
                        {grn_link page='report/view' caption=$report.col_name rid=$report._id target="_blank"}
                    {elseif $report.col_draft == 1}
                        {grn_link page='report/view_draft' caption=$report.col_name rid=$report._id target="_blank"}
                    {/if}
                {/if}
            </td>
            <td>{grn_user_name uid=$report.col_creator name=$report.col_creator_name truncated=$name_width users_info=$creators_info}</td>
            <td>{grn_date_format date=$report.mtime}</td>
            <td>{$report.col_form_name}</td>
        </tr>
    {/foreach}
</table>
<div class="navi">
    <div class="contents_navi">{include file="report/ajax/word_navi.tpl" navi=$navi.navi callback_func="pagingOnSearch" }</div>
</div>
<input type="hidden" id="tmp_key" name="tmp_key" value="{$tmp_key}">
