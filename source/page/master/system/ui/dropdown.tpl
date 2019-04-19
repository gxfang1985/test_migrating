{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="margin_top explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-228' replace='true'}

<form method="POST" id="set_form" action="{grn_pageurl page='system/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<input type="hidden" id="clear_id" name="clear" value="none" />

<table class="margin_top std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-227' replace='true'}</th>
  <td>
  {capture name="grn_system_ui_GRN_SY_UI_226"}{cb_msg module='grn.system.ui' key='GRN_SY_UI-226' replace='true'}{/capture}{grn_checkbox name="change" id="change_id" value="1" checked=$is_change caption=$smarty.capture.grn_system_ui_GRN_SY_UI_226}
  </td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-242' replace='true'}</th>
  <td>
    <table>
      <tr>
        <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-229' replace='true'}</th>
        <td>
          {grn_select_numbers select_name=$config.group.name options=$config.group.options selected=$config.group.selected}{cb_msg module='grn.system.ui' key='GRN_SY_UI-238' replace='true'}
        </td>
      </tr>
      <tr>
        <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-230' replace='true'}</th>
        <td>
          {grn_select_numbers select_name=$config.user.name options=$config.user.options selected=$config.user.selected}{cb_msg module='grn.system.ui' key='GRN_SY_UI-238' replace='true'}
        </td>
      </tr>
      {if $is_schedule_available}
      <tr>
        <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-231' replace='true'}</th>
        <td>
          {grn_select_numbers select_name=$config.facilitygroup.name options=$config.facilitygroup.options selected=$config.facilitygroup.selected}{cb_msg module='grn.system.ui' key='GRN_SY_UI-238' replace='true'}
        </td>
      </tr>
      <tr>
        <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-232' replace='true'}</th>
        <td>
          {grn_select_numbers select_name=$config.facility.name options=$config.facility.options selected=$config.facility.selected}{cb_msg module='grn.system.ui' key='GRN_SY_UI-238' replace='true'}
        </td>
      </tr>
      {/if}
    </table>
  </td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-243' replace='true'}</th>
  <td>
    {capture name='grn_system_ui_GRN_SY_UI_229'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-229' replace='true'}{/capture}{grn_checkbox id="clear-group" name="clear-group" value="1" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_229}<br>
    {capture name='grn_system_ui_GRN_SY_UI_230'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-230' replace='true'}{/capture}{grn_checkbox id="clear-user" name="clear-user" value="1" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_230}<br>
    {if $is_schedule_available}
    {capture name='grn_system_ui_GRN_SY_UI_231'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-231' replace='true'}{/capture}{grn_checkbox id="clear-facilitygroup" name="clear-facilitygroup" value="1" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_231}<br>
    {capture name='grn_system_ui_GRN_SY_UI_232'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-232' replace='true'}{/capture}{grn_checkbox id="clear-facility" name="clear-facility" value="1" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_232}<br>
    {/if}
  </td>
 </tr>
 <tr>
  <td nowrap></td>
  <td>
  {capture name='grn_system_ui_GRN_SY_UI_233'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-233' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_233}
  {grn_button_cancel class="margin" page="system/common_list" id="ui"}
  </td>
 </tr>
</table>
</form>

{include file="grn/system_footer.tpl"}
