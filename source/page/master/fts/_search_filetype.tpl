{if $id}
<select id="{$id}" name="fileType">
{else}
<select id="search-filetype" name="fileType"{if $disabled} disabled="disabled"{/if}>
{/if}
    <option value="ALL" {if $value=="ALL"}selected{/if}>{cb_msg module='grn.fts' key='all-files' replace='true'}</option>
    <option value="ppt" {if $value=="ppt"}selected{/if}>{cb_msg module='grn.fts' key='ppt' replace='true'}</option>
    <option value="doc" {if $value=="doc"}selected{/if}>{cb_msg module='grn.fts' key='doc' replace='true'}</option>
    <option value="xls" {if $value=="xls"}selected{/if}>{cb_msg module='grn.fts' key='xls' replace='true'}</option>
    <option value="pdf" {if $value=="pdf"}selected{/if}>{cb_msg module='grn.fts' key='pdf' replace='true'}</option>
    <option value="txt" {if $value=="txt"}selected{/if}>{cb_msg module='grn.fts' key='txt' replace='true'}</option>
    <option value="other" {if $value=="other"}selected{/if}>{cb_msg module='grn.fts' key='other' replace='true'}</option>
</select>
