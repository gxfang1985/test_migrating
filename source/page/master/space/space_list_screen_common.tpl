{include file='grn/head.tpl'}
{if $site_position|@count > 1}
{include file="grn/header.tpl"}
{else}
{include file="grn/header_no_siteposition.tpl"}
<table class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;"><tbody><tr><td width="100%" valign="bottom" nowrap>
{grn_image image="space20.png"}{$app_name}
</td></tr></tbody></table>
<div class="mainarea">
{/if}

{grn_load_javascript file="grn/html/component/space.js"}

<div id="menu_part">
  <div id="smart_main_menu_part">
    <span class="menu_item"><nobr><a href="{grn_pageurl page='space/create' cid=$this->getCategoryIdOrBlank()}" class="icon-add-grn">{cb_msg module='grn.space' key='spacelist-common-1' replace='true'}</a></nobr></span>
  </div>
  {if $component->isFtsAvailable()}
  <div id="smart_rare_menu_part" style="white-space:nowrap;">
    <form class="clearFix-cybozu" name="form_search" method="get" action="{grn_pageurl page=space/search}">
      <input type="hidden" name="searchRange" value="{$component->getSearchRange()}" />
      <input type="hidden" name="cid" value="{$categoryId}" />
      {include file='fts/_search_box.tpl'}
    </form>
  </div>
  {/if}
</div>

<div class="tab_memu">
{foreach from=$this->getTabList() item=tab}
<div class="tab">
<span class="tab_left_{if $tab->isSelected()}on{else}off{/if}"></span>
<span class="tab_{if $tab->isSelected()}on{else}off{/if}">
{if $tab->isSelected()}<span>{else}<a href="{$tab->getLink()}">{/if}{$tab->getName()|escape}{if $tab->isSelected()}</span>{else}</a>{/if}
</span>
<span class="tab_right_{if $tab->isSelected()}on{else}off{/if}"></span>
</div>
{/foreach}
</div>
<div class="tab_menu_end">&nbsp;</div>
{$component->fetch()}

{include file="grn/footer.tpl"}