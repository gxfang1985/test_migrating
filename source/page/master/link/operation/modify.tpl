{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}">
    <div id="one_parts">
        <!--action--->
        <div id="action">
            <!----->
            <p><div class="explanation">{cb_msg module='grn.link.operation' key='GRN_LNK_OP-53' replace='true'}</div></p>
            {include file="grn/show_validation_errors.tpl"}
            {include file="grn/indispensable.tpl"}
            {include file='link/operation/_modify.tpl' button_file='link/operation/_modify_buttons.tpl'}
            <!----->
        </div>
        <!--action_end--->
    </div>
    <input type="hidden" name="cid" value="{$category.cid}">
    <input type="hidden" name="lid" value="{$link.lid}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</form>
{include file="grn/footer.tpl"}
