{strip}
<span>
  {if $is_favoured}
    {cb_msg module='grn.favour' key='GRN_FAV-1' replace='true'}{grn_favour_app_name}{cb_msg module='grn.favour' key='GRN_FAV-2' replace='true'}
  {else}
    {grn_favour_app_name}{cb_msg module='grn.favour' key='GRN_FAV-3' replace='true'}
  {/if}
</span>
{/strip}