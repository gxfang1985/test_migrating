{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-33' replace='true'}<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-34' replace='true'}
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-35' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='cabinet/system' page_prefix='cabinet/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
