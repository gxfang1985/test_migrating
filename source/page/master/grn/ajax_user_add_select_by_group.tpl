<iframe id="spinner-loading-{$CID}" src="{$app_path}/grn/html/space.html?{$build_date}" frameborder="no" style="width:16; height:16; position:absolute; margin:3px 0 0 3px; z-index:2; display:none;"></iframe>

<select id="select_{$CID}" name="{$CID}" class="user_select_list" size="8" multiple>
{foreach from=$selected_item_options item=option}
{if $option.type == 'user'}
  <option value="{$option.value}">{$option.name}</option>
{elseif $option.type == 'group'}
  <option value="{$option.value}">[{$option.name}]</option>
{/if}
{/foreach}
{if $os == 'mac' }
  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{else}
  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
{/if}
</select>