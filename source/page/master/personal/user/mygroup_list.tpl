{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{if $delete_info_multi }
    {grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
{/if}
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mgid" value="{$mygroup_id|escape}">

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_personal_user_GRN_PRS_US_24'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-24' replace='true'}{/capture}{grn_link image='write20.gif' page='personal/user/mygroup_add' mgid=$mygroup_id caption=$smarty.capture.grn_personal_user_GRN_PRS_US_24 element_id="personal_mygroup_add"}</span>
    <span class="menu_item">{capture name='grn_personal_user_GRN_PRS_US_25'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-25' replace='true'}{/capture}{grn_link image='order20.gif' page='personal/user/mygroup_order' mgid=$mygroup_id caption=$smarty.capture.grn_personal_user_GRN_PRS_US_25 disabled=$order_disabled}</span>
</div>

<table width="100%">
<tr valign="top">
<td width="20%" class="naviColumn">
 <div class="sub_title">{cb_msg module='grn.personal.user' key='GRN_PRS_US-26' replace='true'}</div>
 <ul class="naviColumn_item_area_grn">
  {foreach from=$mygroup_list key=key item=item}
   {if $mygroup_id == $key}
    <li><span class="hilight bold_grn">{$item.name}</span></li>
   {else}
    <li>{grn_link page='personal/user/mygroup_list' mgid=$key caption=$item.name br=true}</li>
   {/if}
  {/foreach}
 </ul>
</td>

<td id="view_part" width="80%" class="vAlignTop-grn">
 {if $mygroup_list}
  {if $mygroup}
  <div class="sub_title mBottom5">{cb_msg module='grn.personal.user' key='GRN_PRS_US-84' replace='true'}</div>
  <div class="nowrap-grn mBottom10">
   <span class="menu_item">{capture name='grn_personal_user_GRN_PRS_US_16'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-16' replace='true'}{/capture}{grn_link image='modify20.gif' page='personal/user/mygroup_modify' mgid=$mygroup_id caption=$smarty.capture.grn_personal_user_GRN_PRS_US_16}</span>
   <span class="menu_item">{capture name='grn_personal_user_GRN_PRS_US_20'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-20' replace='true'}{/capture}{grn_link image='delete20.gif' id='lnk_delete' page='personal/user/mygroup_delete' mgid=$mygroup_id caption=$smarty.capture.grn_personal_user_GRN_PRS_US_20 script="javascript:void(0);"}</span>
  </div>
  {include file='grn/memo.tpl' category_memo=$mygroup.description}

  <div class="mTop5 mBottom5">
   <span class="mRight10">
    {include file="grn/checkall.tpl" elem_name='eid[]'}
   </span>
   <span class="m_small">
    {capture name='grn_personal_user_GRN_PRS_US_33'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-33' replace='true'}{/capture}{grn_button_submit id='btn_delete_multi' caption=$smarty.capture.grn_personal_user_GRN_PRS_US_33 onclick="return false;"}
   </span>
  </div>

  <div>
   <table class="list_column">
    <tr>
     <th style="width:20px;"></th>
     <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-34' replace='true'}</th>
    </tr>
    {foreach from=$mygroup.user_ids item=item}
     <tr>
      <td><input type="checkbox" name="eid[]" value="{$item}"></td>
      <td id="{$item.foreign_key}">{grn_user_name uid=$item users_info=$users_info}</td>
     </tr>
    {/foreach}
    {foreach from=$mygroup.facility_ids item=item}
     <tr>
      <td><input type="checkbox" name="eid[]" value="f{$item}"></td>
      <td>{grn_facility_name faid=$item}</td>
     </tr>
    {/foreach}
   </table>
  {else}
  <div class="content_message_grn"><span><span class="message_middle_icon_size_grn information_message_middle_icon_grn inline_block_grn mRight7"></span></span><span>{cb_msg module='grn.personal.user' key='GRN_PRS_US-85' replace='true'}</span></div>
  {/if}
 {else}
  <div class="list_message_grn">
   <div class="list_message_balloon_grn">
    <span class="bold_grn">{cb_msg module='grn.personal.user' key='GRN_PRS_US-86' replace='true'}</span>
   </div>
   <div class="balloon_arrow_down_grn"></div>
   <div class="list_message_icon_grn">
    <span class="message_middle_icon_size_grn information_message_middle_icon_grn"></span>
   </div>
  </div>
 {/if}
</td>
</tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
