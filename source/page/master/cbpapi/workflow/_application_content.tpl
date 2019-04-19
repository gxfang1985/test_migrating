{capture name="form_name"}{grn_papi_text_format value=$application.form_name}{/capture}
{capture name="application_name"}{grn_papi_text_format value=$application.name}{/capture}
<application id="{$application.id}" name="{$smarty.capture.form_name|grn_noescape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$smarty.capture.application_name|grn_noescape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}" {grn_attr name="processing_step" value=$application.processing_step require=true}
{if GRN_WORKFLOW_STATUS_UNPROCESSING == $application.status || GRN_WORKFLOW_STATUS_IN_PROCESS == $application.status
                        || GRN_WORKFLOW_STATUS_REMAND == $application.status }
            status="{cb_msg module='grn.workflow' key="view_status_0"}"
{elseif GRN_WORKFLOW_STATUS_ACCEPTANCE == $application.status }
            status="{cb_msg module='grn.workflow' key="view_status_1"}"
{elseif GRN_WORKFLOW_STATUS_REJECTION == $application.status }
            status="{cb_msg module='grn.workflow' key="view_status_2"}"
{elseif GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $application.status || GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $application.status}
            status="{cb_msg module='grn.workflow' key="view_status_3"}"
{elseif GRN_WORKFLOW_STATUS_FINISHED == $application.status }
            status="{cb_msg module='grn.workflow' key="view_status_4"}"
{/if}
{if $application.priority} urgent="true" {else} urgent="false" {/if} version="{$application.version}"
    {grn_attr name="number" value=$application.petition_number} {grn_attr name="date" value=$application.ctime require=true} 
    {grn_attr name="status_type" value=$application.status_type require=true}>
    
      <applicant xmlns="http://schemas.cybozu.co.jp/workflow/2008" 
        {grn_attr name="id" value=$application.user}
        {grn_attr name="name" value=$application.user_name require=true}>
        {if $application.agent_user || $application.agent_user_name}
            <proxy {grn_attr name="id" value=$application.agent_user}
                   {grn_attr name="name" value=$application.agent_user_name require=true} />
        {/if}
      </applicant>
      <items xmlns="http://schemas.cybozu.co.jp/workflow/2008">
      {foreach from=$application.items item=item}
            {if $item.type == 2}
                <blank_item />
            {else}
                {if $item.foreign_key == 'grn.workflow.file' }
                    {if $item.view_mode != 'disable'}
                        <files_item {grn_attr name="name" value=$item.display_name require=true}
                                          {if $item.settings.inline == 1}inline="true"{else}inline="false"{/if}>
                            {*File list*}
                            {if is_array($item.files) && count($item.files) > 0 }
                                {foreach from=$item.files item=file}
                                    <file file_id="{$file.ifid}" {grn_attr name="name" value=$file.name require=true}
                                            {grn_attr name="size" value=$file.size}
                                            {grn_attr name="mime_type" value=$file.mime} />
                                {/foreach}
                            {/if}
                        </files_item>
                    {/if}
                {else}
                    <item {grn_attr name="name" value=$item.display_name require=true}
                          {grn_attr name="value" value=$item.view_str|regex_replace:'/^\s+|\s+$/':'' require=true}
                               {if $item.right_align_flag}right_align="true"{else}right_align="false"{/if}
                   />
                {/if}
            {/if}
      {/foreach}
      </items>
      <steps xmlns="http://schemas.cybozu.co.jp/workflow/2008">
      {foreach from=$application.path_steps item=step}
        {if $step.col_activate}
        <step id="{$step._id}" {grn_attr name="name" value=$step.col_role require=true}
            {if GRN_WORKFLOW_CIRCULAR == $step.col_type} 
                type="{cb_msg module='grn.workflow' key="pass_along"}" {grn_attr name="is_approval_step" value="0"}
            {else}
                type="{cb_msg module='grn.workflow' key="col_acceptance_type_`$step.col_acceptance_type`"}" {grn_attr name="is_approval_step" value="1"} 
             {/if}
            >
            {if $step.col_skip }
                <processor id="0" processor_name="{cb_msg module='grn.workflow' key='skip'}" result="{cb_msg module='grn.workflow' key='skip_result'}" />
            {elseif is_array($step.users) && count($step.users) > 0 }
                {foreach from=$step.users item=user}
                    {capture name='result'}{cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}{/capture}
                    <processor {grn_attr name="id" value=$user._id}
                                {grn_attr name="processor_name" value=$user.col_display_name require=true}
                                {grn_attr name="result" value=$smarty.capture.result }
                                {grn_attr name="date" value=$user.col_ptime} {strip}
                                {if 0 < strlen($user.col_comment.current)}
                                    {assign var="comment" value=$user.col_comment.current}
                                    {if 0 < $user.col_comment.log_total}
                                        {foreach from=$user.col_comment.logs item=log name=loops}
                                            {capture name="operation_date"}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime}{/capture}
                                            {capture name="operation"}{cb_msg module='grn.workflow' key="col_result_`$log.col_result`"}{/capture}
                                            {capture name="more_info"}{strip}
                                                {if GRN_WORKFLOW_RESULT_REMAND != $log.col_result}
                                                    {if $log.col_agent}
                                                        {cb_msg module='grn.workflow' key="per_pro_accept_bracket"}{$log.col_agent_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                    {/if}
                                                {else}
                                                    {if $log.col_agent}
                                                        {cb_msg module='grn.workflow' key="per_pro_accept_bracket"}{$log.col_agent_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                    {/if}
                                                    {if 'applicant' == $log.destination}{cb_msg module='grn.workflow' key="applicant_bracket_arrow"}
                                                    {else}
                                                    {assign var='destination' value=$log.destination}
                                                    {cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{$application.path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                    {/if}
                                                {/if}
                                            {/strip}{/capture}
                                            {assign var="comment" value=$comment|cat:"\n"|cat:$smarty.capture.operation_date|cat:" "|cat:$smarty.capture.operation}
                                            {if 0 < strlen($smarty.capture.more_info) }
                                                {assign var="comment" value=$comment|cat:" "}
                                            {/if}
                                            {assign var="comment" value=$comment|cat:$smarty.capture.more_info}
                                            {if 0 < strlen($log.col_comment)}
                                                {assign var="comment" value=$comment|cat:"\n"|cat:$log.col_comment}
                                            {/if}
                                            {if !$smarty.foreach.loop1.last}
                                                {assign var="comment" value=$comment|cat:"\n"}
                                            {/if}
                                        {/foreach}
                                   {/if}
                                   {grn_attr name="comment" value=$comment }
                               {else}
                                {if 0 < $user.col_comment.log_total}
                                    {assign var="comment" value=""}
                                    {foreach from=$user.col_comment.logs item=log name=loop2}
                                        {capture name="operation_date"}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime}{/capture}
                                        {capture name="operation"}{cb_msg module='grn.workflow' key="col_result_`$log.col_result`"}{/capture}
                                        {capture name="more_info"}{strip}
                                            {if GRN_WORKFLOW_RESULT_REMAND != $log.col_result}
                                                {if $log.col_agent}
                                                    {cb_msg module='grn.workflow' key="per_pro_accept_bracket"}{$log.col_agent_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                {/if}
                                            {else}
                                                {if $log.col_agent}
                                                    {cb_msg module='grn.workflow' key="per_pro_accept_bracket"}{$log.col_agent_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                {/if}
                                                {if 'applicant' == $log.destination}{cb_msg module='grn.workflow' key="applicant_bracket_arrow"}
                                                {else}
                                                {assign var='destination' value=$log.destination}
                                                {cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{$application.path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                {/if}
                                            {/if}
                                        {/strip}{/capture}
                                        {assign var="comment" value=$comment|cat:$smarty.capture.operation_date|cat:" "|cat:$smarty.capture.operation}
                                        {if 0 < strlen($smarty.capture.more_info) }
                                            {assign var="comment" value=$comment|cat:" "}
                                        {/if}
                                        {assign var="comment" value=$comment|cat:$smarty.capture.more_info}
                                        {if 0 < strlen($log.col_comment)}
                                            {assign var="comment" value=$comment|cat:"\n"|cat:$log.col_comment}
                                        {/if}
                                        {if !$smarty.foreach.loop2.last}{assign var="comment" value=$comment|cat:"\n"}{/if}
                                    {/foreach}
                                    {grn_attr name="comment" value=$comment }
                                {/if}
                               {/if}
                               {/strip} >
                    {if $user.col_agent_user || $user.col_agent_display_name}
                        <proxy {grn_attr name="id" value=$user.col_agent_user}
                               {grn_attr name="processor_name" value=$user.col_agent_display_name require=true }/>
                    {/if}
                </processor>
            {/foreach}
            {/if}
        </step>
        {/if}
        {/foreach}
      </steps>
    
    {*{if GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID == $application.folder_type }*}
    {if $application.has_operation }
        {if GRN_WORKFLOW_STATUS_REJECTION > $application.status}
            {if ! $application.operation_mode}
                {if GRN_WORKFLOW_ACCEPTANCE == $application.path_steps[$application.processing_step].col_type}
                    {if 'view_only' != $application.operation_mode}
                        <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><approve /></operation>
                        <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><reject /></operation>
                        {if $application.is_remand}
                        <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><sent_back><applicant/>
                        {foreach from=$application.path_steps item=step}
                            {if $step.col_activate}
                                {if 0 < strlen($step.send_back)}
                                   <step {grn_attr name="step_id" value=$step.send_back require=true}/>
                               {/if}
                            {/if}
                        {/foreach}
                        </sent_back></operation>
                        {/if}
                    {/if}
                {else}
                    {if 'view_only' != $application.operation_mode}
                        <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><confirm /></operation>
                    {/if}
                {/if}
            {elseif $application.operation_mode == 'confirm'}  
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><acknowledge /></operation>
            {/if}
        {elseif GRN_WORKFLOW_STATUS_REMAND == $application.status}
            {if 'confirm' == $application.operation_mode || 'reapply' == $application.operation_mode}
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><confirm /></operation>
            {/if}
            {if !$application.operation_mode && 'view_only' != $application.operation_mode}
                {if !$application.processing_step && ($application.login_id == $application.user || $application.login_id == $application.agent_user) }
                   {*<operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><cancel /></operation>*}
                {else}
                    <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><approve /></operation>
                    <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><reject /></operation>
                    {if $application.is_remand}
                        <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><sent_back><applicant/>
                        {foreach from=$application.path_steps item=step}
                            {if $step.col_activate}
                            {if 0 < strlen($step.send_back)}
                                <step {grn_attr name="step_id" value=$step.send_back require=true}/>
                            {/if}
                            {/if}
                        {/foreach}
                        </sent_back></operation>
                    {/if}
                {/if}
            {/if}
        {elseif GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $application.status || GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $application.status}
            {if 'view_only' != $application.operation_mode}
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><confirm /></operation>
            {/if}
        {elseif 'change_transactor' == $application.operation_mode}
            {if 'view_only' != $application.operation_mode}
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><confirm /></operation>
            {/if}
        {elseif 'reapply' == $application.operation_mode}
            {if 'view_only' != $application.operation_mode}
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><confirm /></operation>
            {/if}
        {elseif GRN_WORKFLOW_STATUS_FINISHED == $application.status}
            {if $application.operation_mode == 'confirm'}  
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><acknowledge /></operation>
            {/if}
        {/if}
    {*{elseif GRN_WORKFLOW_FOLDER_TYPE_OUT_ID == $application.folder_type}*}
    {* 送信 *}
        {* 未処理 *}
        {if GRN_WORKFLOW_STATUS_UNPROCESSING == $application.status}
                {if $application.login_id == $application.user || $application.login_id == $application.agent_user }
                    <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><withdraw /></operation>
                {/if}
            {* 進行中 *}
        {elseif GRN_WORKFLOW_STATUS_IN_PROCESS == $application.status || GRN_WORKFLOW_STATUS_REMAND == $application.status}
            {if $application.login_id == $application.user || $application.login_id == $application.agent_user }
                <operation xmlns="http://schemas.cybozu.co.jp/workflow/2008"><cancel /></operation>
            {/if}
        {/if}
    {/if}
    {if is_array($application.folders) && 0 < count($application.folders) }
        {foreach from=$application.folders item=folder}
            <folder xmlns="http://schemas.cybozu.co.jp/workflow/2008" id="{$folder.folder_id}" />
            <folder_type>{$folder.folder_type}</folder_type>
        {/foreach}
    {/if}
</application>