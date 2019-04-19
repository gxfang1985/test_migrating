{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/portlet_group_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_40'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-40' replace='true'}{/capture}{grn_link page='portal/personal/portlet_group_add' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_40 image='write20.gif'}</span>
</div>

   <p>
   <div class="sub_title">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-43' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="admin_list_table" width="100%">
    <colgroup>
     <col width="1%">
     <col width="99%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-46' replace='true'}</th>
    </tr>
{foreach from=$portlet_group item=portlet_group}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$portlet_group.plgid}"></td>
     <td>{grn_link page='portal/personal/portlet_group_view' caption=$portlet_group.title image='detail20.gif' plgid=$portlet_group.plgid}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$view_set.navi }
     </div>
     {capture name='grn_portal_personal_GRN_POT_PE_47'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-47' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_47 onclick="return false;" id='btn_delete_multi'}
     {grn_delete title=$delete_multi.title page=$delete_multi.page handler=$delete_multi.handler data=$delete_multi.data multi_target=$delete_multi.multi_target form_target=$delete_multi.form_target}
</form>

{include file='grn/personal_footer.tpl'}
