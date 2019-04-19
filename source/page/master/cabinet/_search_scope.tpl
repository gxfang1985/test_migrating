<div class="search-conditionScope-grn">
    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='scope' replace='true'}</span>
    <div class="search-conditionButtonBlock-grn">
        <input type="radio" name="scopeItem" id="scope-file-button" value="file" {if $scopeItem != 'folder'}checked{/if} /><label for="scope-file-button" class="search-conditionScopeButton-grn">{cb_msg module='grn.fts' key='scope-file' replace='true'}</label>
        <input type="radio" name="scopeItem" id="scope-folder-button" value="folder" {if $scopeItem == 'folder'}checked{/if} /><label for="scope-folder-button" class="search-conditionScopeButton-grn">{cb_msg module='grn.fts' key='scope-folder' replace='true'}</label>
    </div>
</div>
