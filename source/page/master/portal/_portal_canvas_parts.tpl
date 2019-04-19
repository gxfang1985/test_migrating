{* set link *}
{if $mode == 'system'}
    {assign var="order_link" value="portal/system/portlet_order"}
    {assign var="add_link" value="portal/system/portlet_add"}
{elseif $mode == 'operation'}
    {assign var="order_link" value="portal/operation/portlet_order"}
    {assign var="add_link" value="portal/operation/portlet_add"}
{elseif $mode == 'personal'}
    {assign var="order_link" value="portal/personal/portlet_order"}
    {assign var="add_link" value="portal/personal/portlet_add"}
{elseif $mode == 'template'}
    {assign var="order_link" value="portal/system/base_portlet_order"}
    {assign var="add_link" value="portal/system/base_portlet_add"}
{/if}
{* set position *}
{if $position == 'top'}
    {capture name='canvas_position_name'}{cb_msg module='grn.portal' key='GRN_POT-5' replace='true'}{/capture}
{elseif $position == 'left'}
    {capture name='canvas_position_name'}{cb_msg module='grn.portal' key='GRN_POT-6' replace='true'}{/capture}
{elseif $position == 'center'}
    {capture name='canvas_position_name'}{cb_msg module='grn.portal' key='GRN_POT-7' replace='true'}{/capture}
{elseif $position == 'right'}
    {capture name='canvas_position_name'}{cb_msg module='grn.portal' key='GRN_POT-8' replace='true'}{/capture}
{/if}
{strip}
<span class="portal_canvas_block_name_grn">{$smarty.capture.canvas_position_name}</span>
{if $browser.type eq 'mobilesafari' || $browser.type eq 'android' ||$browser.screen_type eq 'touch'}
    <a href="{grn_pageurl image='order20.gif' page=$order_link pid=$portal_id position=$position}">
        <span class="icon_inline_grn icon_order_grn vAlignMiddle-grn"></span>
        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-9' replace='true'}</span>
    </a>
{/if}
{/strip}
<div class="portlet_setting_droppable_area">
    {if $browser.type eq 'mobilesafari' || $browser.type eq 'android' || $browser.screen_type eq 'touch'}
        {strip}
        <div class="mBottom15 mTop15">
            <a href="{grn_pageurl page=$add_link pid=$portal_id position=$position index=0}" class='portlet_add_link'>
                <span class="icon_inline_grn icon_add_grn vAlignMiddle-grn"></span>
                <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-10' replace='true'}</span>
            </a>
        </div>
        {/strip}
    {/if}
    {foreach from=$portlet_items key=key item=item name=$position}
        {if $item.isActive}
            {include file='portal/_portlet_row.tpl' mode=$mode item=$item}
            {if $browser.type eq 'mobilesafari' || $browser.type eq 'android' || $browser.screen_type eq 'touch'}
                {strip}
                <div class="mBottom15 mTop15">
                    <a href="{grn_pageurl page=$add_link pid=$portal_id position=$position index=$smarty.foreach.$position.iteration}" class="portlet_add_link">
                        <span class="icon_inline_grn icon_add_grn vAlignMiddle-grn"></span>
                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-10' replace='true'}</span>
                    </a>
                </div>
                {/strip}
            {/if}
        {/if}
    {/foreach}
</div>
