{**
 *  date picker for mobile view
 *  Nguyen Huynh Long
 *  2014/02/14
 *
 *  @param  string    id              id of date select element
 *  @param  string    id_associate    id of associate element - use in case add or modify schedule, when user select start date, also change end date
 *  @param  string    date            string of date. Ex: "2014-02-14"
 *  @param  boolean   icon_only       whether use only icon calendar or not
 *  @param  string    icon_class      css class that display icon
 *  Note: {$id}_set is hidden value of date select, when you need to catch event when user choose date, catch "change" event of {$id}_set element
 *  In case not use icon canlendar, return input hidden to store value of date
 *  <input type="hidden" id="{$id}_year" name="{$id}_year" value="{$year}">
 *  <input type="hidden" id="{$id}_month" name="{$id}_month" value="{$month}">
 *  <input type="hidden" id="{$id}_day" name="{$id}_day" value="{$day}">
 *}

{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="grn/html/mobile_datepicker.css"}
{grn_load_javascript file="grn/html/component/mobile_datepicker.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
    $(document).ready(function(){
      $('#{/literal}{$id}{literal}').on('click',function(event){
          datepicker.setIconOnly('{/literal}{$icon_only}{literal}');
          datepicker.setCurrentElement(event.target);
          datepicker.setInputAssociate('{/literal}{$id_associate}{literal}');
      });
    });
})();
</script>
{/literal}
<script id="datepicker_header" type="text/x-template">
{strip}
  {foreach name=wday from=$wday_name item=value}
    <div class="{if $smarty.foreach.wday.iteration == 1}
                  mobile_datepicker_sun_grn
                {else}
                  {if $smarty.foreach.wday.iteration == 7} 
                    mobile_datepicker_sat_grn
                  {else}
                    mobile_datepicker_weekdays_grn
                  {/if}
                {/if} mobile_datepicker_listtitle_grn">
      <span>{$value}</span>
    </div>
  {/foreach}
{/strip}
</script>
<script id="datepicker_footer" type="text/x-template">
{strip}
  <div data-theme="{$data_theme}" class="mobile_button_area_grn">
    <div class="mobile_cancel_grn">
      <input type="reset" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-14' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
    </div>
  </div>
{/strip}
</script>
{if $icon_only}
  <a id="{$id}" href="#dialog_datepicker" data-rel="popup" data-transition="pop" data-theme="{$data_theme}" class="{$icon_class}"></a>
  <input type="hidden" id="{$id}_set" name="{$id}_set" value="{$date}">
{else}
  <div class="mobile-contentSubButton-grn mobile_select_date_grn {if $float_left}mobile_float_left{/if}">
    <a id="{$id}" href="#dialog_datepicker" data-rel="popup" data-transition="pop" data-theme="{$data_theme}" data-role="button" class="mobile-btn-calender-grn">
      <span class="mobile-icon-calender-grn"></span>
      <span class="mobile-font-normal-grn">{$date_str}</span>
    </a>
    <input type="hidden" id="{$id}_set" name="{$id}_set" value="{$date}">
    <input type="hidden" id="{$id}_year" name="{$id}_year" value="{$year}">
    <input type="hidden" id="{$id}_month" name="{$id}_month" value="{$month}">
    <input type="hidden" id="{$id}_day" name="{$id}_day" value="{$day}">
  </div>
{/if}
{if $is_first_loaded_datepicker}
<script language="JavaScript" text="text/javascript">
var settings_datepicker = {ldelim}
    container         : 'dialog_datepicker',
    year_unit         : '{$year_unit}',
    month_unit        : '{$month_unit}',
    day_unit          : '{$day_unit}',
    delimiter         : '{$delimiter}',
    date_order        : '{$date_order}',
    month_name        : '{$str_month_name}',
    wday_name         : '{$str_wday_name}',
    ajaxURLGetHoliday : "{grn_pageurl page='grn/ajax_get_holiday_for_mobile_datepicker'}",
    locale            : '{$locale}'
{rdelim};
{literal}
var datepicker;
$(document).ready(function(){
    datepicker = new grn.component.mobile_datepicker(settings_datepicker);
});
{/literal}
</script>
  <div data-role="popup" id="dialog_datepicker" data-shadow="false" data-overlay-theme="b">
    <div class="mobile_datepicker_page_grn">
      <div class="mobile_datepicker_bar_grn">
        {strip}
        <ul>
          <li class="mobile_width_a_grn">
            <span class="mobile_datepicker_icon_backsub_grn">
              <a class="previous_month" href="#"></a>
            </span>
          </li>
          {grn_mobile_datepicker_month_year_select}
          <li class="mobile_width_d_grn">
            <a class="today" href="#">{cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}</a>
          </li>
          <li class="mobile_width_e_grn">
            <span class="mobile_datepicker_icon_advancesub_grn">
              <a class="next_month" href="#"></a>
            </span>
          </li>
        </ul>
        {/strip}
      </div><!-- /mobile_datepicker_bar -->
      <div class="mobile_datepicker_grn">
        <div class="mobile_datepicker_list_grn">
        </div><!-- /grid-c -->
      </div><!-- end of mobile_datepicker_grn-->
    </div>
  </div>
{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
    $(document).ready(function(){
      $('#{/literal}{$id}_set{literal}').on('change', function(event){
        datepicker.handlerChangeValue(event);
      });
    });
})();
</script>
{/literal}
