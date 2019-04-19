<form name="star/delete_multi" method="post" action="{grn_pageurl page='star/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>
        {cb_msg module='grn.star' key='GRMSG_STAR_1'}{grn_image image="star20.gif"}{cb_msg module='grn.star' key='GRMSG_STAR_2'}{*Do you want to delete star item as bellow?*}<br /><br />
        {cb_msg module='grn.star' key='GRN_STAR-18' replace='true'}{*Target*}{cb_msg module='grn.star' key='GRN_STAR-20' replace='true'} <span class="bold">{if !$appid}{cb_msg module='grn.star' key='GRN_STAR-3' replace='true'}{else}{$category}{/if}</span><br />
        {cb_msg module='grn.star' key='GRN_STAR-19' replace='true'}{*Number*}{cb_msg module='grn.star' key='GRN_STAR-20' replace='true'} <span class="bold delete_count"></span>
    </p>
    <input type="hidden" name="app_id" value="{$appid|escape}">
    {foreach from=$star item=id}
        <input type="hidden" name="star[]" value="{$id|escape}">
    {/foreach}
</form>