{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_application_menu_refresh'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-1' replace='true'}</p>
 <p>
  {capture name='grn_personal_ui_GRN_PRS_UI_2'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-2' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_2}
  {capture name='grn_personal_ui_GRN_PRS_UI_3'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-3' replace='true'}{/capture}{grn_button_cancel page='personal/ui/application_menu_list' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_3}
 </p>
</form>
{include file='grn/personal_footer.tpl'}
