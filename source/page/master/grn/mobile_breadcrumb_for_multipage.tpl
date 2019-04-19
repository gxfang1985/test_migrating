{* This template is used for multipage of mobile view 
 * $back_link back to previous page
 *}

<div class="mobile_breadcrumbtitle_grn {if $page_with_list}mobile_titlebar_content_withList_grn{/if}">
  {strip}
    <div class="mobile_breadcrumbtitle_left_grn">
      <a href="#" {if !$use_callback}onclick="javascript:location.href = '#{$back_link}';"{/if}>{$upper_page|escape}</a>
      <span class="mobile_icon_breadcrumb_arrow_grn"></span>
    </div>
    <div class="mobile_breadcrumbtitle_right_grn">
        {if $icon}
          {if $is_space}
            <div class="mobile_spaceID_breadcrumb_grn">
              <img src="{$icon|escape}?{$build_date}" height="32"/>
            </div>
          {else}
            <img src="{$icon|escape}?{$build_date}" class="ui-li-icon mobile-icon-big-grn" height="22"/>
          {/if}
        {elseif $app_id}
          <span class="mobile_icon_breadcrumb_grn mobile_app_{$app_id|escape}_s_b_grn"></span>
        {/if}
        {$current_page|escape}
    </div>
  {/strip}
</div>
