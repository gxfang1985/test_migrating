{if $is_breadcrumb_show}
  {grn_load_javascript file='grn/html/page/space/mobile/todo/member_select_breadcrumb.js'}
  <div class="mobile_breadcrumbtitle_grn {if ! $not_need_withList}mobile_titlebar_content_withList_grn{/if}">
    {strip}
      {if $breadcrumb_upper_page_member}
        <div class="mobile_breadcrumbtitle_left_grn" id="left_text_member">
          <a href="{grn_pageurl page=$breadcrumb_upper_page_member.page params=$breadcrumb_upper_page_member.params}">{$breadcrumb_upper_page_member.name|escape}</a>
          <span class="mobile_icon_breadcrumb_arrow_grn"></span>
        </div>
      {/if}
      <div class="mobile_breadcrumbtitle_right_grn" id="right_text_member">
        {if $breadcrumb_current_page_member.icon}
          <img src="{$breadcrumb_current_page_member.icon|escape}?{$build_date}" class="ui-li-icon mobile-icon-big-grn" height="22"/>
        {elseif $breadcrumb_current_page_member.app_id}
          <span class="mobile_icon_breadcrumb_grn mobile_app_{$breadcrumb_current_page_member.app_id|escape}_s_b_grn"></span>
        {/if}
        {$breadcrumb_current_page_member.name|escape}
      </div>
    {/strip}
  </div>
{/if}
