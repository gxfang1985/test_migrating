{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
  <div class="mobile-cmt-operate-grn">
  {include file='workflow/mobile/_attention.tpl'}
  <div class="mobile_wf_text_area_grn">
    {strip}
    <div class="mobile_status_area_grn">
    {if $priority}
      <div class="mobile_status_alert_mark_grn"><span></span>{$priority}</div>
    {/if}
    {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
      <div class="mobile_status_mark_grn mobile_inProgress_mark_grn">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</div>
    {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
      <div class="mobile_status_mark_grn mobile_approved_mark_grn">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</div>
    {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
      <div class="mobile_status_mark_grn mobile_rejected_mark_grn">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</div>
    {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
      <div class="mobile_status_mark_grn mobile_cancel_mark_grn">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</div>
    {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
      <div class="mobile_status_mark_grn mobile_complete_mark_grn">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</div>
    {/if}
    </div>
    {/strip}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.workflow.mobile' key='title' replace='true'}{if $petition.petition_number != ''}<span class="mobile_No_text_grn">{cb_msg module='grn.workflow.mobile' key='number' replace='true'}{$petition.petition_number|escape}</span>{/if}</div>
      <div class="mobile_contents_detail_grn mobile_pointtext_grn">{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
    </div>
    <div class="mobile-separation-grn"></div>
    {if $view}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</div>
      <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid only_text='true'}</div>
      {if $petition.agent_user || $petition.agent_user_name}
        <div class="mobile_contents_detail_grn">{cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name valid=$petition.agent_user_valid only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
      {/if}
    </div>
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='item_type_4' replace='true'}</div>
      <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}</div>
    </div>
    <div class="mobile-separation-grn"></div>
    {include file='workflow/mobile/_item_details.tpl'}
    {else}
      <div class="mobile-list-todoDetail-grn">
        {strip}
          {cb_msg module='grn.workflow' key='cannot_show_contents' replace='true'}
        {/strip}
      </div>
    {/if}
  </div>
  {if $view}
    {include file='workflow/mobile/_process_status.tpl'}
  {/if}
  </div>
</div>
{if $wf_operations|@count > 0}
{grn_load_javascript file="grn/html/page/workflow/mobile/operate_menu.js"}
<div class="mobile_navbar_menu_grn" id="operate_menu_workflow">
    <ul class="mobile_scroll_area_grn">
    {foreach from=$wf_operations key=page item=params}
        {if 'workflow/mobile/handle' == $page}
            {foreach from=$params item=param}
                {if 'acceptance' == $param.cmd}
                    <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$page params=$param}" onclick="javascript:grn.page.workflow.mobile.operate_menu.closeMenu();">{cb_msg module='grn.workflow.mobile' key='menuapprove' replace='true'}</a></li>
                {elseif 'reject' == $param.cmd}
                    <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$page params=$param}" onclick="javascript:grn.page.workflow.mobile.operate_menu.closeMenu();">{cb_msg module='grn.workflow.mobile' key='menureject' replace='true'}</a></li>
                {elseif 'remand' == $param.cmd}
                    <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$page params=$param}" onclick="javascript:grn.page.workflow.mobile.operate_menu.closeMenu();">{cb_msg module='grn.workflow.mobile' key='menusendback' replace='true'}</a></li>
                {elseif 'confirmation' == $param.cmd}
                    <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$page params=$param}" onclick="javascript:grn.page.workflow.mobile.operate_menu.closeMenu();">{cb_msg module='grn.workflow.mobile' key='menuacknowledge' replace='true'}</a></li>
                {/if}
            {/foreach}
        {elseif 'workflow/mobile/command_handle' == $page}
            <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a onclick="grn.component.mobile_ajax_submit.ajaxSubmit('confirm{$tmp_key|escape}');grn.page.workflow.mobile.operate_menu.closeMenu();return false">{cb_msg module='grn.workflow.mobile' key='menuacknowledge' replace='true'}</a></li>
            <form method="post" id="confirm{$tmp_key|escape}" action="{grn_pageurl page=$page}" enctype="multipart/form-data">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <input type="hidden" name="fid" value="{$fid|escape}">
                <input type="hidden" name="pid" value="{$pid|escape}">
                <input type="hidden" name="in_process" value="{$in_process|escape}">
                <input type="hidden" name="cmd" value="confirmation">
                <input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
            </form>
        {/if}
    {/foreach}
    </ul>
</div>
{/if}