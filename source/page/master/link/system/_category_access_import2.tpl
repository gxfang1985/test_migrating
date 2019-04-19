   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <tr>
 {foreach from=$lines.0 key=idx item=col}
     <th nowrap>{$idx+1}{cb_msg module='grn.link.system' key='GRN_LNK_SY-214' replace='true'}</th>
 {/foreach}
    </tr>
{foreach from=$lines item=line}
    <tr valign="top">
 {foreach from=$line item=col}
     <td>{$col|escape}</td>
 {/foreach}
    </tr>
{/foreach}
   </table>

<p>
{include file=$button_file}
</p>
