{assign var="is_print_page" value=true}
{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
    <meta name="robots" content="noindex, nofollow, noarchive">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <title>{$page_title}</title>
    {grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
    <script language="JavaScript" type="text/javascript">
        jQuery.noConflict();
    </script>
    {grn_load_css file="grn/html/std.css"}
    {grn_load_css file="grn/html/msgbox.css"}
    {grn_load_css file="grn/html/treeview.css"}
    {grn_load_css file="grn/html/print.css" media="print"}
    {grn_load_css file="grn/html/image_grn.css"}
    {grn_load_css file="grn/html/mail.css"}
    {grn_load_css file="grn/html/schedule.css"}
    {grn_load_css file="grn/html/workflow.css"}
    {grn_load_application_specific_header}
    {grn_load_search_css}

    <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">

    {if !$is_print_page}
        {if $kintone_dialog_mode}
            {grn_load_css file="grn/html/Design-mm.css"}
            {grn_load_css file="grn/html/Design_relation_style.css"}
        {else}
            {grn_design assign="design"}
            {if ! $design}
                {grn_load_css file="grn/html/Design-mm.css"}
            {else}
                <link href="{$app_path}/grn/html/{$design}.css?{$build_date}" rel="stylesheet" type="text/css">
            {/if}
        {/if}
    {else}
    {literal}
        <style>#headerimage { display:none; }</style>
    {/literal}
    {/if}
    {if $browser.type == "mobilesafari" || $browser.type == "android"}
        <link href="{$app_path}/grn/html/specific-{$browser.type}.css?{$build_date}" rel="stylesheet" type="text/css">
    {/if}
    {if $browser.type == "android"}
        {grn_load_css file="grn/html/android.css"}
    {/if}
    {if $browser.type === "msie" && $browser.ver_major <= 11}
        {grn_load_css file="grn/html/ie11.css"}
    {/if}
    <link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
    {grn_load_javascript file="grn/common/base.js"}
    {include file="grn/browser.tpl"}
    {grn_load_javascript file="grn/html/std.js"}
    {grn_load_prototype_js}
    {grn_load_javascript file="grn/html/textarea.js"}
    {grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
    {grn_load_javascript file="fw/yui/build/event/event-min.js"}
    {grn_load_javascript file="fw/yui/build/dom/dom-min.js"}
    {grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
    {grn_load_javascript file="fw/yui/build/treeview/treeview-min.js"}
    {grn_load_javascript file="fw/yui/build/json/json-min.js"}
    {grn_load_javascript file="grn/html/fag_tree_26.js"}
    {grn_load_javascript file="grn/html/tree.js"}
    {grn_load_javascript file="grn/html/tree-facilitygroup.js"}
    {grn_load_javascript file="grn/html/tree-organization-item.js"}
    {grn_load_javascript file="grn/html/text_multilanguage.js"}
    {grn_load_javascript file="grn/html/component/autofit.js"}
    {grn_load_javascript file="grn/html/msgbox.js"}
    {grn_load_javascript file="grn/html/com_header.js"}
    {grn_load_javascript file="grn/html/component/button.js"}

    {include file="grn/url_builder.tpl"}

    {grn_load_javascript file="grn/html/component/i18n.js"}
    {grn_load_javascript_resource}
    {include file="grn/component/ajax.tpl"}
    {include file="grn/_common_js.tpl"}

    {if $is_print_page}
        {grn_load_javascript file="grn/html/print.js"}
    {/if}

    {if ! $kintone_dialog_mode}
        <script type="text/javascript" language="javascript">
            var command_show_hide_applicationMenu_url ="{grn_pageurl page='grn/ajax_state_application_menu'}";
            var ajax_my_space_list_url = "{grn_pageurl page='grn/ajax_my_space_list'}";
            var ajax_app_menu_url = "{grn_pageurl page='grn/ajax_app_menu'}";
            var link_spiner = '{grn_image image="spinner.gif"}';

            var get_data_notification_url ="{grn_pageurl page='notification/ajax/page_header'}";
            var get_number_notification_url ="{grn_pageurl page='grn/ajax_get_number_notification'}";
            var get_favour_notify_list_url ="{grn_pageurl page='grn/ajax_get_favour_notify_list'}";

            var get_auto_data_url ="{grn_pageurl page='grn/get_data_auto_complete'}";

            grn.html.com_header.setNextUpdateNotification({grn_get_update_notification_time_header});

            {literal}
            jQuery(function () {
                var container_wrap_element = document.getElementById("container-wrap");
                if (container_wrap_element) {
                    container_wrap_element.focus();
                }
            });
            {/literal}

            grn.component.button.util.addEventListenerForAutoDisableButton();
        </script>
    {/if}
    <script type="text/javascript" language="javascript">
        {grn_common_data_for_javascript}
    </script>
    {include file="grn/_head_customization.tpl"}
    <script type="text/javascript" language="javascript">
        grn.html.com_header.addEventListenerForResizeWindow();
    </script>
</head>

<body {if isset($onunload)}onUnload="{$onunload}"{/if} {if isset($onBeforeUnload)}onBeforeUnload="{$onBeforeUnload}"{/if} {if isset($onload)}onload="{$onload}"{/if} class="print_body_grn">
{if !$is_print_page}
    {include file="grn/_head_common.tpl"}
{/if}
<div id="body">
    <table class="layout" id="headerimage" width="100%"><tr><td class="seasonHeader"><br></td></table>

{literal}
<style >
<!--
body
{
    background:#ffffff;
}

.view_sh
{
    width:650px;
    font-size: 12pt;
}
.setting_view_sh
{
    background-color:#DDDDDD;
    border:1px dashed #666666;
    margin:0;
    padding:0;
    width:100%;
}

.ShareRepeat
{

}
.HolidayNoIcon, .AnniversaryNoIcon, .Weather
{

}
.br_banner_print
{
    padding:2px;
    font-size:80%;
    border:1px solid #000000;
}
.s_banner_print
{
    padding:2px;
    font-size:80%;
    vertical-align:top;
    border:1px solid #000000;
}
.s_banner_print a
{
    color: #000000;
}

.border_black
{
    border-color: #000000;
}
-->
</style>
{/literal}
<script language="JavaScript" type="text/javascript"><!--
<!--
{literal}
var FullTitlesContent = new Array();//save info all titles wil be print
var FullTitlesElement;
var MenusContent = new Array();//save info all menu wil be print
var MenusElement;
var TitlesDisplayElement; // elment for view title
Event.observe(window, 'load', function() {
    // title
    FullTitlesElement =  $$('span.spanFullTitle');
    for(var i=0; i<FullTitlesElement.length; i++)
    {
        FullTitlesContent[FullTitlesContent.length] = FullTitlesElement[i].innerHTML;
    }
    // menu
    MenusElement =  $$('span.spanMenu');
    for(var i=0; i<MenusElement.length; i++)
    {
        MenusContent[MenusContent.length] = MenusElement[i].innerHTML;
    }
    // title display
    TitlesDisplayElement =  $$('span.spanTitleDisplay');
    
    ResetValueSetting();//for firefox
});
function ResetValueSetting()
{
  $("LW").value = 650;
  $("FS").selectedIndex = 4;
  $("EL").selectedIndex = 1;
  $("ET").selectedIndex = 1;
  $("ei").checked = 'checked';
  $("ho").checked = 'checked';
  $("an").checked = 'checked';
  $("bz").checked = 'checked';
}
function SetWidth(WidthValue)
{

    var WidthValue =$("LW").value;
    if( isNaN(WidthValue) )
    {
        WidthValue = 650;
        $("LW").value = WidthValue;
    }
  if( WidthValue < 650 )
  {
    WidthValue = 650;
    $("LW").value = WidthValue;
  }
  else	if( WidthValue >1280)
  {
          WidthValue = 1280;
          $("LW").value = WidthValue;
  }
  $("view").style.width =  WidthValue + "px";
}
function setLengthCharacter(lengthValue)
{
  var numTitle = FullTitlesElement.length;
  for( var i=0; i < numTitle; i++)
  {
    if(lengthValue == -1)// only menu
    {
        if ( MenusContent[i].length == 0)
        {
            TitlesDisplayElement[i].innerHTML = "&nbsp;--";
        }
        else
        {
            TitlesDisplayElement[i].innerHTML = MenusContent[i];
        }
    }
    else if(lengthValue == 0) //all
    {
        TitlesDisplayElement[i].innerHTML = FullTitlesContent[i];
    }
    else // substring title
    {
        TitlesDisplayElement[i].innerHTML = FullTitlesContent[i].substring(0,lengthValue);
    }
  }
}
function DisplayElement(typeElement, valueCheck)
{
    var displayType = "inline";
  if(!valueCheck)
  {
    displayType = "none";
  }
  var updateElements = $$(typeElement);
  var numElements = updateElements.length;
  for(var i=0; i < numElements; i++)
  {
    updateElements[i].style.display = displayType;
  }
}
function DisplayHolidays(valueCheck)
{
  if( valueCheck )
  {
    DisplayElement("span.spanHoliday",true);
  }
  else
  {
    DisplayElement("span.spanHoliday",false);
  }
}
function DisplayAnniversarys(valueCheck)
{
    if( valueCheck )
    {
        DisplayElement("span.spanAnniversary",true);
    }
    else
    {
        DisplayElement("span.spanAnniversary",false);
    }
}
function SetDisplayEndTime(valueDisplay)
{
  if(valueDisplay == "1")
  {
    DisplayElement("'span.EndTimeDisplay",true);
  }
  else
  {
    DisplayElement("'span.EndTimeDisplay",false);
  }
}
function SwitchConfig() {
    var state = $("setting").style.display;
    if(state == "none" || state == "")
    {
      $('setting').update('Toggle setting_view_sh on');
    }
    else
    {
      $('setting').update('Toggle setting_view_sh off');
    }
}
{/literal}
//-->
</script>
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/print_personal_month'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<TABLE style="WIDTH: 600px" border=0>
  <TBODY>
    <TR>
      <TD><B>{grn_date_format_switch date=$bdate format="DateFull_YM"}
      {$schedule_name|escape:"html"} {cb_msg module='grn.schedule' key='GRN_SCH-666' replace='true'}</B></TD>
    </TR>
  </TBODY>
</TABLE>
{**setting**}
<div id="div_print_setting">
<table class="table_plain_grn print_action_base_grn">
  <tr>
    <td nowrap>
      <table border="0" cellspacing="0" cellpadding="4" width="100%">
        <tr>
         <td nowrap>
          <font size="+1">{cb_msg module='grn.schedule' key='GRN_SCH-868' replace='true'}</font>
          <font size="-1">{cb_msg module='grn.schedule' key='GRN_SCH-833' replace='true'}</font>
         </td>
        </tr>
      </table>
      <br> {**setting**}
      <table class="formTable">
        <col nowrap/>
        <col nowrap/>
        <tbody>
          <tr>
            <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-834' replace='true'}</td>
            <td><input type="text" style="ime-mode: disabled;" value="650"
              size="5" id="LW" /> {cb_msg module='grn.schedule' key='GRN_SCH-835' replace='true'}
            <button onclick="SetWidth()" type="button">{cb_msg module='grn.schedule' key='GRN_SCH-836' replace='true'}</button>
            </td>
          </tr>
          <tr>
            <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-837' replace='true'}</td>
            <td><select onchange="setFontSize(this.value)" id="FS">
              <option value="8pt">8pt</option>
              <option value="9pt">9pt</option>
              <option value="10pt">10pt</option>
              <option value="11pt">11pt</option>
              <option value="12pt" selected="">12pt</option>
              <option value="13pt">13pt</option>
              <option value="14pt">14pt</option>
              <option value="15pt">15pt</option>
              <option value="16pt">16pt</option>
              <option value="17pt">17pt</option>
              <option value="18pt">18pt</option>
              <option value="19pt">19pt</option>
              <option value="20pt">20pt</option>
            </select>
            &nbsp;
            </td>
          </tr>
          <tr>
            <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-838' replace='true'}</td>
            <td><select onchange="setLengthCharacter(this.value)" id="EL">
              <option value="-1">{cb_msg module='grn.schedule' key='GRN_SCH-839' replace='true'}</option>
              <option value="0" selected="">{cb_msg module='grn.schedule' key='GRN_SCH-840' replace='true'}</option>
              <option value="5">5{cb_msg module='grn.schedule' key='GRN_SCH-841' replace='true'}</option>
              <option value="10">10{cb_msg module='grn.schedule' key='GRN_SCH-841' replace='true'}</option>
              <option value="15">15{cb_msg module='grn.schedule' key='GRN_SCH-841' replace='true'}</option>
              <option value="20">20{cb_msg module='grn.schedule' key='GRN_SCH-841' replace='true'}</option>
            </select></td>
          </tr>
          <tr>
            <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-842' replace='true'}</td>
            <td><select onchange="SetDisplayEndTime(this.value);" id="ET">
              <option value="0">{cb_msg module='grn.schedule' key='GRN_SCH-843' replace='true'}</option>
              <option  value="1">{cb_msg module='grn.schedule' key='GRN_SCH-844' replace='true'}</option>
            </select></td>
          </tr>
          <tr>
            <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-845' replace='true'}</td>
            <td><input type="checkbox" value="1" onclick="DisplayElement('span.ShareRepeat',this.checked)"
              name="EI" id="ei" /><label onmouseout='this.style.color=""'
              onmouseover='this.style.color="#ff0000"' for="ei" style="">{cb_msg module='grn.schedule' key='GRN_SCH-846' replace='true'}</label>
            <br />
            <input type="checkbox" onclick="DisplayHolidays(this.checked)"
              checked="" name="HO" id="ho" /><label
              onmouseout='this.style.color=""'
              onmouseover='this.style.color="#ff0000"' for="ho">{cb_msg module='grn.schedule' key='GRN_SCH-847' replace='true'}</label> <br />
            <input type="checkbox" value="1" onclick="DisplayAnniversarys(this.checked)"
              checked="" name="AN" id="an" /><label
              onmouseout='this.style.color=""'
              onmouseover='this.style.color="#ff0000"' for="an">{cb_msg module='grn.schedule' key='GRN_SCH-848' replace='true'}</label> <br />
            <input type="checkbox" value="1" onclick="DisplayElement('span.Weather, span.SixKindsOfDay',this.checked)"
              name="BZ" id="bz" /><label onmouseout='this.style.color=""'
              onmouseover='this.style.color="#ff0000"' for="bz">{cb_msg module='grn.schedule' key='GRN_SCH-849' replace='true'}</label>
            </td>
          </tr>
          <tr>
            <td align="right">{cb_msg module="grn.schedule" key="LOCALE_SETTING" replace="true"}</td>
            <td>
              <select onchange="setLocale(this.value)" id="Locale">
                <option value="user">{cb_msg module="grn.schedule" key="USER_SETTING" replace="true"}</option>
                <option value="system">{cb_msg module="grn.schedule" key="SYSTEM_SETTING" replace="true"}</option>
              </select>
              &nbsp;
            </td>
          </tr>
          <tr>
            <td><br /></td>
            <td>
                {strip}
                    <div class="mTop10 mBottom5">
                        {capture name='grn_schedule_GRN_SCH_869'}{cb_msg module='grn.schedule' key='GRN_SCH-869' replace='true'}{/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_869 id="schedule_button_print" onclick="doPrint();return false;" auto_disable=false}

                        {capture name='grn_schedule_GRN_SCH_870'}{cb_msg module='grn.schedule' key='GRN_SCH-870' replace='true'}{/capture}
                        {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_870 id="schedule_button_cancel" page="schedule/personal_month" page_param_event=$event page_param_uid=$uid page_param_gid=$gid page_param_bdate=$bdate}
                    </div>
                {/strip}
            </td>
          </tr>
        </tbody>
      </table>
    </td>
  </tr>
</table>
</div>
<p>
{**calendar**}
<div id="one_parts">
 <div id="view" style="" class="view_sh">
  <table width="100%" border="1px" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border: 1px solid #000000">
   <colgroup>
    <col width="12%">
    <col width="12%">
    <col width="12%">
    <col width="12%">
    <col width="12%">
    <col width="12%">
    <col width="12%">
   </colgroup>
   <tbody id="um__body">
    <tr>
    {section name=cnt start=0 loop=7}
      {assign var="tmp_startwday" value="`$smarty.section.cnt.index+$cy_schedule_um_startwday`"}
      {assign var="number" value="`$tmp_startwday%7`"}
      <th align="center" class="border_black">{grn_msg_switch module="fw.date" key="WDayShort`$number`"}</th>
    {/section}
    </tr>

{foreach from=$schedule.week key=week_key item=week}
 {if $week_key < $cy_schedule_um_buffer_count || $week_key >= ($cy_schedule_um_buffer_count + $javascript_value_list.cy_schedule_um_week_display) }
  {assign var='display_flag' value='false'}
 {else}
  {assign var='display_flag' value='true'}
 {/if}
   <tr id="um__{$week.trid}" {if $display_flag == 'false' }style="display:none;"{/if}>
 {foreach from=$week.schedule_event item=week_event}
    <td valign="top"   height="60px" class="border_black">
     <table width="100%" cellspacing="0" cellpadding="2">
      <tr>
       <td valign="top" style="border-bottom:1px solid #000000;" nowrap>
        {grn_date_format_switch date=$week_event.date format="DateShort_MD" page="personal_month"}
       </td>
      </tr>
   {foreach from=$week_event.calendar item=calendar}
      <tr>
       <td>
                {if $calendar.type == "1"}
                <span class="spanHoliday">
                    {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                </span>
                {elseif $calendar.type == "2"}
                <span class="spanAnniversary">
                    {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                </span>
                {elseif $calendar.type == "5"}
                <span class="spanAnniversary">
                    {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                </span>
                {elseif $calendar.type == "weather"}
                <span class="Weather">
                  {grn_image image=$calendar.data.info.image}{$calendar.data.location_name}
                </span>
                {elseif $calendar.type == "six_kinds_of_day"}
                <span class="SixKindsOfDay">{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}</span>
                {/if}
       </td>
      </tr>
   {/foreach}
{strip}
   {foreach from=$week_event.event item=event}
      <tr>
       <td>
       <div class="{$event.type} normalEventElement personalMonth_calendar_item">
        {if $event.str_date neq ''}
          <div class="listTime">{$event.str_date|grn_noescape}</div>
        {/if}
        <div class="personalMonthEventTitle{if $event.allday}Allday{/if}">
        {if ! $event.private}
            {if $event.conflict}
                <span class="attention">{capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}{grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}</span>
            {/if}
            {if $event.attendance_check_show}
                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
            {/if}
        {/if}
        {**Begin display title**}        
        <span class="spanTitleDisplay">{$event.str_full_title|grn_noescape}</span>{if $event.str_private}{$event.str_private|grn_noescape}{/if}{if $event.str_extend_item}{$event.str_extend_item|grn_noescape}{/if}
        <div style="display:none;"><span class="spanMenu">{$event.str_menu|grn_noescape}</span><span class="spanFullTitle">{$event.str_full_title|grn_noescape}</span></div>
        {**End display title**}
        <span class="ShareRepeat">
          {if $event.is_private}
            {grn_image image="image-common/privateMark_sub16.png"}
          {/if}
          {if $event.type == 'share_repeat' || $event.type == 'repeat'}
                {grn_image image="repeat16.gif"}
          {/if}
         </span>
         </div>
       </div>
       </td>
      </tr>
   {/foreach}
{/strip}
     </table>
    </td>
 {/foreach}
   </tr>
 {grn_schedule_weekbanner banner_events=$week.banner_event page='schedule/view' setdate=$week.week_start enddate=$week.week_end banner_class='s_banner_print' blank_class='br_banner_print' banner_image='banner16.gif' uid=$schedule.user_id gid=$group_id referer_key=$referer_key trid=$week.trid display_flag=$display_flag onclick="return false;"} 
{/foreach}
   </tbody>
  </table>
  <div class="none">&nbsp;</div>
  <table width="100%">
   <colgroup>
    <col width="6%">
{foreach from=$month_count item=month}
    <col width="5%">
{/foreach}
    <col width="6%">
    <col width="*">
   </colgroup>
   <tr>
    <td align="center" nowrap="">
    </td>
   </tr>
  </table>
 </div>
 <!--view_end--->
</div>
</form>
<div id="timezone-name"><span id="timezone-name-title">{grn_msg_switch module='grn.schedule' key='TIMEZONE'}</span><span id="timezone-name-data">{cb_msg module='fw.timezone' key=$timezone_name}</span></div>
</div>
</body>
</html>
