{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link.system' key='GRN_LNK_SY-63' replace='true'}<span class="bold">{grn_sentence image='linklist20.gif' caption=$link.title}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-64' replace='true'}</p>
 <p>
  {capture name='grn_link_system_GRN_LNK_SY_65'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-65' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_65}
  {capture name='grn_link_system_GRN_LNK_SY_66'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-66' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_system_GRN_LNK_SY_66}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
<input type="hidden" name="lid" value="{$link.lid}">
</form>
{include file="grn/system_footer.tpl"}
