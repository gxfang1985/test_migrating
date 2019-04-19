{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-93' replace='true'}
<br>
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-189' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='schedule/operation' page_prefix='schedule/operation/' base_prefix=''}

{include file='grn/footer.tpl'}
