{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='portal/_include_portal_setting.tpl'}
{grn_load_javascript file="js/dist/notification.js"}
{grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}
<div class="portal_setting_name_base_grn">
    <table class="portal_setting_name_grn">
        <tbody>
        <tr>
            <td style="width: 1px">
                {capture name="on_msg"}{cb_msg module='grn.portal' key='GRN_POT-14' replace='true'}{/capture}
                {capture name="off_msg"}{cb_msg module='grn.portal' key='GRN_POT-16' replace='true'}{/capture}
                {include file="grn/component/toggle_button.tpl" id="open_button_portal" button_on=$portal.is_open on_msg=$smarty.capture.on_msg off_msg=$smarty.capture.off_msg}
            </td>
            <td>
                <span id="portal_setting_portal_name" class="portal_setting_portal_name_grn">{$portal.name|escape}</span>
            </td>
            <td>
                {strip}
                <span class="menu_item_right_grn">
                    <span class="menu_item">
                        <a id="delete_portal" href="javascript:void(0)">
                            {grn_image image='delete20.gif'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-167' replace='true'}
                        </a>
                    </span>
                </span>
                {/strip}
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="portal_setting_menu_grn">
    <div id="main_menu_part">
        {strip}
        <span id="portal_setting_title_modify" class="menu_item">
            <a href="javascript:void(0)" onclick="grn.page.portal.setting.openPortalTitleModify({$portal_id})">
                {grn_image image='modify20.gif'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-162' replace='true'}
            </a>
        </span>
        <span id="portal_setting_view" class="menu_item">
            {capture name='grn_portal_system_GRN_POT_SY_165'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-165' replace='true'}{/capture}
            {grn_link image='image-common/preview_user20.png' page='portal/system/preview_index' pid=$portal_id caption=$smarty.capture.grn_portal_system_GRN_POT_SY_165}
        </span>
        <span id="portal_setting_self_view" class="menu_item">
            {capture name='grn_portal_system_GRN_POT_SY_62'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-62' replace='true'}{/capture}
            {grn_link image='image-common/preview20.png' page='portal/system/preview' pid=$portal_id uid=$login_id caption=$smarty.capture.grn_portal_system_GRN_POT_SY_62 target='_blank'}
        </span>
        <span id="portal_setting_open_all" class="menu_item">
            <a href="javascript:void(0)" onclick="grn.page.portal.setting.openPortletOpenAll({$portal_id})">
                {grn_image image="open20.gif"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-180' replace='true'}
            </a>
        </span>
        <span id="portal_setting_access_list" class="menu_item">
            {capture name='grn_portal_system_GRN_POT_SY_166'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-166' replace='true'}{/capture}
            {grn_link image='access20.gif' page='portal/system/access_list' pid=$portal_id caption=$smarty.capture.grn_portal_system_GRN_POT_SY_166}
            <a href="javascript:void(0)" id="access_list_info" class="mLeft2"><span class="icon_information_sub16_grn icon_inline_grn icon_only_grn"></span></a>
        </span>
        {include file="portal/_portal_access_info.tpl" model=$portal.security_model count=$portal.access_count}
        {/strip}
    </div>
</div>
{include file='portal/_portlet_setting_main.tpl' mode='system'}
<script>
<!--
{literal}
(function(){
    {/literal}
    grn.page.portal.setting.msgResource.delete_portlet_title = "{cb_msg module='grn.portal.system' key='portlet_delete'}";
    grn.page.portal.setting.msgResource.delete_portlet_explain = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-259' replace='true'}<strong>%%PORTLET_NAME%%</strong>{cb_msg module='grn.portal.system' key='GRN_POT_SY-260' replace='true'}";
    grn.page.portal.setting.msgResource.portal_open_title = "{cb_msg module='grn.portal.system' key='open'}";
    grn.page.portal.setting.msgResource.portal_open_explain = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-274' replace='true'}<strong>%%PORTAL_NAME%%</strong>{cb_msg module='grn.portal.system' key='GRN_POT_SY-275' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-277' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-278' replace='true'}";
    grn.page.portal.setting.msgResource.portal_close_explain = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-274' replace='true'}<strong>%%PORTAL_NAME%%</strong>{cb_msg module='grn.portal.system' key='GRN_POT_SY-275' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-276' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-278' replace='true'}";
    grn.page.portal.setting.msgResource.portlet_open_all_title = "{cb_msg module='grn.portal.system' key='portlet_open_all'}";
    grn.page.portal.setting.msgResource.portlet_open_all_explain ="{cb_msg module='grn.portal.system' key='GRN_POT_SY-437' replace='true'}<span class='bold'>%%PORTAL_NAME%%</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-438' replace='true'}";
    grn.page.portal.setting.msgResource.portal_modify_title = "{cb_msg module='grn.portal.system' key='modify'}";
    grn.page.portal.setting.msgResource.portlet_modify_title = "{cb_msg module='grn.portal.system' key='portlet_modify'}";
    grn.page.portal.setting.msgResource.validate_error = "{cb_msg module='grn.portal' key='GRN_POT-48' replace='true'}";
    grn.page.portal.setting.msgResource.open = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-295' replace='true'}";
    grn.page.portal.setting.msgResource.close = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-296' replace='true'}";
    grn.page.portal.setting.msgResource.save = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-20' replace='true'}";
    grn.page.portal.setting.ajaxUrl = "{cb_pageurl page='portal/system/command_ajax_handler'}";
    grn.page.portal.setting.commandPrefix = "grn.portal.ajax.system.";
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
{include file='grn/system_footer.tpl'}
