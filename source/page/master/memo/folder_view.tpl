{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_memo_GRN_MEM_16'}{cb_msg module='grn.memo' key='GRN_MEM-16' replace='true'}{/capture}{grn_link page='memo/folder_modify' caption=$smarty.capture.grn_memo_GRN_MEM_16 image='write20.gif' class='menu_item' did=$folder_id alt=''}</span>
    <span class="menu_item">{capture name='grn_memo_GRN_MEM_17'}{cb_msg module='grn.memo' key='GRN_MEM-17' replace='true'}{/capture}{grn_link page='memo/folder_delete' caption=$smarty.capture.grn_memo_GRN_MEM_17 image='delete20.gif' class='menu_item' did=$folder_id alt=''}</span>
</div>

{grn_title title=$page_title class="inline_block_grn mBottom10" no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-18' replace='true'}</th>
        <td>{$folder.name|escape:"html"}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-19' replace='true'}</th>
        <td>
            {capture name='grn_memo_GRN_MEM_20'}{cb_msg module='grn.memo' key='GRN_MEM-20' replace='true'}{/capture}
            {grn_link page='memo/index' caption=$smarty.capture.grn_memo_GRN_MEM_20 image='folder20.gif' disabled=1}
            {foreach name="path" from=$folder.path item=node}
                &nbsp;&gt;&nbsp;{grn_link page='memo/folder_view' caption=$node.name did=$node.id}
            {/foreach}
        </td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.memo' key='GRN_MEM-21' replace='true'}</th>
        <td>{grn_format body=$folder.memo}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-22' replace='true'}</th>
        <td>{grn_user_name uid=$login.id name=$login.name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$folder.ctime}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-23' replace='true'}</th>
        <td>{grn_user_name uid=$login.id name=$login.name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$folder.mtime}</td>
    </tr>
</table>

{include file='grn/footer.tpl'}
