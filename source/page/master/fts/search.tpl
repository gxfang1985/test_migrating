{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}
{include file="fts/_common.tpl"}

<table class="global_navi_title" cellpadding="0" style="padding:0;">
    <tbody>
    <tr>
        <td width="100%" valign="bottom" nowrap>{cb_msg module='grn.fts' key='search' replace='true'}</td>
    </tr>
    </tbody>
</table>

<div class="mainarea">

{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

<table class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {include file='fts/_search_result.tpl' application='all'}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$form_name}" method="get" action="{grn_pageurl page='fts/search'}">
                {include file='fts/_search_keyword.tpl' text=$text}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                <div class="search-conditionsPartition-grn"></div>
                {include file='fts/_search_filefilter.tpl' fileOnly=$fileOnly}
                <div class="search-conditionsPartition-grn"></div>
                <div class="search-conditionApp-grn">
                    {if $availableApplications.mail}
                    <div>
                        <label><input id="app_mail" name="mail" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $searchApplications.mail} checked="checked"{/if} /><span>{grn_appname app_id='mail'}</span></label>
                        {*<span class="search-conditionNoneSign-grn">0件</span>*}
                    </div>
                    {/if}
                    {if $availableApplications.cabinet}
                    <div>
                        <label><input id="app_cabinet" name="cabinet" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $searchApplications.cabinet} checked="checked"{/if} /><span>{grn_appname app_id='cabinet'}</span></label>
                    </div>
                    {/if}
                    {if $availableApplications.bulletin}
                    <div>
                        <label><input id="app_bulletin" name="bulletin" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $searchApplications.bulletin} checked="checked"{/if} /><span>{grn_appname app_id='bulletin'}</span></label>
                    </div>
                    {/if}
                    {if $availableApplications.message}
                    <div>
                        <label><input id="app_message" name="message" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $searchApplications.message} checked="checked"{/if} /><span>{grn_appname app_id='message'}</span></label>
                    </div>
                    {/if}
                    {if $availableApplications.space}
                    <div>
                        <label><input id="app_space" name="space" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $searchApplications.space} checked="checked"{/if} /><span>{grn_appname app_id='space'}</span></label>
                    </div>
                    {/if}
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
{grn_load_javascript file="grn/html/page/fts/search.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.fts.search;
    var form = new G.SearchForm();
    form.disableTitleFilter();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
