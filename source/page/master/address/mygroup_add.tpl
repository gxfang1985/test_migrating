{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/command_mygroup_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_address_GRN_ADDR_193'}{cb_msg module='grn.address' key='GRN_ADDR-193' replace='true'}{/capture}{include file='address/_mygroup_form.tpl' submit_caption=$smarty.capture.grn_address_GRN_ADDR_193 cancel_page='address/mygroup_list'}

</form>
{include file="grn/footer.tpl"}
