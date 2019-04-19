{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=''}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.memo' key='GRN_MEM-153' replace='true'}</th>
   <td>{include file="memo/_folder_menu.tpl" param_name="pdid"}</td>
  </tr>
{include file='grn/file_modify.tpl' noframe=1}
 </table>
 <input type="hidden" name="iid" value="{$item_id}">
 <input type="hidden" name="did" value="{$folder_id}">
</form>
{include file="grn/footer.tpl"}
