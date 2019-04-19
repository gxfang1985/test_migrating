<table class="std_form">
{if $move_link}
 <tr>
  <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-172' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$parent.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-173' replace='true'}</th>
{elseif $target}
 <tr>
  <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-174' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$target.parent.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-175' replace='true'}</th>
{/if}
  <td width="80%">

<form name="category_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="s_cid" value="{$set_category_id|escape}">
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
<input type="hidden" name="ss" value="1">

<div class="input_box">

<div class="search_navi">
<input type="text" name="text" value="{$text|escape}" size="20"><input type="submit" name="search" value="{cb_msg module='grn.link' key='GRN_LNK-176' replace='true'}">
</div>

{** カテゴリ検索結果 **}
{if $search}

<div class="m_small">
{foreach from=$search.result item=item}
{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.path}<br>
{/foreach}
<p>
<a href="{grn_pageurl page=$page_info.all cid=$category_id s_cid=$set_category_id ss=1 params=$params}">[{cb_msg module='grn.link' key='GRN_LNK-177' replace='true'}]</a>
</div>

{** カテゴリ選択状態 **}
{elseif $set_category_id}

<div class="hilight">
<span class="m_small">

{foreach name="path" from=$category.ancestors item=item}
{if $smarty.foreach.path.iteration == 1}{grn_image image='category20.gif'}{/if}{grn_link page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.name} &gt; 
{/foreach}
{if $smarty.foreach.path.total < 1}{grn_image image='category20.gif'}{/if}{$category.name|escape}

</span>
</div>

<hr size="1">
{if $category.parent}
<div class="margin_bottom">
<small>
{capture name='grn_link_GRN_LNK_178'}{cb_msg module='grn.link' key='GRN_LNK-178' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$category.parent.cid ss=1 params=$params caption=$smarty.capture.grn_link_GRN_LNK_178}
</small>
</div>
{/if}

{** 未選択状態 **}
{else}
<div class="m_small">
{grn_image image='category20.gif'}{cb_msg module='grn.link' key='GRN_LNK-179' replace='true'}
</div>
<hr size="1">
{/if}

{** 検索結果ではなく、サブカテゴリがある場合はリンクを表示 **}
{if ! $search && count($category.children) > 0}
<div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-180' replace='true'}</div>
<small>
{foreach from=$category.children key=key item=item}
    {if $browser.type == 'msie'}
        <div class="inline_block_grn">
            {grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
        </div>
    {else}
        {grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
    {/if}
{/foreach}
</small>
{/if}

</div>
</form>

  </td>
 </tr>

{assign var="form_name" value=$smarty.template|basename}
{if ! $page_info.parts[2]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{/if}
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="s_cid" value="{$set_category_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {strip}
     {if $target.cid == $category.cid || $current.cid == $category.cid}
      {capture name='grn_link_GRN_LNK_181'}{cb_msg module='grn.link' key='GRN_LNK-181' replace='true'}{/capture}
      {capture name='link_button_save_onclick'}
       if(!grn.component.button("#link_button_save").isDisabled()) document.forms['{$form_name}'].submit();
      {/capture}
      {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_181 id="link_button_save" onclick=$smarty.capture.link_button_save_onclick disabled=true}
     {else}
      {capture name='grn_link_GRN_LNK_182'}{cb_msg module='grn.link' key='GRN_LNK-182' replace='true'}{/capture}
      {capture name='link_button_save_onclick'}
       if(!grn.component.button("#link_button_save").isDisabled()) document.forms['{$form_name}'].submit();
      {/capture}
      {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_182 id="link_button_save" onclick=$smarty.capture.link_button_save_onclick}
     {/if}
     {if $move_link}
      {grn_button action="cancel" id="link_button_cancel" page=$page_prefix|cat:'/view' page_param_cid=$category_id page_param_lid=$link_id page_param_type="personal"}
     {else}
      {grn_button action="cancel" id="link_button_cancel" page=$page_prefix|cat:'/category_view' page_param_cid=$target.cid page_param_type="personal"}
     {/if}
    {/strip}
   </div>
  </td>
 </tr>
</form>
</table>
