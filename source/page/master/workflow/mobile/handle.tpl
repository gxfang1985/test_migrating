{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if $view}
{include file="grn/common.tpl"}
{assign var='form_id' value='workflow_mobile_handle'}
<form id="{$form_id}" method="post" action="{grn_pageurl page='workflow/mobile/command_'|cat:$page_info.last}" enctype="multipart/form-data">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
        {include file='grn/mobile_breadcrumb.tpl'}
        <div class="mobile_breadcrumb_margin_grn"></div>
        <div class="mobile_wf_text_area_grn">
            <div class="mobile_delete_confirm_grn">
                <span class="mobile_text_grn">
                {strip}
                    {if $command == 'acceptance'}
                        {cb_msg module='grn.workflow.mobile' key='handle_accept' replace='true'}
                    {elseif $command == 'reject'}
                        {cb_msg module='grn.workflow.mobile' key='handle_reject' replace='true'}
                    {elseif $command == 'remand'}
                        {cb_msg module='grn.workflow.mobile' key='handle_remand' replace='true'}
                    {elseif $command == 'confirmation'}
                        {cb_msg module='grn.workflow.mobile' key='handle_confirm' replace='true'}
                    {/if}
                {/strip}
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
            </div>
            <div class="mobile-div-title-grn"></div>
            <div class="mobile_wf_text_area_grn">
                <div class="mobile-list-todoDetail-grn">
                    <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='name' replace='true'}</div>
                    {if $agent_id}
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {grn_user_name uid=$user_id only_text='true'}
                        </div>
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$agent_id only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                        </div>
                    {else}
                        <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                            {grn_user_name uid=$login.id name=$login.name only_text='true'}
                        </div>
                    {/if}
                </div>
                {if $command == 'remand'}
                    <div class="mobile-div-title-grn">
                        <span class="mobile-label-grn">{cb_msg module='grn.workflow.mobile' key='destination' replace='true'}</span>
                            <div data-role="fieldcontain" class="mobile_select_grn">
                                <a id="selectDestination" href="#selectMenuDestination" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
                                    <span class="mobile_event_menu_content_grn">----------</span>
                                    <span class="mobile_select_icon_grn"></span>
                                </a>
                                <input type="hidden" name="destination" value="" id="destination">
                                {capture name='grn_remand_destination'}{cb_msg module='grn.workflow.mobile' key='destination' replace='true'}{/capture}
                                {include file="grn/mobile_select_menu.tpl"
                                         selectMenuTitle=$smarty.capture.grn_remand_destination
                                         select_items=$remand_options
                                         selectMenuUI='selectDestination'
                                         selectMenuValue='destination'
                                         popupMenu='selectMenuDestination'
                                         selected_value=$remand_options.applicant.value}
                            </div>
                    </div>
                {/if}
                <div class="mobile-div-title-grn">
                    <span class="mobile-label-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</span>
                    {grn_textarea necessary=true name="col_comment" id="col_comment" rows="50" class="mobile-textarea-grn" disable_return_key=true}
                </div>
            </div>
        </div>
        {capture name='grn_handle_button_value'}
            {if $command == 'acceptance'}
                {cb_msg module='grn.workflow.mobile' key='approvebutton' replace='true'}
            {elseif $command == 'reject'}
                {cb_msg module='grn.workflow.mobile' key='rejectbutton' replace='true'}
            {elseif $command == 'remand'}
                {cb_msg module='grn.workflow.mobile' key='remandbutton' replace='true'}
            {elseif $command == 'confirmation'}
                {cb_msg module='grn.workflow.mobile' key='acknowledgebutton' replace='true'}
            {/if}
        {/capture}
        <div data-theme="{$data_theme}" class="mobile_button_area_grn">
            <div class="mobile-buttonMain-grn mobile-button-left-grn">
                <input type="button" value="{$smarty.capture.grn_handle_button_value}" data-inline="true" data-theme="{$data_theme}" onclick="grn.component.mobile_ajax_submit_wf.ajaxSubmit('{$form_id}', {if $beforeSendFn}{$beforeSendFn}{else}''{/if}, {if $afterSendFn}{$afterSendFn}{else}''{/if});"/>
            </div>
            <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
                <input type="button" value="{cb_msg module='grn.workflow.mobile' key='cancelbutton' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="javascript:history.back();"/>
            </div>
        </div>
        <input type="hidden" name="fid" value="{$fid|escape}">
        <input type="hidden" name="pid" value="{$pid|escape}">
        <input type="hidden" name="cmd" value="{$command|escape}">
        <input type="hidden" name="in_process" value="{$in_process|escape}">
    </div>
</form>
{grn_load_javascript file="grn/html/component/mobile_ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{literal}
    <script language="Javascript" type="text/javascript">
        var G = grn.component.mobile_ajax_submit_wf;
        G.commandAutoScheduleURL = {/literal}"{grn_pageurl page='workflow/mobile/command_auto_schedule'}"{literal};
        G.petition_id = {/literal}"{$pid}"{literal};
    </script>
{/literal}
{/if}