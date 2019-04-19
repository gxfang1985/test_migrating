{**
 *  select menu for mobile view
 *  Nguyen Huynh Long
 *  2014/02/14
 *
 *  @param      selectMenuTitle   title of select menu, if do not set, use the select target
 *  @param      select_items      data for display in select menu
 *  @param      selectMenuUI      id of element display title same as select menu of browser
 *  @param      selectMenuValue   id of hidden element store value as option selected of select menu of browser
 *  @param      popupMenu         id of popup - stimulate as select menu on mobile view
 *  @param      name_value        key of value will be set in data-value attribute - as value of option in select menu. Default: 'value'
 *  @param      name_title        key of title. Default: 'title'
 *  @param      name_color        key of color. Default: 'color'
 *  @param      use_menu_color    determine using menu color or not
 *  @param      default_title     display as default option, it has not value
 *  @param      previous_page     return to previous screen after select item or tap to close select menu
 *  @param      selected_value    value of item that is selected - use for init select menu with selected item
 *  @param      expandMenuSelect  optional: id of element in case need to add more item to select menu (JS will get value of selectMenuValue for value of new item and value of expandMenuSelect for title of new item)
    Ex:
 *    <a id="selectMenuUI" href="#popupMenu" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
 *       <span class="mobile_event_menu_content_grn">----------</span>
 *       <span class="mobile_select_icon_grn"></span>
 *    </a>
 *    <input type="hidden" value="" name="menu" id="selectMenuValue">
      <input type="hidden" value="" id="expandMenuSelect">
      {include file="grn/mobile_select_menu.tpl"
        selectMenuTitle=$selectMenuTitle
        select_items=$select_items
        selectMenuUI='selectMenuUI'
        selectMenuValue='selectMenuValue'
        popupMenu='popupMenu'
        default_title='--------------------'
        use_menu_color='true'
        selected_value=$selected_value
        }
 *  Add event "change" for "selectMenuValue" element instead of select menu of browser
 *  Note: include file grn/mobile_select_menu.tpl after link a like example
 *  This select menu using popup of jquery mobile
 *
 *}

{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/mobile_select_menu.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
{/literal}

    var settings = {ldelim}
        selectMenu       : '#{$selectMenuUI}',
        selectMenuValue  : '#{$selectMenuValue}',
        container        : '#{$popupMenu}',
        selectedValue    : '{$selected_value|escape|escape:javascript}',
        expandMenuSelect : '#{$expandMenuSelect}',
        selectMenuTitle  : '{$selectMenuTitle}',
        useMenuColor     : '{$use_menu_color}',
        defaultTitle     : '{$default_title}',
        name             : 'mobileSelectMenu_{$popupMenu}'
    {rdelim};

{literal}
    $(document).ready(function(){
        var G = new grn.component.mobile_select_menu(settings);
        G.initSize =false;

        $(document).on("popupbeforeposition","{/literal}#{$popupMenu}{literal}",function(event){
            if(!G.initSize || G.needResize)
            {
                G.setSizeSelectMenu(event);
                G.initSize = true;
            }
        });

        $('{/literal}#{$popupMenu}{literal}').on('click',function(event){
            G.setSizeSelectMenu(event);
        });

        $( window ).on( "resize", function( event ) {
            var popup = $('{/literal}#{$popupMenu}{literal}');
            if(popup.is(':visible'))
            {
                G.setSizeSelectMenu(event);
            }
        });
    });

})();
</script>
{/literal}
<div data-role="popup" id="{$popupMenu}" data-corners="false" data-overlay-theme="b" data-shadow="false">
  <div class="mobile_select_menu_titlebar_div_grn">
    <div class="mobile_titlebar_grn">
      <span class="mobile_text_grn">{$selectMenuTitle}</span>
      <a href="#" class="mobile_titlebar_right_grn mobile_colse_icon_grn"></a>
    </div>
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile_ul_grn select_menu_list">
      {if strlen($default_title) > 0}
          <li data-icon="false" class="mobile_list_grn {if $use_menu_color}mobile_event_list_grn{/if}">
            <span class="mobile_select_item"></span>
            <a href="#" class="selection_item" data-value="">{$default_title}</a>
          </li>
      {/if}
      {foreach from=$select_items item=select}
        {if $select.is_category}
          <li data-icon="false" class="mobile_list_grn mobile_list_category_grn"><span>{$select.$name_title|default:$select.title|escape}</span></li>
        {else}
          <li data-icon="false" class="mobile_list_grn {if $use_menu_color}mobile_event_list_grn{/if}">
              <span class="mobile_select_item {if $selected_value == $select.$name_value|default:$select.value}mobile_check_grn{/if}"></span>
              {if $use_menu_color}
                  {if $select.$name_color|default:$select.color !== FALSE && $select.$name_color|default:$select.color !== '' && ! is_null( $select.$name_color|default:$select.color )}
                    {if $select.$name_color|default:$select.color != '0'}
                        <span class="mobile_event_menu_grn mobile_event_menu_color{$select.$name_color|default:$select.color}_grn"></span>
                    {else}
                        <span class="mobile_event_menu_grn mobile_event_menu_color_none_grn"></span>
                    {/if}
                  {/if}
              {/if}
              <a href="#" class="selection_item" data-value="{$select.$name_value|default:$select.value|escape}">{$select.$name_title|default:$select.title|escape}</a>
          </li>
        {/if}
      {/foreach}
      {* last line empty *}
      <li data-icon="false" class="mobile_list_grn mobile_select_menu_last_item_grn">
            <span class="mobile_select_item"></span>
            <a href="#" data-value="">&nbsp</a>
          </li>
    </ul>
    <div class="mobile_select_button_area_grn">
      <div class="mobile_cancel_grn">
      <input class="cancel_button" type="reset" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-14' replace='true'}" data-inline="true" data-theme="{$data_theme}"/></div>
    </div>
  </div>
</div>
