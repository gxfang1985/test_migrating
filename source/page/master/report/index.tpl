{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/report.js"}
<script src="{$app_path}/fw/yui/build/yahoo-dom-event/yahoo-dom-event.js?{$build_date}" type="text/javascript"></script> 
<script src="{$app_path}/fw/yui/build/animation/animation-min.js?{$build_date}" type="text/javascript"></script> 
<link rel="stylesheet" type="text/css" href="{$app_path}/grn/html/report.css?{$build_date}"> 
{include file='report/_title_search.tpl'}

<div class="mainarea">
<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<div style="" class="content">
  <div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item">
            {capture name='grn_report_GRN_RPRT_261'}{cb_msg module='grn.report' key='GRN_RPRT-261' replace='true'}{/capture}{grn_link image='write20.gif' page='report/send' caption=$smarty.capture.grn_report_GRN_RPRT_261 top=1}
        </span>
        <span class="menu_item">
            {include file='report/_display_options.tpl'}
        </span>
    </div>

        <div id="smart_rare_menu_part">
            {capture name='grn_report_GRN_RPRT_357'}{cb_msg module='grn.report' key='GRN_RPRT-357' replace='true'}{/capture}{grn_simple_search caption=$smarty.capture.grn_report_GRN_RPRT_357 name='search_text' action='report/search' page='report/search'}
        </div>
  </div>
{literal}
<script>
function  clear_star_catch()
{
    reportListDataCaches = new Array();
}
</script>
{/literal}

{include file="star/star_init.tpl" list_id="report_list" use_star=true on_update="clear_star_catch"}
    <table id="reportTable" width="100%">
        <tbody>
            <tr valign="top">
                <td width="23%" id="tree_part">
                    {include file="report/_menu.tpl"}
                </td>
                <td width="77%" id="view_part">
                    <div id="search_result" >
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>
</td></tr></tbody></table><!--end of maincontents_list-->

{include file='grn/footer.tpl'}