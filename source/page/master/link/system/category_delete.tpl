{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.link.system' key='GRN_LNK_SY-208' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.title}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-209' replace='true'} </p>
 <div class="attention">{cb_msg module='grn.link.system' key='GRN_LNK_SY-210' replace='true'}</div>
 <p>
  {capture name='grn_link_system_GRN_LNK_SY_211'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-211' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_211}
  {capture name='grn_link_system_GRN_LNK_SY_212'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-212' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_system_GRN_LNK_SY_212}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/system_footer.tpl"}
