{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/command_mygroup_order'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='mgids[]' options=$mygroups}
  <!----->
 </div>
</div>
{strip}
  <div class="mTop15 mBottom15">
   {capture name='grn_address_GRN_ADDR_94'}{cb_msg module='grn.address' key='GRN_ADDR-94' replace='true'}{/capture}
   {grn_button id='address_book_button_save' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_address_GRN_ADDR_94 onclick="grn_onsubmit_common(document.forms['`$form_name`']); grn.component.button.util.submit(this);"}
   {grn_button id='address_book_button_cancel' action='cancel'}
  </div>
{/strip}
 <input type="hidden" name="mgid" value="{$mygroup_id}">
</form>
{include file='grn/footer.tpl'}
