<table class="std_form">
{if $file}
 <tr>
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-236' replace='true'}</th>
  <td>{grn_image image='folder20.gif'}{$current.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-237' replace='true'}</th>
  <td width="80%">
{elseif $target}
 <tr>
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-238' replace='true'}</th>
  <td>{grn_image image='folder20.gif'}{$target.parent.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-239' replace='true'}</th>
  <td width="80%">
{else}
 <tr>
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-240' replace='true'}</th>
  <td>{grn_image image='folder20.gif'}{$current.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-241' replace='true'}</th>
  <td width="80%">
{/if}

<form name="folder_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="s_hid" value="{$set_folder_id|escape}">
<input type="hidden" name="hid" value="{$folder_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
<input type="hidden" name="ss" value="1">

<div class="input_box">

<div class="search_navi">
<input type="text" name="text" value="{$text|escape}" size="20"><input type="submit" name="search" value="{cb_msg module='grn.cabinet' key='GRN_CAB-242' replace='true'}">
</div>

{** フォルダ検索結果 **}
{if $search}

<div class="m_small">
 {foreach from=$search.result item=item}
  {grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.path}<br>
 {/foreach}
<p>
<a href="{grn_pageurl page=$page_info.all hid=$folder_id s_hid=$set_folder_id ss=1 params=$params}">[{cb_msg module='grn.cabinet' key='GRN_CAB-243' replace='true'}]</a>
</div>

{** フォルダ選択状態 **}
{elseif $set_folder_id}

<div class="hilight">
<span class="m_small">

 {foreach name="path" from=$folder.ancestors item=item}
  {if $smarty.foreach.path.iteration == 1}{grn_image image='folder20.gif'}{/if}{grn_link page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name} &gt; 
 {/foreach}
 {if $smarty.foreach.path.total < 1}
  {grn_image image='folder20.gif'}
 {/if}
 {$folder.name|escape}

</span>
</div>

<div class="border-partition-common-grn"></div>
 {if $folder.parent}
<div class="margin_bottom">
<small>
{capture name='grn_cabinet_GRN_CAB_244'}{cb_msg module='grn.cabinet' key='GRN_CAB-244' replace='true'}{/capture}{grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$folder.parent.hid ss=1 params=$params caption=$smarty.capture.grn_cabinet_GRN_CAB_244}
</small>
</div>
 {/if}

{** 未選択状態 **}
{else}
<div class="m_small">
{grn_image image='folder20.gif'}{cb_msg module='grn.cabinet' key='GRN_CAB-245' replace='true'}
</div>
<div class="border-partition-common-grn"></div>
{/if}

{** 検索結果ではなく、サブフォルダがある場合はリンクを表示 **}
{if ! $search && count($folder.children) > 0}
<div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-246' replace='true'}</div>
<small>
 {foreach from=$folder.children key=key item=item}
     {if $browser.type == 'msie'}
         <div class="inline_block_grn">
             {grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
         </div>
     {else}
         {grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
     {/if}
 {/foreach}
</small>
{/if}

</div>
</form>

  </td>
 </tr>

 <tr>
  <td></td>
  <td>
   {assign var="form_name" value=$smarty.template|basename}
   {if ! $page_info.parts[2]}
   <form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {else}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
     {/if}
     <input type="hidden" name="hid" value="{$folder_id|escape}">
     <input type="hidden" name="s_hid" value="{$set_folder_id|escape}">
     {foreach from=$params key=name item=value}
      <input type="hidden" name="{$name|escape}" value="{$value|escape}">
     {/foreach}
    {if $is_user_page}{strip}
        <div class="mTop10">
            {if $target.hid == $folder.hid || $current.hid == $folder.hid}
                {capture name='grn_cabinet_GRN_CAB_247'}{cb_msg module='grn.cabinet' key='GRN_CAB-247' replace='true'}{/capture}
                {grn_button id="cabinet_button_move" action='submit' ui='main' spacing='normal' caption=$smarty.capture.grn_cabinet_GRN_CAB_247 disabled=true}
            {elseif $move_disabled}
                {capture name='grn_cabinet_GRN_CAB_248'}{cb_msg module='grn.cabinet' key='GRN_CAB-248' replace='true'}{/capture}
                {grn_button id="cabinet_button_move" action='submit' ui='main' spacing='normal' caption=$smarty.capture.grn_cabinet_GRN_CAB_248 disabled=true}
            {else}
                {capture name='grn_cabinet_GRN_CAB_249'}{cb_msg module='grn.cabinet' key='GRN_CAB-249' replace='true'}{/capture}
                {grn_button id="cabinet_button_move" action='submit' ui='main' spacing='normal' caption=$smarty.capture.grn_cabinet_GRN_CAB_249}
            {/if}
            {if $cancel_page}
                {grn_button id="cabinet_button_cancel" action='cancel' page=$cancel_page page_param_hid=$folder_id page_param_fid=$file_id}
            {else}
                {capture name='grn_pageurl'}{$page_prefix|cat:'/folder_view'}{/capture}
                {grn_button id="cabinet_button_cancel" action='cancel' page=$smarty.capture.grn_pageurl page_param_hid=$target.hid}
            {/if}
        </div>{/strip}
    {else}
        {if $target.hid == $folder.hid || $current.hid == $folder.hid}
            {capture name='grn_cabinet_GRN_CAB_247'}{cb_msg module='grn.cabinet' key='GRN_CAB-247' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_247 disabled=1}
        {elseif $move_disabled}
            {capture name='grn_cabinet_GRN_CAB_248'}{cb_msg module='grn.cabinet' key='GRN_CAB-248' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_248 disabled=1}
        {else}
            {capture name='grn_cabinet_GRN_CAB_249'}{cb_msg module='grn.cabinet' key='GRN_CAB-249' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_249}
        {/if}
        {if $cancel_page}
            {grn_button_cancel page=$cancel_page hid=$folder_id fid=$file_id}
        {else}
            {grn_button_cancel page=$page_prefix|cat:'/folder_view' hid=$target.hid}
        {/if}
    {/if}
  </td>
 </tr>
</form>
</table>
