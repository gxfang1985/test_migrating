{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/html_portlet_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_129'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-129' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_add' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_129 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_130'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-130' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_import' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_130 image='import20.gif'}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_213'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-213' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_name_import1' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_213 image='import20.gif'}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_131'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-131' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_export1' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_131 image='export20.gif'}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_214'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-214' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_name_export' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_214 image='export20.gif'}</span>
</div>

   <p>
   <div class="sub_title">{cb_msg module='grn.portal.operation' key='GRN_POT_OP-132' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="admin_list_table" width="100%">
    <colgroup>
     <col width="1%">
     <col width="99%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-135' replace='true'}</th>
    </tr>
{foreach from=$portlet item=portlet}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$portlet.plid}"></td>
     <td>{grn_link page='portal/operation/html_portlet_view' caption=$portlet.title image='detail20.gif' plid=$portlet.plid}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$view_set.navi }
     </div>
       {cb_msg module='grn.portal.operation' key='GRN_POT_OP-136' replace='true'}{capture name='grn_portal_operation_GRN_POT_OP_137'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-137' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_137 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}

</form>
{include file='grn/footer.tpl'}
