{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{include file='schedule/system/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-196' replace='true'}
<br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-571' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='schedule/system' page_prefix='schedule/system/' base_prefix=''}

{include file='grn/system_footer.tpl'}
