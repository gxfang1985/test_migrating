{include file="workflow/cellular/header.tpl"}
{strip}

{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{assign var=process value=null}

{* ------------------------------------------------------------------------ *}
{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-6' replace='true'} -->
    {assign var=process value='confirmation'}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-7' replace='true'}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-8' replace='true'}{$petition.transactor_name|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-9' replace='true'}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-10' replace='true'}{grn_workflow_cellular_string_split string=$petition.comment page_paraname="bp"}<br>
    <hr>
{elseif GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-11' replace='true'} -->
    {assign var=process value='confirmation'}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-12' replace='true'}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-13' replace='true'}{$petition.transactor_name|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-14' replace='true'}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-15' replace='true'}{grn_workflow_cellular_string_split string=$petition.comment page_paraname="bp"}<br>
    <hr>
{elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-16' replace='true'} -->
    {if 'confirm' == $handle_mode}
        {assign var=process value='confirmation'}
    {/if}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-17' replace='true'}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-18' replace='true'}{$petition.transactor_name|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-19' replace='true'}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-20' replace='true'}{grn_workflow_cellular_string_split string=$petition.comment page_paraname="bp"}<br>
    <hr>

{elseif 'change_transactor' == $handle_mode}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-21' replace='true'} -->
    {assign var=process value='confirmation'}
    {assign var=path_step_id value=$change_path_history.col_path_step_data}
    {assign var=path_step value=$path_steps.$path_step_id}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-22' replace='true'}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-23' replace='true'}{$change_path_history.col_creator_name|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-24' replace='true'}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$change_path_history.col_ctime}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-25' replace='true'}{$path_step.col_role|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-26' replace='true'}
    {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
        {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-27' replace='true'}<br>
    {else}
        {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}<br>
    {/if}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-28' replace='true'}<br>
    {foreach from=$change_path_history.add_users item=user}
        &nbsp;&nbsp;{$user.col_display_name|escape}<br>
    {/foreach}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-29' replace='true'}<br>
    {foreach from=$change_path_history.deleted_users item=user}
        &nbsp;&nbsp;{$user.col_display_name|escape}<br>
    {/foreach}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-30' replace='true'}{grn_workflow_cellular_string_split string=$change_path_history.col_comment page_paraname="bp"}<br>
    <hr>

{elseif 'reapply' == $handle_mode}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-31' replace='true'} -->
    {assign var=process value='confirmation'}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-32' replace='true'}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-33' replace='true'}{$petition.user_name|escape}<br>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-34' replace='true'}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}<br>
    <hr>

{elseif 'confirm' == $handle_mode}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-35' replace='true'} -->
    {assign var=process value='confirmation'}
    {if $error}
        {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-36' replace='true'}
        <hr>
    {/if}

{else}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-37' replace='true'} -->
{/if}

{if GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID == $folder.col_folder_type}
  {if $process == 'confirmation'}
    {if 'view_only' != $handle_mode}
        {* 確認 *}
        {grn_workflow_cellular_form name=$form_name method="post" page="$pagepath/command_handle" fid=$fid pid=$pid comment="" in_process=$in_process}
        {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_38'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-38' replace='true'}{/capture}{grn_workflow_cellular_submit name='confirmation' caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_38}<br>
        </form><hr>
    {/if}
  {/if}
{/if}

{* ------------------------------------------------------------------------ *}
{if GRN_WORKFLOW_STATUS_REJECTION > $petition.status}
    {if ! $handle_mode}
        {* 承認 *}
        {if GRN_WORKFLOW_ACCEPTANCE == $path_steps.$in_process.col_type}
            {assign var=process value='acceptance'}
        {else}
            {assign var=process value='circular'}
        {/if}
    {/if}
{elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
    {* 差し戻し *}
    {if ! $handle_mode && 'view_only' != $handle_mode}
        {if ! $in_process && $user_id == $petition.creator}
            {* 申請者本人に差し戻し *}
            {assign var=process value='creator_remand'}
        {else}
            {* 途中ステップに差し戻し *}
            {if GRN_WORKFLOW_ACCEPTANCE == $path_steps.$in_process.col_type}
                {assign var=process value='acceptance'}
            {else}
                {assign var=process value='circular'}
            {/if}
        {/if}
    {/if}
{/if}

{if $process && $is_files}
    {assign var=process value='is_files'}
{/if}

{if GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID != $folder.col_folder_type}
    {assign var=process value='null'}
{/if}


{* ------------------------------------------------------------------------ *}
{capture name=validate_message_emoji}
    {cb_msg module='grn.workflow.cellular' key="validate_message_emoji"}<a href="#_handle">{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-39' replace='true'}</a><br>
    <hr>
{/capture}
{validate form=$form_name field="comment" criteria="grn_workflow_cellular_notEmoji" message=$smarty.capture.validate_message_emoji}

{capture name=validate_message_length}
    {cb_msg module='grn.workflow.cellular' key="validate_message_length"}<a href="#_handle">{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-40' replace='true'}</a><br>
    <hr>
{/capture}
{validate form=$form_name field="comment" criteria="grn_workflow_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_length}

{capture name=validate_message_remand_empty}
    {cb_msg module='grn.workflow.cellular' key="validate_message_remand_empty"}<a href="#_handle">{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-41' replace='true'}</a><br>
    <hr>
{/capture}
{validate form=$form_name field="destination" criteria="notEmpty" message=$smarty.capture.validate_message_remand_empty}

{* ------------------------------------------------------------------------ *}
{if $view}
{* ------------------------------------------------------------------------ *}
{if $petition.priority == 0}
{else}
{grn_workflow_cellular_pictogram key="priority"}{grn_workflow_cellular_priority value=$petition.priority}<br>
{/if}
{grn_workflow_cellular_pictogram key="id"}
{cb_msg module='grn.workflow.cellular' key="petition_number"}<br>
&nbsp;&nbsp;{$petition.petition_number|escape}<br>

{grn_workflow_cellular_pictogram key="person"}
{cb_msg module='grn.workflow.cellular' key="petition_creator_name"}<br>
&nbsp;&nbsp;{$petition.user_name|escape}
{if $petition.agent_user}
<br>
&nbsp;&nbsp;{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-42' replace='true'}{$petition.agent_user_name|escape})
{/if}
<br>

{grn_workflow_cellular_pictogram key="clock"}
{cb_msg module='grn.workflow.cellular' key="petition_create_time"}<br>
&nbsp;&nbsp;{grn_date_format format='DateTimeShort_YMD_HM' date=$petition.ctime}<br>

{cb_msg module='grn.workflow.cellular' key="reverse_triangle"}
{cb_msg module='grn.workflow.cellular' key="petition_form_name"}<br>
&nbsp;&nbsp;{$petition.form_name|escape}({$petition.name|escape})<br>

{if $user_id == $petition.user ||
    $user_id == $petition.agent_user
}
  {if GRN_WORKFLOW_FOLDER_TYPE_OUT_ID == $folder.col_folder_type}
    {* 送信一覧のみ 取り消しリンク *}
    {if GRN_WORKFLOW_STATUS_UNPROCESSING == $petition.status}
        <div align="right">{capture name='grn_workflow_cellular_GRN_GR_WKF_CE_43'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-43' replace='true'}{/capture}{grn_workflow_cellular_link page="$pagepath/cancel" caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_43 fid=$fid pid=$pid}</div>
    {elseif GRN_WORKFLOW_STATUS_IN_PROCESS == $petition.status}
        <div align="right">{capture name='grn_workflow_cellular_GRN_GR_WKF_CE_44'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-44' replace='true'}{/capture}{grn_workflow_cellular_link page="$pagepath/cancel" caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_44 fid=$fid pid=$pid}</div>
    {/if}
  {/if}
{/if}
<hr>

{if $item_data_list}
    <!-- {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-45' replace='true'}<br> -->
    {assign var=brtag value=""}
    {foreach from=$item_data_list item=item}
        {if $item.type == 2}
            <br>
        {else}
            {if $item.br != 0}
              {$brtag|grn_noescape}
              {cb_msg module='grn.workflow.cellular' key="reverse_triangle"}
              {$item.display_name|escape}<br>
              &nbsp;&nbsp;
            {else}
              {$item.separator|escape}
            {/if}
            {assign var=brtag value=""}
            {if $item.view_truncate}
                {$item.view_str|grn_workflow_cellular_truncate:100|escape|regex_replace:"/\r?\n/":"<br>&nbsp;&nbsp;"}
                <div align="right">
                {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_46'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-46' replace='true'}{/capture}{grn_workflow_cellular_link page="$pagepath/detail" caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_46 fid=$fid pid=$pid iid=$item.iid}
                </div>
            {else}
                {$item.view_str|escape|regex_replace:"/\r?\n/":"<br>&nbsp;&nbsp;"}
                {assign var=brtag value="<br>"}
            {/if}
        {/if}
    {/foreach}
    {$brtag|grn_noescape}
    <hr>
{/if}

{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-47' replace='true'}<br>
{foreach name=path_step from=$path_steps item=path_step}
    {if $path_step.col_activate}
        {* 状況アイコン *}
        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}
            {if $path_step.in_process}
                {cb_msg module='grn.workflow.cellular' key="red_arrow"}
            {else}
                {cb_msg module='grn.workflow.cellular' key="quadrangle"}
            {/if}
        {else}
            {cb_msg module='grn.workflow.cellular' key="quadrangle"}
        {/if}
        {* 経路ステップ名 *}
        {grn_workflow_cellular_link page="$pagepath/status" fid=$fid pid=$pid psid=$path_step._id caption=$path_step.col_role}
        <br>
        {* 経路種別 *}
        {cb_msg module='grn.workflow.cellular' key="tree_lastbranch"}
        {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
            {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-48' replace='true'}
        {else}
            {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
        {/if}
        {* コメント有無 *}
        {assign var=step_comment value=false}
        {foreach name=user from=$path_step.users item=user}
            {if $user.col_comment.current}
                {assign var=step_comment value=true}
            {/if}
            {if 0 < $user.col_comment.log_total}
                {foreach from=$user.col_comment.logs item=log}
                    {if $log.col_comment}
                        {assign var=step_comment value=true}
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
        {if $step_comment}
            {grn_workflow_cellular_pictogram key="pencil"}
        {/if}
        <br>
    {/if}
{/foreach}
<hr>
{* ------------------------------------------------------------------------ *}
{/if}
{* ------------------------------------------------------------------------ *}

{if $process == 'acceptance'}
    {* 承認 *}
    <a name="_handle"></a>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-49' replace='true'}<br>
    {grn_workflow_cellular_form name=$form_name method="post" page="$pagepath/command_handle" fid=$fid pid=$pid in_process=$in_process}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-50' replace='true'}<br>
    <textarea name="comment" cols=16 rows=3 istyle="1" mode="hiragana">{$comment|escape}</textarea><br>
    {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_51'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-51' replace='true'}{/capture}{grn_workflow_cellular_submit name='acceptance' caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_51}<br>
    {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_52'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-52' replace='true'}{/capture}{grn_workflow_cellular_submit name='reject'     caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_52}<br>
    {if $is_remand}
     {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-53' replace='true'}<br>
     <select name="destination">
     {html_options options=$remand_options}
     </select><br>
     {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-54' replace='true'}{capture name='grn_workflow_cellular_GRN_GR_WKF_CE_55'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-55' replace='true'}{/capture}{grn_workflow_cellular_submit name='remand'  caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_55}<br>
    {/if}
    </form><hr>
{elseif $process == 'circular'}
    {* 回覧の確認 *}
    <a name="_handle"></a>
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-56' replace='true'}<br>
    {grn_workflow_cellular_form name=$form_name method="post" page="$pagepath/command_handle" fid=$fid pid=$pid in_process=$in_process}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-57' replace='true'}<br>
    <textarea name="comment" cols=16 rows=3 istyle="1" mode="hiragana">{$comment|escape}</textarea><br>
    {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_58'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-58' replace='true'}{/capture}{grn_workflow_cellular_submit name='confirmation' caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_58}<br>
    </form><hr>
{elseif $process == 'creator_remand'}
    {* 申請者本人に差し戻し *}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-59' replace='true'}<br>
{*
    {if GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID == $folder.col_folder_type}
        {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-60' replace='true'}<br>
        {grn_workflow_cellular_form name="$pagepath/cancel" method="post" page="$pagepath/command_cancel" fid=$fid pid=$pid comment=""}
        {capture name='grn_workflow_cellular_GRN_GR_WKF_CE_61'}{cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-61' replace='true'}{/capture}{grn_workflow_cellular_submit name='cancel' caption=$smarty.capture.grn_workflow_cellular_GRN_GR_WKF_CE_61}<br>
    {/if}
*}
    <hr>
{elseif $process == 'is_files'}
    {* 添付ファイル有り申請 *}
    {cb_msg module='grn.workflow.cellular' key='GRN_GR_WKF_CE-62' replace='true'}<br>
    <hr>
{/if}


{grn_workflow_cellular_link page="$pagepath/list" accesskey=3 fid=$fid caption_module='grn.workflow.cellular' caption_key="list"}<br>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
