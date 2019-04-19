{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-91' replace='true'}<span class="bold">{grn_sentence image='linklist20.gif' caption=$link.name}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-92' replace='true'}
</div>
<p>

{include file="link/operation/_category_parent.tpl" move_link=1 parent=$current page_prefix="link"}

{include file="grn/footer.tpl"}
