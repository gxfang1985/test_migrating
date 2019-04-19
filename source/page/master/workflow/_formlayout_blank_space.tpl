{grn_title title=$page_title class=$page_info.parts[0]}
<p>
    {include file='grn/show_validation_errors.tpl'}
</p>
<form name="{$form_info.name}" method="post" action="{grn_pageurl page=$form_info.action}" enctype="multipart/form-data">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tr>
            <th nowrap>{capture name='grn_workflow_item_code'}{cb_msg module='grn.workflow' key='item_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_item_code}</th>
            <td>
                {capture name='grn_workflow_item_code_value_validate_message'}{cb_msg module='grn.workflow' key='item_code_value_validate_message' replace='true'}{/capture}{validate form=$form_info.name field="code" empty="true" criteria="isRegExp" message=$smarty.capture.grn_workflow_item_code_value_validate_message expression="/^[\da-zA-Z_\-]+$/" transform="cb_trim" append="validation_errors"}
                {grn_text name='code' size='50' disable_return_key=true value=$item.code}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>{capture name='grn_workflow_allocate_right'}{cb_msg module='grn.workflow' key='allocate_right' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_allocate_right}</th>
            <td>
                {capture name='grn_workflow_allocate_item_right'}{cb_msg module='grn.workflow' key='allocate_item_right' replace='true'}{/capture}{grn_checkbox name='reverse_br' id='reverse_br' value=1 caption=$smarty.capture.grn_workflow_allocate_item_right checked=$item.reverse_br}
                <div class="br">&nbsp;</div>
                <div class="sub_explanation">{cb_msg module='grn.workflow' key='deselect_to_allocate_below_js_item' replace='true'}</div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {if $is_new_item}
                    <input class="margin" type="submit"
                           value="{cb_msg module='grn.workflow' key='add_1' replace='true'}"
                           id="{$page_info.last}_submit">
                    {grn_button_cancel page=$form_info.action_cancel cid=$category_id fid=$form_id}
                {else}
                    <input class="margin" type="submit"
                           value="{cb_msg module='grn.workflow' key='change' replace='true'}"
                           id="{$page_info.last}_submit">
                    {grn_button_cancel page=$form_info.action_cancel cid=$category_id fid=$form_id iid=$item.iid}
                {/if}
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$category_id|escape}">
    <input type="hidden" name="fid" value="{$form_id|escape}">
    <input type="hidden" name="iid" value="{$item.iid|escape}">
</form>