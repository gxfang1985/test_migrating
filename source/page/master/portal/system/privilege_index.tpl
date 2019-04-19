{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-305' replace='true'}
</div>

<p>
{capture name='grn_portal_system_GRN_POT_SY_306'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-306' replace='true'}{/capture}{capture name='grn_portal_system_GRN_POT_SY_307'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-307' replace='true'}{/capture}{include file='grn/flat_privilege_index.tpl' node_name=$smarty.capture.grn_portal_system_GRN_POT_SY_306 node_image='portal20.gif' prop_name=$smarty.capture.grn_portal_system_GRN_POT_SY_307 prop_code='' page_prefix='portal/system/'}

{include file="grn/system_footer.tpl"}
