<?xml version="1.0" encoding="{php}echo mb_preferred_mime_name( cb_get_http_output_encoding() );{/php}" ?>
<garoon version="{php} global $G_config_grn;echo $G_config_grn->get( 'System', 'version' );{/php}" xml:lang="{php}$i18n = CB_I18N::getInstance();
echo $i18n->getCurrentLanguage();{/php}" datetime="{php}$ts = new CB_TimeStampEx();$ts->setTimeZone('UTC');$dt=$ts->getDateTime();echo sprintf( '%04d-%02d-%02dT%02d:%02d:%02dZ',$dt->year,$dt->month,$dt->day,$dt->hour,$dt->minute,$dt->second );{/php}">
 <error number="{$ErrorNumber}">
  <diag>{$ErrorDiag|grn_noescape}</diag>
  <cause>{$ErrorCause|grn_noescape}</cause>
{if $HaveAdditional}
  {foreach from=$AdditionalMessage item=current}
  <additional>{$current|grn_noescape}</additional>
  {/foreach}
{/if}
  <counter>{$ErrorCounterMeasure|grn_noescape}</counter>
 </error>
</garoon>
