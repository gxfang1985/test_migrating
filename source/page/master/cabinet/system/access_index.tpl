{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-36' replace='true'}
</div>

<p>
{capture name='grn_cabinet_system_GRN_CAB_SY_38'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-38' replace='true'}{/capture}
{capture name='grn_cabinet_system_GRN_CAB_SY_39'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-39' replace='true'}{/capture}
{include file='grn/tree_access_index_26.tpl' 
         prop_name=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_38
         prop_code=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_39 page_prefix='cabinet/system/'}

{include file="grn/system_footer.tpl"}
