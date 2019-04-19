{include file="report/cellular/header.tpl"}
{strip}

{grn_report_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{if $report.enable_follow}
    {grn_report_cellular_link page="$pagepath/follow" rid="$rid" accesskey="1" caption_module='grn.report.cellular' caption_key="link_follow"}<br>
{/if}
{$report.form_name|escape}({$report.name|escape})<br>
<hr>
{* ------------------------------------------------------------------------ *}
{if $event}
  {cb_msg module='grn.report.cellular' key="associated_appointment"}<br />
  &nbsp;&nbsp;<a href="{grn_cellular_pageurl page="schedule/cellular/look1" eid=$eid day=$day mid=$mid}">{$event->getTitle()}</a><br />
{/if}
{grn_report_cellular_pictogram key="person"}
{cb_msg module='grn.report.cellular' key="report_creator_name"}<br>
&nbsp;&nbsp;{$report.creator_name|escape}
<br>

{grn_report_cellular_pictogram key="clock"}
{cb_msg module='grn.report.cellular' key="report_modify_time"}<br>
&nbsp;&nbsp;{grn_date_format format='DateTimeShort_YMD_HM' date=$report.mtime}<br>

{grn_report_cellular_pictogram key="joint"}
{cb_msg module='grn.report.cellular' key="report_notification"}<br />
{if $report.notification_num > 0}
&nbsp;&nbsp;<a href="{grn_cellular_pageurl page="report/cellular/notification" type=$type rid=$rid}">{$report.notification_num}{cb_msg module='grn.report.cellular' key='human_unit'}</a><br />
{else}
&nbsp;&nbsp;{$report.notification_num}{cb_msg module='grn.report.cellular' key='human_unit'}<br />
{/if}
<hr>

{if $report.enable_member}
    {cb_msg module='grn.report.cellular' key="reverse_triangle"}{cb_msg module='grn.report.cellular' key='report_member'}<br />
    {if $report.members_num > 0}
      &nbsp;&nbsp;<a href="{grn_cellular_pageurl page="report/cellular/member" type=$type rid=$rid}">{$report.members_num}{cb_msg module='grn.report.cellular' key='human_unit'}</a><br />
    {else}
      &nbsp;&nbsp;{$report.members_num}{cb_msg module='grn.report.cellular' key='human_unit'}<br />
    {/if}
{/if}

{if $report.enable_partner}
    {cb_msg module='grn.report.cellular' key="reverse_triangle"}{cb_msg module='grn.report.cellular' key='outside_parties' replace='true'}<br />
    {if $report.partners_num > 0}
      &nbsp;&nbsp;<a href="{grn_cellular_pageurl page="report/cellular/partner" type=$type rid=$rid}">{$report.partners_num}{cb_msg module='grn.report.cellular' key='human_unit'}</a><br />
    {else}
      &nbsp;&nbsp;{$report.partners_num}{cb_msg module='grn.report.cellular' key='human_unit'}<br />
    {/if}
{/if}

{if $item_data_list}
    <!-- {cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-9' replace='true'}<br> -->
    {foreach from=$item_data_list item=item}
        {if $item.type == 2}
            <br>
        {else}
            {$brtag|grn_noescape}
            {cb_msg module='grn.report.cellular' key="reverse_triangle"}
            {$item.display_name|escape}<br>
            &nbsp;&nbsp;
            {if $item.view_truncate}
                {$item.view_str|grn_report_cellular_truncate:100|escape|regex_replace:"/\r?\n/":"<br>&nbsp;&nbsp;"}
                <div align="right">
                {capture name='grn_report_cellular_GRN_RPRT_CELL_10'}{cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-10' replace='true'}{/capture}{grn_report_cellular_link page="$pagepath/detail" caption=$smarty.capture.grn_report_cellular_GRN_RPRT_CELL_10 type=$type rid=$rid iid=$item.iid}
                </div>                
            {else}
                {if $item.data_type == 'grn.report.date' && strlen($item.view_str) === 0}
                &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-400' replace='true'}
                &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-402' replace='true'}
                &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-404' replace='true'}
                {else}
                    {$item.view_str|escape|regex_replace:"/\r?\n/":"<br>&nbsp;&nbsp;"}
                {/if}
            {/if}
        {/if}
        <br>
    {/foreach}
    <hr>
{/if}

{* ------------------------------------------------------------------------ *}
{if count($follow_list) gt 0}
    <a name = "follow"></a>
    {foreach from=$follow_list item=follow}
        {grn_report_cellular_pictogram key="follow"}
        {grn_report_cellular_link page="$pagepath/follow_detail" type=$type rid=$rid follow_id=$follow.id caption=$follow.data|regex_replace:"/[ \t\r\n]/":""|default:"."|grn_report_cellular_truncate:$width}<br>
        {$follow.follow_id}{cb_msg module='grn.report.cellular' key='GRN_RPRT_CELL-11' replace='true'}{cb_date_format format='DateTimeCompact' date=$follow.ctime}&nbsp;{$follow.creator_name|escape}{if $follow.deletable}&nbsp;{grn_report_cellular_link page="$pagepath/delete" rid=$rid follow_id=$follow.id type=$type caption_module='grn.report.cellular' caption_key="link_delete"}{/if}<br>
    {/foreach}
    <br>
    {if $prev}
        {grn_report_cellular_link page="$pagepath/look" fp=$prev_page rid=$rid fragment="follow" caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
    {/if}
    {if $next}
        {grn_report_cellular_link page="$pagepath/look" fp=$next_page rid=$rid fragment="follow" caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
    <hr>
{/if}



{* ------------------------------------------------------------------------ *}
{grn_report_cellular_link page="$pagepath/list" accesskey=3 type=$type caption_module='grn.report.cellular' caption_key="list"}<br>
{grn_report_cellular_link page="$pagepath/search" accesskey=4 type=$type caption_module='grn.report.cellular' caption_key="search"}<br>

{/strip}
{include file="report/cellular/footer.tpl"}
