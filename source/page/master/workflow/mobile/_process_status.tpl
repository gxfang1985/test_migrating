<ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_wf_progress_state_grn">
    <li data-icon="false" class="mobile_title_grn">{cb_msg module='grn.workflow' key='process_status' replace='true'}</li>
    {foreach name=path_step from=$path_steps item=path_step}
        {if $path_step.col_activate}
            {if ! $path_step.col_skip || 0 < $path_step.user_count}
                {* 経路種別と経路ステップ *}
                {strip}
                {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}
                    {if $path_step.last_acceptance}
                        {if $path_step.in_process}
                            <li data-icon="false" class="mobile_step_bar_grn mobile_current_grn"><span></span>
                        {elseif GRN_WORKFLOW_FINISHED_REMAND == $path_step.col_finished}
                            <li data-icon="false" class="mobile_step_bar_grn mobile_current_grn"><span class="mobile_wf_remand_grn"></span>
                        {else}
                            <li data-icon="false" class="mobile_step_bar_grn">
                        {/if}
                    {else}
                        {if $path_step.in_process}
                            <li data-icon="false" class="mobile_bar_grn mobile_current_grn"><span></span>
                        {elseif GRN_WORKFLOW_FINISHED_REMAND == $path_step.col_finished}
                            <li data-icon="false" class="mobile_bar_grn mobile_current_grn"><span class="mobile_wf_remand_grn"></span>
                        {else}
                            <li data-icon="false" class="mobile_bar_grn">
                        {/if}
                    {/if}
                {else}
                    {if $path_step.last_acceptance}
                        <li data-icon="false" class="mobile_step_bar_grn">
                    {else}
                        <li data-icon="false" class="mobile_bar_grn">
                    {/if}
                {/if}
                {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                    {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                {else}
                    {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                {/if}
                {cb_msg module='grn.workflow.mobile' key='colon' replace='true'}{$path_step.col_role|escape}</li>
                {/strip}
                {foreach name=user from=$path_step.users item=user}
                    {* 結果 *}
                    {* 0:- 1:未処理 2:承認 3:却下 4:差し戻し 5:確認 *}
                        {if !$smarty.foreach.user.last}
                            <li data-icon="false" class="mobile_operation_grn mobile_under_line_grn">
                        {else}
                            <li data-icon="false" class="mobile_operation_grn">
                        {/if}
                        {if GRN_WORKFLOW_RESULT_ACCEPT <= $user.col_result}
                            {if $path_step.last_acceptance}
                                <div class="mobile_wf_progress_mark_ok_grn">{cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}</div>
                            {else}
                                <div class="mobile_wf_progress_mark_grn">{cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}</div>
                            {/if}
                        {else}
                            <div class="mobile_wf_blank_mark_grn"></div>
                        {/if}
                        <div class="mobile_info_grn">
                            {if $user.col_agent_user || $user.col_agent_display_name}
                                <div class="mobile_user_grn">{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid only_text='true'}</div>
                                <div class="mobile_user_grn">{cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$user._agent_id name=$user.col_agent_display_name valid=$user.col_agent_valid only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
                            {else}
                                <div class="mobile_user_grn">{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid only_text='true'}</div>
                            {/if}
                            {* コメント *}
                            {if $user.col_comment.current}
                                <div class="mobile_text_grn">{grn_mobile_format body=$user.col_comment.current}</div>
                            {/if}
                            {* 日時 *}
                            <div class="mobile_date_grn">{if GRN_WORKFLOW_RESULT_UNPROCESSING != $user.col_result}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$user.col_ptime}{/if}</div>
                            {if 0 < $user.col_comment.log_total}
                                {foreach from=$user.col_comment.logs item=log}
                                  {strip}
                                    {if GRN_WORKFLOW_RESULT_REMAND == $log.col_result}
                                        <div class="mobile_progress_histroy_grn">
                                            {cb_msg module='grn.workflow' key="col_result_`$log.col_result`"}
                                            {if $log.col_agent}
                                                {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$log.col_agent name=$log.col_agent_name only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                            {/if}
                                            {if 'applicant' == $log.destination}
                                                {cb_msg module='grn.workflow' key='applicant_bracket_arrow' replace='true'}
                                            {else}
                                                {assign var='destination' value=$log.destination}
                                                {cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{$path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                            {/if}
                                            <br>
                                            <span>
                                                {grn_mobile_format body=$log.col_comment}
                                            </span>
                                            <br>
                                            {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime}
                                        </div>
                                    {else}
                                        <div class="mobile_text_grn">
                                            {cb_msg module='grn.workflow' key="col_result_`$log.col_result`"}
                                            {if $log.col_agent}
                                                {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$log.col_agent name=$log.col_agent_name only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                            {/if}
                                            {if GRN_WORKFLOW_RESULT_REMAND == $log.col_result}
                                                {if 'applicant' == $log.destination}
                                                    {cb_msg module='grn.workflow' key='applicant_bracket_arrow' replace='true'}
                                                {else}
                                                    {assign var='destination' value=$log.destination}
                                                    {cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{$path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                {/if}
                                            {/if}
                                        </div>
                                        <div class="mobile_text_grn">
                                            {grn_mobile_format body=$log.col_comment}
                                        </div>
                                        <div class="mobile_date_grn">
                                            {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime}
                                        </div>
                                        {/if}
                                  {/strip}
                                {/foreach}
                            {/if}
                        </div>
                    </li>
                {/foreach}
            {else}
            {* （省略） *}
            {* 経路種別と経路ステップ *}
            {strip}
                <li data-icon="false" class="mobile_bar_grn">
                {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                    {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                {else}
                    {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                {/if}
                {cb_msg module='grn.workflow.mobile' key='colon' replace='true'}{$path_step.col_role}
                </li>
            {/strip}
            <li data-icon="false" class="mobile_operation_grn">
                <div class="mobile_info_grn">
                    <div class="mobile_user_grn">{cb_msg module='grn.workflow' key='skip' replace='true'}</div>
                </div>
            </li>
            {/if}
        {/if}
    {/foreach}
</ul>