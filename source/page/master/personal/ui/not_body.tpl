{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-79' replace='true'}</th>
  <td>{capture name='grn_personal_ui_GRN_PRS_UI_80'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-80' replace='true'}{/capture}{grn_checkbox name=$config.display_application_menu.name id=$config.display_application_menu.name value="1" checked=$config.display_application_menu.checked caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_80}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-81' replace='true'}</th>
   <td>
    <table class="borderTable">
     <tr>
      <td style="text-align:center;"><input type="radio" name="application_menu_style" value="Small" {if $config.application_menu_style=='Small'}checked{/if}></td>
      <td style="text-align:center;"><input type="radio" name="application_menu_style" value="NoIcon" {if $config.application_menu_style=='NoIcon'}checked{/if}></td>
     </tr>
     <tr>
      <td style="text-align:center;vertical-align:top;" nowrap>{grn_image image='defaultmenu32.gif'}<br><font color="#0000ff">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-82' replace='true'}</font></td>
      <td style="text-align:center;" nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-83' replace='true'}<br>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-84' replace='true'}
      </td>
     </tr>
    </table>
   </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_personal_ui_GRN_PRS_UI_87'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-87' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_87}
  {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
