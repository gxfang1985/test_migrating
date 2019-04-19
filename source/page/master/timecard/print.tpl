{assign var="is_print_page" value=true}
{capture name="print_page_name"}{grn_appname app_id='timecard'} {cb_msg module='grn.timecard' key='GRN_TIM-42' replace='true'}{/capture}
{assign var="page_title" value=$smarty.capture.print_page_name}
{include file="grn/head.tpl"}

<body bgcolor="#ffffff" class="print_body_grn">
    <div id="div_print_setting">
      <table class="table_plain_grn print_action_base_grn">
        <tbody>
          <tr>
            <td nowrap="">
              <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="">
                      <font size="+1">{cb_msg module="grn.timecard" key="PRINT_SETTING" replace="true"}</font>
                      <font size="-1">{cb_msg module="grn.timecard" key="THIS_AREA_WILL_NOT_BE_PRINTED" replace="true"}</font>
                    </td>
                  </tr>
                </tbody>
              </table>
              <br />
              <table class="formTable">
                <colgroup>
                  <col nowrap>
                  <col nowrap>
                </colgroup>
                <tbody>
                  <tr>
                    <td align="right">{cb_msg module="grn.timecard" key="FONT_SIZE" replace="true"}</td>
                    <td>
                      <select onchange="setFontSize(this.value)" id="FontSize">
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
                    <td align="right">{cb_msg module="grn.timecard" key="LOCALE_SETTING" replace="true"}</td>
                    <td>
                      <select onchange="setLocale(this.value)" id="Locale">
                        <option value="user">{cb_msg module="grn.timecard" key="USER_SETTING" replace="true"}</option>
                        <option value="system">{cb_msg module="grn.timecard" key="SYSTEM_SETTING" replace="true"}</option>
                      </select>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                      <td align="right">{cb_msg module='grn.timecard' key='GRN_TIM-59' replace='true'}</td>
                      <td>
                          {capture name='grn_timecard_GRN_TIM_60'}
                              {cb_msg module='grn.timecard' key='GRN_TIM-60' replace='true'}
                          {/capture}
                          {grn_checkbox id="show_timecard_ip" name="show_timecard_ip" value="1" caption=$smarty.capture.grn_timecard_GRN_TIM_60 onclick="display_on_off_check_by_name(this, 'timecard_ip')"}
                      </td>
                  </tr>
                  <tr>
                    <td align="right"></td>
                    <td>
                      <div class="mTop10 mBottom5">
                        {strip}
                          {capture name='grn_timecard_print'}{cb_msg module="grn.timecard" key="PRINT" replace="true"}{/capture}
                          {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_timecard_print id="print_button_save" onclick="doPrint();return false;" auto_disable=false}

                          {capture name='grn_timecard_back'}{cb_msg module="grn.timecard" key="BACK" replace="true"}{/capture}
                          {if $is_system}
                            {capture name='grn_timecard_back_url'}
                              {grn_pageurl page='timecard/system/timecard_view' date=$date_str uid=$user_id oid=$oid}
                            {/capture}
                          {else}
                            {capture name='grn_timecard_back_url'}
                              {grn_pageurl page='timecard/index' date=$date_str}
                            {/capture}
                          {/if}
                          {capture name='grn_timecard_back_onclick'}
                            location.href='{$smarty.capture.grn_timecard_back_url|htmlspecialchars_decode}';
                          {/capture}
                          {grn_button action="cancel" caption=$smarty.capture.grn_timecard_back id="print_button_cancel" onclick=$smarty.capture.grn_timecard_back_onclick}
                        {/strip}
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </tbody>
      </table>      
    </div>
    <div id="view">
<b>{grn_user_name uid=$user_id name=$user_name nolink=TRUE noimage=TRUE} {grn_msg_switch module='grn.timecard' key='GRN_TIM-43'}{grn_appname app_id='timecard'}</b><p>
<b>{$date.year}{grn_msg_switch module='grn.timecard' key='GRN_TIM-44'}{$date.month|string_format:"%02d"}{grn_msg_switch module='grn.timecard' key='GRN_TIM-45'}</b>
<table class="timecardPrint-grn" border="1" cellspacing="0" cellpadding="2" bordercolor=#000000 style="border-collapse:collapse;font-size:100%;">
  <tr>
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-46'}</th>
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-47'}</th>
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-48'}</th>
{foreach from=$config.absence_max_list item=value}
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-49'}</th>
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-50'}</th>
{/foreach}
    <th>{grn_msg_switch module='grn.timecard' key='GRN_TIM-51'}</th>
  </tr>
{foreach from=$timecards item=card}
  <tr>
    <td class="tAlignRight-grn">{grn_timecard_date date=$card.date}</td>
    <td class="tAlignCenter-grn">
      {if $card.start }
        {grn_date_format_switch date=$card.start  format="TimeShort_HM"}
        {if $card.start_ip}
          <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$card.start_ip}</div>
        {/if}
      {else}
        <br>
      {/if}
    </td>
    <td class="tAlignCenter-grn">
      {if $card.finish}
        {grn_date_format_switch date=$card.finish format="TimeShort_HM"}
        {if $card.finish_ip}
          <div id="timecard_ip"  name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$card.finish_ip}</div>
        {/if}
      {else}
        <br>
      {/if}
    </td>
    {foreach from=$card.absences item=absence}
      <td class="tAlignCenter-grn">
        {if $absence.trip}
          {grn_date_format_switch date=$absence.trip format="TimeShort_HM"}
          {if $absence.trip_ip}
            <div id="timecard_ip"  name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$absence.trip_ip}</div>
          {/if}
        {else}
          <br>
        {/if}
      </td>
      <td class="tAlignCenter-grn">
        {if $absence.back}
          {grn_date_format_switch date=$absence.back format="TimeShort_HM"}
          {if $absence.back_ip}
            <div id="timecard_ip"  name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$absence.back_ip}</div>
          {/if}
        {else}
          <br>
        {/if}
      </td>
    {/foreach}
    <td align="left">{if strlen($card.remarks) > 0}{$card.remarks|escape}{else}<br>{/if}</td>
  </tr>
{/foreach}
</table>
<div id="timezone-name"><span id="timezone-name-title">{grn_msg_switch module='grn.timecard' key='TIMEZONE'}</span><span id="timezone-name-data">{grn_msg_switch module='fw.timezone' key=$timezone_name}</span></div>
</div>

</body>
</html>
