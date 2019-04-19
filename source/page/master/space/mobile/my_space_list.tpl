{foreach from=$space_collection item=space name=space_col}
<li data-icon="false">
  <a href="{grn_pageurl page='space/mobile/application/discussion/index' spid=$space->getId()}" class="mobile-list-text-grn">
    {if ! $space->isPublic()}
    <span class="mobile-icon-list-privateMark-grn"></span>
    {/if}
    <img src="{$space->getDisplayIconPath()}" class="ui-li-icon mobile-icon-big-grn" height="32"/>
    {$space->getSpaceName()|escape}
    <span class="mobile-array-list-grn"></span>
  </a>
</li>
{/foreach}