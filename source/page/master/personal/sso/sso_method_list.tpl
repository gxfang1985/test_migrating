{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/sso/sso_method_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="sub_title">{include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
<table class="admin_list_table">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-4' replace='true'}</th>
 </tr>
{foreach from=$sso_method item=sso_method}
 <tr valign="top">
  <td>{grn_link page='personal/sso/sso_method_view' caption=$sso_method.display_name image='detail20.gif' smid=$sso_method.smid}</td>
 </tr>
{/foreach}
</table>

<div class="contents_navi">
{include file="grn/word_navi.tpl" navi=$view_set.navi }
</div>
</form>

{include file='grn/personal_footer.tpl'}
