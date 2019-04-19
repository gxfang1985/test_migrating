{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{include file="fts/_common.tpl"}
{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

{if $space}
    {grn_space_show_expiration_date_warning space=$space}
{/if}

<table class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {include file='fts/_search_result.tpl' application='space' searchRange=$searchRange categoryId=$categoryId}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$form_name}" method="get" action="{grn_pageurl page='space/search'}">
                <input type="hidden" id="search-space-range" name="searchRange" value="{$searchRange}" />
                {if $spaceId}<input type="hidden" id="search-space-id" name="spid" value="{$spaceId}" />{/if}
                {if $from_todo}<input type="hidden" name="from_todo" value="1" />{/if}
                {if $searchRange=="ALL"}<input id="search-category-id" type="hidden" name="cid" value="{$categoryId}">{/if}
                {include file='fts/_search_keyword.tpl' text=$text}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionKeywordTarget-grn">
                    {include file='fts/_search_filefilter.tpl' fileOnly=$fileOnly disabled=$titleFilter}
                    {include file='fts/_search_titlefilter.tpl' titleFilter=$titleFilter msgkey='search-space-subject' disabled=$fileOnly}
                </div>
                {if $searchRange=="ALL" && $categoryId!="1"}
                    <div class="search-conditionsPartition-grn"></div>
                    {include file='fts/_search_target_all.tpl' target=$target type="category"}
                {/if}
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionApp-grn">
                    <div>
                        <label><input id="app_discussion" name="discussion" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $spaceApplications.discussion} checked="checked"{/if} /><span>{cb_msg module='grn.space' key='discussion' replace='true'}</span></label>
                    </div>
                    <div>
                        <label><input id="app_todo" name="todo" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $spaceApplications.todo} checked="checked"{/if} /><span>{cb_msg module='grn.space' key='todo' replace='true'}</span></label>
                    </div>
                </div>
                <div class="search-conditionsPartition-grn"></div>
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
{grn_load_javascript file="grn/html/page/space/search_fts.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.space.search_fts;
    var form = new G.SearchForm();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
