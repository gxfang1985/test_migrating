{include file="mail/_mail_popup_header.tpl"}

{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}" enctype="multipart/form-data">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  {include file="mail/_send_popup.tpl" button_file="mail/_draft_modify_popup_buttons.tpl"}
  <input type="hidden" name="mid" value="{$mail.mid}">
  <input type="hidden" name="tmp_key" value="{$tmp_key}">
  <input type="hidden" name="action" value="{$action}">
</form>

{include file="mail/_mail_popup_footer.tpl"}
