{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$sso_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_personal_sso_GRN_PRS_SO_9'}{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-9' replace='true'}{/capture}{grn_link page='personal/sso/sso_method_set' caption=$smarty.capture.grn_personal_sso_GRN_PRS_SO_9 image='modify20.gif' smid=$sso_method.smid}</span>
<span class="menu_item">{if $sso_method.is_personal === 0}{assign var='is_access_reset' value='true'}{/if}{capture name='grn_personal_sso_GRN_PRS_SO_10'}{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-10' replace='true'}{/capture}{grn_link page='personal/sso/sso_method_reset' caption=$smarty.capture.grn_personal_sso_GRN_PRS_SO_10 image='delete20.gif' disabled=$is_access_reset smid=$sso_method.smid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.personal.sso' key='GRN_PRS_SO-11' replace='true'}
  </th>
  <td>
      {$sso_method.display_name|escape}
  </td>
 <tr>
  <th nowrap>
      {cb_msg module='grn.personal.sso' key='GRN_PRS_SO-12' replace='true'}
  </th>
  <td>
      {$sso_method.application|escape}
  </td>
 </tr>
{grn_sso_include_method method=$sso_method display="view-personal" identifier=$identifier}
</table>

{include file="grn/personal_footer.tpl"}
