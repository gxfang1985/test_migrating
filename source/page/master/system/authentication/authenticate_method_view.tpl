{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$authenticate_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_34'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-34' replace='true'}{/capture}{grn_link page='system/authentication/authenticate_method_modify' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_34 image='modify20.gif' amid=$authenticate_method.amid}</span>
<span class="menu_item">{if $authenticate_method.is_default == 1}{assign var='is_access_delete' value='true'}{/if}{capture name='grn_system_authentication_GRN_SY_AU_35'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-35' replace='true'}{/capture}{grn_link page='system/authentication/authenticate_method_delete' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_35 image='delete20.gif' disabled=$is_access_delete amid=$authenticate_method.amid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-36' replace='true'}
  </th>
  <td>
      {$authenticate_method.display_name|escape}
  </td>
 </tr>
{grn_auth_include_method method=$authenticate_method display="view-system"}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-37' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$authenticate_method.creator_uid name=$authenticate_method.creator_name}
       {grn_date_format date=$authenticate_method.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-38' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$authenticate_method.modify_uid name=$authenticate_method.modify_name}
       {grn_date_format date=$authenticate_method.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
