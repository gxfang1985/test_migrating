{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="nid" value="{$node_id|escape}">
    {foreach from=$eid item=item}
        <input type="hidden" name="eid[]" value="{$item|escape}">
    {/foreach}

    <div class="explanation">
        {cb_msg module='grn.cabinet' key='GRN_CAB-324' replace='true'}<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>{cb_msg module='grn.cabinet' key='GRN_CAB-325' replace='true'}
        {cb_msg module='grn.cabinet' key='GRN_CAB-326' replace='true'}<span class="bold">{$count}</span> {cb_msg module='grn.cabinet' key='GRN_CAB-327' replace='true'}

    </div>

    {capture name='grn_cabinet_GRN_CAB_328'}{cb_msg module='grn.cabinet' key='GRN_CAB-328' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_328}
    {capture name='grn_cabinet_GRN_CAB_329'}{cb_msg module='grn.cabinet' key='GRN_CAB-329' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_GRN_CAB_329}

</form>

{include file="grn/footer.tpl"}
