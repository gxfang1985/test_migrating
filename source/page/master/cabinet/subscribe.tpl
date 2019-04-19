{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-224' replace='true'}<br>
 <span class="notice">{cb_msg module='grn.cabinet' key='GRN_CAB-225' replace='true'}</span> {cb_msg module='grn.cabinet' key='GRN_CAB-226' replace='true'}
</div>
<p>

<table width="100%" border="0" cellspacing="2" cellpadding="12" bgcolor="ffffff" style="border:1px solid #999999;">
 <tr>
  <td>
    <form name="folder_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
    <input type="hidden" name="s_hid" value="{$set_folder_id|escape}">
    <input type="hidden" name="hid" value="{$folder_id|escape}">
    {foreach from=$params key=name item=value}
    <input type="hidden" name="{$name|escape}" value="{$value|escape}">
    {/foreach}
    <input type="hidden" name="ss" value="1">
   <input type="text" name="text" value="{$text|escape}" size="20" maxlength="100">
   <input type="submit" name="search" value="{cb_msg module='grn.cabinet' key='GRN_CAB-227' replace='true'}">
   </form>
  </td>
 </tr>

{** フォルダ検索結果 **}
{if $search}
 <tr>
  <td>
{foreach from=$search.result item=item}
{grn_cabinet_folder_title page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.path notified=$item.notified image='folder20.gif'}<br>
{/foreach}
  </td>
 </tr>
 <tr>
  <td>
   <a href="{grn_pageurl page=$page_info.all hid=$folder_id s_hid=$set_folder_id ss=1 params=$params}">[{cb_msg module='grn.cabinet' key='GRN_CAB-228' replace='true'}]</a>
  </td>
 </tr>

{** フォルダ選択状態 **}
{elseif $set_folder_id}

{strip}
 <tr bgcolor="dddddd">
  <td>
     <div class="sub_title" style="margin-bottom:0.5em;">{cb_msg module='grn.cabinet' key='GRN_CAB-229' replace='true'}</div>
{foreach name="path" from=$folder.ancestors item=item}
{if $smarty.foreach.path.iteration == 1}{grn_image image='folder20.gif'}{/if}{grn_link page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}&nbsp;&gt;&nbsp;
{/foreach}
{if $smarty.foreach.path.total < 1}{grn_image image='folder20.gif'}{/if}{$folder.name|escape}{if $folder.notified}&nbsp;{grn_image image='subscribe20.png'}{/if}
  </td>
 </tr>
{/strip}

{if $folder.parent}
 <tr>
  <td>
{capture name='grn_cabinet_GRN_CAB_230'}{cb_msg module='grn.cabinet' key='GRN_CAB-230' replace='true'}{/capture}{grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$folder.parent.hid ss=1 params=$params caption=$smarty.capture.grn_cabinet_GRN_CAB_230}
  </td>
 </tr>
{/if}

{** 未選択状態 **}
{else}
 <tr>
  <td>
{grn_image image='folder20.gif'}{cb_msg module='grn.cabinet' key='GRN_CAB-231' replace='true'}
  </td>
 </tr>
{/if}

{** 検索結果ではなく、サブフォルダがある場合はリンクを表示 **}
{if ! $search && count($folder.children) > 0}
 <tr>
  <td>
  <div class="sub_title" style="margin-bottom:0.5em;">{cb_msg module='grn.cabinet' key='GRN_CAB-232' replace='true'}</div>
{foreach from=$folder.children key=key item=item}
{grn_cabinet_folder_title page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name child=$item.child_count notified=$item.notified image='folder20.gif'}&nbsp;
{/foreach}
  </td>
 </tr>
{/if}

</table>


{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/command_subscribe'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="hid" value="{$folder_id|escape}">
<input type="hidden" name="s_hid" value="{$set_folder_id|escape}">
 {foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
 {/foreach}

{** select box **}

<div class="margin_top">
<select name="candidate_folders[]" size="5" multiple>
{if $search}
 {foreach from=$search.result item=item}
<option value="{$item.hid}">{$item.path|escape}{if $item.notified}&nbsp;*{/if}</option>
 {/foreach}
{else}
 {if $set_folder_id == GRN_CABINET_ROOT_FOLDER_ID}
<option value="{$set_folder_id|escape}">{$folder.name|escape}</option>
{else}
<option value="{$set_folder_id|escape}">
{foreach from=$folder.ancestors item=item}
{$item.name|escape}&nbsp;&gt;
{/foreach}
{$folder.name|escape}{if $folder.notified}&nbsp;*{/if}
</option>
 {/if}
 {foreach from=$folder.children key=key item=item}
<option value="{$item.hid}">{$item.path_string|escape}{if $item.notified}&nbsp;*{/if}</option>
 {/foreach}
{/if}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
</select>
</div>

<div style="margin:1em 0em;">
<input type="submit" name="add" value="{cb_msg module='grn.cabinet' key='GRN_CAB-233' replace='true'}"{if $selected_candidate} disabled{/if}> &nbsp;&nbsp; 
<input type="submit" name="remove" value="{cb_msg module='grn.cabinet' key='GRN_CAB-234' replace='true'}">
</div>

<div class="margin_top">
<select size="5" multiple id="selected_folders" name="selected_folders[]">
 {foreach from=$candidate_folders item=item}
<option value="{$item.hid|escape}">{$item.path|escape}{if $item.notified}&nbsp;*{/if}</option>
 {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
</div>
{strip}
    <div class="mTop15 mBottom15">
        {capture name='grn_cabinet_GRN_CAB_235'}{cb_msg module='grn.cabinet' key='GRN_CAB-235' replace='true'}{/capture}

        {grn_button id='cabinet_button_save' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_cabinet_GRN_CAB_235}
        {grn_button id='cabinet_button_cancel' action='cancel' page='cabinet/index' page_param_hid=$folder_id}
    </div>
{/strip}

</form>

{include file="grn/footer.tpl"}
