{* show validation errors *}
{foreach item=one_error from=$validation_errors}
{$one_error|escape}<br>
{/foreach}
