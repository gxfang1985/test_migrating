<div class="search-otherCondition-grn">
    <span class="search-conditionLabel-grn">{cb_msg module='grn.fts' key='languages' replace='true'}</span>
    <div>
        <select id='search-language' name='language'>
            <option value='all'{if $language === 'all'} selected{/if}>{cb_msg module='grn.fts' key='all-languages' replace='true'}</option>
            <option value='ja'{if $language === 'ja'} selected{/if}>{cb_msg module='grn.fts' key='ja' replace='true'}</option>
            <option value='en'{if $language === 'en'} selected{/if}>{cb_msg module='grn.fts' key='en' replace='true'}</option>
            <option value='zh'{if $language === 'zh'} selected{/if}>{cb_msg module='grn.fts' key='zh' replace='true'}</option>
        </select>
    </div>
</div>
