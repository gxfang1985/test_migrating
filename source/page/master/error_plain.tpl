{*
 * {cb_msg module='grn' key='GRN_GRN-112' replace='true'}
 * @see include/fw/error_handler.html
 *}Error: {$ErrorNumber}

{$ErrorDiag|grn_noescape}

Cause:
{$ErrorCause|grn_noescape}
{if $HaveAdditional}{foreach from=$AdditionalMessage item=current}

Additional Information:
{$current|grn_noescape}{/foreach}{/if}

Counter Measure:
{$ErrorCounterMeasure|grn_noescape}
{if $show_backtrace}

Developer Information:
{$ErrorDeveloperInfo|grn_noescape}

Stack Dump:
{$ErrorDetailTable|grn_noescape}{/if}
