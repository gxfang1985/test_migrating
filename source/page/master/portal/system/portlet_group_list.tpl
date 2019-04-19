{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/portlet_group_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_143'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-143' replace='true'}{/capture}{grn_link page='portal/system/portlet_group_add' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_143 image='write20.gif'}</span>
</div>

   <p>
   <div class="sub_title">{cb_msg module='grn.portal.system' key='GRN_POT_SY-145' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="93%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-148' replace='true'}</th>
    </tr>
{foreach from=$portlet_group item=portlet_group}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$portlet_group.plgid}"></td>
     <td>{grn_link page='portal/system/portlet_group_view' caption=$portlet_group.title image='detail20.gif' plgid=$portlet_group.plgid}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$view_set.navi }
     </div>
       {cb_msg module='grn.portal.system' key='GRN_POT_SY-149' replace='true'}{capture name='grn_portal_system_GRN_POT_SY_150'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-150' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_portal_system_GRN_POT_SY_150 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}

</form>

{include file='grn/system_footer.tpl'}
