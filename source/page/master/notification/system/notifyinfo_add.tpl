{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-43' replace='true'}</div>

<p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_44'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-44' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_44 necessary=TRUE}</th>
  <td>{capture name='grn_notification_system_GRN_NTFC_SY_45'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-45' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_notification_system_GRN_NTFC_SY_45 append="validation_errors" }{grn_text necessary=TRUE name="id" value=$id size="50" maxlength="60" disable_return_key=true}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_46'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-46' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_46 necessary=TRUE}</th>
  <td>{grn_text necessary=TRUE name="name" value=$name size="50" maxlength="60" disable_return_key=true}{capture name='tmp'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-28' replace='true'}{/capture}{validate form=$form_name field='name' criteria="notEmpty" transform="cb_trim" message=$smarty.capture.tmp append="validation_errors"}</td>
 </tr>
 <tr valign="top">
   <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_62'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-62' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_62 necessary=TRUE}{capture name='grn_notification_system_GRN_NTFC_SY_63'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-63' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_notification_system_GRN_NTFC_SY_63 append="validation_errors"}</th>
   <td>
     {grn_textarea cols=80 rows=5 name="url" value=$url}<br />
     {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-65' replace='true'}<br />
     <table cellpadding="0" cellspacing="0">
       <tbody>
         <tr valign="top">
           <td>
             {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-66' replace='true'}
           </td>
           <td>
             {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-67' replace='true'}<br />
             {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-68' replace='true'}
           </td>
         </tr>
       </tbody>
     </table>
   </td>     
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_notification_system_GRN_NTFC_SY_48'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-48' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_48}
       {grn_button_cancel page='notification/system/notifyinfo_list'}
  </td>
 </tr>
</table>

<input type="hidden" name="app_id" value="{$app_id}">
</form>

{include file='grn/system_footer.tpl'}
