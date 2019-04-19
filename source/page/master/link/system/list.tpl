{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{* grn_simple_search caption='リンク集検索' name='search_text' action='link/search' page='link/search' dcid=$category_id *}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_1'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-1' replace='true'}{/capture}{grn_link image='linklist20.gif' page='link/system/add' cid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_1}</span>
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_2'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-2' replace='true'}{/capture}{grn_link image='write20.gif' page='link/system/separator_add' cid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_2}</span>
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_3'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-3' replace='true'}{/capture}{grn_link image='category20.gif' page='link/system/category_add' pcid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_3}</span>
    <div id="rare_menu_part_under">
        <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_4'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-4' replace='true'}{/capture}{grn_link image='import20.gif' page='link/system/import1' cid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_4}</span>
        <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_5'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-5' replace='true'}{/capture}{grn_link image='export20.gif' page='link/system/export' cid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_5}</span>
    </div>
</div>
<table width="100%">
<tr valign="top">
<td id="tree_part">
{include file='grn/org_tree_26.tpl'}
</td>
<td id="view_part" width="90%">

{if $is_root}
<div>
<span class="sub_title">{$category.title|escape}</span>
{capture name='grn_link_system_GRN_LNK_SY_12'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-12' replace='true'}{/capture}{grn_link page='link/system/category_view' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_12 image='detail20.gif'}
</div>
{else}
<div>
<span class="sub_title">{$category.title|escape}</span>
{capture name='grn_link_system_GRN_LNK_SY_13'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-13' replace='true'}{/capture}{grn_link page='link/system/category_view' cid=$category_id caption=$smarty.capture.grn_link_system_GRN_LNK_SY_13 image='detail20.gif'}
</div>
{include file='grn/memo.tpl' category_memo=$category.memo}
{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id}">
<table class="list_column">
 <colgroup>
  <col width="1%">
  <col width="90%">
  <col width="10%" align="right">
 </colgroup>
 <tr>
  <th>{include file='grn/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
  <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-14' replace='true'}</th>
  <th></th>
 </tr>
 {foreach from=$share_link_list item=item}
 <tr>
  <td>{grn_checkbox name='ids[]' id="ids_`$item.lid`" value=$item.lid}</td>
  {if $item.object == 'link'}
  <td>
   {if $set_popup}
    {if $item.sid > 0}
     {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url target='_blank'}
     {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='window20.gif'}
    {else}
     {capture name='grn_link_system_GRN_LNK_SY_15'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-15' replace='true'}{/capture}{grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width target='_blank' title=$smarty.capture.grn_link_system_GRN_LNK_SY_15 no_script=true}
     {capture name='grn_link_system_GRN_LNK_SY_16'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-16' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='window20.gif' title=$smarty.capture.grn_link_system_GRN_LNK_SY_16 no_script=true}
    {/if}
   {else}
    {if $item.sid > 0}
     {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url}
     {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='blank20.gif' target='_blank'}
    {else}
     {grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width no_script=true}
     {capture name='grn_link_system_GRN_LNK_SY_17'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-17' replace='true'}{/capture}{grn_link_raw page=$item.url caption='' image='blank20.gif' target='_blank' title=$smarty.capture.grn_link_system_GRN_LNK_SY_17 no_script=true}
    {/if}
   {/if}
  </td>
  <td nowrap>{capture name='grn_link_system_GRN_LNK_SY_18'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-18' replace='true'}{/capture}{grn_link page='link/system/view' cid=$category_id lid=$item.lid caption=$smarty.capture.grn_link_system_GRN_LNK_SY_18 image='detail20.gif'}</td>
  {else}
  <td colspan="2"><hr></td>
  {/if}
 </tr>
 {/foreach}
</table>
{cb_msg module='grn.link.system' key='GRN_LNK_SY-19' replace='true'}{capture name='grn_link_system_GRN_LNK_SY_20'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-20' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_link_system_GRN_LNK_SY_20 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}
</form>

</td>


</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
