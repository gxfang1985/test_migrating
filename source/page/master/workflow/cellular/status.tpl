{include file="workflow/cellular/header.tpl"}
{strip}

{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-1' replace='true'}<br>
&nbsp;&nbsp;
{$path_step.col_role|escape}<br>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-2' replace='true'}<br>
&nbsp;&nbsp;
{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-3' replace='true'}
{else}
    {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
{/if}
<br>

<hr>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-4' replace='true'}<br>

{if count($users)}
    {foreach name=user from=$users item=user}
        {grn_workflow_cellular_pictogram key="person"}
        {$user.col_display_name|escape}<!--{$user.col_current_display_name|escape}--><br>
        {assign var=is_comment_detail value=false}{* コメント詳細無 *}
        {if GRN_WORKFLOW_RESULT_UNPROCESSING != $user.col_result}
            &nbsp;&nbsp;
            {cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}
            ({grn_date_format format='DateTimeShort_YMD_HM' date=$user.col_ptime})<br>
            {if $user.col_comment.current}
                &nbsp;&nbsp;
                {grn_workflow_cellular_pictogram key="pencil"}
                {$user.col_comment.current|grn_workflow_cellular_truncate:100|escape|nl2br}<br>
                {assign var=is_comment_detail value=true}{* コメント詳細有 *}
            {/if}
        {/if}
        {if 0 < $user.col_comment.log_total}
            {assign var=is_comment_detail value=true}{* コメント詳細有 *}
            {foreach from=$user.col_comment.logs item=log}
                {if $log.col_comment}
                {/if}
            {/foreach}
        {/if}
        
        {if $is_comment_detail}{* コメント詳細有無 *}
            <div align="right">
            {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_5'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-5' replace='true'}{/capture}{grn_workflow_cellular_link page="$pagepath/comment" caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_5 fid=$fid pid=$pid psid=$psid psuid=$user._id}
            </div>
        {/if}
        <br>
    {/foreach}
    {if $navi.previous_page_start_position != -1 || $navi.next_page_start_position != -1}
        {if $navi.previous_page_start_position != -1}
            <a href="{grn_workflow_cellular_pageurl page="$pagepath/status" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.workflow.cellular' key="previous_list"}</a>&nbsp;
        {/if}
        {if $navi.next_page_start_position != -1}
            <a href="{grn_workflow_cellular_pageurl page="$pagepath/status" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.workflow.cellular' key="next_list"}</a>
        {/if}
        <br>
        <br>
    {/if}
{else}
    {cb_msg module='grn.workflow' key='skip'}<br>
    <br>
{/if}

{grn_workflow_cellular_link page="$pagepath/look" accesskey=2 fid=$fid pid=$pid caption_module='grn.workflow.cellular' caption_key="link_back"}<br>

<hr>
{grn_workflow_cellular_link page="$pagepath/list" accesskey=3 fid=$fid caption_module='grn.workflow.cellular' caption_key="list"}<br>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
