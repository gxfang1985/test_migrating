{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="tab_menu">
    <div class="tab">
        <span class="tab_left_on"></span>
        <span class="tab_on">{capture name='grn_system_GRN_SY_1'}{cb_msg module='grn.system' key='GRN_SY-1' replace='true'}{/capture}{grn_link image='inform20.gif' page='system/index' caption=$smarty.capture.grn_system_GRN_SY_1 disabled=yes element_id="system-index"}</span>
        <span class="tab_right_on"></span>
    </div>
    <div class="tab">
        <span class="tab_left_off"></span>
        <span class="tab_off">{capture name='grn_system_GRN_SY_2'}{cb_msg module='grn.system' key='GRN_SY-2' replace='true'}{/capture}{grn_link image='adminbasic20.gif' page='system/common_list' caption=$smarty.capture.grn_system_GRN_SY_2 element_id="system-common-list"}</span>
        <span class="tab_right_off"></span>
    </div>
    <div class="tab">
        <span class="tab_left_off"></span>
        <span class="tab_off">{capture name='grn_system_GRN_SY_3'}{cb_msg module='grn.system' key='GRN_SY-3' replace='true'}{/capture}{grn_link image='function20.gif' page='system/application_list' app_id='' caption=$smarty.capture.grn_system_GRN_SY_3 element_id="system-application-list"}</span>
        <span class="tab_right_off"></span>
    </div>
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>

<table class="multicol" width="100%">
    <tr valign="top">
        <td class="naviColumn" width="30%">
            <ul class="naviColumn_item_area_grn">
                {foreach from=$list item=logic}
                    {if $logic.id == $menu}
                        <li><span class="hilight bold_grn">{$logic.name|escape}</span></li>
                    {else}
                        <li><a href="{grn_pageurl page='system/index' id=$logic.id}">{$logic.name|escape}</a></li>
                    {/if}
                {/foreach}
            </ul>
        </td>
        <td>&nbsp;</td>
        <td width="70%">
            {$contents|grn_noescape}
        </td>
    </tr>
</table>
{include file="grn/system_footer.tpl"}
