{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cbwebsrv/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
   <colgroup>
    <col width="70%">
    <col width="30%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-11' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-12' replace='true'}</th>
   </tr>
{* 路線検索 *}
   <tr valign="top">
    <td>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-13' replace='true'}</td>
    <td>{grn_checkbox caption='' name='srv_ids[]' id='CBRoute' value='CBRoute' checked=$service_list.CBRoute}</td>
   </tr>

{* 天気予報 *}
   <tr>
    <td>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-21' replace='true'}</td>
    <td>{grn_checkbox caption='' name='srv_ids[]' id='CBWeather' value='CBWeather' checked=$service_list.CBWeather}</td>
   </tr>
{* 六曜 *}
   <tr>
    <td>{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-23' replace='true'}</td>
    <td>{grn_checkbox caption='' name='srv_ids[]' id='CBSixKindsOfDay' value='CBSixKindsOfDay' checked=$service_list.CBSixKindsOfDay}</td>
   </tr>
  </table>
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_cbwebsrv_system_GRN_WBS_SY_24'}{cb_msg module='grn.cbwebsrv.system' key='GRN_WBS_SY-24' replace='true'}{/capture}{grn_button_submit class='line' caption=$smarty.capture.grn_cbwebsrv_system_GRN_WBS_SY_24}
 {grn_button_cancel class='line'}
</p>
</form>
{include file='grn/system_footer.tpl'}
