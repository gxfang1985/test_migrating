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
    <ul>
        <li><a href="/settings/profile" target="_blank">{cb_msg module='grn' key='HEADER_SETTINGS_PROFILE' replace='true'}</a></li>
    </ul>
</div>
<div class="cloudHeader-dropdownContents-section-grn">
    {strip}
    <ul>
        <li>
            <a id="com_header_personal_setting_link" href="/g/personal/common_list.csp" class="cloudHeader-personal-settings-grn">
                {cb_msg module='grn' key='HEADER_SETTINGS_PERSONAL' replace='true'}
            </a>
        </li>
        <li>
            <a id="com_header_setting_design_link" href="/g/personal/ui/design.csp">
                {cb_msg module='grn' key='GRN_GRN-208' replace='true'}
            </a>
        </li>
        <li>
            <a id="com_header_feedback_link" href="https://r.cybozu.com/g/garoon/feedback" target="_blank">
                {cb_msg module='grn' key='HEADER_LINK_FEEDBACK' replace='true'}
            </a>
        </li>
    </ul>
    {/strip}
</div>
<div class="cloudHeader-dropdownContents-section-last-grn">
    <ul>
        <li><a href={grn_user_help_link} target="_blank">{cb_msg module='grn' key='HEADER_USER_HELP' replace='true'}</a></li>
        {grn_hide_logout assign='hide_logout'} 
        {if !$hide_logout }
        <li><a id="com-header-logout-link" href="javascript:logout()">{cb_msg module='grn' key='HEADER_LOGOUT' replace='true'}</a></li>
            <form id="form_logout" method="post" action="{grn_pageurl page='command_logout'}" style="margin: 0;">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            </form>
        {/if}
    </ul>
</div>
