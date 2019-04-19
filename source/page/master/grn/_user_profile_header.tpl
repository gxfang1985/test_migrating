<script type="text/javascript" language="javascript">
<!--
{literal}
function logout()
{
    var form = jQuery("#form_logout");
    form.submit();
}
{/literal}
//-->
</script>
<div class="cloudHeader-dropdownContents-section-grn">
  <div class="cloudHeader-account-box">
    <div class="cloudHeader-account-box-contents">
        <div>
            {grn_link image="image-common/user16.png" no_image_class=true title=$login.name class="hd_pulldown_username_grn" page='personal/user/user_view' caption=$login.name}
        </div>
        {capture name='grn_HEADER_EDIT'}{cb_msg module='grn' key='HEADER_EDIT' replace='true'}{/capture}{grn_link page='personal/user/user_modify' caption=$smarty.capture.grn_HEADER_EDIT br="true"}
    </div>
  </div>
</div>
<div class="cloudHeader-dropdownContents-section-grn">
    <ul>
        {if isset($smarty.capture.show_personal_setting) && $smarty.capture.show_personal_setting != FALSE}
        <li><a href="{$smarty.capture.show_personal_setting|grn_noescape}">{cb_msg module='grn.grn' key='GRN_GRN-843' replace='true'}</a></li>
        {else}
            {if $smarty.const.ON_FOREST !== 1 && $is_changeble_locale}
                <li>{capture name='grn_HEADER_SETTINGS_ACCOUNT'}{cb_msg module='grn' key='HEADER_SETTINGS_ACCOUNT' replace='true'}{/capture}{grn_link page='personal/i18n/config' caption=$smarty.capture.grn_HEADER_SETTINGS_ACCOUNT br="true"}</li>
            {/if}
            {if $is_password_config}
                <li>{capture name='grn_GRN_GRN_204'}{cb_msg module='grn' key='GRN_GRN-204' replace='true'}{/capture}{grn_link page='personal/user/password' caption=$smarty.capture.grn_GRN_GRN_204 br="true" element_id="com_header_change_password_link"}</li>
            {/if}
            <li>{capture name='grn_GRN_GRN_208'}{cb_msg module='grn' key='GRN_GRN-208' replace='true'}{/capture}{grn_link page='personal/ui/design' caption=$smarty.capture.grn_GRN_GRN_208 br="true" element_id='com_header_setting_design_link'}</li>
            <li>{capture name='grn_grn_GRN_GRN_845'}{cb_msg module='grn.grn' key='GRN_GRN-845' replace='true'}{/capture}{grn_link page='personal/application_list' caption=$smarty.capture.grn_grn_GRN_GRN_845 br="true" element_id='com_header_personal_setting_link'}</li>
        {/if}
    </ul>
</div>
<div class="cloudHeader-dropdownContents-section-last-grn">
  <ul>
    <li>
        <a href='javascript:popupWin("{grn_user_help_link}","help",800,600,0,0,0,1,0,1)'>{cb_msg module='grn' key='HEADER_USER_HELP' replace='true'}</a>
    </li>
    <li>
        {grn_hide_logout assign='hide_logout'}
        {if !$hide_logout }
        <a id="com-header-logout-link" href="javascript:logout()">{cb_msg module='grn.grn' key='GRN_GRN-1202' replace='true'}</a>
        <form id="form_logout" method="post" action="{grn_pageurl page='command_logout'}" style="margin: 0;">
         <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        </form>
        {/if}
    </li>
  </ul>
</div>

