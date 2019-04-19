{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/system/command_'|cat:$page_info.last}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-1' replace='true'}</th>
  <td>
    <div id="auto_presence_box">
       {capture assign='grn_presence_system_GRN_PRSC_SY_4'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-4' replace='true'}{/capture}{grn_checkbox name='auto_set_presence' id='auto_set_presence' value=1 checked=$info.auto_set_presence caption=$grn_presence_system_GRN_PRSC_SY_4}<br>
       {if $smarty.const.ON_FOREST !== 1}
           {capture assign='grn_presence_system_GRN_PRSC_SY_5'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-5' replace='true'}{/capture}{grn_checkbox name='auto_set_absence' id='auto_set_absence' value=1 checked=$info.auto_set_absence caption=$grn_presence_system_GRN_PRSC_SY_5}
       {/if}
    </div>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-56' replace='true'}</th>
  <td>{capture assign='grn_presence_system_GRN_PRSC_SY_57'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-57' replace='true'}{/capture}{grn_checkbox name='show_proxy_settings_menu' id='show_proxy_settings_menu' value=1 checked=$show_proxy_settings_menu caption=$grn_presence_system_GRN_PRSC_SY_57}<br></td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture assign='grn_presence_system_GRN_PRSC_SY_9'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-9' replace='true'}{/capture}{grn_button_submit class='margin' caption=$grn_presence_system_GRN_PRSC_SY_9}
      {grn_button_cancel}
  </td>
 </tr>
</table>
</form>

{include file='grn/system_footer.tpl'}