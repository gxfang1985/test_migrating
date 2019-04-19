{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>
 <table class="std_form">
  <!--category_items-->
  <tr>
   <th>{capture name='grn_report_system_GRN_RPRT_SY_556'}{cb_msg module='grn' key='grn.comment.permission' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_556}</th>
   <td>{capture name='grn_report_system_GRN_RPRT_SY_557'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-557' replace='true'}{/capture}{grn_checkbox name='enable_follow' id='enable_follow' value=1 checked=$enable_follow caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_557}</td>
  </tr>
  <tr>
   <th>{capture name='grn_report_system_GRN_RPRT_SY_466'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-466' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_466}</th>
   <td>{capture name='grn_report_system_GRN_RPRT_SY_467'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-467' replace='true'}{/capture}{grn_checkbox name='enable_htmleditor' id='enable_htmleditor' value=1 checked=$enable_htmleditor caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_467}</td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn' key='grn.comment.permission.conf.anchor' replace='true'}</th>
   <td>
    {capture name='grn_report_system_GRN_RPRT_SY_559'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-559' replace='true'}{/capture}{grn_checkbox name="enable_follow_autolink" id="enable_follow_autolink" value="1" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_559 checked=$enable_follow_autolink}
   </td>
  </tr>
    <tr>
   <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-568' replace='true'}</th>
   <td>
    {capture name="rdo_allusers"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-569' replace='true'}{/capture}
    {capture name="rdo_attendees"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-570' replace='true'}{/capture}
    {grn_radio name='security_setattendees' id='AllUsers' value='0' caption=$smarty.capture.rdo_allusers    checked=$report_allusers}
    {grn_radio name='security_setattendees' id='Attendees' value='1' caption=$smarty.capture.rdo_attendees  checked=$report_attendeesusers}
   </td>
  </tr>
  <tr>
   <td><br></td>
   <td>
       {capture name='grn_report_system_GRN_RPRT_SY_468'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-468' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_468}
       {grn_button_cancel}
   </td>
  </tr>
 </table>

</form>
{include file="grn/system_footer.tpl"}
 
