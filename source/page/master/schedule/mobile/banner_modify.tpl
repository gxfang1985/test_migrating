{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/schedule_banner_add.js"}

{assign var="form_name" value=$smarty.template|basename}
<form id="schedule_mobile_banner_modify" name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='schedule/mobile/command_modify'}" data-ajax="false">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="BN" value="1">
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
      {grn_mobile_select_date id='start' id_associate='end' date=$start_date}
      <span class="mobile_schedule_timeline_grn"></span>
    </div><!--mobile-div-title-grn-->
    <div class="mobile-div-title-grn">
      {grn_mobile_select_date id='end' date=$end_date}
      <span class="mobile_timezone_grn">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span>
      <input type='hidden' id='timezone' name='timezone' value='{$schedule_event.timezone}' />
      <input type='hidden' id='end_timezone' name='end_timezone' value='{$schedule_event.end_timezone}' />
      <div id="invalid_date" style="display:none;" class="mobile_schedule_list_grn mobile_schedule_information_alert_grn">
        <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
        <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='invalid_date' replace='true'}</span>
      </div>
    </div><!--mobile-div-title-grn-->

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
    </ul>

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
  {include file="schedule/mobile/_modify_button.tpl" form_id='schedule_mobile_banner_modify'}
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

