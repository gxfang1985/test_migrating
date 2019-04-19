{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file='portal/_include_portal_setting.tpl'}
<div class="portal_setting_name_base_grn">
    <table class="portal_setting_name_grn">
        <tbody>
        <tr>
            <td><span id="portal_setting_portal_name" class="portal_setting_portal_name_grn">{$portal.name|escape}</span></td>
        </tr>
        </tbody>
    </table>
</div>
<div class="portal_setting_menu_grn">
    <div id="main_menu_part">
        {strip}
        <span id="portal_setting_title_modify" class="menu_item">
            <a href="javascript:void(0)" onclick="grn.page.portal.setting.openPortalTitleModify({$portal_id})">
                {grn_image image='modify20.gif'}{$app_name|escape}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-65' replace='true'}
            </a>
        </span>
        <span id="portal_setting_view" class="menu_item">
            {capture name='grn_portal_operation_GRN_POT_OP_66'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-66' replace='true'}{/capture}
            {grn_link image='portal20.gif' page='portal/operation/preview_index' pid=$portal_id caption=$app_name|cat:$smarty.capture.grn_portal_operation_GRN_POT_OP_66}
        </span>
        <span id="portal_setting_self_view" class="menu_item">
            {capture name='grn_portal_operation_GRN_POT_OP_1'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-1' replace='true'}{/capture}
            {grn_link image='portal20.gif' page='portal/operation/preview' pid=$portal_id uid=$login_id caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_1 target='_blank'}
        </span>
        <span id="portal_setting_open_all" class="menu_item">
            <a href="javascript:void(0)" onclick="grn.page.portal.setting.openPortletOpenAll({$portal_id})">
                {grn_image image="open20.gif"}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-80' replace='true'}
            </a>
        </span>
        <span id="portal_setting_access_list" class="menu_item">
            {capture name='grn_portal_operation_GRN_POT_OP_67'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-67' replace='true'}{/capture}
            {grn_link image='access20.gif' page='portal/operation/access_list' pid=$portal_id caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_67}
            <a href="javascript:void(0)" id="access_list_info" class="access_list_info_grn">
                {grn_image image="image-common/information_sub16.png"}
            </a>
        </span>
        {include file="portal/_portal_access_info.tpl" model=$portal.security_model count=$portal.access_count}
        {/strip}
    </div>
</div>
{include file='portal/_portlet_setting_main.tpl' mode='operation'}
<script>
<!--
{literal}
(function(){
    {/literal}
    grn.page.portal.setting.msgResource.delete_portlet_title = "{cb_msg module='grn.portal.operation' key='portlet_delete'}";
    grn.page.portal.setting.msgResource.delete_portlet_explain = "{cb_msg module='grn.portal.operation' key='GRN_POT_OP-118' replace='true'}<strong>%%PORTLET_NAME%%</strong>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-119' replace='true'}";
    grn.page.portal.setting.msgResource.portal_modify_title = "{cb_msg module='grn.portal.operation' key='modify'}";
    grn.page.portal.setting.msgResource.portlet_modify_title = "{cb_msg module='grn.portal.operation' key='portlet_modify'}";
    grn.page.portal.setting.msgResource.portlet_open_all_title = "{cb_msg module='grn.portal.operation' key='portlet_open_all'}";
    grn.page.portal.setting.msgResource.portlet_open_all_explain = "{cb_msg module='grn.portal.operation' key='GRN_POT_OP-184' replace='true'}<span class='bold'>%%PORTAL_NAME%%</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-185' replace='true'}";
    grn.page.portal.setting.msgResource.validate_error = "{cb_msg module='grn.portal' key='GRN_POT-48' replace='true'}";
    grn.page.portal.setting.msgResource.open = "{cb_msg module='grn.portal.operation' key='GRN_POT_OP-138' replace='true'}";
    grn.page.portal.setting.msgResource.close = "{cb_msg module='grn.portal.operation' key='GRN_POT_OP-139' replace='true'}";
    grn.page.portal.setting.msgResource.save = "{cb_msg module='grn.portal.operation' key='GRN_POT_OP-5' replace='true'}";
    grn.page.portal.setting.ajaxUrl = "{cb_pageurl page='portal/operation/command_ajax_handler'}";
    grn.page.portal.setting.commandPrefix = "grn.portal.ajax.operation.";
    {literal}
    grn.page.portal.setting.msgResource.toggleButtonMsg = {
        {/literal}
        'on_msg': "{cb_msg module='grn.portal' key='GRN_POT-14' replace='true'}",
        'off_msg': "{cb_msg module='grn.portal' key='GRN_POT-16' replace='true'}",
        'turn_on_msg': "{cb_msg module='grn.portal' key='GRN_POT-17' replace='true'}",
        'turn_off_msg': "{cb_msg module='grn.portal' key='GRN_POT-15' replace='true'}"
        {literal}
    };
})();
{/literal}
//-->
</script>
{include file='grn/footer.tpl'}
