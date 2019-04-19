{if !$no_header}
  {include file='grn/head.tpl'}
  {include file="grn/header.tpl"}
{else}
  <div id="hidden_siteposition" style="display: none;">
    {grn_site_position positions=$site_position}
  </div>
{/if}
{grn_load_javascript file="grn/html/component/space.js"}

{if $appli==""}
  <div class="attention">{cb_msg module="grn.space" key="deleted_space" replace="true"}</div>
{elseif $appli=="grn.discussion"}
  <div class="attention">{cb_msg module="grn.space" key="deleted_discussion" replace="true"}</div>
{elseif $appli=="grn.todo"}
  <div class="attention">{cb_msg module="grn.space" key="deleted_todo" replace="true"}</div>
{/if}

{if !$no_footer}
  {include file="grn/footer.tpl"}
{else}
  <div id="hidden_backlink" style="display: none;">
    {grn_backlink positions=$site_position}
  </div>
{/if}
