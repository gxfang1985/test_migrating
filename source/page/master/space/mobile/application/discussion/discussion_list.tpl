{foreach from=$discussions item=discussion}
  {if $discussion.to_show_body}
    {assign var='page_to_turn' value='body'}
  {else}
    {assign var='page_to_turn' value='detail'}
  {/if}
  <li data-icon="false">
    <a href="{grn_pageurl page='space/mobile/application/discussion/'|cat:$page_to_turn spid=$space_id tid=$discussion.id}" class="mobile-list-text-short-grn">
    {if $discussion.unread}
      <span class="mobile_list_icon_unread_grn"></span>
    {/if}
      {$discussion.title|escape}<span class="mobile-array-list-grn"></span>
    </a>
  </li>
{/foreach}