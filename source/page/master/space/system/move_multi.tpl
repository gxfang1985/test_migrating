{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<p>
    {cb_msg module='grn.space.system' key='move_multi-1' replace='true'}<br>
    {cb_msg module='grn.space.system' key='move_multi-2' replace='true'}<span class="bold">{$movingSpaceList|@count}</span>
</p>
<div class="explanation">
    {cb_msg module='grn.space.system' key='move_multi-3' replace='true'}
</div>
<p>

<table class="std_form">
    <tr>
        <th nowrap>{cb_msg module='grn.space.system' key='move_multi-4' replace='true'}</th>
        <td>{grn_image image='category20.gif'}{$fromCategoryPath|escape}</td>
    </tr>
    <tr valign='top'>
        <th nowrap>{cb_msg module='grn.space.system' key='move_multi-5' replace='true'}</th>
        <td width="80%">
            <form name="category_select_search" method="get" action="{grn_pageurl page=$page_info.all}">
                <input type="hidden" name="cid" value="{$cid|escape}">
                {foreach from=$params key=name item=value}
                <input type="hidden" name="{$name|escape}" value="{$value|escape}">
                {/foreach}
                <div class="input_box">
                    <div class="search_navi">
                        <input type="text" name="text" value="{$text|escape}" size="20"><input type="submit" name="search" value="{cb_msg module='grn.space.system' key='move_multi-8' replace='true'}">
                    </div>
                    {if $searchCategoryCollection}
                    <div class="m_small">
                    {foreach from=$searchCategoryCollection item=item}
                        {grn_link image="category20.gif" page=$page_info.all cid=$cid s_cid=$item->getId() ss=1 params=$params caption=$item->getCategoryName()}<br>
                    {/foreach}
                        <p>
                        <a href="{grn_pageurl page=$page_info.all cid=$toCategory->getId() ss=1 params=$params}">{cb_msg module='grn.space.system' key='move_multi-9' replace='true'}</a>
                    </div>
                    {elseif $toCategory} 
                    <div class="hilight">
                        <span class="m_small">
                        {* ここは、カテゴリのコレクションが必要 *}
                        {foreach name="path" from=$toAncestorCategoryCollection item=item}                                              
                            {if $smarty.foreach.path.iteration == 1}
                                {grn_image image='category20.gif'}
                            {/if}

                            {if $item->getId() == $toCategory->getId()}
                                {$item->getCategoryName()|escape}
                            {else}
                                {grn_link page=$page_info.all cid=$cid s_cid=$item->getId() ss=1 params=$params caption=$item->getCategoryName()} &gt;
                            {/if}
                        {/foreach}
                        {if $smarty.foreach.path.total < 1}                                                                   
                            {grn_image image='category20.gif'}
                        {/if}
                        </span>
                    </div>
                    <hr size="1">
                        {if $toCategory->getParentCategoryId()}
                    <div class="margin_bottom">
                        <small>
                        {capture name='grn_space_system_move_multi_10'}{cb_msg module='grn.space.system' key='move_multi-10' replace='true'}{/capture}{grn_link image='category20.gif' page=$page_info.all cid=$cid s_cid=$toCategory->getParentCategoryId() ss=1 params=$params caption=$smarty.capture.grn_space_system_move_multi_10}
                        </small>
                    </div>
                        {/if}

                        {if $toCategory->countChildlen() > 0}
                    <div class="sub_title">{cb_msg module='grn.space.system' key='move_multi-12' replace='true'}</div>
                    <small>
                        {* 移動先カテゴリの子カテゴリコレクション *}
                        {foreach from=$toChildCategoryCollection key=key item=item}
                            {if $browser.type == 'msie'}
                                <div class="inline_block_grn">
                                    {grn_link image='category20.gif' page=$page_info.all cid=$cid s_cid=$item->getId() ss=1 params=$params caption=$item->getCategoryName()}{if $item->countChildlen() > 0}({$item->countChildlen()}){/if}&nbsp;
                                </div>
                            {else}
                                {grn_link image='category20.gif' page=$page_info.all cid=$cid s_cid=$item->getId() ss=1 params=$params caption=$item->getCategoryName()}{if $item->countChildlen() > 0}({$item->countChildlen()}){/if}&nbsp;
                            {/if}
                        {/foreach}
                    </small>
                        {/if}
                    {else}
                    <div class="m_small">
                        {grn_image image='category20.gif'}{cb_msg module='grn.space.system' key='move_multi-11' replace='true'}
                    </div>
                    <hr size="1">
                    {/if}
                </div>
            </form>
        </td>
    </tr>

    {assign var="form_name" value=$smarty.template|basename}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_move_multi'|escape}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="cid" value="{$cid|escape}">
        <input type="hidden" name="s_cid" value="{$toCategory->getId()|escape}">
        {foreach from=$params key=name item=value}
        <input type="hidden" name="{$name|escape}" value="{$value|escape}">
        {/foreach}
        <tr>
            <td></td>
            <td>
            {if $toCategory->getId() == $cid || $toCategory->getId() == 1}{* 元のカテゴリORルートカテゴリ*}
                {capture name='grn_space_system_move_multi_6'}{cb_msg module='grn.space.system' key='move_multi-6' replace='true'}{/capture}
                {grn_button_submit class='margin' caption=$smarty.capture.grn_space_system_move_multi_6 disabled=1}
            {else}
                {capture name='grn_space_system_move_multi_7'}{cb_msg module='grn.space.system' key='move_multi-7' replace='true'}{/capture}
                {grn_button_submit class='margin' caption=$smarty.capture.grn_space_system_move_multi_7}
            {/if}
            {if $calcel_page}
                {grn_button_cancel page=$cancel_page cid=$cid filter_id=$filter_id}
            {else}
                {grn_button_cancel page=$page_prefix|cat:'space/system/category_list' cid=$cid filter_id=$filter_id}
            {/if}
            </td>
        </tr>
    </form>
</table>
{include file="grn/system_footer.tpl"}
