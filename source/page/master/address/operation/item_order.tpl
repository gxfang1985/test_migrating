{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <span class="explanation">
   {cb_msg module='grn.address.operation' key='GRN_ADDR_OP-74' replace='true'}<br>
  </span>
  <span class="sub_explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-75' replace='true'}</span>
  <p class="item">
  {grn_change_order form_name=$form_name select_name='iid[]' options=$item_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    <input class="margin" type="submit" value="{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-76' replace='true'}" onclick="grn_onsubmit_common(this.form);">
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
<input type="hidden" name="bid" value="{$book_id}">
</form>
{include file='grn/footer.tpl'}
