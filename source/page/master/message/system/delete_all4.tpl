{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-82' replace='true'}</div>

<ul>
<li>{capture name='grn_message_system_GRN_MSG_SY_83'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-83' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_system_GRN_MSG_SY_83 page='system/application_list' app_id='message'}
</ul>

{include file="grn/system_footer.tpl"}
