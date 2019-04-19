{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-123' replace='true'}
</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_124'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-124' replace='true'}{/capture}{capture name='grn_address_system_GRN_ADDR_SYS_125'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-125' replace='true'}{/capture}{capture name='grn_address_system_GRN_ADDR_SYS_126'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-126' replace='true'}{/capture}{include file='grn/flat_access_index.tpl' node_name=$smarty.capture.grn_address_system_GRN_ADDR_SYS_124 node_image='person20.gif' prop_name=$smarty.capture.grn_address_system_GRN_ADDR_SYS_125 prop_code=$smarty.capture.grn_address_system_GRN_ADDR_SYS_126 page_prefix='address/system/'}

{include file="grn/system_footer.tpl"}
