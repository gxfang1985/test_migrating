<div class="portlet_parts_area_grn">
    {grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
    {grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
    <dl id="portel_filter_pulldown_menu" class="selectmenu_grn selectmenu_style1_grn selectmenu_base_grn">
        <dt>{strip}
            <a id="portlet_filter" href="javascript:void(0)" class="nowrap-grn">
                <span></span>
                <span class="portlet_parts_area_pulldown_grn pulldown_head">{$portlet_filter.all}</span>
                <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                <input type='hidden' name='pulldown_head' value=''>
            </a>
        </dt>{/strip}
        <dd>
            <div class="pulldown_menu_grn" style="display: none;">
                <ul>
                {foreach from=$portlet_filter key=key item=item name=filter}
                    {strip}
                    <li>
                        <a href="javascript:void(0)">
                            <span class="vAlignMiddle-grn">{$item}</span>
                            <input type="hidden" value="{$key}">
                        </a>
                    </li>
                    {/strip}
                {/foreach}
                </ul>
            </div>
        </dd>
    </dl>
    <div class="portlet_parts_list_base_grn">
        <ul>
        {foreach from=$portlet_list key=key item=item name=portlet}
            {strip}
            <li class="portlet_parts_list_grn {$item.type}">
                <span class="portlet_parts_trigger_grn" id="draggable_portlet_parts_{$key}">
                    <span class="icon_{$item.class}_grn icon_inline_grn"></span>
                    <span>{$item.title}</span>
                </span>
            </li>
            {/strip}
        {/foreach}
        </ul>
    </div>
</div>
