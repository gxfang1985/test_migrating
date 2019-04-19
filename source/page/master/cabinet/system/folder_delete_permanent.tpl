{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_folder_delete_permanent'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.cabinet' key='GRN_CAB-310' replace='true'}<br>
{grn_sentence caption=$folder.name image='folder20.gif' class='bold'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-311' replace='true'} <br>
<br>
<div class="attention">{cb_msg module='grn.cabinet' key='GRN_CAB-312' replace='true'}</div>
<div class="attention">{cb_msg module='grn.cabinet' key='GRN_CAB-313' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_cabinet_GRN_CAB_314'}{cb_msg module='grn.cabinet' key='GRN_CAB-314' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_314}
  {capture name='grn_cabinet_GRN_CAB_315'}{cb_msg module='grn.cabinet' key='GRN_CAB-315' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_315 page='cabinet/system/folder_list'}
 </p>
<input type="hidden" name="hid" value="{$folder.hid}">

</form>
{include file="grn/system_footer.tpl"}