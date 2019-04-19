{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/page/schedule/mobile/repeat_condition.js"}

{if $schedule_event.type == 'day'}
    {assign var='selected_day' value=TRUE}
{/if}
{if $schedule_event.type == 'weekday'}
    {assign var='selected_weekday' value=TRUE}
{/if}
{if $schedule_event.type != 'day' && $schedule_event.type != 'weekday' && $schedule_event.type != 'month'}
    {assign var='selected_week' value=TRUE}
    {if $schedule_event.type == ''}
        {assign var='selected_week_value' value='week'}
    {else}
        {assign var='selected_week_value' value=$schedule_event.type}
    {/if}
{else}
    {assign var='selected_week_value' value='week'}
{/if}
{if $schedule_event.type == 'month'}
    {assign var='selected_month' value=TRUE}
{/if}

{literal}
<script language="JavaScript" text="text/javascript">
(function(){

    $(document).ready(function(){

        $(document).on("pagebeforeshow","#_repeat_condition",function(event,data){
            if(typeof data.prevPage.attr('id') == 'undefined')
            {
                grn.page.schedule.mobile.repeat_condition.saveLastChoice();
            }
            else
            {
                switch (data.prevPage.attr('id'))
                {
                    case 'popup_menu_week':
                    case 'popup_menu_weekday':
                        grn.page.schedule.mobile.repeat_condition.selectRadioBtn('week');
                        break;
                    case 'popup_menu_monthday':
                        grn.page.schedule.mobile.repeat_condition.selectRadioBtn('3month');
                        break;
                }
            }
        });
    });

})();
</script>
{/literal}

<div data-role="page" id="_repeat_condition">
  <div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
    <!--breadcrumb-->
    {capture name='GRN_SCH_MOBILE_18'}{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-18' replace='true'}{/capture}
    {include file="grn/mobile_breadcrumb_for_multipage.tpl" upper_page=$upper_page current_page=$smarty.capture.GRN_SCH_MOBILE_18 page_with_list="TRUE" app_id='schedule'}
    <!--end breadcrumb-->
    <div class="mobile_schedule_grn mobile_repeating_conditions_grn">
      <div class="mobile_list_grn">
        <ul>
          <li class="mobile_schedule_repeat_everyday">
            <span class="mobile_icon_radiobutton_grn {if $selected_day}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
            <span class="mobile_radiobutton_grn">
              <input name="" id="day" value="day" type="radio" {if $selected_day}check='checked'{/if}>
            </span>
            <span class="mobile_text_grn">{cb_msg module='grn.schedule' key='GRN_SCH-58' replace='true'}</span>
          </li>
          <li class="mobile_schedule_repeat_weekday">
            <span class="mobile_icon_radiobutton_grn {if $selected_weekday}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
            <span class="mobile_radiobutton_grn">
              <input name="" id="weekday" value="weekday" type="radio" {if $selected_weekday}check='checked'{/if}>
            </span>
            <span class="mobile_text_grn">{cb_msg module='grn.schedule' key='GRN_SCH-59' replace='true'}</span>
          </li>
          <li class="mobile_schedule_repeat_week">
            <span class="mobile_icon_radiobutton_grn {if $selected_week}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
            <span class="mobile_radiobutton_grn">
              <input name="" id="week" value="week" type="radio" {if $selected_week}check='checked'{/if}>
            </span>
            <span class="mobile_text_grn">
              <a id="menu_week" href="#popup_menu_week" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn mobile_select_short_view_grn">
                  <span class="mobile_event_menu_content_grn">----------</span>
                  <span class="mobile_select_icon_grn"></span>
              </a>
              <input type="hidden" value="" name="week" id="menu_week_value">
              <input type="hidden" value="" id="menu_week_title">
                {include file="grn/mobile_select_menu.tpl"
                select_items=$week_option
                selectMenuUI='menu_week'
                selectMenuValue='menu_week_value'
                popupMenu='popup_menu_week'
                previous_page='_repeat_condition'
                selected_value=$selected_week_value
                expandMenuSelect='menu_week_title'
                }
              <a id="menu_weekday" href="#popup_menu_weekday" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn mobile_select_short_view_grn">
                  <span class="mobile_event_menu_content_grn">----------</span>
                  <span class="mobile_select_icon_grn"></span>
              </a>
              <input type="hidden" value="" name="wday" id="menu_weekday_value">
              <input type="hidden" value="" id="menu_weekday_title">
                {include file="grn/mobile_select_menu.tpl"
                select_items=$weekday_option
                selectMenuUI='menu_weekday'
                selectMenuValue='menu_weekday_value'
                popupMenu='popup_menu_weekday'
                previous_page='_repeat_condition'
                selected_value=$schedule_event.wday
                expandMenuSelect='menu_weekday_title'
                }
            </span>
          </li>
          <li class="mobile_schedule_repeat_month">
            <span class="mobile_icon_radiobutton_grn {if $selected_month}mobile_icon_radiobuttonon_grn{else}mobile_icon_radiobuttonoff_grn{/if}"></span>
            <span class="mobile_radiobutton_grn">
              <input name="" id="3month" value="month" type="radio" {if $selected_month}check='checked'{/if}>
            </span>
            <span class="mobile_text_grn"><span class="mobile_textmargin_grn">{cb_msg module='grn.schedule' key='GRN_SCH-73' replace='true'}</span>
              <a id="menu_monthday" href="#popup_menu_monthday" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn mobile_select_short_view_grn">
                  <span class="mobile_event_menu_content_grn">----------</span>
                  <span class="mobile_select_icon_grn"></span>
              </a>
              <input type="hidden" value="" name="day" id="menu_monthday_value">
              <input type="hidden" value="" id="menu_monthday_title">
                {include file="grn/mobile_select_menu.tpl"
                select_items=$monthday_option
                selectMenuUI='menu_monthday'
                selectMenuValue='menu_monthday_value'
                popupMenu='popup_menu_monthday'
                previous_page='_repeat_condition'
                selected_value=$schedule_event.day
                expandMenuSelect='menu_monthday_title'
                }
          </span>
          </li>
        </ul>
      </div>
    </div>
    <div data-theme="{$data_theme}" class="mobile_button_area_grn">
      <div class="mobile_ok_grn">
        <input type="submit" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-19' replace='true'}" data-inline="true" data-theme="{$data_theme}" />
      </div>
      <div class="mobile_cancel_grn">
        <input type="reset" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-17' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
      </div>
    </div>
  </div><!-- end of content-->
  <input type="hidden" value="{$schedule_event.type|default:'week'}" name="type" id="repeat_condition_type">
    {include file="grn/mobile_footer_for_multipage.tpl"}
</div><!--page-->
