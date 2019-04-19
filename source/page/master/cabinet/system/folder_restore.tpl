{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_folder_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.cabinet' key='GRN_CAB-316' replace='true'}<br>
{grn_sentence caption=$folder.name image='folder20.gif' class='bold'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-317' replace='true'} <br>
<br>
 </p>
 <p>
  {capture name='grn_cabinet_GRN_CAB_318'}{cb_msg module='grn.cabinet' key='GRN_CAB-318' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_318}
  {capture name='grn_cabinet_GRN_CAB_319'}{cb_msg module='grn.cabinet' key='GRN_CAB-319' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_319 page='cabinet/system/folder_list'}
 </p>
<input type="hidden" name="hid" value="{$folder.hid}">

</form>
{include file="grn/system_footer.tpl"}