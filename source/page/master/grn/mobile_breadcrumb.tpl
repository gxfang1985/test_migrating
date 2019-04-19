{* Every Content pages(data-role="content") can include this file to show Breadcrumb
e.g. {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true right_include_file="XXX.tpl"}
If the class of Content does not include "mobile-content-withList-grn", "not_need_withList=true" is necessary.

If there is other elements at the right side, can use [right_include_file="XXX.tpl"] to include these elements.
But if the "right include file" is "up/down page icon" or "select menu", do not need to set "right_include_file" in TPL file.
 1. "up/down page icon":
        Just need to set parameter "page_up_down" in CSP file;
 2. "select menu":
        Need to create a "select menu file", and set it into parameter "select_menu_include_file" in TPL file.
        e.g. {include file="grn/mobile_breadcrumb.tpl" select_menu_include_file="XXX.tpl"}
*}

{if $is_breadcrumb_show}
  {grn_load_javascript file='grn/html/component/mobile_breadcrumb.js'}
  <div class="mobile_breadcrumbtitle_grn {if ! $not_need_withList}mobile_titlebar_content_withList_grn{/if}">
    {strip}
      {if $breadcrumb_upper_page}
        <div class="mobile_breadcrumbtitle_left_grn {if $breadcrumb_upper_page.is_history_back}mobile_left_noArrow_grn{/if}" id="left_text">
          {if $breadcrumb_upper_page.is_history_back}
            <a href="javascript:history.back();" class="mobile_breadcrumbtitle_back_grn"></a>
          {else}
            <a href="{grn_pageurl page=$breadcrumb_upper_page.page params=$breadcrumb_upper_page.params}">{$breadcrumb_upper_page.name|escape}</a>
            <span class="mobile_icon_breadcrumb_arrow_grn"></span>
          {/if}
        </div>
      {/if}
      <div class="mobile_breadcrumbtitle_right_grn" id="right_text">
        {if $breadcrumb_current_page.icon}
          {if $is_space}
            <div class="mobile_spaceID_breadcrumb_grn">
              <img src="{$breadcrumb_current_page.icon|escape}?{$build_date}" height="32"/>
            </div>
          {else}
            <img src="{$breadcrumb_current_page.icon|escape}?{$build_date}" class="ui-li-icon mobile-icon-big-grn" height="22"/>
          {/if}
        {elseif $breadcrumb_current_page.app_id}
          <span class="mobile_icon_breadcrumb_grn mobile_app_{$breadcrumb_current_page.app_id|escape}_s_b_grn"></span>
        {/if}
        {$breadcrumb_current_page.name|escape}
      </div>
      {if $page_up_down}
        <div id="right_include" class="mobile_updown_div_grn">
          <a href="{if $page_up_down.up_disable}javascript:void(0);{else}{grn_pageurl page=$page_up_down.page params=$page_up_down.up_params}{/if}" class="{if $page_up_down.up_disable}mobile_base_disable_grn{/if} mobile_page_up_grn"></a>
          <a href="{if $page_up_down.down_disable}javascript:void(0);{else}{grn_pageurl page=$page_up_down.page params=$page_up_down.down_params}{/if}" class="{if $page_up_down.down_disable}mobile_base_disable_grn{/if} mobile_page_down_grn"></a>
        </div>
      {elseif $select_menu_include_file}
        <div id="right_include" class="mobile_select_area_div_grn">
          {include file=$select_menu_include_file}
        </div>
      {elseif $right_include_file}
        {include file=$right_include_file div_id='right_include'}
      {/if}
    {/strip}
  </div>
{/if}
