{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$portlet.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_464'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-464' replace='true'}{/capture}{grn_link page='portal/system/php_portlet_modify' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_464 image='modify20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_465'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-465' replace='true'}{/capture}{grn_link page='portal/system/php_portlet_delete' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_465 image='delete20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_466'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-466' replace='true'}{/capture}{grn_link page='portal/system/php_portlet_preview' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_466 image='view20.gif' plid=$portlet.plid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-467' replace='true'}
  </th>
  <td>
      {$portlet.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-468' replace='true'}
  </th>
  <td>
      {$portlet.group|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-469' replace='true'}
  </th>
  <td>
      {if $portlet.my_portal}{cb_msg module='grn.portal.system' key='GRN_POT_SY-470' replace='true'}{else}{cb_msg module='grn.portal.system' key='GRN_POT_SY-471' replace='true'}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-472' replace='true'}
  </th>
  <td>
   {grn_format body=$portlet.data nolink=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-473' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.creator_uid name=$portlet.creator_name}
       {grn_date_format date=$portlet.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-474' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.modify_uid name=$portlet.modify_name}
       {grn_date_format date=$portlet.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
