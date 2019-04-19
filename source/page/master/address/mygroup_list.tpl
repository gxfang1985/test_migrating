{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{include file="address/_title_search.tpl"}
{assign var='form_name' value=$smarty.template|basename}

<div class="mainarea">
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div class="tab_portal">
<div class="tab_menu">
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_on"></td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {grn_image image='myaddressgroup20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-9' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
  </tr>
 </table>
 
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td class="tab_left_off"></td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/user_list'}">{grn_image image='user20.gif'}{cb_msg module='grn.address' key='GRN_ADDR-10' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
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

<!--menubar-->
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_address_GRN_ADDR_12'}{cb_msg module='grn.address' key='GRN_ADDR-12' replace='true'}{/capture}{grn_link page='address/mygroup_add' caption=$smarty.capture.grn_address_GRN_ADDR_12        mgid=$group_id image='write20.gif'}</span>
{if $mygroups_count > 1}
<span class="menu_item">{capture name='grn_address_GRN_ADDR_13'}{cb_msg module='grn.address' key='GRN_ADDR-13' replace='true'}{/capture}{grn_link page='address/mygroup_order' caption=$smarty.capture.grn_address_GRN_ADDR_13 mgid=$group_id image='order20.gif'}</span>
{else}
<span class="menu_item">{capture name='grn_address_GRN_ADDR_14'}{cb_msg module='grn.address' key='GRN_ADDR-14' replace='true'}{/capture}{grn_link page='address/mygroup_order' caption=$smarty.capture.grn_address_GRN_ADDR_14 mgid=$group_id image='order20.gif' disabled=1}</span>
{/if}
</div>
<!--menubar end-->

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<table>
<tbody>
<tr valign="top">
    <td id="tree_part">
        <div class="sub_title">{cb_msg module='grn.address' key='GRN_ADDR-15' replace='true'}</div>
        {foreach from=$mygroups item=item}
        <div class="tree_item">
            {if $item.id == $group_id}
            <span class="hilight"><span class="bold">
            {grn_link image='myaddressgroup20.gif' page='address/mygroup_list' mgid=$item.id caption=$item.name}
            </span></span>
            {else}
            {grn_link image='myaddressgroup20.gif' page='address/mygroup_list' mgid=$item.id caption=$item.name}
            {/if}
        </div>
        {/foreach}
    </td>
    
    <td id="view_part" width="70%">
        {if $group_id}
        <div class="margin_bottom">
            <div>
            <span class="bold">{$group_name|escape}</span>{capture name='grn_address_GRN_ADDR_16'}{cb_msg module='grn.address' key='GRN_ADDR-16' replace='true'}{/capture}{grn_link image='detail20.gif' page='address/mygroup_view' mgid=$group_id caption=$smarty.capture.grn_address_GRN_ADDR_16}
            </div>

            <div id="main_menu_part">
            <span class="menu_item">{capture name='grn_address_GRN_ADDR_17'}{cb_msg module='grn.address' key='GRN_ADDR-17' replace='true'}{/capture}{grn_link page='address/mygroup_change' mgid=$group_id caption=$smarty.capture.grn_address_GRN_ADDR_17 image='modify20.gif'}</span>
            </div>
        </div>
        
        <div class="margin_bottom">{include file='grn/memo.tpl' category_memo=$group_memo}</div>
        
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
{include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}
        
        <table class="list_column">
            <colgroup>
            <col width="60"/>
            <col width="40%"/>
            </colgroup>
            
            <tbody>
            <tr>
                <th>{cb_msg module='grn.address' key='GRN_ADDR-21' replace='true'}</th>
                <th>E-mail</th>
            <tr>
            {foreach from=$cards item=item}
            <tr class="{cycle values='linetwo,lineone'}">
                <td>
                {if $item.type == 3}
                    {grn_user_name uid=$item.card_id users_info=$users_info}
                {else}
                    {grn_link image='person20.gif' caption=$item.name page='address/view' bid=$item.book_id cid=$item.card_id}
                {/if}
                </td>
                <td>
                {if $item.show_email}
                    {$item.email|grn_autolink}
                {else}
                    &nbsp;
                {/if}
                </td>
            </tr>
            {/foreach}
            </tbody>
        </table>
        
        <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
        {/if}
    </td>
</tr>
<tbody>
</table>
</form>
</td></tr></tbody></table><!--end of maincontents_list-->

{include file="grn/footer.tpl"}
