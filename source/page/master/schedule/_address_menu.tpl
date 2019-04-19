<tr valign="top">
 <th>{cb_msg module='grn.schedule' key='GRN_SCH-691' replace='true'}</th>
 <td>
  <a href="javascript:display_on_off('address_form')">{cb_msg module='grn.schedule' key='GRN_SCH-692' replace='true'}</a>
   <table class="address" id="address_form" {if ! $schedule_event.address}style="display:none;"{/if}>
    <colgroup>
     <col width="5%">
     <col width="95%">
    </colgroup>
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-693' replace='true'}</th>
     <td>{grn_text name='company_name' value=$schedule_event.address.company_name maxlength='100' size='52' disable_return_key=true}</td>
    </tr>
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-695' replace='true'}</th>
     <td>{grn_text name='zip_code' value=$schedule_event.address.zip_code maxlength='100' size='52' disable_return_key=true}</td>
    </tr>
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-697' replace='true'}</th>
     <td>{grn_text name='physical_address' value=$schedule_event.address.physical_address maxlength='65535' size='52' disable_return_key=true}</td>
    </tr>
{if $schedule_event.address.map_image}
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-698' replace='true'}</th>
      <td>
 {if $schedule_event.address.map_image}
       {grn_image image=$schedule_event.address.map_image name='map_image' id='map_image' direct=TRUE}
 {else}
       {grn_image image='map20.gif' name='map_image' id='map_image'}
 {/if}
       {capture name='grn_schedule_GRN_SCH_700'}{cb_msg module='grn.schedule' key='GRN_SCH-700' replace='true'}{/capture}
       {grn_cbwebsrv_map_clear caption=$smarty.capture.grn_schedule_GRN_SCH_700 form_name=$form_name map_tid="map_url" map_img_tid="map_image" module="schedule"}
     </td>
    </tr>
{/if}<input type="hidden" name="map_url" value="{$schedule_event.address.map_image|escape}">
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-701' replace='true'}</th>
     <td>
      <table class="dataList" id="js_route_search">
       <tr>
        <td nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-702' replace='true'}</td>
        <td>{grn_text name='route' value=$schedule_event.address.route maxlength='65535' size='35' disable_return_key=true}</td>
        <td>&nbsp;</td>
       </tr>
       <tr>
        <td nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-703' replace='true'}</td>
        <td>{grn_text name='route_time' value=$schedule_event.address.route_time size='8' disable_return_key=true}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-704' replace='true'}</td>
        <td>
            {capture name='grn_schedule_GRN_SCH_705'}{cb_msg module='grn.schedule' key='GRN_SCH-705' replace='true'}{/capture}
            {grn_cbwebsrv_route caption=$smarty.capture.grn_schedule_GRN_SCH_705}
        </td>
       </tr>
       <tr>
        <td nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-706' replace='true'}</td>
        <td>{grn_text name='route_fare' value=$schedule_event.address.route_fare size='8' disable_return_key=true}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-707' replace='true'}</td>
        <td>&nbsp;</td>
       </tr>
      </table>
     </td>
    </tr>
    <tr valign="top">
     <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-708' replace='true'}</th>
     <td>{grn_text name='company_telephone_number' value=$schedule_event.address.company_telephone_number size='50' disable_return_key=true}</td>
    </tr>
   </table>
 </td>
</tr>
