{if ! $page_prefix}
    {assign var="page_prefix" value="cabinet"}
{/if}
{if ! $folder_page}
    {assign var="folder_page" value=$page_info.all}
{/if}
<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.cabinet' key='GRN_CAB-19' replace='true'}</th>
        <td>
            {grn_image image='folder20.gif'}
            {assign var="first_node" value="1"}
            {foreach from=$file.position item=node}
                {if $first_node}
                    {assign var="first_node" value="0"}
                {else}
                    &nbsp;&gt;&nbsp;
                {/if}
                {if $folder_id == $node.hid}
                    {assign var="same_folder" value='1'}
                {else}
                    {assign var="same_folder" value='0'}
                {/if}
                {grn_link page=$folder_page caption=$node.title hid=$node.hid sf=$same_folder}
            {/foreach}
        </td>
    </tr>
</table>
<p></p>

{include file="grn/file_view.tpl" download_page=$page_prefix|cat:"/download" restore_page=$page_prefix|cat:"/restore" linkparams=$linkparams auth=$file.auth noframe=1 no_restore=$no_restore name_width=$config.name_width}
