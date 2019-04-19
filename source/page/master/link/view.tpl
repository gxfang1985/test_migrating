{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}

{if $type eq 'personal'}
    <div id="main_menu_part">
        <span class="menu_item">{capture name='grn_link_GRN_LNK_21'}{cb_msg module='grn.link' key='GRN_LNK-21' replace='true'}{/capture}{grn_link element_id='link-modify' page='link/modify' caption=$smarty.capture.grn_link_GRN_LNK_21 image='modify20.gif' cid=$category.cid lid=$link.lid alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_22'}{cb_msg module='grn.link' key='GRN_LNK-22' replace='true'}{/capture}{grn_link page='link/move' caption=$smarty.capture.grn_link_GRN_LNK_22 image='move20.gif' cid=$category.cid lid=$link.lid s_cid=$category.cid alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_23'}{cb_msg module='grn.link' key='GRN_LNK-23' replace='true'}{/capture}{grn_link id = 'lnk_delete' page='link/delete' caption=$smarty.capture.grn_link_GRN_LNK_23 image='delete20.gif' cid=$category.cid lid=$link.lid script="javascript:void(0);" alt=''}</span>
    </div>
{elseif ($type eq 'share' && $management)}
    {if !$avail_move}{assign var='move_disabled' value=1}{/if}
    <div id="main_menu_part">
        <span class="menu_item">{capture name='grn_link_GRN_LNK_24'}{cb_msg module='grn.link' key='GRN_LNK-24' replace='true'}{/capture}{grn_link page='link/operation/modify' caption=$smarty.capture.grn_link_GRN_LNK_24 image='modify20.gif' cid=$category.cid lid=$link.lid alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_25'}{cb_msg module='grn.link' key='GRN_LNK-25' replace='true'}{/capture}{grn_link page='link/operation/move' caption=$smarty.capture.grn_link_GRN_LNK_25 image='move20.gif' cid=$category.cid lid=$link.lid s_cid=$category.cid disabled=$move_disabled alt=''}</span>
        <span class="menu_item">{capture name='grn_link_GRN_LNK_26'}{cb_msg module='grn.link' key='GRN_LNK-26' replace='true'}{/capture}{grn_link page='link/operation/delete' caption=$smarty.capture.grn_link_GRN_LNK_26 image='delete20.gif' cid=$category.cid lid=$link.lid alt=''}</span>
    </div>
{/if}
{grn_title title=$link.title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.link' key='GRN_LNK-27' replace='true'}</th>
        <td>
            {foreach from=$category.path item=path}
                {if $path.cid == GRN_LINK_CATEGORY_ROOT_ID}
                    {grn_link image='category20.gif' page='link/index' caption=$path.title}
                {else}
                    &gt; {grn_link caption=$path.title page='link/index' cid=$path.cid type=$type}
                {/if}
            {/foreach}
            {if $category.cid != GRN_LINK_CATEGORY_ROOT_ID}
                &gt; {grn_link page='link/index' cid=$category.cid type=$type caption=$category.title}
            {/if}
        </td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-29' replace='true'}</th>
        <td id="link-detail-title">{$link.title|escape}</td>
    </tr>
    <tr>
        <th>URL</th>
        <td id="link-detail-url">
            {if $set_popup}
                {if $link.sid > 0}
                    {grn_sso_link caption=$link.url sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url target='_blank'}&nbsp;&nbsp;&nbsp;&nbsp;
                    {grn_sso_link caption='' sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url image='window20.gif'}
                {else}
                    {capture name='grn_link_GRN_LNK_30'}{cb_msg module='grn.link' key='GRN_LNK-30' replace='true'}{/capture}
                    {grn_link_raw caption=$link.url page=$link.url target='_blank' title=$smarty.capture.grn_link_GRN_LNK_30 no_script=true}&nbsp;&nbsp;&nbsp;&nbsp;
                    {capture name='grn_link_GRN_LNK_31'}{cb_msg module='grn.link' key='GRN_LNK-31' replace='true'}{/capture}
                    {grn_link_raw caption='' page=$link.url image='window20.gif' alt=$smarty.capture.grn_link_GRN_LNK_31 no_script=true}
                {/if}
            {else}
                {if $link.sid > 0}
                    {grn_sso_link caption=$link.url sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url}&nbsp;&nbsp;&nbsp;&nbsp;
                    {grn_sso_link caption='' sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url image='blank20.gif' target='_blank'}
                {else}
                    {grn_link_raw caption=$link.url page=$link.url no_script=true}&nbsp;&nbsp;&nbsp;&nbsp;
                    {capture name='grn_link_GRN_LNK_32'}{cb_msg module='grn.link' key='GRN_LNK-32' replace='true'}{/capture}{grn_link_raw caption='' page=$link.url image='blank20.gif' alt=$smarty.capture.grn_link_GRN_LNK_32 target="_blank" no_script=true}
                {/if}
            {/if}
        </td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.link' key='GRN_LNK-33' replace='true'}</th>
        <td id="link-detail-memo">{grn_format body=$link.memo}</td>
    </tr>
    {if $type neq 'personal'}
        <tr valign="top">
            <th>{cb_msg module='grn.link' key='GRN_LNK-34' replace='true'}</th>
            <td>{$link.sso_name|escape}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-35' replace='true'}</th>
            <td>
                {grn_user_name uid=$link.creator_uid name=$link.creator_name}
                {grn_date_format format='DateTimeFull_YMDW_HM' date=$link.ctime}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.link' key='GRN_LNK-36' replace='true'}</th>
            <td>
                {grn_user_name uid=$link.modify_uid name=$link.modify_name}
                {grn_date_format format='DateTimeFull_YMDW_HM' date=$link.mtime}
            </td>
        </tr>
    {/if}
</table>

{include file="grn/footer.tpl"}
