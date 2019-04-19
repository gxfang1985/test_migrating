{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/notify_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
<div class="explanation">
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-43' replace='true'}
</div>

<p>
{capture name='grn_cabinet_system_GRN_CAB_SY_45'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-45' replace='true'}{/capture}
{capture name='grn_cabinet_system_GRN_CAB_SY_46'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-46' replace='true'}{/capture}
{include file='grn/tree_notify_index_26.tpl'
    prop_name=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_45
    prop_code=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_46
    page_prefix='cabinet/system/'
    enable_force=''}

{include file="grn/system_footer.tpl"}
