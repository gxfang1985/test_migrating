{include file="grn/doctype.tpl"}
{grn_load_prototype_js}
{grn_load_javascript file="grn/common/base.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
<html lang="{$html_tag_lang}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="robots" content="noindex, nofollow, noarchive">
        <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1">
        <title>{cb_msg module='grn' key='GRN_GRN-32' replace='true'}</title>
        {grn_load_css file="grn/html/std.css"}
        {grn_load_css file="grn/html/mobile_error.css" media="screen and (max-width: 480px)"}
        <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
        {grn_load_css file="grn/html/Design-mm.css"}
    </head>

    <body>
    {if ! $kintone_dialog_mode}
        {strip}
            <header id="header-wrap" class="header-media">
                <div id="header-container">
                    <div id="header">
                        <div class="cloudHeader-grn ">
                            <div class="cloudHeader-inner-grn">
                                <nav class="header_left_area_grn">
                                    <h1 id="cloudHeader-customer-logo" class="cloudHeader-logoBox-grn">
                                        {if $smarty.const.ON_FOREST === 1}
                                            <a class="cloudHeader-logo-grn" href="{grn_pageurl page='index'}"
                                               title="{cb_msg module='grn' key='HEADER_FOREST_LOGO_TITLE' replace='true'}"
                                               aria-label="{cb_msg module='grn' key='HEADER_FOREST_LOGO_TITLE' replace='true'}">
                                                {grn_slash_assign}
                                                {if $region eq "CN"}
                                                    <span class="header_logo_cn_grn"></span>
                                                {else}
                                                    <span class="header_logo_com_grn"></span>
                                                {/if}
                                            </a>
                                        {else}
                                            <a class="cloudHeader-logo-grn" href="{grn_pageurl page='index'}"
                                               title="{cb_msg module='grn.grn' key='grn.header.default_logo_title'}"
                                               aria-label="{cb_msg module='grn.grn' key='grn.header.default_logo_title'}">
                                                <span class="header_logo_grn"></span>
                                            </a>
                                        {/if}
                                    </h1>
                                    {if $smarty.const.ON_FOREST === 1}
                                        {include file="grn/header_contents/_home.tpl"}
                                    {/if}
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        {/strip}
    {/if}
        <div class="error_content_grn">
            <div class="img_attention60_grn">
                {grn_image image='image-common/attention60.png'}
            </div>
            <div class="icon_attention60_grn"></div>
            <div class="error_main_grn">
                <h2 id="error_number" class="error_label_grn">{cb_msg module='fw.error' key="Error"} ({$ErrorNumber})</h2>
                {$ErrorDiag|grn_noescape}

                <h3 class="error_label_grn" >{cb_msg module='fw.error' key="Cause"}</h3>
                {$ErrorCause|grn_noescape}

                {if $HaveAdditional}
                    <h3>{cb_msg module='fw.error' key="Additional Information"}</h3>
                    {foreach from=$AdditionalMessage item=current}
                        {$current|grn_noescape}
                        <br><br>
                    {/foreach}
                {/if}

                <h3 class="error_label_grn">{cb_msg module='fw.error' key="Counter Measure"}</h3>
                {$ErrorCounterMeasure|grn_noescape}

                {if ! $kintone_dialog_mode}
                <p>{cb_msg module='fw.error' key="Press Back Button"}</p>
                <p class="error_back_grn">
                    <a href="javascript:history.back()">
                        {grn_image image='image-common/back44.png' class='vAlignMiddle-grn mRight5'}<span class='vAlignMiddle-grn'>{cb_msg module='fw.error' key="Back"}</span>
                    </a>
                </p>
                {/if}

                {if $show_backtrace}
                <div class="error_border_partition_grn"></div>
                <b>{cb_msg module='grn' key='GRN_GRN-33' replace='true'}</b>

                <h3>{cb_msg module='grn' key='GRN_GRN-34' replace='true'}</h3>
                {$ErrorDeveloperInfo|grn_noescape}

                <h3 class="error_label_grn">{cb_msg module='grn' key='GRN_GRN-35' replace='true'}</h3>
                <p>
                    {cb_msg module='grn' key='GRN_GRN-36' replace='true'} / {cb_msg module='grn' key='GRN_GRN-37' replace='true'}
                </p>
                <pre class="error_backtrace_grn">{$ErrorDetailTable|grn_noescape}</pre>

                <p>{cb_msg module='grn' key='GRN_GRN-38' replace='true'}</p>
                <pre class="error_backtrace_grn">{$ErrorInput|grn_noescape}</pre>
                {/if}
            </div>
        </div>
