<form name="category_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="s_cid" value="{$set_category_id|escape}">
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
<input type="hidden" name="ss" value="1">

<table class="input_box"><tr><td>

<div class="search_navi">
<input type="text" name="text" value="{$text|escape}" size="20" maxlength="100"><input type="submit" name="search" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-181' replace='true'}">
</div>

{** カテゴリ検索結果 **}
{if $search}

{foreach from=$search.result item=item}
{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.path}<br>
{/foreach}
<p>
<div><a href="{grn_pageurl page=$page_info.all cid=$category_id s_cid=$set_category_id ss=1 params=$params}">[{cb_msg module='grn.bulletin' key='GRN_BLLT-182' replace='true'}]</a></div>

{** カテゴリ選択状態 **}
{elseif $set_category_id}

<div class="hilight">
<span class="m_small">

{foreach name="path" from=$category.ancestors item=item}
{if $smarty.foreach.path.iteration == 1}{grn_image image='category20.gif'}{/if}{grn_link page=$page_info.all cid=$category_id s_cid=$item.cid ss=1 params=$params caption=$item.name}&nbsp;&gt;&nbsp;
{/foreach}
{if $smarty.foreach.path.total < 1}{grn_image image='category20.gif'}{/if}{$category.name|escape}

</span>
</div>

{if $category.parent}
<div class="border-partition-common-grn"></div>
<div>
<small>
{capture name='grn_bulletin_GRN_BLLT_183'}{cb_msg module='grn.bulletin' key='GRN_BLLT-183' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$category_id s_cid=$category.parent.cid ss=1 params=$params caption=$smarty.capture.grn_bulletin_GRN_BLLT_183}
</small>
</div>
{/if}

{** 未選択状態 **}
{else}
<div class="m_small">
{grn_image image='category20.gif'}{cb_msg module='grn.bulletin' key='GRN_BLLT-184' replace='true'}
</div>
<div class="border-partition-common-grn"></div>
{/if}

{** 検索結果ではなく、サブカテゴリがある場合はリンクを表示 **}
{if ! $search && count($category.children) > 0}
<br>
<div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-185' replace='true'}</div>
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

</td></tr></table>
</form>

{if ! $no_submit_form}
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

 {if $selectbox}

<div class="margin_top">
<select name="candidate_categories[]" size="5" multiple>
{if $set_category_id == GRN_BULLETIN_ROOT_CATEGORY_ID}
<option value="{$set_category_id|escape}">{$category.name|escape}</option>
{/if}
  {foreach from=$category.children key=key item=item}
<option value="{$item.cid}">{$item.name|escape}</option>
  {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
</select>
</div>

<div class="margin_top">
<input type="submit" name="add" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-186' replace='true'}"{if $selected_candidate} disabled{/if}> &nbsp;&nbsp; 
<input type="submit" name="remove" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-187' replace='true'}">
</div>

<div class="margin_top">
<select size="5" multiple name="selected_categories[]" id="selected_categories">
  {foreach from=$candidate_categories item=item}
<option value="{$item.cid|escape}">{$item.path}</option>
  {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
</div>

 {/if}
{/if}
