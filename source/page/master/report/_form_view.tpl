{if $is_operation}
  {assign var=disabled value=$is_not_manage}
  {assign var=action_dir value='operation'}
{else}
  {assign var=disabled value=false}
  {assign var=action_dir value='system'}
{/if}
<!--page_title-->
{if $page_title}
 {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

<div class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-133' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_134'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-134' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_134 page='report/'|cat:$action_dir|cat:'/form_memo_modify' cid=$category_id fid=$form_id image='modify20.gif' disabled=$disabled}</span>
</div>
<table class="view_table" width="80%">
 <colgroup>
  <col width="20%">
  <col width="80%">
 </colgroup>
 <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-135' replace='true'}</th>
  <td>{grn_format body=$form.admin_memo}</td>
 </tr>
</table>

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/'|cat:$action_dir|cat:'/form_serial_initialize1'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-136' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_137'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-137' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_137 page='report/'|cat:$action_dir|cat:'/form_modify' cid=$category_id fid=$form_id image='modify20.gif' disabled=$disabled}</span>
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_138'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-138' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_138 page='report/'|cat:$action_dir|cat:'/form_move' cid=$category_id fid=$form_id image='move20.gif' disabled=$disabled}</span>
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_139'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-139' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_139 page='report/'|cat:$action_dir|cat:'/form_delete' cid=$category_id fid=$form_id image='delete20.gif' disabled=$disabled}</span>
{if $form.active == 0}
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_140'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-140' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_140 page='report/'|cat:$action_dir|cat:'/form_activate' cid=$category_id fid=$form_id image='open20.gif' disabled=$disabled}</span>
{else}
 <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_141'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-141' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_141 page='report/'|cat:$action_dir|cat:'/form_activate' cid=$category_id fid=$form_id image='open20.gif' disabled=$disabled}</span>
{/if}
</div>
<table class="view_table" width="80%">
 <colgroup>
  <col width="20%">
  <col width="70%">
  <col width="10%">
 </colgroup>
 <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-142' replace='true'}</th>
  <td colspan="2">{$form.name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-143' replace='true'}</th>
  <td colspan="2">{$form.foreign_key|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-144' replace='true'}</th>
  <td colspan="2">
      {if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-145' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn' key='grn.comment.permission.conf.item' replace='true'}</th>
  <td colspan="2">{if $form.enable_follow}{cb_msg module='grn' key='grn.comment.permission.conf.add' replace='true'}{else}{cb_msg module='grn' key='grn.comment.permission.conf.not.add' replace='true'}{/if}</td>
 </tr>
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report' key='enable_fields' replace='true'}</th>
  <td colspan="2">{if $form.enable_member}{cb_msg module='grn.report.operation' key='enable_member' replace='true'}{else}{cb_msg module='grn.report.operation' key='disable_member' replace='true'}{/if}</td>
 </tr>
 <tr valign="top">
  <td colspan="2">{if $form.enable_partner}{cb_msg module='grn.report.operation' key='enable_partner' replace='true'}{else}{cb_msg module='grn.report.operation' key='disable_partner' replace='true'}{/if}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-149' replace='true'}</th>
  <td colspan="2">{grn_format body=$form.memo}</td>
 </tr>
  <tr valign="top">
  <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-150' replace='true'}</th>
  <td colspan="2">{if $form.active}<span class="font_green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-151' replace='true'}</span>{else}<span class="font_red">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-152' replace='true'}</span>{/if}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-153' replace='true'}</th>
  <td colspan="2">
   {grn_user_name uid=$form.creator name=$form.creator_name}
   {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$form.ctime}
  </td>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-154' replace='true'}</th>
   <td colspan="2">
    {grn_user_name uid=$form.modifier name=$form.modifier_name}
    {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$form.mtime}
   </td>
  </tr>
</table>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

<form name="{$form_name}/form_layout_list" method="post" action="{grn_pageurl page='report/'|cat:$action_dir|cat:'/command_form_view'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div id="item_list" class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-155' replace='true'}</div>
<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_156'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-156' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_156 page='report/'|cat:$action_dir|cat:'/formlayout_add' cid=$category_id fid=$form_id image='write20.gif' disabled=$disabled}</span>
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_157'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-157' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_157 page='report/'|cat:$action_dir|cat:'/formlayout_blank_add' cid=$category_id fid=$form_id image='write20.gif' disabled=$disabled}</span>
    <span class="menu_item">{if $disabled || $item_count <= 2}{assign var='order_disabled' value='true'}{/if}{capture name='grn_report_operation_GRN_RPRT_OP_158'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-158' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_158 page='report/'|cat:$action_dir|cat:'/formlayout_order' cid=$category_id fid=$form_id image='order20.gif' disabled=$order_disabled}</span>
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_159'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-159' replace='true'}{/capture}{grn_link image='report20.gif' page='report/'|cat:$action_dir|cat:'/form_preview' cid=$category_id fid=$form_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_159 target='_blank' disabled=$disabled}</span>
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $disabled || $item_count <= 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_report_operation_GRN_RPRT_OP_160'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-160' replace='true'}{/capture}{grn_link image='delete20.gif' page='report/'|cat:$action_dir|cat:'/formlayout_delete_all' cid=$category_id fid=$form_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_160 disabled=$delete_disabled}</span>
    </div>
</div>
<div style="width:80%">
 <div class="rp_list">
 <table class="list_column">
     <colgroup>
      <col width="1%">
      <col width="30%">
      <col width="70%">
     </colgroup>
  <tr>
   <th nowrap>{include file="report/checkall.tpl" func_name="CheckAllItems" form_name="`$form_name`/form_layout_list"  elem_name="ids[]" checkall_disabled=$disabled}</th>
   <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-161' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-162' replace='true'}</th>
  </tr>
 {foreach from=$item_list item=item}
  <tr valign="top">
  {if $item.type == 0}
   <td><input type="checkbox" name="ids[]" value="{$item.iid|escape}"></td>
   <td>
     {grn_link page='report/'|cat:$action_dir|cat:'/formlayout_view' caption=$item.display_name image='view20.gif' cid=$category_id fid=$form_id iid=$item.iid}
   </td>
   <td>{$item.display_type|escape}</td>
  {elseif $item.type == 1}
   <td nowrap align="center">&nbsp;-&nbsp;</td>
   <td>
     {grn_link page='report/'|cat:$action_dir|cat:'/formlayout_view' caption=$item.display_name image='view20.gif' cid=$category_id fid=$form_id iid=$item.iid}
   </td>
   <td>{$item.display_type|escape}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-163' replace='true'}</td>
  {elseif $item.type == 2}
   <td><input type="checkbox" name="ids[]" value="{$item.iid|escape}"></td>
   <td colspan="2">
       &nbsp;
   </td>
  {/if}
  </tr>
 {/foreach}
 </table>
 </div>
</div>
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-164' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_165'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-165' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_165 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" disabled=$disabled}&nbsp;&nbsp;
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-166' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_167'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-167' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_167 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" disabled=$disabled}
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="cmd" value="">
</form>
