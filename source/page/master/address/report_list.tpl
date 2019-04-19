{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_title title=$card.subject class=$page_info.parts[0]}

{capture name="navi_right"}{include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
<div class="contents_navi">{include file="grn/smart_word_navi.tpl" navi_right=$smarty.capture.navi_right navi=$navi.navi}</div>

<table class='list_column'>
    <colgroup>
        <col width="33%" />
        <col width="33%" />
        <col width="33%" />
    </colgroup>
    <tbody>
        <tr>
            <th nowrap="">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-5' replace='true'}</th>
            <th nowrap="">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-7' replace='true'}</th>
            {if $sort=='mtd'}
            <th nowrap="">{capture name='grn_report_ajax_GRN_RPRT_AJAX_6'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-6' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_6 page=$page_info.all bid=$book_id cid=$card_id sort='mtu' sp=$navi.start_count-1 reverse=0}</th>
            {else}
            <th nowrap="">{capture name='grn_report_ajax_GRN_RPRT_AJAX_6'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-6' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_6 page=$page_info.all bid=$book_id cid=$card_id sort='mtd' sp=$navi.start_count-1 reverse=1}</th>
            {/if}
        </tr>
        {foreach from=$report_list item=report}
        <tr class="{cycle values='linetwo,lineone'}">
            <td>{grn_link page='report/view' caption="`$report.name`" image='report20.gif' truncated_caption=$subject_width rid=$report.rid}</td>
            <td nowrap="">{grn_user_name uid=$report.creator name=$report.creator_name users_info=$creators_info}</td>
            <td nowrap="">{grn_date_format date=$report.mtime}</td>
        </tr>
        {/foreach}
    </tbody>
</table>

<div class="navi">
    <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi }</div>
</div>

{include file="grn/footer.tpl"}
