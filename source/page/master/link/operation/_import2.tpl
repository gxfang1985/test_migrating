   <table class="admin_list_table" width="100%">
    <tr>
 {foreach from=$lines.0 key=idx item=col}
     <th nowrap>{$idx+1}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-71' replace='true'}</th>
 {/foreach}
    </tr>
{foreach from=$lines item=line}
    <tr valign="top">
 {foreach from=$line item=col}
     <td>{if strlen($col)}{$col|escape}{else}<br>{/if}</td>
 {/foreach}
    </tr>
{/foreach}
   </table>

<p>
{include file=$button_file}
</p>
