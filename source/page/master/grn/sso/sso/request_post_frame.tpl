{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<body onload="">
<form method="post" action="{$sso_method.driver_settings.target_url}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$sso_param_list key=name item=value}
<input type="hidden" name="{$name}" value="{$value}">
{/foreach}
</form>
</body></html>
