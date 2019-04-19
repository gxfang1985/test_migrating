{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-90' replace='true'}</th>
  <td>{capture name='grn_system_ui_GRN_SY_UI_91'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-91' replace='true'}{/capture}{grn_checkbox name=$config.display_application_menu.name id=$config.display_application_menu.name value="1" checked=$config.display_application_menu.checked caption=$smarty.capture.grn_system_ui_GRN_SY_UI_91}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-92' replace='true'}</th>
   <td>
    <table class="borderTable">
     <tr>
      <td style="text-align:center;"><input type="radio" name="application_menu_style" value="Small" {if $config.application_menu_style=='Small'}checked{/if}></td>
      <td style="text-align:center;"><input type="radio" name="application_menu_style" value="NoIcon" {if $config.application_menu_style=='NoIcon'}checked{/if}></td>
     </tr>
     <tr>
      <td style="text-align:center;vertical-align:top;" nowrap>{grn_image image='defaultmenu32.gif'}<br><font color="#0000ff">{cb_msg module='grn.system.ui' key='GRN_SY_UI-93' replace='true'}</font></td>
      <td style="text-align:center;" nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-94' replace='true'}<br>{cb_msg module='grn.system.ui' key='GRN_SY_UI-95' replace='true'}
      </td>
     </tr>
    </table>
   </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-98' replace='true'}</th>
  <td>{capture name='grn_system_ui_GRN_SY_UI_99'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-99' replace='true'}{/capture}{grn_checkbox name=$config.can_user_change_headers.name id=$config.can_user_change_headers.name value="1" checked=$config.can_user_change_headers.checked caption=$smarty.capture.grn_system_ui_GRN_SY_UI_99}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_ui_GRN_SY_UI_100'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-100' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_100}
  {grn_button_cancel}
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
