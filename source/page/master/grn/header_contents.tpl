<!-- .com header -->
{grn_com_header_assign}
{strip}
    <header id="header-wrap" class="header-wrap header_base_grn">
        <div id="header-container">
            <div id="header">
                <div class="cloudHeader-grn">
                    <div class="cloudHeader-inner-grn">
                        <nav class="header_left_area_grn">
                            {include file="grn/header_contents/_start_menu.tpl"}
                            <h1 id="cloudHeader-customer-logo" class="cloudHeader-logoBox-grn">
                                {grn_customer_logo}
                            </h1>
                            {include file="grn/header_contents/_home.tpl"}
                            {if $notify_active}
                                {include file="grn/header_contents/_notification.tpl"}
                            {/if}

                            {if $favour_active}
                                {include file="grn/header_contents/_favour.tpl"}
                            {/if}

                            {if $space_active}
                                {include file="grn/header_contents/_space_menu.tpl"}
                            {/if}
                        </nav>

                        <nav class="header_right_area_grn">
                            <div class="cloudHeader-dropdownMenu-grn cloudHeader-userProfile-grn">
                                <button type="button" id="cloudHeader-userName-grn"
                                        class="cloudHeader-userName-grn button_style_off_grn"
                                        aria-controls="cloudHeader-userProfile-grn"
                                        aria-haspopup="true" aria-expanded="false">
                                    <img src="{$app_path}/grn/image/cybozu/image-common/user_hd.svg" alt=""/>
                                    <span title="{$login.name|escape:"html"}">{$login.name|escape:"html"}</span>
                                </button>
                                <div id="cloudHeader-userProfile-grn"
                                     class="cloudHeader-dropdownContents-grn"
                                     aria-labelledby="cloudHeader-userName-grn" aria-hidden="true">
                                    {include file="grn/_user_profile_header.tpl"}
                                </div>
                            </div>
                            {if $use_fts}
                                {include file="grn/header_contents/_fts.tpl"}
                            {/if}

                            {if $is_admin || $is_admin_application}
                                <div class="cloudHeader-dropdownMenu-grn cloudHeader-admin-grn">
                                    <button type="button" id="cloudHeader-adminSettings-grn"
                                            class="cloudHeader-adminSettingsTitle-grn button_style_off_grn"
                                            title="{cb_msg module='grn' key='HEADER_ADMIN_MENU' replace='true'}"
                                            aria-label="{cb_msg module='grn' key='HEADER_ADMIN_MENU' replace='true'}"
                                            aria-controls="cloudHeader-adminSettings"
                                            aria-haspopup="true" aria-expanded="false">
                                        <span class="cloudHeader-adminSettings-grn"></span>
                                    </button>
                                    <div id="cloudHeader-adminSettings" class="cloudHeader-dropdownContents-grn"
                                         aria-labelledby="cloudHeader-adminSettings-grn" aria-hidden="true">
                                        <ul>
                                            <li>
                                                <a id="com-header-system-page-link"
                                                   href="{cb_pageurl page='system/index'}">
                                                    {cb_msg module='grn.grn' key='GRN_GRN-1083' replace='true'}
                                                </a>
                                            </li>
                                            {if $is_admin}
                                                {if $smarty.const.ON_SAAS === 1}
                                                    {grn_saas_support_link}
                                                {elseif $is_license_available}
                                                    <li>
                                                        <a href="{cb_pageurl page='system/support/support'}">
                                                            {cb_msg module='grn.grn' key='GRN_GRN-939' replace='true'}
                                                        </a>
                                                    </li>
                                                {/if}
                                            {/if}
                                            <li>
                                                {if $html_lang == 'ja'}
                                                    <a href='javascript:popupWin("{grn_system_help_link}","help",800,600,0,0,0,1,0,1)'>
                                                        {cb_msg module='grn' key='HEADER_SYSTEM_HELP' replace='true'}
                                                    </a>
                                                {else}
                                                    <a href={grn_system_help_link} target="_blank">
                                                        {cb_msg module='grn' key='HEADER_SYSTEM_HELP' replace='true'}
                                                    </a>
                                                {/if}
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            {/if}
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
{/strip}
<!-- end of .com header -->
