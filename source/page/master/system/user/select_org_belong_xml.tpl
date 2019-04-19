<?xml version="1.0" encoding="{$charset}" ?>
<garoon version="{php} global $G_config_grn;echo $G_config_grn->get( 'System', 'version' );{/php}" xml:lang="{php}$i18n = CB_I18N::getInstance();
echo $i18n->getCurrentLanguage();{/php}" datetime="{php}$ts = new CB_TimeStampEx();$ts->setTimeZone('UTC');$dt=&$ts->getDateTime();sprintf( '%04d-%02d-%02dT%02d:%02d:%02dZ',$dt->year,$dt->month,$dt->day,$dt->hour,$dt->minute,$dt->second );{/php}">
 <data>
{foreach from=$selected_orgs key=item_id item=item}
  <value id="{$item_id|escape}">
    <name>{$item.name|escape}</name>
    <fullpath>{$item.fullpath|escape}</fullpath>
  </value>
{/foreach}
 </data>
</garoon>
