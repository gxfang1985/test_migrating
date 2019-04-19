{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{* Start Navigation *}
<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-163' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-165' replace='true'}</td>
 </tr>
</table>
</center>
{* End Navigation *}

{include file="report/_send_confirm.tpl"}
 
</form>

{include file="grn/footer.tpl"}
