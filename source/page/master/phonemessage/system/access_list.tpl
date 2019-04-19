{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{include file='phonemessage/system/_access_object_name.tpl'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-28' replace='true'}
<br>
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-69' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='phonemessage/system' page_prefix='phonemessage/system/' base_prefix=''}

{include file='grn/system_footer.tpl'}
