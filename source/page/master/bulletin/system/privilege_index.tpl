{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-99' replace='true'}
</div>

<p>
{capture name='grn_bulletin_system_GRN_BLLT_SYS_101'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-101' replace='true'}{/capture}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_102'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-102' replace='true'}{/capture}
{include file='grn/tree_privilege_index_26.tpl'
         prop_name=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_101
         prop_code=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_102
         page_prefix='bulletin/system/'}

{include file="grn/system_footer.tpl"}
