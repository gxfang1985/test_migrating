<div class="search-conditionFileApp-grn">
    <div class="search-conditionFileAppBlock-grn">
        <label id="filefilter-label"{if $disabled} class="textDisable-grn"{/if}><input id="search-fileonly" name="fileOnly" type="checkbox" class="search-inputCheckbox-grn" value="1"{if $fileOnly} checked="checked"{/if}{if $disabled} disabled="disabled"{/if} />{cb_msg module='grn.fts' key='fileOnly' replace='true'}</label>
        <div class="search-conditionFileSelect-grn">
            <span id="filetype-span" {if $disabled}class="search-filetypeLabel-disabled-grn"{else}class="search-filetypeLabel-grn"{/if}>{cb_msg module='grn.fts' key='filter' replace='true'}</span>{include file='fts/_search_filetype.tpl' value=$fileType disabled=$disabled}
        </div>
    </div>
</div>
