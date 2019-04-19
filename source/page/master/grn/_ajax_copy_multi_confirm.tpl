<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="{$source_info.key}" value="{$source_info.id}">
<p>
{cb_msg module='grn.grn' key='GRN_GRN-1545' replace='true'}{cb_msg module='grn.grn' key='GRN_GRN-426' replace='true'}&nbsp;<span class='bold'>{$source_info.name}</span><br>
{cb_msg module='grn.grn' key='GRN_GRN-1546' replace='true'}{cb_msg module='grn.grn' key='GRN_GRN-426' replace='true'}&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-97' replace='true'}{$targets.count}{cb_msg module='grn.grn' key='GRN_GRN-100' replace='true'}
{foreach from=$targets.list item=item name=target}
    <input type="hidden" name="ids[]" value="{$item.id}">
    {if ! $smarty.foreach.target.first}、{/if}
    <span class='bold'>{$item.name}</span>
{/foreach}
</p>
</form>