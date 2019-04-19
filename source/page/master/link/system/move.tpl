{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.link.system' key='GRN_LNK_SY-173' replace='true'}<span class="bold">{grn_sentence image='linklist20.gif' caption=$link.name}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-174' replace='true'}
</div>
<p>

{include file="link/system/_category_parent.tpl" move_link=1 parent=$current page_prefix="link/system"}

{include file="grn/system_footer.tpl"}
