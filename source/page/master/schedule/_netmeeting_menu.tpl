{**
 * @updated:
 *    2011/06/08 VCBSCH0010 Sync for V-CUBE
 **}
{if $schedule_event.netmeeting}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
{/literal}
{if $schedule_event.netmeeting.available_facilities}
{literal}
    var vcb_faci_item = new Array();
{/literal}
{foreach name=vcb_item_loop from=$schedule_event.netmeeting.available_facilities item=vcb_item}
 {if $vcb_item}
{literal}
    vcb_faci_item.push('{/literal}{$vcb_item}{literal}');
{/literal}
 {/if}
{/foreach}
{/if}
{literal}
function netmeeting_onchange(obj,idx)
{
    var txt = document.getElementById(obj.name + idx);
    if( txt )
    {
        txt.value = obj.value;
    }
}
/**
 *
 * @param {string[]} selected_facility_ids ["1", "4", "33"]
 * @returns {boolean}
 */
function netmeeting_is_selected( selected_facility_ids )
{
    if( ! selected_facility_ids ) return false;
    if( selected_facility_ids.length == 0 ) return false;
    if( vcb_faci_item.length == 0 ) return false;

    for( var i = 0; i < selected_facility_ids.length; i++ )
    {
        if( selected_facility_ids[i] )
        {
            for( var j = 0; j < vcb_faci_item.length; j++ )
            {
                if ( selected_facility_ids[i] == vcb_faci_item[j] )
                {
                    return true;
                }
            }
        }
    }
    return false;
}
function netmeeting_display_on()
{
    document.getElementById('netmeeting_field').style.display = "";
    return;
}
function netmeeting_display_off()
{
    document.getElementById('netmeeting_field').style.display = "none";
    return;
}
function netmeeting_facility_items_OnOff( options )
{
    if( netmeeting_is_selected( options ) )
    {
        netmeeting_display_on();
    }
    else
    {
        netmeeting_display_off();
    }
}

function netmeeting_check_facility( f )
{
    grn.component.member_add.get_instance('member_select').prepareSubmit();
    insert_values(f, 'adjust');
    var facility_list = grn.component.facility_add.get_instance("facility_select");
    if (facility_list) {
        return netmeeting_is_selected(facility_list.facilityList.getValues());
    }
    return false;
}
//-->
</script>
{/literal}
  <tr id="netmeeting_field" valign="top"{if ! $schedule_event.netmeeting.netmeeting_field_dsp} style="display:none;"{/if}>
   <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-1' replace='true'}</th>
   <td>
       <table class="address" cellpadding="3">
        <colgroup>
         <col width="5%">
         <col width="95%">
        </colgroup>
  {if $schedule_event.netmeeting_password_dsp}
        <tr valign="top">
         <th nowrap>
          {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-2' replace='true'}
         </th>
         <td>
          {if $schedule_event.netmeeting.password_mod}
           {assign var='vcb_pson' value=false}
           {capture name='grn_schedule_GRN_VCB_21'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-21' replace='true'}{/capture}{grn_radio name="netmeeting_password_set" id="netmeeting_password_set_off" value="0" caption=$smarty.capture.grn_schedule_GRN_VCB_21 checked=false onclick='display_off(\'netmeeting_password_field\')'}
           {capture name='grn_schedule_GRN_VCB_22'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-24' replace='true'}{/capture}{grn_radio name="netmeeting_password_set" id="netmeeting_password_set_on" value="1" caption=$smarty.capture.grn_schedule_GRN_VCB_22 checked=false onclick='display_on(\'netmeeting_password_field\')'}
           {capture name='grn_schedule_GRN_VCB_23'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-23' replace='true'}{/capture}{grn_radio name="netmeeting_password_set" id="netmeeting_password_set_mod" value="2" caption=$smarty.capture.grn_schedule_GRN_VCB_23 checked=true onclick='display_off(\'netmeeting_password_field\')'}
          {else}
           {if $schedule_event.netmeeting.password_add}{assign var='vcb_psof' value=false}{assign var='vcb_pson' value=true}{else}{assign var='vcb_psof' value=true}{assign var='vcb_pson' value=false}{/if}
           {capture name='grn_schedule_GRN_VCB_21'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-21' replace='true'}{/capture}{grn_radio name="netmeeting_password_set" id="netmeeting_password_set_off" value="0" caption=$smarty.capture.grn_schedule_GRN_VCB_21 checked=$vcb_psof onclick='display_off(\'netmeeting_password_field\')'}
           {capture name='grn_schedule_GRN_VCB_22'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-22' replace='true'}{/capture}{grn_radio name="netmeeting_password_set" id="netmeeting_password_set_on" value="1" caption=$smarty.capture.grn_schedule_GRN_VCB_22 checked=$vcb_pson onclick='display_on(\'netmeeting_password_field\')'}
          {/if}
          <div id="netmeeting_password_field"{if ! $vcb_pson} style="display:none;"{/if}>
          {grn_password name='netmeeting_password' purpose='init' size='50' maxlength=$schedule_event.netmeeting.outside_pass_len value='' disable_return_key=true}<br />
          {grn_password name='netmeeting_retype' purpose='init' size='50' maxlength=$schedule_event.netmeeting.outside_pass_len value='' disable_return_key=true}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-3' replace='true'}
          </div>
         </td>
        </tr>
  {/if}
  {if $schedule_event.netmeeting.outside_rows > 0}
        <tr valign="top">
         <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-4' replace='true'}</th>
         <td>
          <table class="netmeeting">
           <thead>
           <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-5' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-6' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-7' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-8' replace='true'}</th>
    {if $schedule_event.netmeeting.netmeeting_type_dsp}
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-9' replace='true'}</th>
    {/if}
           </tr>
           </thead>
           <tbody>
    {foreach name=vcb_outside_loop from=$schedule_event.netmeeting.outside_items item=vcb_outside_item}
      {assign var='vcb_row_idx' value=$smarty.foreach.vcb_outside_loop.index}
           <tr valign="top">
            <td>{grn_text name='netmeeting_outside_name[]' value=$vcb_outside_item.name size='25' maxlength=$schedule_event.netmeeting.outside_name_len disable_return_key=true}</td>
            <td>{grn_text name='netmeeting_outside_email[]' value=$vcb_outside_item.email size='25' maxlength=$schedule_event.netmeeting.outside_mail_len disable_return_key=true}</td>
            <td>
             {grn_select name='sel_netmeeting_outside_lang' options=$vcb_outside_item.lang_options onchange='netmeeting_onchange(this,'|cat:$vcb_row_idx|cat:');'}
             <input type="hidden" id="sel_netmeeting_outside_lang{$vcb_row_idx}" name="netmeeting_outside_lang[]" value="{$vcb_outside_item.lang}">
            </td>
            <td>
             {grn_select name='sel_netmeeting_outside_timezone' options=$vcb_outside_item.tmzn_options onchange='netmeeting_onchange(this,'|cat:$vcb_row_idx|cat:');'}
             <input type="hidden" id="sel_netmeeting_outside_timezone{$vcb_row_idx}" name="netmeeting_outside_timezone[]" value="{$vcb_outside_item.tmzn}">
            </td>
      {if $schedule_event.netmeeting.netmeeting_type_dsp}
            <td>
             <select name="sel_netmeeting_outside_type" onchange="netmeeting_onchange(this,{$vcb_row_idx});">
              <option value="{$schedule_event.netmeeting.type_list[0]|escape}"{if $vcb_outside_item.type == $schedule_event.netmeeting.type_list[0]} selected{/if}>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-13' replace='true'}</option>
              <option value="{$schedule_event.netmeeting.type_list[1]|escape}"{if $vcb_outside_item.type == $schedule_event.netmeeting.type_list[1]} selected{/if}>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-14' replace='true'}</option>
             </select>
             <input type="hidden" id="sel_netmeeting_outside_type{$vcb_row_idx}" name="netmeeting_outside_type[]" value="{$vcb_outside_item.type}">
            </td>
      {/if}
           </tr>
    {/foreach}
           </tbody>
          </table>
         </td>
        </tr>
  {/if}
       </table>
   </td>
  </tr>
{/if}
