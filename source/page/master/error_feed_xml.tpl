<?xml version="1.0" encoding="{php}echo mb_preferred_mime_name( cb_get_http_output_encoding() );{/php}" ?>
<garoon version="{php} global $G_config_grn;echo $G_config_grn->get( 'System', 'version' );{/php}" xml:lang="{php}$i18n = CB_I18N::getInstance();echo $i18n->getCurrentLanguage();{/php}">
 <error code="{$ErrorNumber}">
  <diagnosis>{$ErrorDiag|grn_noescape}</diagnosis>
  <cause>{$ErrorCause|grn_noescape}</cause>
{if $HaveAdditional}
  {foreach from=$AdditionalMessage item=current}
  <additional>{$current|grn_noescape}</additional>
  {/foreach}
{/if}
  <counter>{$ErrorCounterMeasure|grn_noescape}</counter>
 </error>
</garoon>
