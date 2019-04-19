{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cbwebsrv/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-1' replace='true'}</th>
  <td>
   {capture name='grn_cbwebsrv_system_GRN_WBS_SY_2'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-2' replace='true'}{/capture}{capture name='grn_cbwebsrv_system_GRN_WBS_SY_3'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-3' replace='true'}{/capture}{grn_radio name='send_pid' id='send_pid1' value='1' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_2|cat:$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_3 checked=$send_pid}<span class="mLeft20"><a href="https://r.cybozu.com/g/garoon/jp/cbwebsrv-terms" target="_blank" rel="noopener noreferrer">{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-44' replace='true'}</a></span><br>
   {capture name='grn_cbwebsrv_system_GRN_WBS_SY_4'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-4' replace='true'}{/capture}{capture name='grn_cbwebsrv_system_GRN_WBS_SY_5'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-5' replace='true'}{/capture}{grn_radio name='send_pid' id='send_pid2' value='0' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_4|cat:$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_5 checked=$unsend_pid}<br>
   <p>
    &nbsp;&nbsp;{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-6' replace='true'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-7' replace='true'}
   <ul>
    <li>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-41' replace='true'}
    <li>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-42' replace='true'}
    <li>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-43' replace='true'}
   </ul>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_cbwebsrv_system_GRN_WBS_SY_10'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-10' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_10}
   {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

