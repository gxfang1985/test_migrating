{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<div id="main_menu_part">
    {if $type eq 'personal'}
        {if $is_root}{assign var='root_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_link_GRN_LNK_138'}{cb_msg module='grn.link' key='GRN_LNK-138' replace='true'}{/capture}{grn_link page='link/category_modify' caption=$smarty.capture.grn_link_GRN_LNK_138 image='modify20.gif' cid=$category.cid disabled=$root_disabled alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_139'}{cb_msg module='grn.link' key='GRN_LNK-139' replace='true'}{/capture}{grn_link page='link/category_move' caption=$smarty.capture.grn_link_GRN_LNK_139 image='move20.gif' cid=$category.cid s_cid=$category.parent_category.cid disabled=$root_disabled alt=''}</span>
        {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
        <span class="menu_item">{capture name='grn_link_GRN_LNK_140'}{cb_msg module='grn.link' key='GRN_LNK-140' replace='true'}{/capture}{grn_link id='lnk_delete' page='link/category_delete' caption=$smarty.capture.grn_link_GRN_LNK_140 image='delete20.gif' cid=$category.cid disabled=$root_disabled script="javascript:void(0);" alt=''}</span>
        <div id="rare_menu_part_under">
            {if $category.num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
            <span class="menu_item">{capture name='grn_link_GRN_LNK_141'}{cb_msg module='grn.link' key='GRN_LNK-141' replace='true'}{/capture}{grn_link page='link/category_order' caption=$smarty.capture.grn_link_GRN_LNK_141 image='order20.gif' pcid=$category.cid disabled=$category_order_disabled alt=''}</span>
            {if $category.num_link <= 1}{assign var='order_disabled' value=1}{/if}
            <span class="menu_item">{capture name='grn_link_GRN_LNK_142'}{cb_msg module='grn.link' key='GRN_LNK-142' replace='true'}{/capture}{grn_link page='link/order' caption=$smarty.capture.grn_link_GRN_LNK_142 image='order20.gif' cid=$category.cid disabled=$order_disabled alt=''}</span>
        </div>
    {elseif ($type eq 'share' && $management)}
        {if $is_root}{assign var='root_disabled' value=1}{/if}
        {if $is_root || !$avail_move}{assign var='move_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_link_GRN_LNK_143'}{cb_msg module='grn.link' key='GRN_LNK-143' replace='true'}{/capture}{grn_link page='link/operation/category_modify' caption=$smarty.capture.grn_link_GRN_LNK_143 image='modify20.gif' cid=$category.cid disabled=$root_disabled alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_144'}{cb_msg module='grn.link' key='GRN_LNK-144' replace='true'}{/capture}{grn_link page='link/operation/category_move' caption=$smarty.capture.grn_link_GRN_LNK_144 image='move20.gif' cid=$category.cid s_cid=$category.parent_category.cid disabled=$move_disabled alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_145'}{cb_msg module='grn.link' key='GRN_LNK-145' replace='true'}{/capture}{grn_link page='link/operation/category_delete' caption=$smarty.capture.grn_link_GRN_LNK_145 image='delete20.gif' cid=$category.cid disabled=$root_disabled alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_146'}{cb_msg module='grn.link' key='GRN_LNK-146' replace='true'}{/capture}{grn_link page='link/operation/access_list' caption=$smarty.capture.grn_link_GRN_LNK_146 image='access20.gif' nid=$category.cid alt=''}</span>
        <div id="rare_menu_part_under">
            {if $category.num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
            <span class="menu_item">{capture name='grn_link_GRN_LNK_147'}{cb_msg module='grn.link' key='GRN_LNK-147' replace='true'}{/capture}{grn_link page='link/operation/category_order' caption=$smarty.capture.grn_link_GRN_LNK_147 image='order20.gif' pcid=$category.cid disabled=$category_order_disabled alt=''}</span>
            {if $category.num_link <= 1}{assign var='order_disabled' value=1}{/if}
            <span class="menu_item">{capture name='grn_link_GRN_LNK_148'}{cb_msg module='grn.link' key='GRN_LNK-148' replace='true'}{/capture}{grn_link page='link/operation/order' caption=$smarty.capture.grn_link_GRN_LNK_148 image='order20.gif' cid=$category.cid disabled=$order_disabled alt=''}</span>
        </div>
    {/if}
</div>
{grn_title title=$category.title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.link' key='GRN_LNK-149' replace='true'}</th>
        <td>{$category.title|escape}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.link' key='GRN_LNK-150' replace='true'}</th>
        {if $is_root}
            <td>--</td>
        {else}
            <td>{grn_image image='category20.gif'}{$category.parent_category.title|escape}</td>
        {/if}
    </tr>
    <tr>
        <th>{cb_msg module='grn.link' key='GRN_LNK-151' replace='true'}</th>
        <td>{$category.foreign_key|escape:"html"}<br></td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.link' key='GRN_LNK-152' replace='true'}</th>
        <td>
            {if 1 > $category.memo|count_characters:true}
                <br>
            {else}
                {grn_format body=$category.memo}
            {/if}
        </td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.link' key='GRN_LNK-153' replace='true'}</th>
        <td>
            {foreach from=$category.child_categories item=child_categories}
                {grn_image image='category20.gif'}{$child_categories.title|escape:"html"}
            {/foreach}
        </td>
    </tr>
    {if $type neq 'personal'}
        <tr>
            <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-154' replace='true'}</th>
            <td>
                {grn_user_name uid=$category.creator_uid name=$category.creator_name}
                {grn_date_format format='DateTimeFull_YMDW_HM' date=$category.ctime}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-155' replace='true'}</th>
            <td>
                {grn_user_name uid=$category.modify_uid name=$category.modify_name}
                {grn_date_format format='DateTimeFull_YMDW_HM' date=$category.mtime}
            </td>
        </tr>
    {/if}
</table>

{include file="grn/footer.tpl"}
