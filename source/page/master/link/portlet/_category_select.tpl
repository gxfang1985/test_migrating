
<form name="category_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="cid" value="{$portlet.settings.cid|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
<input type="hidden" name="ss" value="1">

<div class="input_box">

{if ! $no_search_form}
<div class="search_navi">
<input type="text" name="text" value="{$text|escape}" size="20" maxlength="100"><input type="submit" name="search" value="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-1' replace='true'}">
</div>
{/if}

{** カテゴリ検索結果 **}
{if $search}

 {foreach from=$search.result item=item}
  {grn_link image='category20.gif' page=$page_info.all cid=$item.cid ss=1 params=$params caption=$item.path}<br>
 {/foreach}
<p>
<div><a href="{grn_pageurl page=$page_info.all cid=$portlet.settings.cid ss=1 params=$params}">[{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-2' replace='true'}]</a></div>

{** カテゴリ選択状態 **}
{elseif $category}

<div class="hilight">
<span class="m_small">

 {foreach name="path" from=$category.ancestors item=item}
  {if $smarty.foreach.path.iteration == 1}{grn_image image='category20.gif'}{/if}{grn_link page=$page_info.all cid=$category_id ss=1 params=$params caption=$item.name} &gt; 
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image='category20.gif'}{/if}{$category.name|escape}

</span>
</div>
<hr size="1">

 {if $category.parent}
<div>
<small>
  {capture name='grn_link_portlet_GRN_LNK_PO_3'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-3' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$category.parent.cid ss=1 params=$params caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_3}
</small>
</div>
 {/if}

{** 未選択状態 **}
{else}
<div class="m_small">
 {grn_image image='category20.gif'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-4' replace='true'}
</div>
<hr size="1">
{/if}

{** 検索結果ではなく、サブカテゴリがある場合はリンクを表示 **}
{if ! $search && count($category.children) > 0}
<br>
<div class="sub_title">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-5' replace='true'}</div>
<small>
 {foreach from=$category.children key=key item=item}
     {if $browser.type == 'msie'}
         <div class="inline_block_grn">
             {grn_link image='category20.gif' page=$page_info.all cid=$item.cid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
         </div>
     {else}
         {grn_link image='category20.gif' page=$page_info.all cid=$item.cid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
     {/if}
 {/foreach}
</small>
{/if}

</div>
</form>

{if ! $no_submit_form}
 {assign var="form_name" value=$smarty.template|basename}
 {if ! $page_info.parts[2]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {/if}
<input type="hidden" name="cid" value="{$portlet.settings.cid|escape}">
 {foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
 {/foreach}

 {if $selectbox}

<input class="margin" type="submit" name="add" value="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-6' replace='true'}"{if $selected_candidate} disabled{/if}>
<input class="margin" type="submit" name="remove" value="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-7' replace='true'}">

<p>
<div>
<select size=7 multiple id="selected_categories" name="selected_categories[]">
 {foreach from=$candidate_categories item=item}
<option value="{$item.cid|escape}">{$item.path}</option>
 {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
</div>

 {/if}
{/if}
