<div class="tab_menu">
    <div class="tab">
        <span class="tab_left_off"></span>
        <span class="tab_off">
            {capture name='grn_personal_GRN_PRS_4'}{cb_msg module='grn.personal' key='GRN_PRS-4' replace='true'}{/capture}
            {grn_link page='personal/common_list' image='adminbasic20.gif' caption=$smarty.capture.grn_personal_GRN_PRS_4 element_id="personal_common_list"}
        </span>
        <span class="tab_right_off"></span>
    </div>
    <div class="tab">
        <span class="tab_left_on"></span>
        <span class="tab_on">
            {capture name='grn_personal_GRN_PRS_5'}{cb_msg module='grn.personal' key='GRN_PRS-5' replace='true'}{/capture}
            {grn_link page='personal/application_list' image='function20.gif' caption=$smarty.capture.grn_personal_GRN_PRS_5 disabled=yes}
        </span>
        <span class="tab_right_on"></span>
    </div>
</div>

<div class="tab_menu_end">
    <div class="tab_menu_end_bg">&nbsp;</div>
</div>

<table class="multicol" width="100%">
    <tr valign="top">
        <td class="naviColumn" width="30%">
            <ul class="naviColumn_item_area_grn">
                {foreach from=$applications item=app_name key=app_id}
                    {if $app_id == $selected_app}
                        <li><span id="{$app_id|escape}" class="hilight bold_grn">{$app_name|escape}</span></li>
                    {else}
                        <li><a id="{$app_id|escape}" href="{grn_pageurl page='personal/application_list' app_id=$app_id}">{$app_name|escape}</a></li>
                    {/if}
                {/foreach}
            </ul>
        </td>
        <td>&nbsp;</td>
        <td width="70%">
            {if ! $selected_app}
                <div class="explanation">{cb_msg module='grn.personal' key='GRN_PRS-6' replace='true'}</div>
            {else}
                {foreach from=$config_data item=category_data}
                    {if $category_data.name}
                        <div class="entry_on">
                            <div class="subtitle">{$category_data.name|escape}</div>
                    {else}
                        <div class="entry_off">
                    {/if}
                            <div class="admin_icons">
                                <ul>
                                    {foreach from=$category_data.items item=item}
                                        <li><a id="{$item.page|escape}" href="{grn_pageurl page=$item.page}" title="{$item.name|escape}">{grn_image image=`$item.icon`.gif}<br>{$item.name|escape}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                {/foreach}
            {/if}
        </td>
    </tr>
</table>
