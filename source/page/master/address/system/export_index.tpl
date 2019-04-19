{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_address_system_GRN_ADDR_SYS_76'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-76' replace='true'}{/capture}{grn_link image='export20.gif' page='address/system/export' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_76}
<li>{capture name='grn_address_system_GRN_ADDR_SYS_77'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-77' replace='true'}{/capture}{grn_link image='export20.gif' page='address/system/access_export' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_77}
</ul>

{include file="grn/system_footer.tpl"}
