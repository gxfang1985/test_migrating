{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=""}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.memo' key='GRN_MEM-172' replace='true'}<br><br>
  {cb_msg module='grn.memo' key='GRN_MEM-130' replace='true'}{grn_sentence caption=$folder.name image='folder20.gif' class='bold'}<br><br>
  {cb_msg module='grn.memo' key='GRN_MEM-174' replace='true'}{$app_name}{cb_msg module='grn.memo' key='GRN_MEM-175' replace='true'}
 </p>

 <p>
  {capture name='grn_memo_GRN_MEM_176'}{cb_msg module='grn.memo' key='GRN_MEM-176' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_memo_GRN_MEM_176}
  {capture name='grn_memo_GRN_MEM_177'}{cb_msg module='grn.memo' key='GRN_MEM-177' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_memo_GRN_MEM_177}
 </p>
<input type="hidden" name="did" value="{$folder_id}">
</form>
{include file='grn/footer.tpl'}
