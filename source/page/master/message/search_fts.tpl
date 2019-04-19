{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{include file="fts/_common.tpl"}
{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

<table class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {include file='fts/_search_result.tpl' application='message'}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$searchFolderName}" method="get" action="{grn_pageurl page='message/search'}">
                {include file='fts/_search_keyword.tpl' text=$search_text textName='search_text'}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionKeywordTarget-grn">
                    {include file='fts/_search_filefilter.tpl' fileOnly=$fileOnly disabled=$titleFilter}
                    {include file='fts/_search_titlefilter.tpl' titleFilter=$titleFilter msgkey='search-message-title' disabled=$fileOnly}
                </div>
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionTarget-grn">
                    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='search-folder' replace='true'}</span>
                    {capture name='root_caption'}{cb_msg module='grn.message' key='search-root' replace='true'}{/capture}
                    <div class="search-conditionButtonBlock-grn">
                        {grn_message_select_folders select_name="dcid" select_id="search-message-folder" selected_folder_id=$folderId hide_folders=$hideFolders root_caption=$smarty.capture.root_caption}
                    </div>
                </div>
                {include file='fts/_search_modifier.tpl' modifier=$modifier module='grn.message'}
                {include file='fts/_search_term.tpl' dateLower=$dateLower dateUpper=$dateUpper}
                {if !$is_elasticsearch}
                    {include file='fts/_search_languages.tpl' language=$language}
                {/if}
                {include file='fts/_search_submit.tpl'}
            </form>
        </td>
    </tr>
</table>
{grn_load_javascript file="grn/html/component/fts.js"}
{grn_load_javascript file="grn/html/component/closure_proxy_compiled.js"}
{grn_load_javascript file="grn/html/page/message/search_fts.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.message.search_fts;
    var form = new G.SearchForm();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
