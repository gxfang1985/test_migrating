{if $smarty.const.ON_SAAS===1}
 <div class="explanation">{cb_msg module='grn.system' key='GRN_SY-14' replace='true'}</div>
{else}
 <div id="view">
   <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-54' replace='true'}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="20%">
     <col width="80%">
    </colgroup>
    <tr>
     <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-55' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-56' replace='true'}</th>
    </tr>
{foreach from=$info.machine item=v}
    <tr valign="top">
     <td>{$v.id|escape}</td>
     <td>{$v.value|escape}</td>
    </tr>
{/foreach}
   </table>
    
   <br>
   <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-57' replace='true'}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="10%">
     <col width="40%">
     <col width="50%">
    </colgroup>
    <tr>
     <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-58' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-59' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-60' replace='true'}</th>
    </tr>
{foreach from=$info.env item=v}
    <tr valign="top">
    {if $v.dir}
     <td>{$v.id|escape}<br>({$v.dir})</td>
    {else}
     <td>{$v.id|escape}</td>
    {/if}
     <td>{$v.value|escape}</td>
     <td>{$v.memo|escape}</td>
    </tr>
{/foreach}
   </table>
 </div>
</div>
{/if}
