{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cbwebsrv/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
<p><div class="explanation">{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-29' replace='true'}</div><p>
<div class="sub_explanation">{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-30' replace='true'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-31' replace='true'}[{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-32' replace='true'}]{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-33' replace='true'}</div>
  <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
   <colgroup>
    <col width="70%">
    <col width="30%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-34' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-35' replace='true'}</th>
   </tr>
   <tr valign="top">
    <td>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-36' replace='true'}{if $disabled_services.weather}&nbsp;(&nbsp;{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-37' replace='true'}&nbsp;){/if}</td>
    <td>{grn_checkbox caption='' name='event_ids[]' id='Weather' value='Weather' disabled=$disabled_services.weather}</td>
   </tr>
   <tr valign="top">
    <td>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-38' replace='true'}{if $disabled_services.six_kinds_of_day}&nbsp;(&nbsp;{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-39' replace='true'}&nbsp;){/if}</td>
    <td>{grn_checkbox caption='' name='event_ids[]' id='Rokuyo' value='Rokuyo' disabled=$disabled_services.six_kinds_of_day}</td>
   </tr>
  </table>
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_cbwebsrv_system_GRN_WBS_SY_40'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-40' replace='true'}{/capture}{grn_button_submit class='line' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_40}
 {grn_button_cancel class='line'}
</p>
</form>
{include file='grn/system_footer.tpl'}
