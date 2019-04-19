"{$ErrorNumber}","{$ErrorDiag|grn_noescape}","{$ErrorCause|grn_noescape}","{$ErrorCounterMeasure|grn_noescape}"
{if $HaveAdditional}
  {foreach from=$AdditionalMessage item=current}
"{$current|grn_noescape}"
  {/foreach}
{/if}
