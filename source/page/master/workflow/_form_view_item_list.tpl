<colgroup>
 <col width="1%">
 <col width="32%">
 <col width="30%">
 <col width="25%">
{if $smarty.const.ON_FOREST !== 1}
 <col width="12%">
{/if}
</colgroup>
<tr>
 <th nowrap>{include file="workflow/checkall.tpl" func_name="CheckAllItems" form_name="`$form_name`/form_layout_list"  elem_name="ids[]"}</th>
 <th nowrap>{cb_msg module='grn.workflow.system' key='w_item_name_y' replace='true'}</th>
 <th nowrap>{cb_msg module='grn.workflow.system' key='w_item_type' replace='true'}</th>
 <th nowrap>{cb_msg module='grn.workflow.system' key='w_item_code' replace='true'}</th>
{if $smarty.const.ON_FOREST !== 1}
 <th nowrap>{cb_msg module='grn.workflow.system' key='w_export_1_y' replace='true'}</th>
{/if}
</tr>
{foreach from=$item_list item=item}
 <tr valign="top">
 {if $item.type == 0}
  <td><input type="checkbox" name="ids[]" value="{$item.iid|escape}"{if !$enable} disabled{/if}></td>
  <td>
    {grn_link page="workflow/$link_identifier/formlayout_view" caption=$item.display_name image='view20.gif' cid=$category_id fid=$form_id iid=$item.iid}
  </td>
  <td>{$item.display_type|escape}</td>
  <td>{if strpos($item.code,'$') === FALSE}{$item.code|escape}{/if}</td>
  {if $smarty.const.ON_FOREST !== 1}
    <td>{if $item.export_data == 1}{cb_msg module='grn.workflow.system' key='w_export_1_y_value' replace='true'}{/if}</td>
  {/if}
 {elseif $item.type == 3}
  <td><input type="checkbox" name="ids[]" value="{$item.iid|escape}"{if !$enable} disabled{/if}></td>
  <td>
   {grn_link page="workflow/$link_identifier/formlayout_blank_space_detail" caption=$item.display_name image='view20.gif' cid=$category_id fid=$form_id iid=$item.iid}
  </td>
  <td>{$item.display_type|escape}</td>
  <td>{if strpos($item.code,'$') === FALSE}{$item.code|escape}{/if}</td>
  {if $smarty.const.ON_FOREST !== 1}
   <td>{if $item.export_data == 1}{cb_msg module='grn.workflow.system' key='w_export_1_y_value' replace='true'}{/if}</td>
  {/if}
 {elseif $item.type == 1}
  <td nowrap align="center">&nbsp;-&nbsp;</td>
  <td>
    {grn_link page="workflow/$link_identifier/formlayout_view" caption=$item.display_name image='view20.gif' cid=$category_id fid=$form_id iid=$item.iid}
  </td>
  <td>{$item.display_type|escape}{cb_msg module='grn.workflow.system' key='w_standard_item' replace='true'}</td>
  <td>{if strpos($item.code,'$') === FALSE}{$item.code|escape}{/if}</td>
  {if $smarty.const.ON_FOREST !== 1}
    <td>{if $item.export_data == 1}{cb_msg module='grn.workflow.system' key='w_export_1_y_value' replace='true'}{/if}</td>
  {/if}
 {elseif $item.type == 2}
  <td><input type="checkbox" name="ids[]" value="{$item.iid|escape}" {if !$enable} disabled{/if}></td>
  <td colspan="{if $smarty.const.ON_FOREST !== 1}4{else}3{/if}">
   &nbsp;
  </td>
 {/if}
 </tr>
{/foreach}

