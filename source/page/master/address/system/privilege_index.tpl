{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-214' replace='true'}
</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_215'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-215' replace='true'}{/capture}{capture name='grn_address_system_GRN_ADDR_SYS_216'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-216' replace='true'}{/capture}{capture name='grn_address_system_GRN_ADDR_SYS_217'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-217' replace='true'}{/capture}{include file='grn/flat_privilege_index.tpl' node_name=$smarty.capture.grn_address_system_GRN_ADDR_SYS_215 node_image='person20.gif' prop_name=$smarty.capture.grn_address_system_GRN_ADDR_SYS_216 prop_code=$smarty.capture.grn_address_system_GRN_ADDR_SYS_217 page_prefix='address/system/'}

{include file="grn/system_footer.tpl"}
