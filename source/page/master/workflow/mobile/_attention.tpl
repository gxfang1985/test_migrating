{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status}
  <!-- 取り戻し -->
  <div class="mobile-div-title-grn">
    <div class="mobile_box_area_grn">
      <div class="mobile_box_message_grn">
        <span class="mobile_icon_information_grn"></span>
        {cb_msg module='grn.workflow.mobile' key='withdraw' replace='true'}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='processor' replace='true'}</div>
        {if $petition.agent_transactor || $petition.agent_transactor_name}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
          <div class="mobile_contents_detail_grn">{cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
        {else}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
        {/if}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='date_time' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_mobile_format body=$petition.comment}</div>
      </div>
    </div>
  </div>
{elseif GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status}
  <!-- 取り消し -->
  <div class="mobile-div-title-grn">
    <div class="mobile_box_area_grn">
      <div class="mobile_box_message_grn">
        <span class="mobile_icon_information_grn"></span>
        {cb_msg module='grn.workflow.mobile' key='cancel' replace='true'}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='processor' replace='true'}</div>
        {if $petition.agent_transactor || $petition.agent_transactor_name}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
          <div class="mobile_contents_detail_grn">{cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
        {else}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
        {/if}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='date_time' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_mobile_format body=$petition.comment}</div>
      </div>
    </div>
  </div>
{elseif 'change_transactor' == $handle_mode}
  <!-- 経路変更 -->
  {assign var=path_step_id value=$change_path_history.col_path_step_data}
  {assign var=path_step value=$path_steps.$path_step_id}
  <div class="mobile-div-title-grn">
    <div class="mobile_box_area_grn">
      <div class="mobile_box_message_grn">
        <span class="mobile_icon_information_grn"></span>
        {cb_msg module='grn.workflow.mobile' key='routechange' replace='true'}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='processor' replace='true'}</div>
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$change_path_history.col_creator name=$change_path_history.col_creator_name valid=$change_path_history.col_valid only_text='true'}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='date_time' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$change_path_history.col_ctime}</div>
      </div>
      
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='path_step_name' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{$path_step.col_role|escape}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='path_class' replace='true'}</div>
        {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
        <div class="mobile_contents_detail_grn">
        {cb_msg module='grn.workflow' key='pass_along' replace='true'}
        </div>
        {else}
        <div class="mobile_contents_detail_grn">
        {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
        </div>
        {/if}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='add' replace='true'}</div>
        {foreach from=$change_path_history.add_users item=user}
        <div class="mobile_contents_detail_grn">{grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid only_text='true'}</div>
        {/foreach}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='delete_3' replace='true'}</div>
        {foreach from=$change_path_history.deleted_users item=user}
        <div class="mobile_contents_detail_grn">{grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid only_text='true'}</div>
        {/foreach}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_mobile_format body=$change_path_history.col_comment}</div>
      </div>
    </div>
  </div>
{elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
  <!-- 差し戻し -->
  <div class="mobile-div-title-grn">
    <div class="mobile_box_area_grn">
      <div class="mobile_box_message_grn">
      <span class="mobile_icon_information_grn"></span>{cb_msg module='grn.workflow.mobile' key='sendback' replace='true'}</div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='processor' replace='true'}</div>
        {if $petition.agent_transactor || $petition.agent_transactor_name}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
          <div class="mobile_contents_detail_grn">{cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name  valid=$petition.agent_transactor_valid only_text='true'}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</div>
        {else}
          <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid only_text='true'}</div>
        {/if}
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='date_time' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='comment' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_mobile_format body=$petition.comment}</div>
      </div>
    </div>
  </div>
{elseif 'reapply' == $handle_mode}
  <!-- 再申請 -->
  <div class="mobile-div-title-grn">
    <div class="mobile_box_area_grn">
      <div class="mobile_box_message_grn">
      <span class="mobile_icon_information_grn"></span>{cb_msg module='grn.workflow.mobile' key='reapply' replace='true'}</div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid only_text='true'}</div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.workflow' key='date_time' replace='true'}</div>
        <div class="mobile_contents_detail_grn">{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}</div>
      </div>
    </div>
  </div>
{elseif 'confirm' == $handle_mode}
<!-- その他 -->
    {if $error}
        <p>{cb_msg module='grn.workflow' key='processing_or_sent_back' replace='true'}</p>
    {/if}
{/if}
{if $has_editable_item}
    <div class="mobile-div-title-grn">
        <div class="mobile_box_area_grn">
            <div class="mobile_box_message_grn">
                <span class="mobile_icon_information_grn"></span>
                {cb_msg module='grn.workflow.mobile' key='editable' replace='true'}
            </div>
        </div>
    </div>
{/if}
