<div class="explanation">{cb_msg module='grn.memo' key='GRN_MEM-68' replace='true'}</div>
<p></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
    <!--category_items-->
    <tr>
        <th>{capture name='grn_memo_GRN_MEM_69'}{cb_msg module='grn.memo' key='GRN_MEM-69' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_69 necessary=1}</th>
        <td>{capture name='grn_memo_GRN_MEM_70'}{cb_msg module='grn.memo' key='GRN_MEM-70' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_memo_GRN_MEM_70 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}</td>
    </tr>
    <tr>
        <th>{capture name='grn_memo_GRN_MEM_71'}{cb_msg module='grn.memo' key='GRN_MEM-71' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_71}</th>
        <td>
            <select name="pdid">
                <option value="">{cb_msg module="grn.memo" key="lastest_folder_name"}</option>
                {foreach from=$folder_menu key=id item=title}
                    <option value="{$id|escape}"{if $pdid == $id} selected{/if}>{$title|escape}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr valign="top">
        <th>{capture name='grn_memo_GRN_MEM_72'}{cb_msg module='grn.memo' key='GRN_MEM-72' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_72}</th>
        <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
    </tr>
    <tr>
        <td><br></td>
        <td>
            <div class="mTop10">
                {strip}
                    {grn_button ui="main" spacing="normal" action="submit" caption=$submit_caption id="memo_button_save"}
                    {grn_button action="cancel" page=$cancel_page page_param_did=$folder_id page_param_id="memo-folder-cancel" id="memo_button_cancel"}
                {/strip}
            </div>
        </td>
    </tr>
</table>
<input type="hidden" name="did" value="{$folder_id}">