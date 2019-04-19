{include file="grn/system_head.tpl"}
{grn_load_javascript file="grn/html/page/dezielink/system/view.js"}
<script language="JavaScript" type="text/javascript">
    var G = grn.page.dezielink.system.view;
    G.moduleName = '{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-138' replace='true'}';
</script>
{include file="grn/system_header.tpl"}

{include file='dezielink/system/_connector_sync_user.tpl'}

<form name="{$form_name}" method="POST" action="{grn_pageurl page='dezielink/system/command_'|cat:$page_info.last}">
    {capture name='grn_dezielink_system_GRN_DZL_SY_111'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-111' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_111 class="margin"}
    {capture name='grn_dezielink_system_GRN_DZL_SY_112'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-112' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_112 class="margin"}
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
</form>
{include file="grn/system_footer.tpl"}