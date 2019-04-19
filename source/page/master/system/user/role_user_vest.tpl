{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-678' replace='true'}<span class="bold">{grn_image image='role20.gif'}{$role_name|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-679' replace='true'}
</div>

<p>
{capture name='grn_system_user_GRN_SY_US_680'}{cb_msg module='grn.system.user' key='GRN_SY_US-680' replace='true'}{/capture}{include file='grn/org_user_select.tpl' form_name=$smarty.template|basename post_page='system/user/command_role_user_vest' cancel_page='system/user/role_list' submit_caption=$smarty.capture.grn_system_user_GRN_SY_US_680 ous_params=$ous_params json_page='system/org_json'}

{include file="grn/system_footer.tpl"}
