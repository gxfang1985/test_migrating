{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_address_system_GRN_ADDR_SYS_274'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-274' replace='true'}{/capture}{grn_link image='import20.gif' page='address/system/import1' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_274}
<li>{capture name='grn_address_system_GRN_ADDR_SYS_275'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-275' replace='true'}{/capture}{grn_link image='import20.gif' page='address/system/access_import1' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_275}
</ul>

{include file="grn/system_footer.tpl"}
