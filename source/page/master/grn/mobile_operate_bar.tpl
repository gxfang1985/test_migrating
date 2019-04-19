{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div class="mobile_navbar_menu_grn" id="operate_menu">
    <ul class="mobile_scroll_area_grn">
        {foreach from=$operate_menu key=key item=item}
            <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$item.page params=$item.params}" onclick="javascript:grn.component.mobile_appmenu.closeOperateMenu('operate_menu');">{$item.name|escape}</a></li>
        {/foreach}
    </ul>
    <ul><li class="mobile_refresh_grn"><a href="#" onclick="javascript:grn.component.mobile_appmenu.mobile_reload();"><span></span>{cb_msg module='grn.mobile' key='refresh' replace='true'}</a></li></ul>
</div><!--navbar menu-->