{grn_load_javascript file="grn/html/component/tree_item.js"}
{grn_load_javascript file="grn/html/component/weather_location.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.location_tree.LocationTree("{$location_tree_id}");
    //-->
</script>
<div id="{$location_tree_id}" aria-labelledby="weather_forecast_label" class="tree_style2_grn" >
    <ul role="tree" class="tree_first_item_grn">
        {foreach from=$location_tree key=region_key item=region}
            <li id="region_{$region_key}" role="treeitem" class="tree_first_item_grn treeitem region_item" tabindex="0">
                {if $region.checked}
                    <span class="action_text_grn cursor_pointer_grn has_popup_tree_label" aria-haspopup="true" aria-expanded="true" aria-label="{$region.name}">
                        <span class="icon_inline_grn icon_arrow_open_grn arrow_icon"></span>
                        <span id="region_{$region_key}_label" class="region_name">{$region.name}</span>
                    </span>
                {else}
                    <span class="action_text_grn cursor_pointer_grn has_popup_tree_label" aria-haspopup="true" aria-expanded="false" aria-label="{$region.name}">
                        <span class="icon_inline_grn icon_arrow_close_grn arrow_icon"></span>
                        <span id="region_{$region_key}_label" class="region_name">{$region.name}</span>
                    </span>
                {/if}
                <ul role="group" class="weather_point_area_base_grn"
                    {if !$region.checked}style="display: none"{/if}>
                    {foreach from=$region.prefectures key=prefecture_key item=prefecture }
                        <li id="prefecture_{$region_key}_{$prefecture_key}" role="treeitem" class="treeitem prefecture_item" tabindex="-1">
                            <span class="weather_point_area_grn text_color_sub_grn">{$prefecture.name}</span>
                            <span class="weather_point_area_separator_grn"></span>
                            <ul role="group" class="inline_block_grn">
                                {foreach from=$prefecture.points item=point}
                                    {capture name='check_box_id'}{$point.code}{/capture}
                                    <li id="point_{$point.code}" class="inline_block_grn li_point">
                                        <span class="weather_point_grn">
                                            <span role="checkbox" class="checkbox_base_grn treeitem point_item"
                                                  tabindex="-1" aria-checked="{$point.checked}">
                                                {grn_checkbox name='weather_location_list[]' id=$smarty.capture.check_box_id  value=$smarty.capture.check_box_id caption=$point.name checked=$point.checked }
                                            </span>
                                        </span>
                                    </li>
                                {/foreach}
                            </ul>
                        </li>
                    {/foreach}
                </ul>
            </li>
        {/foreach}
    </ul>
</div>
