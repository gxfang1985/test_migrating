{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='portal/_include_portal_setting.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{grn_delete title=$init_info.title page=$init_info.page handler=$init_info.handler data=$init_info.data}
<div class="portal_setting_menu_grn">
    <div id="main_menu_part">
        <span id="portal_template_initialize" class="menu_item"><a id="lnk_init_template" href="javascript:void(0)">{grn_image image='delete20.gif'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-241' replace='true'}</a></span>
    </div>
</div>
{include file='portal/_portlet_setting_main.tpl' mode='template'}
<script>
    <!--
    grn.page.portal.setting.msgResource.delete_portlet_title = "{cb_msg module='grn.portal.system' key='portlet_delete'}";
    grn.page.portal.setting.msgResource.delete_portlet_explain = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-259' replace='true'}<strong>%%PORTLET_NAME%%</strong>{cb_msg module='grn.portal.system' key='GRN_POT_SY-260' replace='true'}";
    grn.page.portal.setting.msgResource.portlet_modify_title = "{cb_msg module='grn.portal.system' key='portlet_modify'}";
    grn.page.portal.setting.msgResource.validate_error = "{cb_msg module='grn.portal' key='GRN_POT-48' replace='true'}";
    grn.page.portal.setting.msgResource.save = "{cb_msg module='grn.portal.system' key='GRN_POT_SY-20' replace='true'}";
    grn.page.portal.setting.ajaxUrl = "{cb_pageurl page='portal/system/command_ajax_handler'}";
    grn.page.portal.setting.commandPrefix = "grn.portal.ajax.system.template_";
    //-->
</script>
{include file='grn/system_footer.tpl'}
