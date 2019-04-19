{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}" enctype="multipart/form-data">
    {include file='grn/show_validation_errors.tpl'}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr>
            <th>{capture name='grn_message_GRN_MSG_79'}{cb_msg module='grn.message' key='GRN_MSG-79' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_79 necessary=true}</th>
            <td>{capture name='grn_message_GRN_MSG_80'}{cb_msg module='grn.message' key='GRN_MSG-80' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_GRN_MSG_80 transform="cb_trim" append="validation_errors"}{grn_text name="title" value=$message.subject size="50" disable_return_key=true}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.message' key='GRN_MSG-81' replace='true'}</th>
            <td>{grn_user_name uid=$message.creator_id name=$message.creator_name}</td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.message' key='GRN_MSG-82' replace='true'}</th>
            <td>
                {include file="grn/richeditor.tpl" html=$message.html text=$message.data cols=$cols rows=$rows enable=$use_editor class="form_textarea_grn"}
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.message' key='GRN_MSG-83' replace='true'}</th>
            <td>{include file="grn/attach_file.tpl" attached_files=$message.attached_files}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_message_grn_msg_84'}{cb_msg module='grn.message' key='GRN_MSG-84' replace='true'}{/capture}
                        {capture name='grn_message_grn_msg_84_onclick'}
                            if (grn.component.button(this).isDisabled()) return false; if (!confirmIfExistFailedFile()) return false; else grn.component.button.util.submit(this); grn.component.button(this).showSpinner();
                        {/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_message_grn_msg_84 onclick=$smarty.capture.grn_message_grn_msg_84_onclick id="message_button_save" auto_disable=false}

                        {grn_button action="cancel" page="message/view" page_param_cid=$cid page_param_rid=$rid page_param_mid=$mid id="message_button_cancel"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" name="cid" value="{$cid}">
    <input type="hidden" name="rid" value="{$rid}">
    <input type="hidden" name="mid" value="{$mid}">
    <input type='hidden' name='fn' value="{$form_name}">
    <input type="hidden" name="tmp_key" value="{$tmp_key}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</form>

{include file='grn/footer.tpl'}
