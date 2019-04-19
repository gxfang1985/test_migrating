{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{include file="fts/_common.tpl"}
{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

<table class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {include file='fts/_search_result.tpl' application='cabinet'}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$searchFolderName}" method="get" action="{grn_pageurl page='cabinet/search'}">
                <input id="search-cabinet-follder" type="hidden" name="hid" value="{$folderId}" />
                {include file='fts/_search_keyword.tpl' text=$text}
                {include file='cabinet/_search_scope.tpl' scopeItem=$scopeItem}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                <div class="search-conditionFileApp-grn">
                    <div class="search-conditionFileAppBlock-grn">
                        <span id="filetype-span" class="search-filetypeLabel-grn">{cb_msg module='grn.fts' key='filter' replace='true'}</span>{include file='fts/_search_filetype.tpl' value=$fileType}
                    </div>
                </div>
                {if $folderId!="1"}{include file='fts/_search_target_all.tpl' target=$target type="folder"}{/if}
                {include file='fts/_search_modifier.tpl' modifier=$modifier}
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
{grn_load_javascript file="grn/html/page/cabinet/search_fts.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.cabinet.search_fts;
    var form = new G.SearchForm();
    form.disableFileOnly();
    form.disableTitleFilter();
    form.disableFilterHander();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
