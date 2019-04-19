{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/notifyinfo_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_notification_system_GRN_NTFC_SY_57'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-57' replace='true'}{/capture}{grn_link page='notification/system/notifyinfo_add' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_57 image='write20.gif'}</span>
</div>

<p>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="42%">
     <col width="41%">
    </colgroup>
    <tr>
     <th nowrap>{assign var='elem_name' value='eid[]'}{include file="grn/checkall.tpl"}</th>
     <th nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-58' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-59' replace='true'}</th>
    </tr>
{foreach from=$app_list item=app}
{if $app.id == 'Cybozu Information'}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
    <tr valign="top">
     <td>{if ! $disabled}<input type="checkbox" name="eid[]" value="{$app.app_id}">{/if}&nbsp;</td>
     <td>{grn_link page='notification/system/notifyinfo_view' caption=$app.id image='notify20.gif' ntfc_aid=$app.app_id disabled=$disabled}</td>
     <td>{$app.name|escape}</td>
    </tr>
{/foreach}
   </table>
       {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-60' replace='true'}{capture name='grn_notification_system_GRN_NTFC_SY_61'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-61' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_61 onclick="if( ! grn_is_checked( this.form,'eid[]' ) ) return false;"}

</form>

{include file='grn/system_footer.tpl'}
