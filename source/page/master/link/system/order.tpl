{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-93' replace='true'}{cb_msg module='grn.link' key='GRN_LNK-187' replace='true'}&nbsp;{grn_sentence image='category20.gif' caption=$category.title}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_links}
  <!----->
 </div><!--action_end--->
</div>
<p>
 {capture name='grn_link_system_GRN_LNK_SY_163'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-163' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_163 onclick="grn_onsubmit_common(this.form);"}{grn_button_cancel}
</p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/system_footer.tpl"}
