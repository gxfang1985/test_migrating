    <B>{$typename}</B><BR>
    {if $filter}
        {include file="report/_filter_view.tpl"}
    {/if}
    <div class="margin_vert">
        <span class="sub_title">
            {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}
        </span>
    </div>
    <TABLE class="list_column" width="100%">
        <TBODY>
            <TR>
                <TH width="1%" nowrap="">{capture name='grn_report_GRN_RPRT_348'}{cb_msg module='grn.report' key='GRN_RPRT-348' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_GRN_RPRT_348}</TH>
                <TH nowrap="">{cb_msg module='grn.report' key='GRN_RPRT-349' replace='true'}</TH>
                <TH nowrap="">{cb_msg module='grn.report' key='GRN_RPRT-350' replace='true'}</TH>
                <TH nowrap="">{cb_msg module='grn.report' key='GRN_RPRT-351' replace='true'}</TH>
            </TR>
            {foreach from=$reportList item=report}
                <TR>
                    <TD nowrap="" style="width: 1%; text-align: center;">
                        {if $report.private}
                            {capture name='grn_report_GRN_RPRT_352'}{cb_msg module='grn.report' key='GRN_RPRT-352' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_GRN_RPRT_352}
                        {/if}
                    </TD>
                    <TD>
                                    {if $report.draft}
                                        {grn_link page='report/view_draft' caption="`$report.name`" rid=$report.id}
                                    {else}
                                        {grn_link page='report/view' caption="`$report.name`" rid=$report.id}
                                    {/if}
                    </TD>
                    <TD nowrap="">{$report.date}</TD>
                    <TD nowrap="">
                        {grn_user_name uid=$report.creator name=$report.creator_name}
                    </TD>
                </TR>    
            {/foreach}
        </TBODY>
    </TABLE>
    <div class="navi">
    <div class="contents_navi">{include file="report/ajax/word_navi.tpl" navi=$navi.navi }</div>
    </div>
