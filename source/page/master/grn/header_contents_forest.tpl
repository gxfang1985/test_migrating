<!-- .com header -->
{if $browser.os_type == "mac" && $browser.type == "firefox"}
    <style type="text/css">
        .cloudHeader-searchbox input, x:-moz-any-link, x:default
        {ldelim}
            height: 14px;
        {rdelim}
    </style>
{/if}
{grn_com_header_assign}
{grn_slash_assign}
{strip}
    <header id="header-wrap" class="header-wrap header_base_grn">
        <div id="header-container">
            <div id="header">
                <div class="cloudHeader-grn">
                    <div class="cloudHeader-inner-grn">
                        <nav class="header_left_area_grn">
                            {include file="grn/header_contents/_start_menu.tpl"}
                            <h1 id="cloudHeader-customer-logo" class="cloudHeader-logoBox-grn">
                                <a class="cloudHeader-logo-grn" href="{$slash_logo.url}"
                                   title="{cb_msg module='grn' key='HEADER_FOREST_LOGO_TITLE' replace='true'}"
                                   aria-label="{cb_msg module='grn' key='HEADER_FOREST_LOGO_TITLE' replace='true'}">
                                    {if $slash_logo.isDefaultLogo eq TRUE}
                                        {if $region eq "CN"}
                                            <span class="header_logo_cn_grn"></span>
                                        {else}
                                            <span class="header_logo_com_grn"></span>
                                        {/if}
                                    {else}
                                        <img id="the-logo" src="{$slash_logo.image|grn_noescape}" alt="{$slash_logo.name}">
                                    {/if}
                                </a>
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
                            {include file="grn/header_contents/_cloud_services.tpl"}
                            <div class="cloudHeader-dropdownMenu-grn cloudHeader-userProfile-grn">
                                <button type="button" id="cloudHeader-userName-grn"
                                        class="cloudHeader-userName-grn button_style_off_grn"
                                        aria-controls="cloudHeader-userProfile-grn"
                                        aria-haspopup="true" aria-expanded="false">
                                    <div class="cloudHeader-userPhoto-grn" style="background-image: url({grn_slash_userimage size='MEDIUM'|grn_noescape});"></div>
                                    <span title="{$slash_username}">{$slash_username}</span>
                                </button>
                                <div id="cloudHeader-userProfile-grn" class="cloudHeader-dropdownContents-grn"
                                     aria-labelledby="cloudHeader-userName-grn" aria-hidden="true">
                                    {include file="grn/_user_profile_header_forest.tpl"}
                                </div>
                            </div>
                            {if $use_fts}
                                {include file="grn/header_contents/_fts.tpl"}
                            {/if}
                            {if $is_admin || $is_admin_application}
                                <div class="cloudHeader-dropdownMenu-grn cloudHeader-admin-grn">
                                    <button type="button" id="cloudHeader-adminSettings-grn"
                                            class="cloudHeader-adminSettingsTitle-grn  button_style_off_grn"
                                            title="{cb_msg module='grn' key='HEADER_ADMIN_MENU' replace='true'}"
                                            aria-label="{cb_msg module='grn' key='HEADER_ADMIN_MENU' replace='true'}"
                                            aria-controls="cloudHeader-adminSettings"
                                            aria-haspopup="true" aria-expanded="false">
                                        <span class="cloudHeader-adminSettings-grn"></span>
                                    </button>
                                    <div id="cloudHeader-adminSettings" class="cloudHeader-dropdownContents-grn"
                                         aria-labelledby="cloudHeader-adminSettings-grn" aria-hidden="true">
                                        <div class="cloudHeader-dropdownContents-section-grn">
                                            <ul>
                                                {if $is_admin}
                                                    <li><a id="com-header-admin-page-link" href="/admin/">
                                                            {cb_msg module='grn' key='HEADER_DOMAIN_ADMIN' replace='true'}
                                                        </a>
                                                    </li>
                                                {/if}
                                            </ul>
                                        </div>
                                        <div class="cloudHeader-dropdownContents-section-grn">
                                            <ul>
                                                <li>
                                                    <a href="/g/system/common_list.csp"
                                                       id="com-header-system-page-link">
                                                        {cb_msg module='grn' key='HEADER_GAROON_ADMIN' replace='true'}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="cloudHeader-dropdownContents-section-last-grn">
                                            <ul>
                                                <li>
                                                    <a href={grn_system_help_link} target="_blank">
                                                        {cb_msg module='grn' key='HEADER_SYSTEM_HELP' replace='true'}
                                                    </a>
                                                </li>
                                                {if $is_admin}
                                                    <li>
                                                        <a href="/support/garoon" target="_blank">
                                                            {cb_msg module='grn' key='HEADER_SUPPORT' replace='true'}
                                                        </a>
                                                    </li>
                                                {/if}
                                            </ul>
                                        </div>
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
