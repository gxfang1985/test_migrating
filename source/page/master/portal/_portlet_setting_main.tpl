<div id="portal_setting_main_area" style="display: table;width: 100%">
    <div id="portal_setting_left_area" class="portal_setting_left_area_grn" style="display: {if $browser.type eq 'mobilesafari' || $browser.type eq 'android' || $browser.screen_type eq 'touch'}none{else}table-cell{/if};">
        {include file='portal/_portlet_parts.tpl' portlet_filter=$portlet_filter portlet_list=$portlet_list}
    </div>
    <div class="left_area_handler_grn" style="display: {if $browser.type eq 'mobilesafari' || $browser.type eq 'android' || $browser.screen_type eq 'touch'}none{else}table-cell{/if};"><div id="portal_setting_left_area_handler" class="left_area_handler_grn left_area_handler_open_grn"></div></div>
    <div id="portal_setting_right_area" class="portal_setting_right_area_grn" style="display: table-cell">
        {if $mode != 'template'}
            {include file='portal/_portal_layout_setting.tpl' csrf_ticket=$csrf_ticket fixed=$fixed portal_id=$portal_id portal_layout=$portal_layout}
        {/if}
        <div id="portal_layout_table" class="portal_canvas_grn">
            {strip}
            <div>
                <div class="portal_canvas_block_top_grn" id="top">
                    {include file="portal/_portal_canvas_parts.tpl" mode=$mode position='top' portlet_items=$column_list[0]}
                </div>
            </div>
            <table border="0" bordercolor="#c9c9c9" cellspacing="0" cellpadding="8" width="100%" class="portal_layout_table_grn">
                <tr>
                    <td class="portal_canvas_block_grn" id="left" style="width: {if $fixed == 1 && $mode != 'template'}{$portal_layout[1]}{else}33{/if}%">
                        {include file="portal/_portal_canvas_parts.tpl" mode=$mode position='left' portlet_items=$column_list[1]}
                    </td>
                    {if $mode == 'template' || $fixed == 0 || ($fixed == 1 && $portal_layout[2] > 0)}
                        <td class="portal_canvas_block_grn" id="center" style="width: {if $fixed == 1 && $mode != 'template'}{$portal_layout[2]}{else}33{/if}%">
                            {include file="portal/_portal_canvas_parts.tpl" mode=$mode position='center' portlet_items=$column_list[2]}
                        </td>
                    {/if}
                    {if $mode == 'template' || $fixed == 0 || ($fixed == 1 && $portal_layout[3] > 0)}
                        <td class="portal_canvas_block_grn" id="right" style="width: {if $fixed == 1 && $mode != 'template'}{$portal_layout[3]}{else}33{/if}%">
                            {include file="portal/_portal_canvas_parts.tpl" mode=$mode position='right' portlet_items=$column_list[3]}
                        </td>
                    {/if}
                </tr>
            </table>
            {/strip}
        </div>
    </div>
</div>