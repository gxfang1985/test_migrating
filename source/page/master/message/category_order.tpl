{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <div id="one_parts">
        <div id="action">
            <!----->
            <div class="explanation mTop15">{cb_msg module='grn.message' key='GRN_MSG-290' replace='true'}
                    <div class="sub_explanation">{cb_msg module='grn.message' key='GRN_MSG-291' replace='true'}</div>
            </div>
            {grn_change_order form_name=$form_name select_name='order[]' options=$category}
            <!----->
        </div>
    </div>

    {strip}
        <div class="mTop15 mBottom15">
        {capture name='grn_message_GRN_MSG_300'}{cb_msg module='grn.message' key='GRN_MSG-300' replace='true'}{/capture}
        {capture name='message_button_save_onclick'}
            grn_onsubmit_common(document.forms['{$form_name}']); grn.component.button.util.submit(this);
        {/capture}
        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_300 onclick=$smarty.capture.message_button_save_onclick id="message_button_save"}

        {grn_button action="cancel" page="message/index" page_param_cid=$cid id="message_button_cancel"}
        </div>
    {/strip}

    <input type="hidden" name="cid" value="{$cid}">
</form>

{include file='grn/footer.tpl'}
