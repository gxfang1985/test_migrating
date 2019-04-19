<div class="search-conditionSort-grn">
    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='sort' replace='true'}</span>
    <div class="search-conditionButtonBlock-grn">
        <input type="radio" name="sortOrder" id="sort-score-button" value="SCORE" {if !$sortByDatetime}checked{/if} /><label for="sort-score-button" class="search-conditionSortButton-grn">{cb_msg module='grn.fts' key='sort-score' replace='true'}</label>
        <input type="radio" name="sortOrder" id="sort-date-button" value="DATETIME" {if $sortByDatetime}checked{/if} /><label for="sort-date-button" class="search-conditionSortButton-grn">{cb_msg module='grn.fts' key='sort-date' replace='true'}</label>
    </div>
</div>
