{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{include file='portal/_include_portal_setting.tpl'}
{grn_load_javascript file="js/dist/notification.js"}
{grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}
{grn_delete title=$init_portal.title page=$init_portal.page handler=$init_portal.handler data=$init_portal.data}
<div class="portal_setting_name_base_grn">
    <table class="portal_setting_name_grn">
        <tbody>
        <tr>
            <td><span id="portal_setting_portal_name" class="portal_setting_portal_name_grn">{$portal.name|escape}</span></td>
            <td>
                {strip}
                <span class="menu_item_right_grn">
                    <span class="menu_item">
                        <a id="lnk_delete" href="javascript:void(0)">
                          {grn_image image='delete20.gif'}{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_8' app_name=$app_name}
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
    <div id="main_menu_part">{strip}
        <span id="portal_setting_title_modify" class="menu_item">
            <a href="javascript:void(0)" onclick="grn.page.portal.setting.openPortalTitleModify({$portal_id})">
             {grn_image image='modify20.gif'}{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_5' app_name=$app_name}
            </a>
        </span>
        <span class="menu_item">
            {capture name='grn_portal_operation_GRN_POT_PE_1'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-1' replace='true'}{/capture}
            {grn_link image='image-common/preview20.png' page='portal/personal/preview' pid=$portal_id caption=$smarty.capture.grn_portal_operation_GRN_POT_PE_1 target='_blank'}
        </span>
        <span class="menu_item">
            <a id="lnk_portal_init" href="javascript:void(0)">
                {grn_image image='delete20.gif'}{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_6' app_name=$app_name}
            </a>
        </span>
    </div>{/strip}
</div>
{include file='portal/_portlet_setting_main.tpl' mode='personal'}
<script>
    <!--
    grn.page.portal.setting.msgResource.delete_portlet_title = "{cb_msg module='grn.portal.personal' key='portlet_delete'}";
    grn.page.portal.setting.msgResource.delete_portlet_explain = "{cb_msg module='grn.portal.personal' key='GRN_POT_PE-84' replace='true'}<strong>%%PORTLET_NAME%%</strong>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-85' replace='true'}";
    grn.page.portal.setting.msgResource.portal_modify_title = "{cb_msg module='grn.portal.personal' key='modify' application_name=$app_name|escape:javascript}";
    grn.page.portal.setting.msgResource.portlet_modify_title = "{cb_msg module='grn.portal.personal' key='portlet_modify'}";
    grn.page.portal.setting.msgResource.validate_error = "{cb_msg module='grn.portal' key='GRN_POT-48' replace='true'}";
    grn.page.portal.setting.msgResource.save = "{cb_msg module='grn.portal.personal' key='GRN_POT_PE-11' replace='true'}";
    grn.page.portal.setting.ajaxUrl = "{cb_pageurl page='portal/personal/command_ajax_handler'}";
    grn.page.portal.setting.commandPrefix = "grn.portal.ajax.personal.";
    //-->
</script>
{include file='grn/personal_footer.tpl'}
