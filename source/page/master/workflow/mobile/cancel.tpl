{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if $folder}
{assign var='form_id' value='workflow_mobile_cancel'}
<form id="{$form_id}" method="post" action="{grn_pageurl page='workflow/mobile/command_'|cat:$page_info.last}" enctype="multipart/form-data">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
        {include file='grn/mobile_breadcrumb.tpl'}
        <div class="mobile_breadcrumb_margin_grn"></div>
        <div class="mobile_wf_text_area_grn">
            <div class="mobile_delete_confirm_grn">
                <span class="mobile_text_grn">
                    {if GRN_WORKFLOW_STATUS_UNPROCESSING == $petition.status}
                        {cb_msg module='grn.workflow.mobile' key='handle_withdraw' replace='true'}
                    {elseif GRN_WORKFLOW_STATUS_IN_PROCESS  == $petition.status || GRN_WORKFLOW_STATUS_REMAND == $petition.status}
                        {cb_msg module='grn.workflow.mobile' key='handle_cancel' replace='true'}
                    {/if}
                </span>
                <span class="mobile_bold_grn">
                {strip}
                    {if $petition.petition_number != ''}
                        {cb_msg module='grn.workflow.mobile' key='number' replace='true'}{$petition.petition_number|escape}
                        &nbsp;{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {/if}
                {/strip}
                </span>
                <span class="mobile_text_grn">
                    {cb_msg module='grn.workflow.mobile' key='inputcmt' replace='true'}
                </span>
                {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING && $petition.agent_user}
                <span class="mobile_text_grn">
                    {cb_msg module='grn.workflow' key='move_application_to_draft' replace='true'}
                </span>
                {/if}
            </div>
            <div class="mobile-div-title-grn"></div>
            <div class="mobile_wf_text_area_grn">
                <div class="mobile-list-todoDetail-grn">
                    <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='name' replace='true'}</div>
                    {if $petition.agent_user}
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {grn_user_name uid=$petition.user name=$petition.user_name only_text='true'}
                        </div>
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                        </div>
                    {else}
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {grn_user_name uid=$login.id name=$login.name only_text='true'}
                        </div>
                    {/if}
                </div>
                <div class="mobile-div-title-grn">
                    <span class="mobile-label-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</span>
                    {grn_textarea necessary=true name="comment" id="comment" rows="50" class="mobile-textarea-grn" disable_return_key=true}
                </div>
            </div>
        </div>
        <div data-theme="{$data_theme}" class="mobile_button_area_grn">
            <div class="mobile-buttonMain-grn mobile-button-left-grn">
                <input type="button" value="{$cancel_button}" data-inline="true" data-theme="{$data_theme}" onclick="grn.component.mobile_ajax_submit.ajaxSubmit('{$form_id}', {if $beforeSendFn}{$beforeSendFn}{else}''{/if}, {if $afterSendFn}{$afterSendFn}{else}''{/if});"/>
            </div>
            <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
                <input type="button" value="{cb_msg module='grn.workflow.mobile' key='cancelbutton' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="javascript:history.back();"/>
            </div>
        </div>
        <input type="hidden" name="fid" value="{$folder_id|escape}">
        <input type="hidden" name="pid" value="{$petition_id|escape}">
        <input type="hidden" name="handle" value="{$handle|escape}">
    </div>
</form>
{/if}