<table class="view_table" width="50%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-11' replace='true'}</th>
        <td>{$folder.name}</td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-12' replace='true'}</th>
        <td>{if $folder.size >= 1048576}
                {grn_format_filesize size=$folder.size unit="MB"}
            {else}
                {grn_format_filesize size=$folder.size unit="KB"}
            {/if}
        </td>
    </tr>
</table>

<p>
<div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-13' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
<div class="{$navi_class}"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>

<table class="list_column" style="width:50%">
    <colgroup>
        <col width="80%">
        <col width="20%">
    </colgroup>
    <tr>
        <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-16' replace='true'}</th>
        {if $sort == 'fsu'}
        <th nowrap>{capture name='grn_cabinet_GRN_CAB_17'}{cb_msg module='grn.cabinet' key='GRN_CAB-17' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_17 page=$page_info.all hid=$folder.id sort='fsd' sp=0 reverse=1}</th>
        {else}
        <th nowrap>{capture name='grn_cabinet_GRN_CAB_18'}{cb_msg module='grn.cabinet' key='GRN_CAB-18' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_cabinet_GRN_CAB_18 page=$page_info.all hid=$folder.id sort='fsu' sp=0}</th>
        {/if}
    </tr>
    {foreach from=$sub_folders item=child}
    <tr>
        <td>{$child.name}{if $child.num_of_children > 0}({$child.num_of_children}){/if}</td>
        <td>{if $child.size >= 1048576}
                {grn_format_filesize size=$child.size unit="MB"}
            {else}
                {grn_format_filesize size=$child.size unit="KB"}
            {/if}
        </td>
    </tr>
    {/foreach}
</table>

<div class="{$navi_class}"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
</p>
