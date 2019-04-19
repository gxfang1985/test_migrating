{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="grn/html/mobile_userselect.css"}
{grn_load_javascript file="grn/html/component/mobile_item_select.js"}
{grn_load_javascript file="grn/html/component/mobile_facility_select.js"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{capture name='GRN_SCH_MOBILE_20'}{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-20' replace='true'}{/capture}
{capture name='GRN_MOBILE_22'}{cb_msg module='grn.mobile' key='GRN_MOBILE-22' replace='true'}{/capture}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
{/literal}
    
    var settings = {ldelim}
        element_id  : 'sITEM',
        ajaxGetItemURL : "{grn_pageurl page='schedule/mobile/ajax/accessible_facility'}",
        ajaxSearchItemURL : "{grn_pageurl page='schedule/mobile/ajax/search_facility'}",
        src_item    : '#src_facility',
        dest_item   : '#dest_facility',
        type_item   : 'facility',
        empty_list  : "{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-8' replace='true'}",
        none_selected : "{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-9' replace='true'}",
        search_caption: "{cb_msg module='grn.grn' key='GRN_GRN-807' replace='true'}",
        group_select_menu_id : 'facility_category_options_sITEM',
        associate_id : 'facilities',
        selectedItem : {$selected_facility|grn_noescape},
        page_name : '{$page_name}',
        default_title_group_select : '{$smarty.capture.GRN_SCH_MOBILE_20}',
        categorySelectUI : 'facility_category_sITEM',
        categorySelectValue : 'facility_category_title_sITEM',
        popupItemCategory : 'popup_facility_category_sITEM',
        defaultUsingPurpose : "{$schedule_event.usingPurposeValue|escape:javascript}",
        keepUsingPurpose : "{$keepUsingPurpose}",
    {rdelim};

{literal}
    $(document).ready(function(){
        var G = new grn.component.mobile_facility_select(settings);
        G.initSelectedItem();
        G.toggleUsingPurposeElement();

        $(document).on("pagebeforeshow","#_sITEM",function(event, data){
            G.bindEventBeforePageShow();

            if(typeof data.prevPage.attr('id') == 'undefined')
            {
                G.processing = false;
                G.saveLastState();
                G.resetSourceItemList();
                G.resetCategorySelect();
            }
        });

        $(document).on("pagebeforehide","#_sITEM",function(event, data){
            G.toggleUsingPurposeElement();
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
<script id="src_facility" type="text/x-template">
    <li data-icon="false" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="div" data-iconpos="right" data-theme="{$data_theme}">
        <a class="selection_item ui-btn" href="#">
            <div class="mobile_add_grn"></div>
            <div class="mobile_user_photo_grn mobile_img_facilityPlofile_grn"></div>
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
<script id="dest_facility" type="text/x-template">
    <li data-icon="false" class="mobile_selected_grn" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="div" data-iconpos="right" data-theme="{$data_theme}">
        <div class="mobile_delete_grn"></div>
        <a class="selection_item ui-btn" href="#">
            <div class="mobile_user_photo_grn mobile_img_facilityPlofile_grn"></div>
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
<div data-role="page" id="_sITEM">
  <div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
      {capture name='facility'}{cb_msg module='grn.schedule' key='GRN_SCH-146' replace='true'}{/capture}
      {include file="grn/mobile_breadcrumb_for_multipage.tpl" upper_page=$upper_page current_page=$smarty.capture.facility page_with_list="TRUE" use_callback="TRUE"}
      <div class="mobile_seletedUser_list_grn">
      <form action="#">
        <div class="mobile_user_search_grn">
          <input id="search_facility" class="search_item" type="search" name="search_facility" placeholder="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-1' replace='true'}"/>
          <a href="" class="mobile_delete_icon_grn delete_input"></a>
          <a href="#" class="mobile_icon_grn search_item_icon"></a>
        </div>
      </form>
      </div>
      <div class="mobile_user_group_grn">
          <a id="facility_category_sITEM" href="#popup_facility_category_sITEM" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
              <span class="mobile_event_menu_content_grn">{$smarty.capture.GRN_SCH_MOBILE_20}</span>
              <span class="mobile_select_icon_grn"></span>
          </a>
          <a class="ui-link-inherit" href="#_popup_{$facility_categories_tree.tree_name}">
              <div class="mobile_group_icon_grn"></div>
          </a>
          <input type="hidden" value="" id="facility_category_options_sITEM">
          <input type="hidden" value="" id="facility_category_title_sITEM">
          {include file="grn/mobile_select_menu.tpl"
          select_items=$fgroup_list
          selectMenuUI='facility_category_sITEM'
          selectMenuValue='facility_category_options_sITEM'
          popupMenu='popup_facility_category_sITEM'
          name_value='oid'
          name_title='name'
          selected_value=$smarty.capture.GRN_SCH_MOBILE_20
          expandMenuSelect='facility_category_title_sITEM'
          selectMenuTitle=$smarty.capture.GRN_MOBILE_22
          }
      </div>
      <div class="mobile_user_label_area_grn">
         <span class="mobile-label-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-2' replace='true'}</span>
         <a class="add_all_to_selected_list mobile-label-grn" href="#">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-3' replace='true'}</a>
      </div>
      <div class="mobile_user_list_scroll_grn {if count($users_info) == 0}mobile-user-list-none-grn{/if}">
        <div class="mobile_list_shadow_grn"></div>
        <div class="mobile_icon_grn">
          <div class="mobile_icon_up_grn"></div>
          <div class="mobile_icon_down_grn"></div>
        </div>
        <ul data-role="listview" data-theme="{$data_theme}" class="source_items mobile-ul-top-grn mobile-ul-bottom-grn mobile_user_list_grn">
          <li data-icon="false" class="mobile_base_disable_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-8' replace='true'}</li>
        </ul>
      </div><!--mobile_user_list_scroll_grn-->
      <div class="mobile_user_label_area_grn">
         <span class="mobile-label-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-4' replace='true'}</span>
         <a class="remove_all_from_selected_list mobile-label-grn" href="#" {if count($users_info) == 0}style="display:none;"{/if}>{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-5' replace='true'}</a>
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
           <input type="submit" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-6' replace='true'}" data-inline="true" data-theme="{$data_theme}" /></div>
         <div class="mobile_cancel_grn">
         <input type="reset" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-7' replace='true'}" data-inline="true" data-theme="{$data_theme}" data-disabled="false"/></div>
      </div>
      <input type="hidden" id="sITEM" name="sITEM[]" value="">
      <input type="hidden" id="checkrepeat" name="checkrepeat" value="">
      <input type="hidden" id="approval" name="approval" value="">
  </div>
    {include file="grn/mobile_footer_for_multipage.tpl"}
</div>

{include file='grn/mobile_group_select.tpl'
  group_tree=$facility_categories_tree
  radio_name='facility_group_select'
  previous_page='_sITEM'
  associate_value_element_back='facility_category_options_sITEM'
  associate_title_element_back='facility_category_title_sITEM'
  facility=true
  allow_all_facilities=$allow_all_facilities
  upper_page=$smarty.capture.facility
}
