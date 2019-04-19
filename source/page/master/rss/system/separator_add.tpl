{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='rss/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.rss.system' key='GRN_RSS_SY-7' replace='true'}</p>
 <p>
  {capture name='grn_rss_system_GRN_RSS_SY_8'}{cb_msg module='grn.rss.system' key='GRN_RSS_SY-8' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_rss_system_GRN_RSS_SY_8}
  {capture name='grn_rss_system_GRN_RSS_SY_9'}{cb_msg module='grn.rss.system' key='GRN_RSS_SY-9' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_system_GRN_RSS_SY_9}
 </p>
</form>
{include file="grn/system_footer.tpl"}
