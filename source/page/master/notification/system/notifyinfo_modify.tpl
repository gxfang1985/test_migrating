{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-24' replace='true'}</div>

<p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_25'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-25' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_25 necessary=TRUE}</th>
  <td>{capture name='grn_notification_system_GRN_NTFC_SY_26'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-26' replace='true'}{/capture}{validate form=$form_name field="ntfc_id" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_notification_system_GRN_NTFC_SY_26 append="validation_errors"}{grn_text necessary=TRUE name="ntfc_id" value=$ntfc_id size="50" maxlength="60" disable_return_key=TRUE}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_27'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-27' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_27 necessary=TRUE}</th>
  <td>
    {capture name='tmp'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-28' replace='true'}{/capture}{validate form=$form_name field='ntfc_name' criteria="notEmpty" transform="cb_trim" message=$smarty.capture.tmp append="validation_errors"}{grn_text necessary=TRUE name='ntfc_name' value=$ntfc_name size="50" maxlength="60" disable_return_key=true}
  </td>
 </tr>
 <tr valign="top">
   <th nowrap>{capture name='grn_notification_system_GRN_NTFC_SY_62'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-62' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_notification_system_GRN_NTFC_SY_62 necessary=TRUE}{capture name='grn_notification_system_GRN_NTFC_SY_63'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-63' replace='true'}{/capture}{validate form=$form_name field="ntfc_url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_notification_system_GRN_NTFC_SY_63 append="validation_errors"}</th>
   <td>
     {grn_textarea cols=80 rows=5 name="ntfc_url" value=$ntfc_url}<br />
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
       {capture name='grn_notification_system_GRN_NTFC_SY_29'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-29' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_29}
       {grn_button_cancel page='notification/system/notifyinfo_view' ntfc_aid=$ntfc_app_id}
  </td>
 </tr>
</table>

<input type="hidden" name="ntfc_aid" value="{$ntfc_app_id}">
</form>

{include file='grn/system_footer.tpl'}
