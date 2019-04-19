{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$app.name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_notification_system_GRN_NTFC_SY_31'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-31' replace='true'}{/capture}{grn_link page='notification/system/notifyinfo_modify' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_31 image='write20.gif' ntfc_aid=$app.app_id}</span>
<span class="menu_item">{capture name='grn_notification_system_GRN_NTFC_SY_32'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-32' replace='true'}{/capture}{grn_link page='notification/system/notifyinfo_delete' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_32 image='delete20.gif' ntfc_aid=$app.app_id}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-33' replace='true'}</th>
  <td>{$app.id|escape}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-34' replace='true'}</th>
  <td>{$app.name|escape}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-64' replace='true'}</th>
  <td>{$app.urlpattern|escape|nl2br}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
