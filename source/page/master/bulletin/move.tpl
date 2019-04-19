{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-1' replace='true'}<br>
{grn_sentence caption=$article.title image='bulletin20.gif' class='bold'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-2' replace='true'}
</div>
<p>

{include file="bulletin/_category_parent.tpl" move_article=1 parent=$current cancel_page='bulletin/view'}

{include file="grn/footer.tpl"}
