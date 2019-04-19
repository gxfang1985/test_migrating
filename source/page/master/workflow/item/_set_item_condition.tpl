{if $required_item === true || $smarty.const.ON_FOREST !== 1}
<tr>
 <th nowrap>{capture name='grn_workflow_item_conditions'}{cb_msg module='grn.workflow' key='item_conditions' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_item_conditions}</th>
 <td>
     {if $required_item === true}
        {capture name='grn_workflow_required_item'}{cb_msg module='grn.workflow' key='required_item' replace='true'}{/capture}{grn_checkbox name='required' id='required' value='1' caption=$smarty.capture.grn_workflow_required_item checked=$item.required}
        <BR>
     {/if}
     {if $smarty.const.ON_FOREST !== 1}
        {capture name='grn_workflow_to_export_data'}{cb_msg module='grn.workflow' key='to_export_data' replace='true'}{/capture}{grn_checkbox name='export_data' id='export_data' value='1' caption=$smarty.capture.grn_workflow_to_export_data checked=$item.export_data}
        <BR>
        <span style='padding-left:21px'>{cb_msg module='grn.workflow' key='to_export_data_description' replace='true'}</span>
     {/if}
 </td>
</tr>
{/if}
