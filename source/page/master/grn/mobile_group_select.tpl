{**
 * Mobile Group Tree View
 *
 * Parameters:
 * [group_tree] =>  [tree_name],                    ID of tree
 *                  [async_url],        REQUIRE     URL to retrieve children nodes
 *                  [oid_key],                      Name of URL parameter used for node. Default: 'oid'
 *                  [root_caption],                 Caption of root node. Default: '（ルート）'
 *                  [no_root],                      Specify TRUE to hide root node. Default: 'FALSE'
 *                  [root],             REQUIRE     $tree->getRoot()
 *
 *}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="group_tree_id" value=$group_tree.tree_name|default:"group_tree"}
{grn_load_css file="grn/html/mobile_groupselect.css"}
{grn_load_javascript file="grn/html/component/mobile_group_select.js"}

<div data-role="page" id="_popup_{$group_tree_id}">
  <div data-role="content" data-theme="c" class="mobile-content-withList-grn">
      {if $facility}
        {capture name='group_select'}{cb_msg module='grn.mobile' key='GRN_MOBILE-21' replace='true'}{/capture}
      {elseif $multi_selected_group eq "true"}
        {capture name='group_select'}{cb_msg module='grn.mobile' key='GRN_MOBILE-23' replace='true'}{/capture}
      {elseif $multi_selected_role eq "true"}
        {capture name='group_select'}{cb_msg module='grn.mobile' key='GRN_MOBILE-23' replace='true'}{/capture}
      {else}
        {capture name='group_select'}{cb_msg module='grn.mobile' key='GRN_MOBILE-13' replace='true'}{/capture}
      {/if}
  {include file="grn/mobile_breadcrumb_for_multipage.tpl" upper_page=$upper_page current_page=$smarty.capture.group_select page_with_list="TRUE" back_link=$previous_page}
  {include file="grn/mobile_select_subtitle_for_multipage.tpl"}
  <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_folderlist_grn {if $multi_selected_role eq "true"}mobile_folderlist_nofolder_grn{/if}" id="{$group_tree_id}">
    {if !$group_tree.no_root}
      <li id="{$group_tree_id}_top" data-icon="false">
        <a href="#">
          {capture assign='root_folder_caption'}
            {if (! is_null($group_tree.root_caption)) && (strlen($group_tree.root_caption) > 0) }
              {$group_tree.root_caption}
            {else}
              {cb_msg module='grn.grn' key='GRN_GRN-173' replace='true'}
            {/if}
          {/capture}
          <span id="deepth_0_top" class="mobile_folderlist_text_overflow_grn">{$root_folder_caption}</span>
          <div>
            <span class="mobile_groupselect_icon_radiobuttonoff_grn"></span>
            <span class="mobile_groupselect_radiobutton_grn">
              <input name="{$radio_name|default:'group_select'}" type="radio" value="">
            </span>
          </div>
        </a>
      </li>
    {/if}
    {grn_mobile_group_select data=$group_tree radio_name=$radio_name prefix_id=$prefix_id prefix_before_value=$prefix_before_value facility=$facility user=$user allow_all_facilities=$allow_all_facilities}
  </ul>
  </div><!-- end of content-->
  <div class="mobile_button_area_fixed_grn">
    <div data-position="fixed" data-theme="c" data-tap-toggle="false" class="mobile_button_area_grn">
        <div class="mobile_ok_grn">
          <input type="submit" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-7' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
        </div>
        <div class="mobile_cancel_grn">
          <input class="cancel_button" type="reset" value="{cb_msg module='grn.mobile' key='GRN_MOBILE-8' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
        </div>
    </div>
  </div>
  {include file="grn/mobile_footer_for_multipage.tpl"}
</div>

{literal}
<script language="JavaScript" text="text/javascript">
(function(){
{/literal}
    
    var settings = {ldelim}
      asyncUrl      : '{grn_pageurl page=$group_tree.async_url}',
      paramName     : '{$group_tree.oid_key|default:"oid"}',
      treeName      : '{$group_tree_id}',
      pageName      : '{$group_tree.page_name}',
      previousPage  : '{$previous_page}',
      container     : '_popup_{$group_tree_id}',
      radio_name    : '{$radio_name}',
      prefix_id     : '{$prefix_id}',
      prefix_before_value : '{$prefix_before_value}',
      associate_value_element_back     : '{$associate_value_element_back}',
      associate_title_element_back     : '{$associate_title_element_back}'
    {rdelim};
    
{literal}
    $(document).ready(function(){
        var G = new grn.component.mobile_group_select(settings);
    });
})();
</script>
{/literal}