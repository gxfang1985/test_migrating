{if $schedule_event.private_setting == 1}
    {assign var='event_non_private' value=false}
    {assign var='event_private' value=true}
    {assign var='event_private_select' value=false}
{elseif $schedule_event.private_setting == 2}
    {assign var='event_non_private' value=false}
    {assign var='event_private' value=false}
    {assign var='event_private_select' value=true}
{else}
    {assign var='event_non_private' value=true}
    {assign var='event_private' value=false}
    {assign var='event_private_select' value=false}
{/if}
<tr>
 <th>{cb_msg module='grn.schedule' key='GRN_SCH-392' replace='true'}</th>
 <td>
{strip}
  {capture name='grn_schedule_GRN_SCH_393'}{cb_msg module='grn.schedule' key='GRN_SCH-393' replace='true'}{/capture}{grn_radio name="private" id="1" value="0" caption=$smarty.capture.grn_schedule_GRN_SCH_393 checked=$event_non_private onclick='display_off(\'private_select\')' span_cover="1"}
  {capture name='grn_schedule_GRN_SCH_394'}{cb_msg module='grn.schedule' key='GRN_SCH-394' replace='true'}{/capture}{grn_radio name="private" id="2" value="1" caption=$smarty.capture.grn_schedule_GRN_SCH_394 checked=$event_private onclick='display_off(\'private_select\')' span_cover="1"}
  {capture name='grn_schedule_GRN_SCH_395'}{cb_msg module='grn.schedule' key='GRN_SCH-395' replace='true'}{/capture}{grn_radio name="private" id="3" value="2" caption=$smarty.capture.grn_schedule_GRN_SCH_395 checked=$event_private_select onclick='display_on(\'private_select\')' span_cover="1"}
{/strip}
 </td>
</tr>
<tr id="private_select" valign="top" {if ! $event_private_select}style="display:none;"{/if}>
 <th>{cb_msg module='grn.schedule' key='GRN_SCH-396' replace='true'}</th>
 <td>
{if $page_info.last == 'adjust_modify' || $page_info.last == 'adjust_result'}
 {assign var='duplication' value=false}
{else}
 {assign var='duplication' value=true}
{/if}
{assign var='plugin_session_name' value='private_menu'}
{assign var='plugin_data_name' value='access_plugin_private_menu'}
  {php}
         $this->assign('search_box_options',array('is_use'       => TRUE,
                                                  'id_searchbox' => 'private_menu'));
  {/php}
  {grn_member_add name='private_select' form_name=$form_name sUID='p_sUID' CGID='p_CGID' CID='p_CID' selected_users=$schedule_event.notify_address app_id='schedule' access_plugin=$view_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name include_org=false duplication=$duplication org_direct=true search_box_options=$search_box_options include_org=true popup_include_org=true require_role_tab=true show_group_role=$show_group_role}
 </td>
</tr>
