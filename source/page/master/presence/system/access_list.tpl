{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{include file='presence/system/_user_name.tpl'}
{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-17' replace='true'}
</div>

{include file='grn/access_list_26.tpl' page_dir='presence/system' page_prefix='presence/system/' base_prefix=''}

{include file='grn/system_footer.tpl'}