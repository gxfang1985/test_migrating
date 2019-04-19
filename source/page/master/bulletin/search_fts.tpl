{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{include file="fts/_common.tpl"}
{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

<table class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {include file='fts/_search_result.tpl' application='bulletin'}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$form_name}" method="get" action="{grn_pageurl page='bulletin/search'}">
                <input id="bulletin-search-category" type="hidden" name="cid" value="{$categoryId}" />
                {include file='fts/_search_keyword.tpl' text=$text}
                {include file='bulletin/_search_scope.tpl' scopeItem=$scopeItem}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionKeywordTarget-grn">
                    {include file='fts/_search_filefilter.tpl' fileOnly=$fileOnly disabled=$titleFilter}
                    {include file='fts/_search_titlefilter.tpl' titleFilter=$titleFilter msgkey='search-bulletin-subject' disabled=$fileOnly}
                </div>
                <div class="search-conditionsPartition-grn"></div>
                {if $categoryId!="1"}{include file='fts/_search_target_all.tpl' target=$target type="category"}{/if}
                {include file='fts/_search_modifier.tpl' modifier=$modifier module='grn.bulletin'}
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
{grn_load_javascript file="grn/html/page/bulletin/search_fts.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.bulletin.search_fts;
    var form = new G.SearchForm();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
