{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}
<p class="explanation">{cb_msg module='grn.workflow.system' key='key_142_1' replace='true'}{$col_name|escape}{cb_msg module='grn.workflow.system' key='key_142_2' replace='true'}</p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
<div style="width: 80%">
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
 <table class="list_column" width="100%" width="100%" border="1" cellspacing="0" cellpadding="2">
  <colgroup>
   <col width="40%">
   <col width="40%">
   <col width="20%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_category' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_valid_invalid_app_form_y' replace='true'}</th>
  </tr>
{foreach from=$forms key=form_id item=form}
  <tr valign="top">
{assign var='col_category' value=$form.col_category}
{if ! $col_category}
{assign var='col_category' value='-1'}
{/if}
   <td nowrap>{grn_workflow_link page='workflow/system/form_view' caption=$form.col_name truncated_caption=$config.subject_width icon_type=$form.col_icon_type icon_id=$form.col_icon_id icon_url=$form.col_icon_url cid=$col_category fid=$form._id}</td>
   <td nowrap>{if ! $form.col_category}{grn_image image='category_trush20.gif'}{cb_msg module='grn.workflow.system' key='w_unlabeled' replace='true'}{else}{grn_image image='category20.gif'}{$form.col_category_name|escape}{/if}</td>
   <td nowrap>{if $form.col_active}<span class="font_green">{cb_msg module='grn.workflow.system' key='w_valid_y' replace='true'}</span>{else}<span class="font_red">{cb_msg module='grn.workflow.system' key='w_invalid_y' replace='true'}</span>{/if}</td>
  </tr>
{/foreach}
 </table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
</div>
{include file='grn/system_footer.tpl'}
