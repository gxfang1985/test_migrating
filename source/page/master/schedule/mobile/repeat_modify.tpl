{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/schedule_banner_add.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/schedule_repeat_add.js"}

{assign var="form_name" value=$smarty.template|basename}

{if $schedule_event.private_setting == 0}
    {assign var='event_non_private' value=true}
{else}
    {assign var='event_non_private' value=false}
{/if}

<script type="text/javascript" language="javascript">
    var __thisPage = grn.page.schedule.mobile.schedule_repeat_add;
    __thisPage.form = '{$form_name}';
    __thisPage.t_year = '{$schedule_event.this_date->year}';
    __thisPage.t_month = '{$schedule_event.this_date->month}';
    __thisPage.t_day = '{$schedule_event.this_date->day}';
    __thisPage.s_year = '{$schedule_event.start_date->year}';
    __thisPage.s_month = '{$schedule_event.start_date->month}';
    __thisPage.s_day = '{$schedule_event.start_date->day}';
</script>

<form id="schedule_mobile_repeat_modify" name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='schedule/mobile/command_modify'}" data-ajax="false">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!---GTM-143-->
<input type="hidden" id="hfExcept" name ="hfExcept" />
<!---end GTM-143-->
<input type="hidden" name="RP" value="1">
<input type="hidden" name='event_id' value="{$schedule_event.event_id|escape}">
<input type="hidden" name='bdate' value="{$bdate|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">

<div data-role="content" class="mobile-content-grn" data-theme="{$data_theme}">
  <!--breadcrumb-->
  {include file="grn/mobile_breadcrumb.tpl"}
  <!--end breadcrumb-->
  <div class="mobile_schedule_grn">
    <div id="range_repeat_modify" class="mobile_list_grn">
      <div id="validate_range" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-178' replace='true'}</span>
      </div>
      <div class="mobile_title_grn">{cb_msg module='grn.schedule' key='GRN_SCH-543' replace='true'}<span class="mobile_important_grn">*</span></div>
      <ul>
        <li><span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="" type="radio" value="this"></span>
          <span class="mobile_text_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-11' replace='true'}</span>
            <div class="mobile_text_grn">
            {grn_mobile_select_date id='this' date=$this_date}
            </div>
        </li>
        <li><span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="" type="radio" value="after"></span>
          <span class="mobile_text_grn">{capture name='grn_schedule_GRN_SCH_850'}{cb_msg module='grn.schedule' key='GRN_SCH-850' replace='true'}{$schedule_event.after_date}{cb_msg module='grn.schedule' key='GRN_SCH-851' replace='true'}{/capture}{$smarty.capture.grn_schedule_GRN_SCH_850}</span>
        </li>
        <li><span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="" type="radio" value="all"></span>
          <span class="mobile_text_grn">{cb_msg module='grn.schedule' key='GRN_SCH-548' replace='true'}</span>
        </li>
      </ul>
      <input type="hidden" value="" name="apply" id="apply">
    </div>
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
      <div class="mobile-separation-grn"></div>
      <li data-icon="false">
        <a href="#_repeat_condition">
          <div class="mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-18' replace='true'}</div>
          <div class="mobile_for_totalnumber_grn">
            <div id="repeat_condition_title" class="mobile-font-warp-grn">{$repeat_caption}</div>
          </div><!--mobile_for_totalnumber_grn-->
          <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
    </ul>

    <div class="mobile-div-title-grn">
      <span class="mobile-label-grn mobile_block_grn">{cb_msg module='grn.schedule' key='GRN_SCH-106' replace='true'}</span>
      {grn_mobile_select_date id='start' id_associate='end' date=$start_date}
      <span class="mobile_schedule_timeline_grn"></span>
    </div><!--mobile-div-title-grn-->

    <div class="mobile-div-title-grn">
      {grn_mobile_select_date id='end' date=$end_date}
      <div id="invalid_date" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='invalid_date' replace='true'}</span>
      </div>
    </div><!--mobile-div-title-grn-->

    <div class="mobile-div-title-grn">
      <span class="mobile-label-grn mobile_block_grn">{cb_msg module='grn.schedule' key='GRN_SCH-119' replace='true'}</span>
      {grn_mobile_select_time prefix='start_' time=$schedule_event.start_time minute_interval=$minute_interval}
      <span class="mobile_schedule_timeline_grn"></span>
      {grn_mobile_select_time prefix='end_' time=$schedule_event.end_time minute_interval=$minute_interval}
      <span class="mobile_timezone_grn">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span>
      <input type='hidden' id='timezone' name='timezone' value='{$schedule_event.timezone}' />
      <input type='hidden' id='end_timezone' name='end_timezone' value='{$schedule_event.timezone}' />
      <div id="validate_repeat_date" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span>
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

    {if $use_private}
    {strip}
    <div class="mobile-div-title-grn">
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
  <div class="mobile-div-title-grn">
    <span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-295' replace='true'}</span>
    {grn_textarea name="memo" value=$schedule_event.memo class="mobile-textarea-grn"}
  </div><!--mobile-div-title-grn-->
  {include file="schedule/mobile/_modify_button.tpl" form_id='schedule_mobile_repeat_modify'}
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

{include file="schedule/mobile/facility_add.tpl" upper_page=$page_title}

{include file="schedule/mobile/repeat_condition.tpl" upper_page=$page_title}

