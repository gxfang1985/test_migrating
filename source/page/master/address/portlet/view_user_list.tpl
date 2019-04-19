{if $settings.font_size == "large"}
 {assign var="style" value='font-size:140%;'}
 {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
 {assign var="style" value=''}
 {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
 {assign var="style" value='font-size:70%;'}
 {assign var="font_size" value='font-size:70%;'}
{/if}
<div style="{$font_size}">
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='address/user_list'}">{$page_title|escape}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_userlist_grn">
<form name="user_list{$portlet.plid}" method="post" action="{grn_pageurl page='address/user_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="list_column" width="100%" style="border-bottom:0 solid">
 <tr>
  <td>
   <div class="margin_bottom">
{grn_org_select user_id=$loginId selected_id=$selected_id app_id=$app_id return_url="address/user_list" all=true tp='au' ppid=$portlet.plid select_style="font-size:100%;"}
   </div>
   <div class="sub_title">{cb_msg module='grn.address.portlet' key='GRN_ADDR_PTLT-6' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
  </td>
 </tr>
</table>
</form>
<div id="userlist_address_book">
<table class="list_column" width="100%" style="border-bottom:0 solid;">
{include file='address/_user_list.tpl' off_word_navi=1}
</table>
</div>
<table class="list_column" width="100%" style="border-top:0 solid;">
 <tr>
  <td style="padding:0" nowrap>
   <div class="m_small"><div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div></div>
  </td>
 </tr>
</table>
</div> <!--end of portal_frame -->

</div>
