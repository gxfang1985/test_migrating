{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-72' replace='true'}{grn_sentence caption=$article.title image='bulletin20.gif' class='bold'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-73' replace='true'}<br>
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-74' replace='true'}
</div>
<p>

{include file="bulletin/_category_parent.tpl" move_article=1 parent=$current cancel_page='bulletin/system/bulletin_view'}

{include file="grn/system_footer.tpl"}
