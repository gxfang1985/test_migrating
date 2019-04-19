{if $need_header}
  {include file='grn/'|cat:$path_prefix|cat:'head.tpl'}
  {include file='grn/'|cat:$path_prefix|cat:'header.tpl'}
  {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

{$component->fetch()}

{if $need_footer}
  {include file='grn/'|cat:$path_prefix|cat:'footer.tpl'}
{/if}