{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-534' replace='true'}
</div>


{capture name='grn_portal_system_GRN_POT_SY_100'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-100' replace='true'}{/capture}{include file='grn/availability_list.tpl' page_dir='portal/system' page_prefix='portal/system/' base_prefix='' authority_name=$smarty.capture.grn_portal_system_GRN_POT_SY_100}

{include file="grn/system_footer.tpl"}
