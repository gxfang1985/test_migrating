    {if $filter}
        {include file="report/_filter_view.tpl"}
    {/if}
    {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
    <div class="contents_navi">{include file="report/ajax/smart_word_navi.tpl" navi_right=$smarty.capture.navi_right navi=$navi.navi}</div>    
    <table class="list_column" width="100%" id="report_list">
      <colgroup>
        <col width="1%" />
        {if $use_star}
        <col width="1%" />
        {/if}
        <col width="34%" />
        <col width="24%" />
        <col width="20%" />
        <col width="20%" />
      </colgroup>
        <tbody>
            <tr>
                <th width="1%">{capture name='grn_report_ajax_GRN_RPRT_AJAX_4'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-4' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_4}</th>
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
                {if $use_star}
                <th></th>
                {/if}
                <th>{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-5' replace='true'}<a href="javascript:;" onclick="{$sort_func}('{$sort_param}');">{grn_image image=$sort_image}</a></th>
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
                <th>{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-7' replace='true'}<a href="javascript:;" onclick="{$sort_func}('{$sort_param}');">{grn_image image=$sort_image}</a></th>
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
                <th>{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-6' replace='true'}<a href="javascript:;" onclick="{$sort_func}('{$sort_param}');">{grn_image image=$sort_image}</a></th>
                <th>{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-26' replace='true'}</th>
            </tr>
            {foreach from=$reportList item=report}
              {if $check_unread && ! $report.last_timestamp}
               {assign var=unread value=1}
              {else}
               {assign var=unread value=0}
              {/if}
              {if $check_unread && $report.otime > $report.last_timestamp}
               {assign var=modified value=1}
              {else}
               {assign var=modified value=0}
              {/if}
              {if $unread || $modified}
                <tr class="unread">
              {else}
                <tr class="{cycle values='linetwo,lineone'}">
              {/if}
                    <td nowrap="" style="width: 1%; text-align: center;">
                        {if $report.private}
                            {capture name='grn_report_ajax_GRN_RPRT_AJAX_8'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-8' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
                        {/if}
                    </td>
                    {if $use_star}
                    <td>
                       {grn_star_icon module="grn.report" star_infos=$star_infos unique_id=$report.id rid=$report.id }
                    </td>
                    {/if}
                    <td>
                        {if $report.draft}
                            {grn_link page='report/view_draft' caption="`$report.name`" truncated_caption=$subject_width rid=$report.id}
                        {else}
                            {grn_link page='report/view' caption="`$report.name`" truncated_caption=$subject_width rid=$report.id unread=$unread}
                        {/if}
                    </td>
                    <td nowrap="">
                        {grn_user_name uid=$report.creator name=$report.creator_name truncated=$name_width users_info=$users_info}
                    </td>
                    <td nowrap="">{grn_date_format date=$report.mtime}</td>
                    <td nowrap="">
                        {if $report.subscribe === "0"}
                            <div class="notify_off">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-27' replace='true'}</div>
                        {/if}
                    </td>
                </tr>    
            {/foreach}
        </tbody>
    </table>
    <div class="navi">
    <div class="contents_navi">{include file="report/ajax/word_navi.tpl" navi=$navi.navi }</div>
    </div>
