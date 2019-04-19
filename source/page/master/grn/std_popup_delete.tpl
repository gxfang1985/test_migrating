<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $explanation}
    <p>{$explanation}</p>
{elseif $target.instance.display_name}
    <p>{$target.class.display_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-959' replace='true'}<span class="bold">{if $image}{grn_image image=$image}{/if}{$target.instance.display_name|cb_mb_truncate|escape}</span>{cb_msg module='grn.grn' key='GRN_GRN-960' replace='true'}</p>
{/if}
 <input type="hidden" name="id" value="{$target.instance.id}">
</form>
