{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <p class="item">
  {grn_change_order form_name=$form_name select_name='bid[]' options=$book_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    <input class="margin" type="submit" value="{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-248' replace='true'}" onclick="grn_onsubmit_common(this.form);">
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
</form>
{include file='grn/system_footer.tpl'}
