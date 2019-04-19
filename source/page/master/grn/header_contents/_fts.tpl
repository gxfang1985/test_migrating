{strip}
<div role="search" class="cloudHeader-searchbox inline_block_grn">
    <form class="clearFix-cybozu" method="get" action="{grn_pageurl page='fts/search'}">
        <div id="searchbox-select-cybozu"></div>
        <div class="input-text-outer-cybozu" id="searchbox-keyword-cybozu">
            <input type="text" name="text" autocomplete="off" class="prefix-grn"
                   placeholder="{cb_msg module='grn' key='HEADER_SEARCH' replace='true'}"
                   title="{cb_msg module='grn' key='HEADER_SEARCH' replace='true'}"
                   maxlength="100"/>
            <button id="searchbox-submit-button" class="searchbox-submit-cybozu"
                    type="submit"
                    title="{cb_msg module='grn' key='HEADER_SEARCHBOX_TITLE' replace='true'}" aria-label="{cb_msg module='grn' key='HEADER_SEARCHBOX_TITLE' replace='true'}">
            </button>
        </div>
    </form>
</div>
{/strip}