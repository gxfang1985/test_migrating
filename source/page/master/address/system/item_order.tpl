{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <span class="sub_explanation">
   {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-151' replace='true'}
  </span>
  <p class="item">
  {grn_change_order form_name=$form_name select_name='iid[]' options=$item_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    {capture name='grn_address_system_GRN_ADDR_SYS_152'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-152' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_152 onclick="grn_onsubmit_common(this.form);"}
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
<input type="hidden" name="bid" value="{$book_id}">
</form>
{include file='grn/system_footer.tpl'}
