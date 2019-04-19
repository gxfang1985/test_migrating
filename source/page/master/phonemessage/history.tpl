{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

<span id="path_part" style="float:right"><nobr>
{capture name='grn_phonemessage_GRN_PHM_65'}{cb_msg module='grn.phonemessage' key='GRN_PHM-65' replace='true'}{/capture}
</nobr></span>

{capture name='page_title'}{$user.display_name|grn_noescape}  {cb_msg module='grn.phonemessage' key='GRN_PHM-62' replace='true'}{$page_title|grn_noescape}{/capture}
{grn_title title=$smarty.capture.page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

 <!--menubar-->

<div id="menu_part">
<div id="smart_main_menu_part">
 <!--Change display format by using user rights-->
{if $user.add}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
  <span class="menu_item">{capture name='grn_phonemessage_GRN_PHM_83'}{cb_msg module='grn.phonemessage' key='GRN_PHM-83' replace='true'}{$application_name|grn_noescape}{cb_msg module='grn.phonemessage' key='GRN_PHM-84' replace='true'}{/capture}{grn_link image='telmemo20_w.gif' caption=$smarty.capture.grn_phonemessage_GRN_PHM_83 page='phonemessage/add' gid=$group_id uid=$user_id  disabled=$disabled}</span>
</div>
<div id="smart_rare_menu_part">
  {grn_simple_search caption=$application_name|cat:$smarty.capture.grn_phonemessage_GRN_PHM_65 name='search_text' action='phonemessage/history_search' page='phonemessage/history_search' cid=$category_id gid=$group_id uid=$user_id with_detail=true}
</div>
 </div>

<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="uid" value="{$user_id}">
<input type="hidden" name="mid" value="">
 <!--view-->
 <div id="view">
  <div class="tab_menu">
{if $category_id == 'sent'}
   <div class="tab">
    <span class="tab_left_off"></span>
    <span class="tab_off">
     {capture name='grn_phonemessage_GRN_PHM_66'}{cb_msg module='grn.phonemessage' key='GRN_PHM-66' replace='true'}{/capture}{grn_link image='inbox20.gif' caption=$smarty.capture.grn_phonemessage_GRN_PHM_66 page='phonemessage/history' cid='' gid=$group_id uid=$user_id sf=1}
    </span>
    <span class="tab_right_off"></span>
   </div>
 {if $login.id == $user_id}
   <div class="tab">
    <span class="tab_left_on"></span>
    <span class="tab_on">
     <span class="sentbox20">{grn_image image='sentbox20.gif'}{cb_msg module='grn.phonemessage' key='GRN_PHM-67' replace='true'}</span>
    </span>
    <span class="tab_right_on"></span>
   </div>
 {/if}
{else}
   <div class="tab">
    <span class="tab_left_on"></span>
    <span class="tab_on">
     <span class="inbox20">{grn_image image='inbox20.gif'}{cb_msg module='grn.phonemessage' key='GRN_PHM-68' replace='true'}</span>
    </span>
    <span class="tab_right_on"></span>
   </div>
 {if $login.id == $user_id}
   <div class="tab">
    <span class="tab_left_off"></span>
    <span class="tab_off">
     {capture name='grn_phonemessage_GRN_PHM_69'}{cb_msg module='grn.phonemessage' key='GRN_PHM-69' replace='true'}{/capture}{grn_link image='sentbox20.gif' caption=$smarty.capture.grn_phonemessage_GRN_PHM_69 page='phonemessage/history' cid='sent' gid=$group_id uid=$user_id sf=1}
    </span>
    <span class="tab_right_off"></span>
   </div>
 {/if}
{/if}
  </div>
  <div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>
  
{include file='phonemessage/_list.tpl' popup_confirm_delete=true}
 </div>
 <!--view_end-->

</form>

{include file='grn/footer.tpl'}
