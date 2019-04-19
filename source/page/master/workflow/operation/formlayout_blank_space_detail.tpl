{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change_with_no_cancel' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change page="workflow/$screen_type/formlayout_blank_space_modify" params=$menu_params image='modify20.gif' disabled=$is_not_manage}</span>
    <span class="menu_item">{capture name='grn_workflow_delete_2'}{cb_msg module='grn.workflow' key='delete_2' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_delete_2 page="workflow/$screen_type/formlayout_blank_space_delete" params=$menu_params image='delete20.gif' disabled=$is_not_manage}</span>
</div>

<p>
<table class="view_table" width="80%">
    <tr valign="top">
        <th>{cb_msg module='grn.workflow' key='item_code' replace='true'}</th>
        <td>{$item.code|escape}</td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.workflow' key='allocate_right' replace='true'}</th>
        <td>{if $item.reverse_br == 0}{cb_msg module='grn.workflow' key='option_string_blank_space_br_no' replace='true'}{else}{cb_msg module='grn.workflow' key='option_string_blank_space_br_yes' replace='true'}{/if}</td>
    </tr>
</table>

{include file="grn/footer.tpl"}
