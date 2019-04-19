{if !$textName}{assign var="textName" value="text"}{/if}
<span class="search-conditionMainlabel-grn">{cb_msg module='grn.fts' key='keyword' replace='true'}</span>
<div class="search-conditionKeywordInputBase-grn"><input id="searchbox" type="text" name="{$textName}" value="{$text}" class="search-conditionKeywordInput-grn" maxlength="100"/><input type="submit" class="search-searchButton-grn" value=""/></div>
