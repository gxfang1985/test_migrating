<table class="std_form">
{if $move_article}
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-229' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$parent.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-230' replace='true'}</th>
{elseif $target}
 <tr>
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-231' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$target.parent.path|escape}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.bulletin' key='GRN_BLLT-232' replace='true'}</th>
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
<input type="text" name="text" value="{$text|escape}" size="20"><input type="submit" name="search" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-233' replace='true'}">
</div>

{** カテゴリ検索結果 **}
{if $search}

<div class="m_small">
{foreach from=$search.result item=item}
{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.path}<br>
{/foreach}
<p>
<a href="{grn_pageurl page=$page_info.all cid=$category_id s_cid=$set_category_id ss=1 params=$params}">[{cb_msg module='grn.bulletin' key='GRN_BLLT-234' replace='true'}]</a>
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

<div class="border-partition-common-grn"></div>
{if $category.parent}
<div class="margin_bottom">
<small>
{capture name='grn_bulletin_GRN_BLLT_235'}{cb_msg module='grn.bulletin' key='GRN_BLLT-235' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$category.parent.cid ss=1 params=$params caption=$smarty.capture.grn_bulletin_GRN_BLLT_235}
</small>
</div>
{/if}

{** 未選択状態 **}
{else}
<div class="m_small">
{grn_image image='category20.gif'}{cb_msg module='grn.bulletin' key='GRN_BLLT-236' replace='true'}
</div>
<div class="border-partition-common-grn"></div>
{/if}

{** 検索結果ではなく、サブカテゴリがある場合はリンクを表示 **}
{if ! $search && count($category.children) > 0}
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-237' replace='true'}</div>
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
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last|escape}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{/if}
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="s_cid" value="{$set_category_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
 <tr>
  <td></td>
  <td>
{if $target.cid == $category.cid || $current.cid == $category.cid}
{capture name='grn_bulletin_GRN_BLLT_238'}{cb_msg module='grn.bulletin' key='GRN_BLLT-238' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_238 disabled=1}
{else}
{capture name='grn_bulletin_GRN_BLLT_239'}{cb_msg module='grn.bulletin' key='GRN_BLLT-239' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_239}
{/if}
{if $move_article}
{grn_button_cancel page=$cancel_page cid=$category_id aid=$article_id}
{else}
{grn_button_cancel page=$page_prefix|cat:'/category_view' cid=$target.cid}
{/if}
  </td>
 </tr>
</form>
</table>
