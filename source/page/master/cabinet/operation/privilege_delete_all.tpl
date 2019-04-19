{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="nid" value="{$node_id|escape}">

    <div class="explanation">
        {cb_msg module='grn.cabinet' key='GRN_CAB-330' replace='true'}<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>{cb_msg module='grn.cabinet' key='GRN_CAB-331' replace='true'}
        {cb_msg module='grn.cabinet' key='GRN_CAB-332' replace='true'}
    </div>

    {capture name='grn_cabinet_GRN_CAB_333'}{cb_msg module='grn.cabinet' key='GRN_CAB-333' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_333}
    {capture name='grn_cabinet_GRN_CAB_334'}{cb_msg module='grn.cabinet' key='GRN_CAB-334' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_GRN_CAB_334}

</form>

{include file="grn/footer.tpl"}
