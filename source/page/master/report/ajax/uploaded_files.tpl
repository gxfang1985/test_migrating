{foreach from=$files item=file}
    <tr>
        <td>
            <input type="checkbox" class="upload_checkbox_{$name}"  onchange="onChangeCheckBox('{$file.fileid}');" id="{$file.fileid}_checkbox" name="upload_fileids[]" value="{$file.fileid}" />
        </td>
        <td>
            <span id="{$file.fileid}_filename">{$file.name|escape} ({$file.size})</span>
        </td>
        <td /><td /><td />
    </tr>
{/foreach}