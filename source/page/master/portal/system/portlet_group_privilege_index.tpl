{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-496' replace='true'}
</div>

<p>
{capture name='grn_portal_system_GRN_POT_SY_497'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-497' replace='true'}{/capture}{capture name='grn_portal_system_GRN_POT_SY_498'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-498' replace='true'}{/capture}{include file='grn/flat_privilege_index.tpl' node_name=$smarty.capture.grn_portal_system_GRN_POT_SY_497 node_image='portlet20.gif' prop_name=$smarty.capture.grn_portal_system_GRN_POT_SY_498 prop_code='' page_prefix='portal/system/portlet_group_'}

{include file="grn/system_footer.tpl"}
