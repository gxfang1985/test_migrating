{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/timezone_info.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/schedule_add.js"}
{if $schedule_event.private_setting == 0}
    {assign var='event_non_private' value=true}
{else}
    {assign var='event_non_private' value=false}
{/if}
{assign var="form_name" value=$smarty.template|basename}
<form id="schedule_mobile_modify" name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='schedule/mobile/command_modify'}" data-ajax="false">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name='event_id' value="{$schedule_event.event_id|escape}">
<input type="hidden" name='bdate' value="{$bdate|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">
{if $allow_file_attachment}
    <input type="hidden" name="allow_file_attachment" value="1">
{/if}

<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
  <!--breadcrumb-->
  {include file="grn/mobile_breadcrumb.tpl"}
  <!--end breadcrumb-->
  <div class="mobile_schedule_grn">
    <div class="mobile-div-title-grn">
    </div><!--mobile-div-title-grn-->
    <div class="mobile-div-title-grn">
      {grn_mobile_select_date id='start' id_associate='end' date=$start_date float_left='float_left'}
      {grn_mobile_select_time prefix='start_' time=$schedule_event.start_time minute_interval=$minute_interval}
      <span class="mobile_schedule_timeline_grn"></span>
      <span class="mobile_timezone_grn">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span>
      <input type='hidden' id='timezone' name='timezone' value='{$schedule_event.timezone}' />
    </div><!--mobile-div-title-grn-->
    <div class="mobile-div-title-grn">
      {grn_mobile_select_date id='end' date=$end_date float_left='float_left'}
      {grn_mobile_select_time prefix='end_' time=$schedule_event.end_time minute_interval=$minute_interval}
      <span class="mobile_timezone_grn">{cb_msg module='fw.timezone' key=$schedule_event.end_timezone}</span>
      <input type='hidden' id='end_timezone' name='end_timezone' value='{$schedule_event.end_timezone}' />
      <div id="validate_date" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span>
      </div>
      <div id="invalid_date" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='invalid_time' replace='true'}</span>
      </div>
    </div><!--mobile-div-title-grn-->
    <div class="mobile-div-title-grn">
    {strip}
      <label for="allday">
        <a id="notime" href="javascript:void(0);" class="mobile-checkboxOff-todo-grn"></a>
        <span class="mobile_checkbox_grn">
          <input name="allday" id="allday" type="checkbox" data-role="none" class="mobile-input-grn"/>
        </span>
      </label>
      <span class="mobile_btn_checkboxtext_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-21' replace='true'}</span>
    {/strip}
    </div>
    <div class="mobile-div-title-grn">
      {capture name='grn_schedule_mobile_menu'}{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-10' replace='true'}{/capture}
      <span class="mobile-label-grn">{$smarty.capture.grn_schedule_mobile_menu}</span>
      <a id="menu_schedule" href="#popup_menu_schedule" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
        <span class="mobile_event_menu_content_grn">----------</span>
        <span class="mobile_select_icon_grn"></span>
      </a>
      <input type="hidden" value="" name="menu" id="menu_schedule_value">
        {include file="grn/mobile_select_menu.tpl"
        selectMenuTitle=$smarty.capture.grn_schedule_mobile_menu
        select_items=$menus
        selectMenuUI='menu_schedule'
        selectMenuValue='menu_schedule_value'
        popupMenu='popup_menu_schedule'
        default_title='--------------------'
        use_menu_color='true'
        selected_value=$schedule_event.selectmenu
        }
    </div><!--mobile-div-title-grn-->
    <div class="mobile-div-title-grn">
      <span class="mobile-label-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-12' replace='true'}</span>
      {grn_text id='title' name="title" value=$schedule_event.title size="50" disable_return_key=true}
    </div><!--mobile-div-title-grn-->
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
        <div class="mobile-separation-grn"></div>
        <li data-icon="false">
          <a id="attendees" class="ui-link-inherit" href="#_sUID">
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-145' replace='true'}</div>
            <div class="mobile_for_totalnumber_grn">
            </div>
            <span class="totalNumber-grn"></span>
            <span class="mobile-array-todo-grn"></span>
          </a>
        </li>
        <div class="mobile-separation-grn"></div>
        <li data-icon="false">
            <a id="facilities" class="ui-link-inherit" href="#_sITEM">
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-146' replace='true'}</div>
            <div class="mobile_for_totalnumber_grn">
            </div><!--mobile_for_totalnumber_grn-->
            <span class="totalNumber-grn"></span>
            <span class="mobile-array-todo-grn"></span>
            </a>
        </li>
        <div class="mobile-separation-grn"></div>
    </ul>

    <div class="mobile-div-title-grn" {if ! $schedule_event.usingApprovalFacility}style="display:none;"{/if} id="using_purpose_element">
      <span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1100' replace='true'}<span class="mobile-required-grn">*</span></span>
      <div id="require_using_purpose" style="display:none;" class="mobile_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1104' replace='true'}</span>
      </div>
      {grn_textarea id="using_purpose" name="using_purpose" value=$schedule_event.usingPurposeValue class="mobile-textarea-grn"}
    </div><!--mobile-div-title-grn-->

  <div class="mobile-div-title-grn">
    <span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-295' replace='true'}</span>
    {grn_textarea name="memo" value=$schedule_event.memo class="mobile-textarea-grn"}
  </div><!--mobile-div-title-grn-->
  {if $allow_file_attachment}
      <div class="mobile-div-title-grn">
          <span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</span>
          {include file="grn/mobile_attach_file.tpl" attached_files=$schedule_event.attached_files}
      </div>
  {/if}

    {if $use_private}
    <div class="mobile-div-title-grn">
    {strip}
      <span class="mobile-label-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-39' replace='true'}</span>
      <div id="idPrivateRaidoButton" class="mobile_radiobutton_group_grn">
        <span class="mobile_radiobutton_base_grn" style="margin-right: 14px;">
          <span class="mobile_icon_radiobutton_grn {if $schedule_event.private_setting == 0}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
          <span class="mobile_radiobutton_grn">
            <div class=" ui-radio">
              <input type="radio" name="" id="" value="0">
            </div>
          </span>
          <span class="mobile_text_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-40' replace='true'}</span>
        </span>
        <span class="mobile_radiobutton_base_grn" style="margin-right: 14px;">
          <span class="mobile_icon_radiobutton_grn {if $schedule_event.private_setting == 1}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
          <span class="mobile_radiobutton_grn">
            <div class=" ui-radio">
              <input type="radio" name="" id="" value="1">
            </div>
          </span>
          <span class="mobile_text_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-41' replace='true'}</span>
        </span>
        <span class="mobile_radiobutton_base_grn" style="margin-right: 0;">
          <span class="mobile_icon_radiobutton_grn {if $schedule_event.private_setting == 2}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
          <span class="mobile_radiobutton_grn">
            <div class=" ui-radio">
              <input type="radio" name="" id="" value="2">
            </div>
          </span>
          <span class="mobile_text_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-42' replace='true'}</span>
        </span>
      </div>
    </div>
    <input type="hidden" id="idPrivateSetting" name="private" value="{$schedule_event.private_setting|default:0}">
    <ul id="idPrivateSettingPublicTo" class="mobile-li-PersonInCharge-grn mobile-div-title-grn ui-listview ui-group-theme-c" data-theme="c" data-role="listview" {if $schedule_event.private_setting neq '2'}style="display:none;"{/if}>
      <div class="mobile-separation-grn"></div>
      <li data-icon="false" class="ui-first-child">
        <a id="default_public" href="#_p_sUID" class="ui-link-inherit ui-btn" id="">
          <div class="mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-43' replace='true'}</div>
          <div class="mobile_for_totalnumber_grn">
          </div><!--mobile_for_totalnumber_grn-->
          <span class="totalNumber-grn"></span>
          <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
    </ul>
  {/strip}
  {/if}
  {if $use_attendance_check}
  <div class="mobile-div-title-grn">
    <span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-997' replace='true'}</span>
    <div class="mobile_switch_button_grn mobile_schedule_attendance_check_grn" {if !$schedule_event.attendance_check}style="display:none;"{/if}>
    {strip}
        <div class="mobile_left_grn mobile_selected_grn">ON</div>
        <a href="#" class="mobile_schedule_switch_type_grn mobile_right_grn mobile_unselected_grn">OFF</a>
    {/strip}
    </div>
    <div class="mobile_switch_button_grn mobile_schedule_not_attendance_check_grn" {if $schedule_event.attendance_check}style="display:none;"{/if}>
    {strip}
        <a href="#" class="mobile_schedule_switch_type_grn mobile_left_grn mobile_unselected_grn">ON</a>
        <div class="mobile_right_grn mobile_selected_grn">OFF</div>
    {/strip}
    </div>
    <input type="hidden" name="attendance_check" id="attendance_check" value="{if $schedule_event.attendance_check}1{/if}">
  </div><!--mobile-div-title-grn-->
  {include file='schedule/mobile/_attendance_confirm_dialog_mobile.tpl' application_id=$application_id}
  {/if}
  {include file="schedule/mobile/_modify_button.tpl" form_id='schedule_mobile_modify'}
  </div><!-- end of mobile_addschedule_grn-->
</div><!-- end of content-->
    {include file="grn/mobile_footer_for_multipage.tpl"}
</form>
</div>

{capture name='attendees_select_page'}{cb_msg module='grn.schedule' key='GRN_SCH-145' replace='true'}{/capture}
{grn_mobile_user_add
  form_name=$form_name
  sUID='sUID'
  selected_users=$selected_users_sUID
  app_id='schedule'
  access_plugin=$add_plugin
  include_org=$show_organize
  associate_id='attendees'
  upper_page=$page_title
  currnet_page_name=$smarty.capture.attendees_select_page
  isCalendar=TRUE
}

{capture name='default_public_select_page'}{cb_msg module='grn.schedule' key='GRN_SCH-318' replace='true'}{/capture}
{grn_mobile_user_add
  form_name=$form_name
  sUID='p_sUID'
  selected_users=$selected_users_p_sUID
  app_id='schedule'
  access_plugin=$view_plugin
  include_org=TRUE
  include_role=TRUE
  role_category_tree=$role_category_tree
  isAllowedRole=$isAllowedRole
  associate_id='default_public'
  upper_page=$page_title
  currnet_page_name=$smarty.capture.default_public_select_page
  show_group_role=$show_group_role
}

{include file="schedule/mobile/facility_add.tpl" upper_page=$page_title keepUsingPurpose=true}

