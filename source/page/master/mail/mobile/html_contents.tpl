{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>{$page_title|escape}</title>
    {grn_load_css file="fw/jquery_mobile/jquery.mobile-1.4.5.min.css"}
    {grn_load_css file="grn/html/mobile_standard.css"}
    {grn_load_css file="grn/html/mobile_mail.css"}
    {grn_load_css file="grn/html/mobile_design_standard.css"}
    <link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
    <link rel="apple-touch-icon-precomposed" href="{$app_path}/grn/image/cybozu/image-mobile/apple-touch-icon.png?{$build_date}">
    {grn_load_javascript file="fw/jquery/jquery-2.2.4.min.js"}
    {grn_load_javascript file="grn/common/base.js"}
    {include file="grn/browser.tpl"}
    {grn_load_javascript file="grn/html/component/custom_jquery_mobile.js"}
    {grn_load_javascript file="fw/jquery_mobile/jquery.mobile-1.4.5.min.js"}
    {grn_load_javascript file="grn/html/page/mail/mobile/view.js"}
</head>
<body>
<div data-role="page">
    {if ! $data_theme}{assign var='data_theme' value='c'}{/if}
    <div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn" style="border-style: none">
        <div class="mobile-cmt-operate-grn">
            <div class="mobile-list-todoDetail-grn mobile_scale_org_grn">
                <div id="the_iframe" class="mobile-contents-todoDetail-new-grn mobile_scale_grn">
                    {$data|grn_noescape}
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>