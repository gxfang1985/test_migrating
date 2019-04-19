{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<body onload="">
<form method="get" action="{$sso_method.driver_settings.target_url}">
{foreach from=$sso_param_list key=name item=value}
<input type="hidden" name="{$name}" value="{$value}">
{/foreach}
</form>
</body></html>
