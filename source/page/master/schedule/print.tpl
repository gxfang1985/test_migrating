{assign var="is_print_page" value=true}
{capture name="print_page_name"}{cb_msg module='grn.schedule' key='GRN_SCH-745' replace='true'}{/capture}
{assign var="page_title" value=$smarty.capture.print_page_name}
{include file="grn/head.tpl"}

  <body class="print_body_grn">
    <div id="div_print_setting">
      <table cellspacing="0" cellpadding="4" class="printSetting-grn">
        <tbody>
          <tr>
            <td nowrap="">
              <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="">
                      <font size="+1">{cb_msg module="grn.schedule" key="PRINT_SETTING" replace="true"}</font>
                      <font size="-1">{cb_msg module="grn.schedule" key="THIS_AREA_WILL_NOT_BE_PRINTED" replace="true"}</font>
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
                    <td align="right">{cb_msg module="grn.schedule" key="FONT_SIZE" replace="true"}</td>
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
                    <td align="right"></td>
                    <td>
                        {strip}
                            <div class="mTop10 mBottom5">
                            {capture name='grn_schedule_print'}{cb_msg module="grn.schedule" key="PRINT" replace="true"}{/capture}
                            {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_print id="schedule_button_print" onclick="doPrint();return false;" auto_disable=false}

                            {capture name='grn_schedule_back'}{cb_msg module="grn.schedule" key="BACK" replace="true"}{/capture}
                            {grn_button action="cancel" caption=$smarty.capture.grn_schedule_back id="schedule_button_cancel" page="schedule/view" page_param_event=$event page_param_bdate=$bdate page_param_uid=$user_id page_param_gid=$group_id}
                            </div>
                        {/strip}
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </tbody>
      </table>      
    </div>
    <div id="view" style="margin-top:5px;">
    {if $is_same_day}
    {assign var='string_format_datetime' value='TimeShort_HM'}
    {else}
    {assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
    {/if}
      <table class="viewTablePrint-grn">
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-746' }</th>
   <td>{$schedule_event.title|escape:"html"}</td>
  </tr>
{if $schedule_event.type == 'banner' || $schedule_event.type == 'share_banner'}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-747' }</th>
   <td>{grn_date_format_switch date=$schedule_event.start_date format="DateTimeLong_YMDW_HM"}{grn_msg_switch module='grn.schedule' key='GRN_SCH-748' }{grn_date_format_switch date=$schedule_event.end_date format=$string_format_datetime}</td>
  </tr>
{elseif $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-749' }</th>
   <td>{if $schedule_event.start_time}{grn_date_format_switch date=$schedule_event.start_time format="DateTimeLong_YMDW_HM"}{/if}{if $schedule_event.end_time}{grn_msg_switch module='grn.schedule' key='GRN_SCH-750' }{grn_date_format_switch date=$schedule_event.end_time format=$string_format_datetime}{/if}</td>
  </tr>
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-752' }</th>
   <td>{if $schedule_event.start_date}{grn_date_format_switch date=$schedule_event.start_date format="DateLong_YMDW"}{/if}{if $schedule_event.end_date}{grn_msg_switch module='grn.schedule' key='GRN_SCH-753' }{grn_date_format_switch date=$schedule_event.end_date format="DateFull_YMDW"}{/if}<span class="user">{$schedule_event.repeat_data.user}</span><span class="system" style="display:none;">{$schedule_event.repeat_data.system}</span></td>
  </tr>
{elseif $schedule_event.type == 'temporary' || $schedule_event.type == 'share_temporary'}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-754' }</th>
   <td nowrap>

 {if $schedule_event.temporary_type == 'or'}
  {foreach from=$schedule_event.temporary item=facility_data}
   <strong>{$facility_data.facility_name|escape}</strong><br>
   {foreach from=$facility_data.dates item=temporary}
    {grn_date_format_switch date=$temporary.setdatetime format="DateTimeLong_YMDW_HM"}{grn_msg_switch module='grn.schedule' key='GRN_SCH-755' }{grn_date_format_switch date=$temporary.enddatetime format=$temporary.string_datetime}<br>
   {/foreach}
  {/foreach}
 {else}
  {foreach from=$schedule_event.temporary item=temporary}
   {grn_date_format_switch date=$temporary.setdatetime format="DateTimeLong_YMDW_HM"}{grn_msg_switch module='grn.schedule' key='GRN_SCH-756' }{grn_date_format_switch date=$temporary.enddatetime format=$temporary.string_datetime}&nbsp;<br>
  {/foreach}
 {/if}
   </td>
  </tr>
{else}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-757' }</th>
   <td>{if $schedule_event.allday}{grn_date_format_switch date=$schedule_event.start_date format="DateTimeLong_YMDW_HM"}{grn_msg_switch module='grn.schedule' key='GRN_SCH-758' }{grn_date_format_switch date=$schedule_event.end_date format=$string_format_datetime}{grn_msg_switch module='grn.schedule' key='GRN_SCH-759' }{else}{grn_date_format_switch date=$schedule_event.start_date format="DateTimeLong_YMDW_HM"}{if $schedule_event.end_date}{grn_msg_switch module='grn.schedule' key='GRN_SCH-760' }{grn_date_format_switch date=$schedule_event.end_date format=$string_format_datetime}{/if}{/if}</td>
  </tr>
{/if}


{if $schedule_event.address}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-761' }</th>
   <td>
       <table border="1" cellspacing="0" cellpadding="2" style="font-size:100%;border-collapse:collapse;" bordercolor="#333333">
        <colgroup>
         <col width="5%">
         <col width="95%">
        </colgroup>
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-762' }</td>
         <td>{$schedule_event.address.company_name|escape|default:"&nbsp;"}</td>
        </tr>
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-763' }</td>
         <td>{$schedule_event.address.zip_code|escape|default:"&nbsp;"}</td>
        </tr>
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-764' }</td>
         <td>{$schedule_event.address.physical_address|escape|default:"&nbsp;"}</td>
        </tr>
 {if $schedule_event.address.map_image}
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-765' }</td>
         <td>
   {grn_image image=$schedule_event.address.map_image direct=true}
 {/if}&nbsp;
         </td>
        </tr>
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-766' }</td>
         <td>{$schedule_event.address.route|escape}<br>{$schedule_event.address.route_time|escape}&nbsp;{grn_msg_switch module='grn.schedule' key='GRN_SCH-767' }<br>{$schedule_event.address.route_fare|escape}&nbsp;{grn_msg_switch module='grn.schedule' key='GRN_SCH-768' }</td>
        </tr>
        <tr valign="top" align="left">
         <td nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-769' }</td>
         <td>{$schedule_event.address.company_telephone_number|escape|default:"&nbsp;"}</td>
        </tr>
       </table>
   </td>
  </tr>
{/if}
{if $schedule_event.type != 'banner'}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-770' }</th>
   <td>
{foreach name='facility' from=$schedule_event.facility key=faid item=facility}
    <span>{$facility|escape:"html"}{grn_facility_status_switch isApproved=$facilityApprovalData.currentStatus.$faid.isApproved}{if $smarty.foreach.facility.total >= 2 && !($smarty.foreach.facility.last)},{/if}</span>
{/foreach}
{if $extended_items|@count > 0}
    <table border="1" cellspacing="0" cellpadding="3" style="margin:5px;font-size:100%;border-collapse:collapse;" bordercolor="#0000002">
    {foreach from=$extended_items key=item_id item=item}
        {if $item.use}
     <tr>
      <th>{grn_show_input_title title=$item.display_name}</th>
      <td>
            {if $item.type == GRN_SCHEDULE_ITEM_MENU}
                {$item.value|escape}
            {elseif $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
                {grn_format body=$item.value}
            {else}
                {$item.value|escape}
            {/if}
      </td>
     </tr>
        {/if}
    {/foreach}
    </table>
{/if}    
   
   
   
   
   
   
   </td>
  </tr>
{/if}
<!--GTM-1677-->
{if count($facilityApprovalData.currentStatus) > 0}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-1043' }</th>
   <td><pre style="margin:0px;word-wrap:break-word;white-space:normal;">{grn_format body=$facilityApprovalData.usingPurpose}</pre></td>
  </tr>
{/if}
<!--End GTM-1677-->
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-771' }</th>
   <td><pre style="margin:0px;word-wrap:break-word;white-space:normal;">{grn_format body=$schedule_event.memo}</pre></td>
  </tr>
  {if $allow_file_attachment}
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-942' }</th>
   <td>
   {if $schedule_event.attach_files}
   {foreach from=$schedule_event.attach_files item=file}
   <pre style="margin:0px;word-wrap:break-word;white-space:normal;">{grn_format body=$file.name}</pre>
   {/foreach}
   {/if}
   </td>
  </tr>
  {/if}
  {if $schedule_event.isAttendanceCheckEvent}
      <tr valign="top" align="left">
          <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-772' }</th>
          <td>
              {if $schedule_event.usersStatus.groups}
                  <div>
                      <div class="schedule_member_base_print_grn">
                          {foreach name="groups" from=$schedule_event.usersStatus.groups item=group}
                              <span>{$group|escape:"html"}{if $smarty.foreach.groups.total >= 2 && !($smarty.foreach.groups.last)},{/if}</span>
                          {/foreach}
                      </div>
                      <div class="border_partition_common_dashed_grn"></div>
                  </div>
              {/if}
              <table class="table_plain_grn view_table_print_sub_grn">
                  <tr>
                      <th>{grn_msg_switch module='grn.schedule' key='GRN_SCH-1013' replace='true'}{$schedule_event.usersStatus.attendantCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}</th>
                      <td style="width: 1px;">&nbsp;：&nbsp;</td>
                      <td>
                          <div class="schedule_member_base_print_grn">
                              {foreach name="attendants" from=$schedule_event.usersStatus.attendant item=attendant}
                                  <span>{$attendant|escape:"html"}{if $smarty.foreach.attendants.total >= 2 && !($smarty.foreach.attendants.last)},{/if}</span>
                              {/foreach}
                          </div>
                      </td>
                  </tr>
                  <tr>
                      <th>{grn_msg_switch module='grn.schedule' key='GRN_SCH-1014' replace='true'}{$schedule_event.usersStatus.absentCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}</th>
                      <td style="width: 1px;">&nbsp;：&nbsp;</td>
                      <td>
                          <div class="schedule_member_base_print_grn">
                              {foreach name="absents" from=$schedule_event.usersStatus.absent item=absent}
                                  <span>{$absent|escape:"html"}{if $smarty.foreach.absents.total >= 2 && !($smarty.foreach.absents.last)},{/if}</span>
                              {/foreach}
                          </div>
                      </td>
                  </tr>
                  <tr>
                      <th>{grn_msg_switch module='grn.schedule' key='GRN_SCH-1015' replace='true'}{$schedule_event.usersStatus.unconfirmedCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}</th>
                      <td style="width: 1px;">&nbsp;：&nbsp;</td>
                      <td>
                          <div class="schedule_member_base_print_grn">
                              {foreach name="notanswers" from=$schedule_event.usersStatus.unconfirmed item=notanswer}
                                  <span>{$notanswer|escape:"html"}{if $smarty.foreach.notanswers.total >= 2 && !($smarty.foreach.notanswers.last)},{/if}</span>
                              {/foreach}
                          </div>
                      </td>
                  </tr>
              </table>
          </td>
      </tr>
  {else}
      <tr valign="top" align="left">
          <th nowrap>{grn_msg_switch module='grn.schedule' key='GRN_SCH-772' }<br>{grn_msg_switch module='grn.schedule' key='GRN_SCH-773' }{$schedule_event.users_count|escape}{grn_msg_switch module='grn.schedule' key='GRN_SCH-774' }</th>
          <td>
              {grn_schedule_members_name members=$schedule_event.users referer_key=$referer_key nobr=true nolink=yes}
              <br></td>
      </tr>
  {/if}
 </table>
    </div>

</body>
</html>
