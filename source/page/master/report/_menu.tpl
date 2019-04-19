{literal}
<script language="Javascript" type="text/javascript">
<!--
plusImage  = {/literal}'{$app_path}/grn/image/cybozu/addressee_on20.gif?{$build_date}'{literal};
minusImage = {/literal}'{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}'{literal};
spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
reportListUrl = {/literal}'{grn_pageurl page="report/ajax/report_list"}'{literal};
unreadCountUrl = {/literal}'{grn_pageurl page="report/ajax/unread_count"}'{literal};
pagingSize = {/literal}{$pagingSize}{literal};
maxHeight = 300;
iFrame = null;

filterPainHeights = new Array();

//window.onloadよりこっちの方が速い
jQuery(document).ready(
        function() {
            iFrame = jQuery('#history_iframe')[0];
            initialize();
         });

function initialize()
{
    updateUnreadCount();

    if(!location.hash)
    {
        {/literal}{if $sf}{literal}
        location.hash = {/literal}'#type={$type}&fid={$fid}&sp={$sp}'{literal};
        {/literal}{/if}{literal}
    }

    if(grn.browser.msie)
        iFrame = jQuery('#history_iframe')[0];

    history_callback();
    loadReportList(location.hash);
}

//描画されてからでないとダメな処理はwindow.onload内に記述する
window.onload = function()
{
    filterPainHeights['recentFilters']  = document.getElementById('recentFiltersPain').clientHeight + 5;
    filterPainHeights['displayFilters'] = document.getElementById('displayFiltersPain').clientHeight > maxHeight ? maxHeight : document.getElementById('displayFiltersPain').clientHeight + 5;
    /* GRN2-1936
    filterPainHeights['personalFilters'] = $('personalFiltersPain').clientHeight > maxHeight ? maxHeight : $('personalFiltersPain').clientHeight + 5;
    */
    filterPainHeights['allFilters']     = document.getElementById('allFiltersPain').clientHeight > maxHeight ? maxHeight : document.getElementById('allFiltersPain').clientHeight + 5;
    document.getElementById('allFiltersPain').style.height = grn.browser.msie ? 1 + 'px' : 0;
    document.getElementById('allFiltersPain').style.visibility = 'visible';

    if(document.getElementById('displayFiltersPain').clientHeight > maxHeight)
        document.getElementById('displayFiltersPain').style.height = maxHeight +'px';
    /* GRN2-1936
    if($('personalFiltersPain').clientHeight > maxHeight)
        $('personalFiltersPain').style.height = maxHeight;
    */

    //長い絞込み名への対策
    width = getWindowWidth()*0.2;
    jQuery('div.filtersContent').each(
        function(index,node)
        {
            node.style.width = width + 'px';
            node.style.overflow = 'auto';
        });
    document.getElementById('allFiltersPain').style.overflow = 'hidden';

    //横スクロールバーが出たら、その分高さを拡張する
    if(document.getElementById('recentFilters').clientWidth > width)
    {
        if(grn.browser.msie)
            document.getElementById('recentFiltersPain').style.height = (filterPainHeights['recentFilters'] + 20) + 'px';
        filterPainHeights['recentFilters'] += 20;
    }
    if(document.getElementById('displayFilters').clientWidth > width)
    {
        if(grn.browser.msie)
            document.getElementById('displayFiltersPain').style.height = (filterPainHeights['displayFilters'] + 20) + 'px';
        filterPainHeights['displayFilters'] += 20;
    }

    if(document.getElementById('allFilters').clientWidth > width)
    {
        filterPainHeights['allFilters'] += 20;
    }
}
//-->
</script>
{/literal}

<iframe id="history_iframe" src="" style="display:none;"></iframe>
{literal}
<style type="text/css">
    <!--
    .folderItem
    {
        height: 1.8em;
    }
    -->
</style>
    {/literal}
<table width="100%">
    <tbody>
        <tr>
            <td nowrap="" class="folderItem">
                <span id="span_receive" class="">
                    {grn_image image='folder20.gif'}<a href="#type=received">{cb_msg module='grn.report' key='GRN_RPRT-235' replace='true'}</a><span id="unreadReceiveCount" style="visibility:hidden;">{if $unread_num > 0}({$unread_num}){/if}</span>
                </span>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="folderItem">
                <span class="" id="span_send">
                    {grn_image image='sentbox20.gif'}<a href="#type=send">{cb_msg module='grn.report' key='GRN_RPRT-236' replace='true'}</a>
                </span>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="folderItem">
                <span class="" id="span_draft">
                    {grn_image image='unsentbox20.gif'}<a href="#type=draft">{cb_msg module='grn.report' key='GRN_RPRT-237' replace='true'}</a>
                </span>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="folderItem"> 
                <span class="" id="span_all">                
                    {grn_image image='inbox20.gif'}<a href="#type=all">{cb_msg module='grn.report' key='GRN_RPRT-238' replace='true'}</a>
                </span>
            </td>
        </tr>
    </tbody>
</table>
<div class="border-partition-common-grn"></div>
<div style="font-size: 14px; padding-left: 1em;" class="smallcorner">
    {if $recentFiltersCount > 0}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="recentFiltersImage" onclick="toggleFilterView('recentFilters');">
        <a href="javascript:toggleFilterView('recentFilters');">
            {cb_msg module='grn.report' key='GRN_RPRT-239' replace='true'}
        </a>
    {else}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="recentFiltersImage" style="display:none;">
        {cb_msg module='grn.report' key='GRN_RPRT-240' replace='true'}
    {/if}
</div>
<div class="filtersContent" id="recentFiltersPain" {if $recentFiltersCount == 0} style="display:none;" {/if}>
    <table id="recentFilters">
        <tbody>
            {foreach from=$recentFilters item=filter}
                <tr>
                    <td nowrap="">
                        <span class="" id="span_recent_{$filter.id}">                
                            <img src="{$app_path}/grn/image/cybozu/node20.gif?{$build_date}" align="top"/><a href="#type=filter&fid={$filter.id}">{$filter.name|escape}</a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<div class="border-partition-common-grn"></div>
<div style="font-size: 14px; padding-left: 1em;" class="smallcorner">
    {if $displayFiltersCount > 0}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="displayFiltersImage" onclick="toggleFilterView('displayFilters');">
        <a href="javascript:toggleFilterView('displayFilters');">
            {cb_msg module='grn.report' key='GRN_RPRT-241' replace='true'}
        </a>
    {else}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="displayFiltersImage" style="display:none;">
        {cb_msg module='grn.report' key='GRN_RPRT-242' replace='true'}
    {/if}
</div>
<div class="filtersContent" id="displayFiltersPain" {if $displayFiltersCount == 0} style="display:none;" {/if}>
    <table id="displayFilters">
        <tbody>
            {foreach from=$displayFilters item=filter}
                <tr>
                    <td nowrap="">
                        <span class="" id="span_display_{$filter.id}">                
                            <img src="{$app_path}/grn/image/cybozu/node20.gif?{$build_date}" align="top"/><a href="#type=filter&fid={$filter.id}">{$filter.name|escape}</a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<div class="border-partition-common-grn"></div>
{* GRN2-1936
<div style="font-size: 14px; padding-left: 1em;" class="smallcorner">
    {if $personalFiltersCount > 0}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="personalFiltersImage" onclick="toggleFilterView('personalFilters');">
        <a href="javascript:toggleFilterView('personalFilters');">
            {cb_msg module='grn.report' key='personal_filter' replace='true'}
        </a>
    {else}
        <img src="{$app_path}/grn/image/cybozu/addressee_off20.gif?{$build_date}" align="absmiddle" id="personalFiltersImage" style="display:none;">
        {cb_msg module='grn.report' key='personal_filter' replace='true'}
    {/if}
</div>
<div class="filtersContent" id="personalFiltersPain" {if $personalFiltersCount == 0} style="display:none;" {/if}>
    <table id="personalFilters">
        <tbody>
            {foreach from=$personalFilters item=filter}
                <tr>
                    <td nowrap="">
                        <span class="" id="span_personal_{$filter.id}">
                            <img src="{$app_path}/grn/image/cybozu/node20.gif?{$build_date}" align="top"/><a href="#type=filter&fid={$filter.id}">{$filter.name|escape}</a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<div class="border-partition-common-grn"></div>
*}
<div style="font-size: 14px; padding-left: 1em;">
    {if $allFiltersCount > 0}
        <img src="{$app_path}/grn/image/cybozu/addressee_on20.gif?{$build_date}" align="absmiddle" id="allFiltersImage" onclick="toggleFilterView('allFilters');">
        <a href="javascript:toggleFilterView('allFilters');" >{cb_msg module='grn.report' key='GRN_RPRT-243' replace='true'}</a>
    {else}
        <img src="{$app_path}/grn/image/cybozu/addressee_on20.gif?{$build_date}" align="absmiddle" id="allFiltersImage" style="display:none;">
        {cb_msg module='grn.report' key='GRN_RPRT-244' replace='true'}
    {/if}
</div>                
<div class="filtersContent" style="visibility:hidden;" id="allFiltersPain">
    <table id="allFilters">
        <tbody>
            {foreach from=$allFilters item=filter}
                <tr>
                    <td nowrap="">
                        <span class="" id="span_all_{$filter.id}">                
                            <img src="{$app_path}/grn/image/cybozu/node20.gif?{$build_date}" align="top"/><a href="#type=filter&fid={$filter.id}">{$filter.name|escape}</a>
                        </span>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

