{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div id="one_parts">
 <div id="view">
  <div class="sub_title">{cb_msg module='grn.system.license' key='GRN_SY_LI-3' replace='true'}</div>
  <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
   <colgroup>
    <col width="15%">
    <col width="45%">
    <col width="40%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.system.license' key='GRN_SY_LI-4' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.license' key='GRN_SY_LI-5' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.license' key='GRN_SY_LI-6' replace='true'}</th>
   </tr>
{foreach from=$licenses key=oid item=license}
   <tr valign="top">
    <td>{grn_date_format date=$license.register format="DateTimeMiddle_YMD_HM"}</td>
    <td>{grn_link page='system/license/view' caption=$license.key id=$oid}</td>
    <td>{$license.name|escape}</td>
   </tr>
{/foreach}
  </table>
 </div>
</div>
{include file="grn/system_footer.tpl"}
