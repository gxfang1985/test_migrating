{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_address_GRN_ADDR_42'}{cb_msg module='grn.address' key='GRN_ADDR-42' replace='true'}{/capture}{grn_link page='address/mygroup_modify' caption=$smarty.capture.grn_address_GRN_ADDR_42 image='write20.gif' mgid=$group.id alt=''}</span>
    {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
    <span class="menu_item">{capture name='grn_address_GRN_ADDR_43'}{cb_msg module='grn.address' key='GRN_ADDR-43' replace='true'}{/capture}{grn_link id = 'lnk_delete'  script="javascript:void(0);" page='address/mygroup_delete' caption=$smarty.capture.grn_address_GRN_ADDR_43 image='delete20.gif' mgid=$group.id alt=''}</span>
</div>

{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.address' key='GRN_ADDR-44' replace='true'}</th>
        <td>{$group.name|escape}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.address' key='GRN_ADDR-45' replace='true'}</th>
        <td>{grn_format body=$group.memo}</td>
    </tr>
</table>

{include file="grn/footer.tpl"}
