{* show indexmenu list, the selected indexmenu-items displays *}
{if $indexmenu}
 {foreach from=$indexmenu item=menu}
  {if $menu.disabled == ''}
<li>{grn_link page=$menu.page caption=$menu.caption class=$menu.class}
  {else}
<li>{grn_link page=$menu.page caption=$menu.caption class=$menu.class}
  {/if}
 {/foreach}
{/if}
