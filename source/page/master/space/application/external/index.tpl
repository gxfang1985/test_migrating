<div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item">
            <nobr>
                <a href="{$this_getApplication->getOriginalViewURL()|escape}" target="_blank" class="icon-blank-grn">{cb_msg module="grn.space" key="external-1" replace="true"}</a>
            </nobr>
        </span>
        <span class="menu_item">
            <nobr>
                <a href="{$this_getApplication->getMaintenanceViewURL()|escape}" target="_blank" class="icon-setting-grn">{cb_msg module="grn.space" key="external-2" replace="true"}</a>
            </nobr>
        </span>
    </div>
</div>

<iframe id="external-app-iframe" src="{$this_getApplication->getViewURL()|escape}"
        style="height:500px; width:100%; margin:0; padding:0; border:0;"></iframe>
{* 500px of iframe height is enough to show kintone error pages.*}

{grn_load_javascript file="grn/html/page/space/application/iframe_height.js"}
