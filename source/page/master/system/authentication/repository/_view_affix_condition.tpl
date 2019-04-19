{strip}
    {if array_key_exists('affix_condition', $driver_settings) && $driver_settings.affix_condition}
        {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_73'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-73' replace='true'}{/capture}
        {grn_sentence image='check20.gif' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_73}
        <br>

        {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-74' replace='true'}
        {if $driver_settings.affix_type === 'prefix'}
            {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-75' replace='true'}
        {else}
            {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-76' replace='true'}
        {/if}
        &nbsp;"{$driver_settings.affix_string}"
        <br>

        {if $driver_settings.affix_strip}
            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_78'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-78' replace='true'}{/capture}
            {grn_sentence image='check20.gif' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_78}

        {else}
            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_79'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-79' replace='true'}{/capture}
            {grn_sentence image='spacer20.gif' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_79}
        {/if}
    {else}
        {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_80'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-80' replace='true'}{/capture}
        {grn_sentence image='spacer20.gif' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_80}
    {/if}
{/strip}