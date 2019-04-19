<div class="tab_menu">
    <div class="tab">
        <span class="tab_left_on"></span>
        <span class="tab_on">
            {capture name='grn_personal_GRN_PRS_1'}{cb_msg module='grn.personal' key='GRN_PRS-1' replace='true'}{/capture}
            {grn_link page='personal/common_list' image='adminbasic20.gif' caption=$smarty.capture.grn_personal_GRN_PRS_1 disabled=yes element_id="personal_common_list"}
        </span>
        <span class="tab_right_on"></span>
    </div>
    <div class="tab">
        <span class="tab_left_off"></span>
        <span class="tab_off">
            {capture name='grn_personal_GRN_PRS_2'}{cb_msg module='grn.personal' key='GRN_PRS-2' replace='true'}{/capture}
            {grn_link page='personal/application_list' app_id='' image='function20.gif' caption=$smarty.capture.grn_personal_GRN_PRS_2 element_id="personal_application_list"}
        </span>
        <span class="tab_right_off"></span>
    </div>
</div>

<div class="tab_menu_end">
    <div class="tab_menu_end_bg">&nbsp;</div>
</div>

<table class="multicol" width="100%">
    <tr valign="top">
        <td class="naviColumn" width="30%">
            <ul class="naviColumn_item_area_grn">
                {foreach from=$logic_list item=logic}
                    {if $logic.selected}
                        <li><span id="{$logic.id|escape}" class="hilight bold_grn">{$logic.name|escape}</span></li>
                    {else}
                        <li><a id="{$logic.id|escape}" href="{grn_pageurl page='personal/common_list' id=$logic.id}">{$logic.name|escape}</a></li>
                    {/if}
                {/foreach}
            </ul>
        </td>
        <td>&nbsp;</td>
        <td width="70%">
            {if ! $selected}
                <div class="explanation">{cb_msg module='grn.personal' key='GRN_PRS-3' replace='true'}</div>
            {else}
                {foreach from=$config_data item=category}
                    {if $category.name}
                        <div class="entry_on">
                            <div class="subtitle">{$category.name|escape}</div>
                    {else}
                        <div class="entry_off">
                    {/if}
                            <div class="admin_icons">
                                <ul>
                                    {foreach from=$category.items item=item}
                                        <li><a id="{$item.page}" href="{grn_pageurl page=$item.page params=$item.url_params}" title="{$item.name|escape}">{grn_image image=`$item.icon`.gif}<br>{$item.name|escape}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                {/foreach}
            {/if}
        </td>
    </tr>
</table>
