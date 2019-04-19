<div id="search-result" class="search-listBlockAll-grn"></div>
<div class="search-spinner-container" id="search-spinner">{grn_image image='spinner.gif'}</div>
<div class="search-message-container" id="search-empty-text" style="display: none;">
    <span class="search-message">{cb_msg module='grn.fts' key='empty-text' replace='true'}</span>
</div>
<div class="search-message-container" id="no-search-result" style="display: none;">
    <span class="search-message">{cb_msg module='grn.fts' key='no-search-result' replace='true'}</span>
</div>
<div id="search-more-container" style="display: none;" class="search-listMoreButtonBlock-grn">
    <a id="search-more" href="javascript:void(0);" class="search-listMoreButton-grn">{cb_msg module='grn.fts' key='search-more' replace='true'}</a>
</div>
{if $application!=='message' && $application!=='all'}
<div id="search-information-container" style="display: none;" class="search-information-grn">
    <div class="search-informationText-grn">
        {if $application==='bulletin'}
        {cb_msg module='grn.fts' key='category-limit' replace='true'}
        {elseif $application==='cabinet'}
        {cb_msg module='grn.fts' key='folder-limit' replace='true'}
        {elseif $application==='space'}
        {cb_msg module='grn.fts' key='space-limit' replace='true'}
        {/if}
    </div>
</div>
{/if}
