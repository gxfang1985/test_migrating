<div class="search-conditionScope-grn">
    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='scope' replace='true'}</span>
    <div class="search-conditionButtonBlock-grn">
        <input type="radio" name="scopeItem" id="scope-topic-button" value="topic" {if $scopeItem != 'category'}checked{/if} /><label for="scope-topic-button" class="search-conditionScopeButton-grn">{cb_msg module='grn.fts' key='scope-topic' replace='true'}</label>
        <input type="radio" name="scopeItem" id="scope-category-button" value="category" {if $scopeItem == 'category'}checked{/if} /><label for="scope-category-button" class="search-conditionScopeButton-grn">{cb_msg module='grn.fts' key='scope-category' replace='true'}</label>
    </div>
</div>
