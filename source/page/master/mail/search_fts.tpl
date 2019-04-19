{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{include file="fts/_common.tpl"}
{grn_load_css file="grn/html/component/closure_compiled.css"}
{grn_load_css file="grn/html/page/fts/search.css"}
{assign var="form_name" value=$smarty.template|basename}

<table id="search-result-grn" class="search-result-grn">
    <tr>
        <td class="search-listArea-grn">
            {*メールと添付ファイルの切り替え*}
            <div class="search-listMenu-grn">
            {if ! $fileOnly}
                <span id="search-mail-message" class="search-listMenuItem-grn bold">{grn_image image="mail16.png"}{$appName}</span>
                <span class="separator-grn"></span>
                <span id="search-mail-file-link" class="search-listMenuItem-grn">
                    <a href="javascript:void(0)">
                        {grn_image image="image-common/attachment16.png"}{cb_msg module="grn.fts" key="attached_file" replace='true'}
                    </a>
                </span>
            {else}
                <span id="search-mail-message-link" class="search-listMenuItem-grn">
                    <a href="javascript:void(0)">
                        {grn_image image="mail16.png"}{$appName}
                    </a>
                </span>
                <span class="separator-grn"></span>
                <span id="search-mail-file" class="search-listMenuItem-grn bold">{grn_image image="image-common/attachment16.png"}{cb_msg module="grn.fts" key="attached_file" replace='true'}</span>{include file="fts/_search_filetype.tpl" id="selectbox" value=$fileType}
            {/if}
            </div>
            {*ここまで*}
            {if ! $fileOnly}
                {include file='mail/_search_result_mail.tpl'}
            {/if}
            {include file='fts/_search_result.tpl'}
        </td>
        <td class="search-conditionArea-grn">
            <form id="search-fts" name="{$form_name}" method="get" action="{grn_pageurl page='mail/search'}">
                <input id="search-account-id" name="aid" type="hidden" value="{$accountId}">
                <input type="hidden" id="search-fileonly" name="fileOnly" {if $fileOnly}value="1"{else}value="0"{/if}>
                <input type="hidden" id="search-filetype" name="fileType" value="{$fileType}">
                <input type="hidden" id="search-precid" name="pre_cid" value="{$pre_cid}">
                {include file='fts/_search_keyword.tpl' text=$search_text textName='search_text'}
                {include file='fts/_search_sort.tpl' sortByDatetime=$sortByDatetime}
                {if ! $fileOnly}
                    <div class="search-conditionsPartition-grn"></div>
                    <div class="search-conditionKeywordTarget-grn">
                        {include file='fts/_search_titlefilter.tpl' titleFilter=$titleFilter msgkey='search-email-title' fileOnly=$fileOnly}
                    </div>
                    <div class="search-conditionsPartition-grn"></div>
                {/if}
                <div class="search-conditionTarget-grn">
                    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='search-folder' replace='true'}</span>
                    <div class="search-conditionButtonBlock-grn">
                        {grn_mail_select_folders select_id="search-folder-id" select_name="cid" selected_folder_id=$folderId account_id=$accountId hide_folder_codes=$hideFolders root_caption_key='search-root'}
                    </div>
                </div>
                <div class="search-otherCondition-grn">
                    <label for="search-mail-sender">
                        <span class="search-conditionLabel-grn">{cb_msg module='grn.mail' key='posted-by' replace='true'}</span>
                    </label>
                    <div><input name="sender" id="search-mail-sender" value="{$sender}" type="text" class="search-conditionInputText-grn" /></div>
                </div>
                <div class="search-otherCondition-grn">
                    <label for="search-mail-receiver">
                        <span class="search-conditionLabel-grn">{cb_msg module='grn.mail' key='send-to' replace='true'}</span>
                    </label>
                    <div><input name="receiver" id="search-mail-receiver" value="{$receiver}" type="text" class="search-conditionInputText-grn" /></div>
                </div>
                {include file='fts/_search_term.tpl' dateLower=$dateLower dateUpper=$dateUpper}
                {if !$is_elasticsearch}
                    {include file='fts/_search_languages.tpl' language=$language}
                {/if}
                {include file='fts/_search_submit.tpl'}
            </form>
        </td>
    </tr>
</table>

{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
{grn_load_javascript file="grn/html/component/fts.js"}
{grn_load_javascript file="grn/html/component/closure_proxy_compiled.js"}
{grn_load_javascript file="grn/html/page/mail/search_fts.js"}
{grn_load_javascript file="grn/html/folder_select.js"}
<script type="text/javascript">
{literal}
jQuery(function (){
    var G = grn.page.mail.search_fts;
    var form = new G.SearchForm();
    form.disableModifier();
    form.disableFilterHander();
    form.init('{/literal}{$html_lang}{literal}', {/literal}{$runBackgroundSearch|@json_encode}{literal});
});
{/literal}
</script>

{include file="grn/footer.tpl"}
