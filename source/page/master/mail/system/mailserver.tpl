{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_81'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-81' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_81 page='mail/system/mailserver_add' element_id="system_mail_server_add"}</span>
    <span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_82'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-82' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_82 page='mail/system/mailserver_order' disabled=$disabled_change_order element_id="system_mail_server_order"}</span>
    <div id="rare_menu_part_under">
        {capture name='grn_mail_system_GRN_MAIL_SY_83'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-83' replace='true'}{/capture}{grn_link class='menu_item' image='delete20.gif' page='mail/system/mailserver_delete_all' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_83 element_id="system_mail_server_delete_all"}
    </div>
</div>

    <p>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="30%">
     <col width="25%">
     <col width="10%">
     <col width="25%">
     <col width="10%">
    </colgroup>
    <tr>
     <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-84' replace='true'}</th>
     <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-85' replace='true'}</th>
     <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-86' replace='true'}</th>
     <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-87' replace='true'}</th>
     <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-88' replace='true'}</th>
    </tr>
{foreach name=mailservers from=$mailservers key=msid item=mailserver}
    <tr valign="top">
     <td>
      {grn_link caption=$mailserver.title page='mail/system/mailserver_view' msid=$msid image='mailserver20.gif'}
     </td>
     <td>{$mailserver.smtp_server|escape}</td>
     <td>{$mailserver.smtp_port|escape}</td>
     <td>{$mailserver.received_server|escape}</td>
     <td>{$mailserver.received_port|escape}</td>
    </tr>
{/foreach}
   </table>

{include file='grn/system_footer.tpl'}
