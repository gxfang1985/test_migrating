{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{include file="address/_title_search.tpl"}
{assign var='form_name' value=$smarty.template|basename}

<div class="mainarea">
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/user_search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div class="tab_portal">
<div class="tab_menu">
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_off"></td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mygroup_list'}">{grn_image image='myaddressgroup20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-141' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
  </tr>
 </table>
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_on"></td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {grn_image image='user20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-142' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
  </tr>
 </table>
{if $access.private_address}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_off"></td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a id="personal_address_book" href="{grn_pageurl page='address/index' bid=-1}">{grn_image image='person20.gif'}{cb_msg module='grn.address' key="private" application_name=$resources.application_name}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
  </tr>
 </table>
{/if}
{if $access.shared_address}
    {foreach from=$books key=key item=item}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_off"></td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/index' bid=$key}">{grn_image image='person20.gif'}{$item.display_name|escape}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
  </tr>
 </table>
    {/foreach}
{/if}
</div>
<div class="tab_menu_end"></div>
</div><!--end of tab_portal-->

<!--group_select-->
<div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item">
            {grn_org_select user_id=$loginId selected_id=$selected_id app_id=$app_id return_url="address/user_list" all=true}
        </span>
    </div>
    <div id="smart_rare_menu_part">
        {capture name='grn_address_GRN_ADDR_192'}{cb_msg module='grn.address' key='GRN_ADDR-192' replace='true'}{/capture}
        {grn_simple_search caption=$smarty.capture.grn_address_GRN_ADDR_192 name='st' action='address/user_search' page='address/user_search'}
    </div>
</div>
<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
{include file='address/_user_list.tpl'}
</td></tr></tbody></table><!--end of maincontents_list-->

</form>

{include file="grn/footer.tpl"}
