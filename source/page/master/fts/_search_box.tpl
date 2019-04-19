{if !$textName}{assign var='textName' value='text'}{/if}
<div class="search_navi">
    <div class="searchbox-grn">
        <div id="searchbox-select-cybozu"></div>
        <div class="input-text-outer-cybozu" id="searchbox-keyword-cybozu">
            <input {if $inputId}id="{$inputId}" {/if}type="text" name="{$textName}" autocomplete="off" class="input-text-cybozu" maxlength="100"/>
            <button type="submit" class="searchbox-submit-cybozu"></button>
        </div>
    </div>
</div>
