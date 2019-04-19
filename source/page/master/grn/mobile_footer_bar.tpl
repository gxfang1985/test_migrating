{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="footer" data-position="fixed" data-tap-toggle="false" data-theme="{$data_theme}" id="mobile_footer">
    <div data-role="navbar" class="mobile_navbar_grn" id="mobile_footer_bar">
        <ul>
            {if $footer_bar|@count >= 1}
                {foreach from=$footer_bar item=item}
                    {if $item.name == 'nobar'}
                        <li></li>
                    {else}
                        {strip}
                        <li class="mobile_navbar_{$item.name|escape}_grn">
                            <a id="footer_bar_{$item.name|escape}" href="{if 'appmenu' == $item.class}#appmenu{elseif $item.page}{grn_pageurl page=$item.page params=$item.params}{else}javascript:void(0);{/if}" class="mobile_navbar_icon_{$item.name|escape}_grn mobile_icon_tool_{$item.class|escape}_grn">
                                {if 'notify' == $item.class}
                                    <div class="mobile_nitify_sum_position_grn">
                                        {grn_get_notify_num_for_mobile_view mid='notification'}
                                    </div>
                                {elseif 'menu' == $item.class || 'appmenu' == $item.class}
                                    <div class="mobile_triangle_{$item.name|escape}_grn"></div>
                                {/if}
                            </a>
                            <div class="mobile_bg_grn"></div>
                        </li>
                        {/strip}
                    {/if}
                {/foreach}
            {else}
                <li></li>
            {/if}
        </ul>
    </div><!-- navbar --> 
    {include file='grn/mobile_operate_bar.tpl'}
</div>
