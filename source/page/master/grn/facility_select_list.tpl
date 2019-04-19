{grn_load_javascript file="grn/html/component/member_select_list.js"}
<div class="selectlist_base_grn">
    <div id="selectlist_base_{$list_name}" aria-multiselectable="true" class="selectlist_grn {$div_class_name}"
         style="{$style}" tabindex="0">
        <span id="spinner_{$list_name}"
              style="display:none;position:absolute;">{grn_image image='spinner.gif' style="display:none"}</span>
        <ul id="ul_{$list_name}">
            {foreach from=$selected_item_options item=item}
                {capture name="member_id"}{$list_name}_member_facility_{$item.id}{/capture}
                <li id="{$smarty.capture.member_id}" class="{$list_name}"
                    data-value="{$item.id}" data-approval="{$item.approval}" data-repeat="{$item.repeat}" data-ancestors="{$item.ancestors}" data-code="{$item.code}" data-name="{$item.name}">
                    <span class="selectlist_facility_grn"></span>
                    <span class="selectlist_text2_grn">{$item.displayName|escape}</span>
                </li>
            {/foreach}
        </ul>
    </div>
</div>

{if $select_all or $view_detail}
    <div class="textSub-grn mTop5">
        {if $select_all}
            <a id="select_all_{$list_name}" class="mRight20"
               href="javascript:void(0);">{cb_msg module='grn.grn' key='GRN_GRN-1569' replace='true'}</a>
            <a id="un_select_all_{$list_name}" style="display:none" class="mRight20"
               href="javascript:void(0);">{cb_msg module='grn.grn' key='GRN_GRN-1570' replace='true'}</a>
        {/if}
        {if $view_detail}
            {capture name='grn_schedule_GRN_SCH_814'}{cb_msg module='grn.schedule' key='GRN_SCH-814' replace='true'}{/capture}{grn_popup_facility_list_link caption=$smarty.capture.grn_schedule_GRN_SCH_814 list_name='cITEM' form_name=$form_name var_CID='cITEM' system_display=false duplication=$duplication}
        {/if}
    </div>
{/if}
{if $is_view_facility_path}
<table cellspacing="0" cellpadding="0" border="0" {if ! $show_affiliation_group}style="display:none;"{/if}
       class="facility_group_path" id="facility-group">
    <tbody>
    <tr valign="top">
        <td nowrap="">{cb_msg module='grn.schedule' key='GRN_SCH-813' replace='true'}</td>
        <td><span style="" id="selected-path"></span></td>
    </tr>
    </tbody>
</table>
{/if}

