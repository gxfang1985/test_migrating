{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$login_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_1'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-1' replace='true'}{/capture}{grn_link page='system/authentication/login_method_modify' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_1 image='modify20.gif' lmid=$login_method.lmid}</span>
<span class="menu_item">{if $login_method.is_default == 1}{assign var='is_access_delete' value='true'}{/if}{capture name='grn_system_authentication_GRN_SY_AU_2'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-2' replace='true'}{/capture}{grn_link page='system/authentication/login_method_delete' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_2 image='delete20.gif' disabled=$is_access_delete lmid=$login_method.lmid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-3' replace='true'}
  </th>
  <td>
      {$login_method.display_name|escape}
  </td>
 </tr>
{grn_auth_include_method method=$login_method display="view-system"}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-4' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$login_method.creator_uid name=$login_method.creator_name}
       {grn_date_format date=$login_method.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-5' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$login_method.modify_uid name=$login_method.modify_name}
       {grn_date_format date=$login_method.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
