{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <p>
        <div class="explanation">{cb_msg module='grn.message' key='GRN_MSG-138' replace='true'}</div>
    </p>

    {include file='grn/show_validation_errors.tpl'}
    {if $category.type eq null}
        {include file='grn/indispensable.tpl'}
    {/if}
    <table class="std_form">
        <tr>
            {if $category.type eq null}
                <th>{capture name='grn_message_GRN_MSG_139'}{cb_msg module='grn.message' key='GRN_MSG-139' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_139 necessary=true}</th>
            {else}
                <th>{capture name='grn_message_GRN_MSG_140'}{cb_msg module='grn.message' key='GRN_MSG-140' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_140}</th>
            {/if}
            <td>
                {capture name='grn_message_GRN_MSG_141'}{cb_msg module='grn.message' key='GRN_MSG-141' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_GRN_MSG_141 transform="cb_trim" append="validation_errors"}
                {if $category.type eq null}
                    {grn_text name="title" size="30" value=$category.title}
                {else}
                    {$category.title|escape}
                {/if}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.message' key='GRN_MSG-142' replace='true'}</th>
            <td>
                {if $category.type eq null}
                    {grn_message_select_folders select_name="pid" selected_folder_id=$cid hide_special_folder="1" hide_selected_folder="1" parent_folder_id=$category.parent_id}
                {else}
                    {cb_msg module='grn.message' key='GRN_MSG-143' replace='true'}
                {/if}
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.message' key='GRN_MSG-144' replace='true'}</th>
            <td>{grn_textarea name="memo" rows="9" value=$category.memo}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_message_GRN_MSG_145'}{cb_msg module='grn.message' key='GRN_MSG-145' replace='true'}{/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_145 id="message_button_save"}

                        {grn_button action="cancel" page="message/folder_view" page_param_cid=$cid id="message_button_cancel"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$cid}">
    <input type='hidden' name='fn' value="{$form_name}">
</form>

{include file='grn/footer.tpl'}
