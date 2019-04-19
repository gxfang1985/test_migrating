{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<div id="two_parts">
 <!--menubar-->
 <div id="menubar_top">
  <ul id="menu">
   <li>{capture name='grn_portal_system_GRN_POT_SY_81'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-81' replace='true'}{/capture}{grn_link page='portal/system/privilege_portlet_group_select_add' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_81 class='write20' opid=$portal_operation_id pid=$portal_id tid=$target_id type=$target_type}
  </ul>
 </div>
 <!--menubar_end-->
 <!--view--->
{include file='portal/system/_privilege_view.tpl'}
 <!--view_end--->
</div>
{include file="grn/system_footer.tpl"}
