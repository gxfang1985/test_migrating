<tr valign="top">
 <th>{cb_msg module='grn.workflow' key='item_conditions' replace='true'}</th>
 <td>
   {if $item.required == 1 && $required_item == true}{cb_msg module='grn.workflow' key='required_item' replace='true'}<BR>{/if}
   {if $item.export_data == 1 && $smarty.const.ON_FOREST !== 1}{cb_msg module='grn.workflow' key='to_export_data' replace='true'}{/if}
 </td>
</tr>

