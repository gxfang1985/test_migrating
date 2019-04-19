{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
    <meta name="robots" content="noindex, nofollow, noarchive">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <title>{$page_title}</title>
    {grn_load_css file="grn/html/std.css"}
    {grn_load_css file="grn/html/treeview.css"}
    {grn_load_css file="grn/html/msgbox.css"}
    {grn_load_application_specific_header}
    {grn_load_css file="grn/html/image_grn.css"}
    {if $popup_facility_list}
        {grn_load_css file="grn/html/schedule.css"}
    {/if}
    <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
    {if $browser.type == "android"}
        {grn_load_css file="grn/html/android.css"}
    {/if}
    {if $browser.type === "msie" && $browser.ver_major <= 11}
        {grn_load_css file="grn/html/ie11.css"}
    {/if}
    <link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
    {grn_load_javascript file="grn/common/base.js"}
    {include file="grn/browser.tpl"}
    {grn_load_javascript file="grn/html/std.js"}
    {grn_load_prototype_js}

    {grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
    {grn_load_javascript file="fw/yui/build/event/event-min.js"}
    {grn_load_javascript file="fw/yui/build/dom/dom-min.js"}
    {grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
    {grn_load_javascript file="fw/yui/build/treeview/treeview-min.js"}
    {grn_load_javascript file="fw/yui/build/json/json-min.js"}
    {grn_load_javascript file="fw/yui/build/animation/animation-min.js"}
    {grn_load_javascript file="fw/yui/build/yahoo-dom-event/yahoo-dom-event.js"}

    {grn_load_javascript file="grn/html/component/autofit.js"}
    {grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
    {include file="grn/url_builder.tpl"}
    {grn_load_javascript file="grn/html/component/i18n.js"}
    {grn_load_javascript_resource}
    {include file='grn/component/ajax.tpl'}
    {include file="grn/_common_js.tpl"}
    {grn_load_javascript file="grn/html/msgbox.js"}
    <script language="JavaScript" type="text/javascript">
        jQuery.noConflict();
        {grn_common_data_for_javascript}
    </script>
</head>
<body>
<div id="body">
{grn_load_javascript file="grn/html/tree-organization-item.js"}
{grn_load_javascript file="grn/html/tree-facilitygroup.js"}
{grn_load_javascript file="grn/html/fag_tree_26.js"}
{grn_load_javascript file="grn/html/tree.js"}
{grn_load_css file="grn/html/schedule.css"}
{grn_load_css file="grn/html/image_grn.css"}
{grn_load_css file="grn/html/portal.css"}
{grn_load_css file="grn/html/mail.css"}
{grn_load_css file="grn/html/std.css"}
{grn_load_javascript file="js/dist/notification.js"}
<div class="popup_title_grn">
    <div class="float_left">
        {if $portal.title}
            {grn_title title=$portal.title class=$page_info.parts[0]}
        {/if}
    </div>
    <a href="#" onclick="window.close();" role="button">
        <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}"
             aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
    </a>
    <div class="clear_both_0px"></div>
</div>
{include file="grn/url_builder.tpl"}
<script type="text/javascript" language="javascript">
    {grn_common_data_for_javascript}
</script>
{include file="grn/_head_customization.tpl"}
<div{if $fixed} class="portal_fixed_grn"{/if}>
    {if $portlet_layout.layout_0}
        <table class="top_parts">
            <tr>
                <td class="portal_base_top_grn">
                    {foreach from=$portlet_layout.layout_0.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
            </tr>
        </table>
    {/if}
    <table class="top_parts portlet_main_table">
        <tr>
            {if $portlet_layout.layout_1}
                <td class="portal_base_left_grn"{if $fixed && $portal_layout[1]} style="width: {$portal_layout[1]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_1.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
            {/if}
            {if $portlet_layout.layout_2}
                <td class="portal_base_center_grn"{if $fixed && $portal_layout[2]} style="width: {$portal_layout[2]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_2.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
            {/if}
            {if $portlet_layout.layout_3}
                <td class="portal_base_right_grn"{if $fixed && $portal_layout[3]} style="width: {$portal_layout[3]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_3.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
            {/if}
        </tr>
    </table>
</div>
{grn_load_customization_js_css}
</div><!--body_end-->
