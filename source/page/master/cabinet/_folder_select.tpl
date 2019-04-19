
<form name="folder_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
<input type="hidden" name="s_hid" value="{$set_folder_id|escape}">
<input type="hidden" name="hid" value="{$folder_id|escape}">
{foreach from=$params key=name item=value}
<input type="hidden" name="{$name|escape}" value="{$value|escape}">
{/foreach}
<input type="hidden" name="ss" value="1">

<table class="input_box"><tr><td>

<div class="search_navi">
<input type="text" name="text" value="{$text|escape}" size="20" maxlength="100"><input type="submit" name="search" value="{cb_msg module='grn.cabinet' key='GRN_CAB-200' replace='true'}">
</div>

{** フォルダ検索結果 **}
{if $search}

{foreach from=$search.result item=item}
{grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.path}<br>
{/foreach}
<p>
<div><a href="{grn_pageurl page=$page_info.all hid=$folder_id s_hid=$set_folder_id ss=1 params=$params}">[{cb_msg module='grn.cabinet' key='GRN_CAB-201' replace='true'}]</a></div>

{** フォルダ選択状態 **}
{elseif $set_folder_id}

<div class="hilight">
<span class="m_small">

{foreach name="path" from=$folder.ancestors item=item}
{if $smarty.foreach.path.iteration == 1}{grn_image image='folder20.gif'}{/if}{grn_link page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}&nbsp;&gt;&nbsp;
{/foreach}
{if $smarty.foreach.path.total < 1}{grn_image image='folder20.gif'}{/if}{$folder.name|escape}

</span>
</div>

{if $folder.parent}
<div class="border-partition-common-grn"></div>
<div>
<small>
{capture name='grn_cabinet_GRN_CAB_202'}{cb_msg module='grn.cabinet' key='GRN_CAB-202' replace='true'}{/capture}{grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$folder.parent.hid ss=1 params=$params caption=$smarty.capture.grn_cabinet_GRN_CAB_202}
</small>
</div>
{/if}

{** 未選択状態 **}
{else}
<div class="m_small">
{grn_image image='folder20.gif'}{cb_msg module='grn.cabinet' key='GRN_CAB-203' replace='true'}
</div>
<div class="border-partition-common-grn"></div>
{/if}

{** 検索結果ではなく、サブフォルダがある場合はリンクを表示 **}
{if ! $search && count($folder.children) > 0}
<br>
<div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-204' replace='true'}</div>
<small>
{foreach from=$folder.children key=key item=item}
  {if is_null($item.deleted)}
    {if $browser.type == 'msie'}
        <div class="inline_block_grn">
            {grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
        </div>
    {else}
        {grn_link image='folder20.gif' page=$page_info.all hid=$folder_id s_hid=$item.hid ss=1 params=$params caption=$item.name}{if $item.child_count}({$item.child_count}){/if}&nbsp;
    {/if}
  {/if}
{/foreach}
</small>
{/if}

</td></tr></table>
</form>

{assign var="form_name" value=$smarty.template|basename}

{if ! $no_submit_form}
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

 {if $selectbox}

<div class="margin_top">
<select name="candidate_folders[]" size="5" multiple>
{if $set_folder_id == GRN_CABINET_ROOT_FOLDER_ID}
<option value="{$set_folder_id|escape}">{$folder.name|escape}</option>
{/if}
  {foreach from=$folder.children key=key item=item}
<option value="{$item.hid}">{$item.name|escape}</option>
  {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
</select>
</div>

<div class="margin_top">
<input type="submit" name="add" value="{cb_msg module='grn.cabinet' key='GRN_CAB-205' replace='true'}"{if $selected_candidate} disabled{/if}> &nbsp;&nbsp; 
<input type="submit" name="remove" value="{cb_msg module='grn.cabinet' key='GRN_CAB-206' replace='true'}">
</div>

<div class="margin_top">
<select size="5" multiple id="selected_folders" name="selected_folders[]">
 {foreach from=$candidate_folders item=item}
<option value="{$item.hid|escape}">{$item.path|escape}</option>
 {/foreach}
<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
</div>

 {/if}
{/if}
