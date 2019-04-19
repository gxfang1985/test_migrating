{foreach from=$files item=file}
    <tr>
        <td>
            <input id="{$file.fileid}_checkbox" type="checkbox" class="upload_checkbox" onclick="onChangeCheckBox('{$file.fileid}')" checked="" value="{$file.fileid}" name="upload_fileids[]"/>
        </td>
        <td>
            <span id="{$file.fileid}_filename">{$file.name|escape} ({$file.size})</span>
        </td>
        <td /><td /><td />
    </tr>
{/foreach}