{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if $smarty.const.ON_FOREST === 1}
    {grn_hide_logout assign='hide_logout'}
{else}
    {assign var='hide_logout' value=false}
{/if}
{if !$hide_logout}{grn_mobile_logout form='form_logout' page='grn/mobile_logout.tpl' handler='mobile_logout'}{/if}
<div data-role="panel" id="appmenu" data-position="right" data-display="push" data-swipe-close="false" data-dismissible="ture" class="mobile_app_menu_grn">
    <ul id="panelUl">
        {foreach from=$application_menu key=key item=item}
            <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c"><a href="{grn_pageurl page=$item.url params=$item.params}"><span class="mobile_{$key}_grn"></span>{$item.name|escape}{grn_get_notify_num_for_mobile_view mid=$key isAppMenu=TRUE}</a></li>
        {/foreach}
        <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c {if !$hide_logout}mobile_pcview_grn{/if}"><a href="{grn_pageurl page='index'}">{cb_msg module='grn.mobile' key='pcview' replace='true'}</a></li>
        {if !$hide_logout}
            <li id="mobile_logout" data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c mobile_logout_grn">
                <a href="javascript:void(0);">{cb_msg module='grn' key='HEADER_LOGOUT' replace='true'}</a>
            </li>
        {/if}
    </ul>
    <!-- panel content goes here -->
</div><!--panel end-->
