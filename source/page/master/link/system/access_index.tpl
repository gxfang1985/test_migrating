{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.link.system' key='GRN_LNK_SY-83' replace='true'}
</div>

<p>
{capture name='grn_link_system_GRN_LNK_SY_85'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-85' replace='true'}{/capture}
{capture name='grn_link_system_GRN_LNK_SY_86'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-86' replace='true'}{/capture}
{include file='grn/tree_access_index_26.tpl'
         prop_name=$smarty.capture.grn_link_system_GRN_LNK_SY_85
         prop_code=$smarty.capture.grn_link_system_GRN_LNK_SY_86
         page_prefix='link/system/'}

{include file="grn/system_footer.tpl"}
