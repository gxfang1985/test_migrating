{grn_load_javascript file="grn/html/component/member_select_list.js"}
<div class="selectlist_area_grn">
    <span id="spinner_{$list_name}" style="display:none;position:absolute;z-index:1;">{grn_image image='spinner.gif' style="display:none"}</span>
    <div id="selectlist_base_{$list_name}" aria-multiselectable="true" class="selectlist_grn {$div_class_name}" tabindex="0" style="{$style}">
        <ul id="ul_{$list_name}">
            {foreach from=$selected_item_options item=item key=key}
                {capture name="member_id"}{$list_name}_member_{$item.type}_{$item.id}{/capture}
                    {if $item.type == "user"}
                        {if $item.isLoginUser eq true}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-LOGIN_USER' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_user_login_grn{/capture}
                        {elseif $item.isInvalidUser eq true}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-INACTIVE_USER' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_user_invalid_grn{/capture}
                        {elseif $item.isNotUsingApp eq true}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-NOT_APPLICATION_USER' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_user_invalid_app_grn{/capture}
                        {else}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-1571' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_user_grn{/capture}
                        {/if}
                    {elseif $item.type == "group"}
                        {if $is_calendar}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-ORGANIZATION_PLAN' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_cal_group_grn{/capture}
                        {else}
                            {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-ORGANIZATION' replace='true'}{/capture}
                            {capture name="image_class"}selectlist_group_grn{/capture}
                        {/if}
                    {elseif $item.type == "omitted"}
                        {capture name="image_class"}selectlist_omitted_grn{/capture}
                    {else}
                        {capture name="image_text"}{cb_msg module='grn.grn' key='GRN_GRN-ROLE' replace='true'}{/capture}
                        {capture name="image_class"}selectlist_role_grn{/capture}
                    {/if}

                    <li id="{$smarty.capture.member_id}" class="{$list_name}" data-value="{$key}" data-type="{$item.type}" data-name="{$item.displayName}" {if $is_foreign_key_public || $item.type !== 'user'}data-code="{$item.foreignKey}"{/if}>

                    <span class="{$smarty.capture.image_class}" aria-label="{$smarty.capture.image_text}"
                          title="{$smarty.capture.image_text}"></span>
                    <span class="selectlist_text_grn{if $item.type == 'omitted'} selectlist_text_omitted_grn{/if}">{$item.displayName}</span>
                </li>
            {/foreach}
        </ul>
        <span id="spinner_scroll_{$list_name}" style="display:none;">{grn_image image='spinner.gif'}</span>
    </div>
</div>
{strip}
{if $select_all or $view_detail}
    <div class="textSub-grn mTop5">
        {if $select_all}
            <a id="select_all_{$list_name}" class="mRight20" href="javascript:void(0);">{cb_msg module='grn.grn' key='GRN_GRN-1569' replace='true'}</a>
            <a id="un_select_all_{$list_name}" style="display:none" class="mRight20" href="javascript:void(0);">{cb_msg module='grn.grn' key='GRN_GRN-1570' replace='true'}</a>
        {/if}
        {if $view_detail}
            {capture name='grn_grn_GRN_GRN_821'}{cb_msg module='grn.grn' key='GRN_GRN-1572' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_grn_GRN_GRN_821 system_display=false function_name="popupMember" list_name=$list_name_suffix is_button=false form_name=$form_name}
        {/if}
    </div>
{/if}
{/strip}
