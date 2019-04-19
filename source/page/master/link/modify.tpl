{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <!--action--->
 <div id="action">
  <!----->
  <div class="explanation">{cb_msg module='grn.link' key='GRN_LNK-20' replace='true'}</div>
  {include file='grn/indispensable.tpl'}
  <br>
   {include file='link/_modify.tpl' button_file='link/_modify_buttons.tpl'}
  <!----->
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="cid" value="{$category.cid}">
<input type="hidden" name="lid" value="{$link.lid}">
</form>
{include file="grn/footer.tpl"}
