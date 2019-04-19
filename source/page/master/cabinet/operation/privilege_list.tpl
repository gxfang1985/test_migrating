{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-320' replace='true'}<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>{cb_msg module='grn.cabinet' key='GRN_CAB-321' replace='true'}
{cb_msg module='grn.cabinet' key='GRN_CAB-322' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='cabinet/operation' page_prefix='cabinet/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
