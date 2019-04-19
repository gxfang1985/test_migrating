{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-18' replace='true'}<span class="bold">{grn_sentence image='bulletin20.gif' caption=$article.title}</span>{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-19' replace='true'}
</div>
<p>

{include file="bulletin/_category_parent.tpl" move_article=1 parent=$current cancel_page='bulletin/operation/bulletin_view'}

{include file="grn/footer.tpl"}
