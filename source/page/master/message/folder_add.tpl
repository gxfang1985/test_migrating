{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <p>
        <div class="explanation">{cb_msg module='grn.message' key='GRN_MSG-22' replace='true'}</div>
    </p>

    {include file='grn/show_validation_errors.tpl'}
    {include file='grn/indispensable.tpl'}

    <table class="std_form">
        <tr>
            <th>{capture name='grn_message_GRN_MSG_23'}{cb_msg module='grn.message' key='GRN_MSG-23' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_23 necessary=true}</th>
            <td>{capture name='grn_message_GRN_MSG_24'}{cb_msg module='grn.message' key='GRN_MSG-24' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_GRN_MSG_24 transform="cb_trim" append="validation_errors"}{grn_text name="title" size="30" value=$category.title}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.message' key='GRN_MSG-25' replace='true'}</th>
            <td>{grn_message_select_folders select_name="dcid" selected_folder_id=$category_id hide_special_folder=1}</td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.message' key='GRN_MSG-26' replace='true'}</th>
            <td>{grn_textarea name="memo" rows="9" value=$category.memo}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_message_GRN_MSG_27'}{cb_msg module='grn.message' key='GRN_MSG-27' replace='true'}{/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_27 id="message_button_save"}

                        {grn_button action="cancel" page="message/index" page_param_cid=$category_id page_param_sf='1' id="message_button_cancel"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>

    <input type="hidden" name="cid" value="{$category_id}">
    <input type='hidden' name='fn' value="{$form_name}">
</form>

{include file='grn/footer.tpl'}
