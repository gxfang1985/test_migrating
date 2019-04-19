{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$sso_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_sso_GRN_SY_SS_26'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-26' replace='true'}{/capture}{grn_link page='system/sso/sso_method_modify' caption=$smarty.capture.grn_system_sso_GRN_SY_SS_26 image='modify20.gif' smid=$sso_method.smid}</span>
<span class="menu_item">{capture name='grn_system_sso_GRN_SY_SS_27'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-27' replace='true'}{/capture}{grn_link page='system/sso/sso_method_delete' caption=$smarty.capture.grn_system_sso_GRN_SY_SS_27 image='delete20.gif' smid=$sso_method.smid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso' key='GRN_SY_SS-28' replace='true'}
  </th>
  <td>
      {$sso_method.display_name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso' key='GRN_SY_SS-29' replace='true'}
  </th>
  <td>
      {$sso_method.application|escape}
  </td>
 </tr>
    {grn_sso_include_method method=$sso_method display="view-system" identifier=$identifier}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso' key='GRN_SY_SS-30' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$sso_method.creator_uid name=$sso_method.creator_name}
       {grn_date_format date=$sso_method.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso' key='GRN_SY_SS-31' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$sso_method.modify_uid name=$sso_method.modify_name}
       {grn_date_format date=$sso_method.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
