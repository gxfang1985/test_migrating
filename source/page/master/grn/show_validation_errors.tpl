{* show validation errors *}
{foreach item=one_error from=$validation_errors}
<div class="attention"><span class="bold">{grn_link class="subnotify16" disabled=TRUE caption=$one_error}</span></div>
{/foreach}
