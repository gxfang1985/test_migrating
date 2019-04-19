{assign var="module" value=$module|default:'grn.fts'} 
<div class="search-otherCondition-grn">
    <span class="search-conditionLabel-grn">{cb_msg module=$module key='posted-by'}</span>
    <div><input name="modifier" id="search-modifier" value="{$modifier}" type="text" class="search-conditionInputText-grn" /></div>
</div>
