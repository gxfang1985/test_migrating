<div style="margin-left:1em">
<table>
{foreach from=$children key=key item=item}
<tr>
<td>{grn_organize_name gid=$key is_sandbox_page=$is_sandbox_page}{cb_msg module='grn.system.user' key='GRN_SY_US-529' replace='true'}{$item.code|escape}{cb_msg module='grn.system.user' key='GRN_SY_US-530' replace='true'}</td>
</tr>
{if $item.children}
<tr>
<td>
{include file='system/user/_org_code_tree.tpl' children=$item.children}
</td>
</tr>
{/if}
{/foreach}
</table>
</div>
