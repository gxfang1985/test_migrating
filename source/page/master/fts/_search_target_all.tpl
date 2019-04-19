<div class="search-conditionTarget-grn">
    <div class="search-conditionButtonBlock-grn">
        <label><input id="search-target" type="checkbox" class="search-inputCheckbox-grn" name="target" value="ALL" {if $target==="ALL"}checked{/if} />{if $type==="category"}{cb_msg module='grn.fts' key='all-category' replace='true'}{else}{cb_msg module='grn.fts' key='all-folder' replace='true'}{/if}</label>
    </div>
</div>
