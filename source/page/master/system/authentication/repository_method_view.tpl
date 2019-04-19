{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$repository_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_56'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-56' replace='true'}{/capture}{grn_link page='system/authentication/repository_method_modify' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_56 image='modify20.gif' rmid=$repository_method.rmid}</span>
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_57'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-57' replace='true'}{/capture}{grn_link page='system/authentication/repository_method_delete' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_57 image='delete20.gif' rmid=$repository_method.rmid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-58' replace='true'}
  </th>
  <td>
      {$repository_method.display_name|escape}
  </td>
 </tr>
{grn_auth_include_method method=$repository_method display="view-system"}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-59' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$repository_method.creator_uid name=$repository_method.creator_name}
       {grn_date_format date=$repository_method.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-60' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$repository_method.modify_uid name=$repository_method.modify_name}
       {grn_date_format date=$repository_method.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
