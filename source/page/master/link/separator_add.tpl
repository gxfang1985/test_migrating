{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>
        {cb_msg module='grn.link' key='GRN_LNK-98' replace='true'}<br>
        <span class="bold">{grn_image image='category20.gif'}{$category.title|escape}</span><br>
    </p>
    {strip}
    <div class="mTop15 mBottom15">
            {capture name='grn_link_GRN_LNK_100'}{cb_msg module='grn.link' key='GRN_LNK-100' replace='true'}{/capture}
            {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_100 id="link_button_save"}

            {capture name='grn_link_GRN_LNK_101'}{cb_msg module='grn.link' key='GRN_LNK-101' replace='true'}{/capture}
            {grn_button action="cancel" caption=$smarty.capture.grn_link_GRN_LNK_101 id="link_button_cancel"}
    </div>
    {/strip}
    <input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/footer.tpl"}
