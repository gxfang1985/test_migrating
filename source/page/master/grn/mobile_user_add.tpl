{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="grn/html/mobile_userselect.css"}
{grn_load_javascript file="grn/html/component/mobile_item_select.js"}
{grn_load_javascript file="grn/html/component/mobile_user_select.js"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{capture name='GRN_MOBILE_12'}{cb_msg module='grn.mobile' key='GRN_MOBILE-12' replace='true'}{/capture}
{capture name='GRN_MOBILE_22'}{cb_msg module='grn.mobile' key='GRN_MOBILE-22' replace='true'}{/capture}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
{/literal}
    
    var settings = {ldelim}
        element_id  : '{$sUID}',
        ajaxGetItemURL : "{grn_pageurl page='grn/ajax_get_user_for_mobile_selection'}",
        ajaxSearchItemURL : "{grn_pageurl page='grn/ajax_search_user_for_mobile_selection'}",
        args        : "access_plugin={$access_plugin_encoded}&plugin_session_name={$plugin_session_name}&app_id={$app_id}",
        include_org : '{$include_org}',
        isCalendar : '{$isCalendar}',
        show_group_role : '{$show_group_role}',
        isAllowedRole : '{$isAllowedRole}',
        src_item    : '#src_user',
        dest_item   : '#dest_user',
        type_item   : 'user',
        empty_list  : "{cb_msg module='grn.mobile' key='GRN_MOBILE-9' replace='true'}",
        none_selected : "{cb_msg module='grn.mobile' key='GRN_MOBILE-10' replace='true'}",
        search_caption: "{cb_msg module='grn.grn' key='GRN_GRN-807' replace='true'}",
        group_select_menu_id : 'category_options_{$sUID}',
        associate_id : '{$associate_id}',
        selectedItem : {$selected_users|grn_noescape},
        page_name : '{$page_name}',
        default_title_group_select : '{$smarty.capture.GRN_MOBILE_12}',
        categorySelectUI : 'user_category_{$sUID}',
        categorySelectValue : 'category_title_{$sUID}',
        popupItemCategory : 'popup_user_category_{$sUID}'
    {rdelim};
    
{literal}
    $(document).ready(function(){
        var G = new grn.component.mobile_user_select(settings);
        G.initSelectedItem();

        $(document).on("pagebeforeshow","{/literal}#_{$sUID}{literal}",function(event, data){
            G.bindEventBeforePageShow();

            if(typeof data.prevPage.attr('id') == 'undefined')
            {
                G.processing = false;
                G.saveLastState();
                G.resetSourceItemList();
                G.resetCategorySelect();
            }
        });

        $(document).on("pagebeforehide","{/literal}#_{$sUID}{literal}",function(event, data){
            if(typeof data.nextPage.attr('id') == 'undefined' && !G.adding )
            {
                G.cancel();
            }
            G.adding = false;
        });
    });

})();
</script>
{/literal}
<script id="src_user" type="text/x-template">
    <li data-icon="false" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="div" data-iconpos="right" data-theme="{$data_theme}">
        <a class="selection_item ui-btn" href="#">
            <div class="mobile_add_grn"></div>
            <div class="mobile_user_photo_grn mobile_img_userPlofile_grn"></div>
            <div class="mobile_info_grn">
                <div class="mobile_position_center_grn">
                    <div class="mobile_position_width_grn">
                        <div class="mobile_user_grn"></div>
                        <div class="mobile_text_grn"></div>
                    </div>
                </div>
            </div>
        </a>
    </li>
</script>
<script id="dest_user" type="text/x-template">
    <li data-icon="false" class="mobile_selected_grn" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="div" data-iconpos="right" data-theme="{$data_theme}">
        <div class="mobile_delete_grn"></div>
        <a class="selection_item ui-btn" href="#">
            <div class="mobile_user_photo_grn mobile_img_userPlofile_grn"></div>
            <div class="mobile_info_grn">
                <div class="mobile_position_center_grn">
                    <div class="mobile_position_width_grn">
                        <div class="mobile_user_grn"></div>
                        <div class="mobile_text_grn"></div>
                    </div>
                </div>
            </div>
            <span></span>
        </a>
    </li>
</script>
<div data-role="page" id="_{$sUID}">
  <div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
      {include file="grn/mobile_breadcrumb_for_multipage.tpl" upper_page=$upper_page current_page=$currnet_page_name page_with_list="TRUE" use_callback="TRUE"}
      <div class="mobile_seletedUser_list_grn">
        <form action="#">
        <div class="mobile_user_search_grn">
          <input id="search_user" class="search_item" type="search" name="search_user_{$sUID}" placeholder="{cb_msg module='grn.mobile' key='GRN_MOBILE-2' replace='true'}"/>
          <a href="#" class="mobile_delete_icon_grn delete_input"></a>
          <a href="#" class="mobile_icon_grn search_item_icon"></a>
        </div>
        </form>
      </div>
      <div class="mobile_user_group_grn">
        <a id="user_category_{$sUID}" href="#popup_user_category_{$sUID}" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
          <span class="mobile_event_menu_content_grn">{$smarty.capture.GRN_MOBILE_12}</span>
          <span class="mobile_select_icon_grn"></span>
        </a>
        <a class="ui-link-inherit" href="#_popup_{$user_categories_tree.tree_name}">
          <div class="mobile_group_icon_grn"></div>
        </a>
        <input type="hidden" value="" id="category_options_{$sUID}">
        <input type="hidden" value="" id="category_title_{$sUID}">
        {include file="grn/mobile_select_menu.tpl"
        select_items=$category_menu
        selectMenuUI='user_category_'|cat:$sUID
        selectMenuValue='category_options_'|cat:$sUID
        popupMenu='popup_user_category_'|cat:$sUID
        selected_value=$smarty.capture.GRN_MOBILE_12
        expandMenuSelect='category_title_'|cat:$sUID
        selectMenuTitle=$smarty.capture.GRN_MOBILE_22
        }
      </div>
      <div class="mobile_user_label_area_grn">
         <span class="mobile-label-grn">{if $associate_id eq 'default_public'}{cb_msg module='grn.mobile' key='GRN_MOBILE-15' replace='true'}{else}{cb_msg module='grn.mobile' key='GRN_MOBILE-3' replace='true'}{/if}</span>
         <a class="add_all_to_selected_list mobile-label-grn" href="#">{cb_msg module='grn.mobile' key='GRN_MOBILE-4' replace='true'}</a>
      </div>
      <div class="mobile_user_list_scroll_grn {if count($users_info) == 0}mobile-user-list-none-grn{/if}">
        <div class="mobile_list_shadow_grn"></div>
        <div class="mobile_icon_grn">
          <div class="mobile_icon_up_grn"></div>
          <div class="mobile_icon_down_grn"></div>
        </div>
        <ul data-role="listview" data-theme="{$data_theme}" class="source_items mobile-ul-top-grn mobile-ul-bottom-grn mobile_user_list_grn">
          <li data-icon="false" class="mobile_base_disable_grn">{cb_msg module='grn.mobile' key='GRN_MOBILE-9' replace='true'}</li>
        </ul>
      </div><!--mobile_user_list_scroll_grn-->
      <div class="mobile_user_label_area_grn">
         <span class="mobile-label-grn">{cb_msg module='grn.mobile' key='GRN_MOBILE-5' replace='true'}</span>
         <a class="remove_all_from_selected_list mobile-label-grn" href="#" {if count($users_info) == 0}style="display:none;"{/if}>{cb_msg module='grn.mobile' key='GRN_MOBILE-6' replace='true'}</a>
      </div>
      <div class="mobile_user_list_scroll_grn">
        <div class="mobile_list_shadow_grn"></div>
        <div class="order_selected_list mobile_order_icon_grn">
          <div class="mobile_order_control_grn order_top">
            <div class="mobile_order_top_grn"></div>
          </div>
          <div class="mobile_order_control_grn order_up">
            <div class="mobile_order_up_grn"></div>
          </div>
          <div class="mobile_order_control_grn order_down">
            <div class="mobile_order_down_grn"></div>
          </div>
          <div class="mobile_order_control_grn order_bottom">
            <div class="mobile_order_bottom_grn"></div>
          </div>
        </div>
      <ul data-role="listview" data-theme="{$data_theme}" class="selected_items mobile-ul-top-grn mobile-ul-bottom-grn mobile_user_list_grn">
      </ul>
      </div><!--mobile_user_list_scroll_grn-->
      <div data-theme="{$data_theme}" class="mobile_button_area_grn">
          <div class="mobile_ok_grn">
            <input type="submit" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-7' replace='true'}" data-inline="true" data-theme="{$data_theme}" />
          </div>
          <div class="mobile_cancel_grn">
            <input type="reset" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-8' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
          </div>
      </div>
      <input type="hidden" id="selected_groups_{$sUID}" name="selected_groups_{$sUID}[]" value="">
      <input type="hidden" id="selected_users_{$sUID}" name="selected_users_{$sUID}[]" value="">
  </div>
    {include file="grn/mobile_footer_for_multipage.tpl"}
</div>

{include file='grn/mobile_group_select.tpl'
  group_tree=$user_categories_tree
  radio_name='user_group_select'
  previous_page='_'|cat:$sUID
  associate_value_element_back='category_options_'|cat:$sUID
  associate_title_element_back='category_title_'|cat:$sUID
  prefix_id=$sUID|replace:'_':'-'
  prefix_before_value='g'
  user=true
  upper_page=$currnet_page_name
  include_role=$popup_include_role
  multi_selected_group=$popup_include_role
  multi_selected_role=FALSE
  sUID=$sUID
}

{if $popup_include_role}
    {include file='grn/mobile_group_select.tpl'
      group_tree=$role_categories_tree
      radio_name='role_group_select'
      previous_page='_'|cat:$sUID
      associate_value_element_back='category_options_'|cat:$sUID
      associate_title_element_back='category_title_'|cat:$sUID
      prefix_id=$sUID|replace:'_':'-'
      prefix_before_value='r'
      user=false
      upper_page=$currnet_page_name
      include_role=$popup_include_role
      multi_selected_group=FALSE
      multi_selected_role=$popup_include_role
      sUID=$sUID
    }
{/if}
