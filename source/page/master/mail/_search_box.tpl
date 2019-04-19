{strip}
<form class="clearFix-cybozu" method="get" action="{grn_pageurl page='mail/search'}" {if $mail_3pane}onsubmit="javascript:this.cid.value=grn.page.mail.mail_3pane.cid;"{/if}>
    <input type="hidden" name="aid" value="{$category.aid}">
    <input type="hidden" name="cid" value="{$category.cid}">
    <div class="search_navi search_normal_grn search_normal_3pane_grn">
        <div class="searchbox-grn">
            <div id="searchbox-select-cybozu"></div>
            <div class="input-text-outer-cybozu" id="searchbox-keyword-cybozu">
                <input id="search_text" value="" name="search_text" autocomplete="off" class="input-text-cybozu" type="text" maxlength="100">
                <button type="submit" class="searchbox-submit-cybozu"></button>
            </div>
        </div>
        {if !$use_fts}
            <span class="searchboxSub-grn"><a href="javascript:void(0);" onclick="jQuery('#search_text').val('');jQuery(this).parents('form').submit();return false;">{cb_msg module='grn.common' key='simple_search_detail'}</a></span>
        {/if}
    </div>
</form>
{/strip}