{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<form name="{$form_info.name}" method="post" action="{grn_pageurl page=$form_info.action}"
      enctype="multipart/form-data">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>{$confirm_message}</p>
    <p>
        {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
        {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_workflow_system_w_no}
    </p>
    <input type="hidden" name="cid" value="{$category_id|escape}">
    <input type="hidden" name="fid" value="{$form_id|escape}">
    <input type="hidden" name="iid" value="{$item.iid|escape}">
</form>

{include file='grn/system_footer.tpl'}
