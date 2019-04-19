{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{grn_load_javascript file="grn/html/page/customization/group_view.js"}

<div id="main_menu_part">
    <span class="menu_item">
        {capture name='customization_form_edit'}{cb_msg module='grn.customization' key='customization.group_view.link.modify' replace='true'}{/capture}
        {grn_link image='modify20.gif' page=$link_modify_page caption=$smarty.capture.customization_form_edit id=$customization_group->getId()}
    </span>
    <span class="menu_item">
        {capture name='customization_form_delete'}{cb_msg module='grn.customization' key='customization.group_view.link.delete' replace='true'}{/capture}
        {grn_link script='javascript:void(0)' caption=$smarty.capture.customization_form_delete image='delete20.gif' element_id='lnk_delete' id='lnk_delete'}
    </span>
</div>

<p>
<table class="view_table">
    <tr>
        <th class="nowrap-grn">
            {cb_msg module='grn.customization' key='customization.group_view.field_status' replace='true'}
        </th>
        <td>
            {if $customization_group->isActive() }
                <span class="font_green">
                    {cb_msg module='grn.customization' key='customization.group_view.status_active' replace='true'}
                </span>
            {else}
                <span class="font_red">
                    {cb_msg module='grn.customization' key='customization.group_view.status_deactivate' replace='true'}
                </span>
            {/if}
        </td>
    </tr>

    <tr>
        <th class="nowrap-grn" style="width:15%;">
            {cb_msg module='grn.customization' key='customization.group_view.field_group_name' replace='true'}
        </th>
        <td>
            {$customization_group->getName()|escape}
        </td>
    </tr>

    {if require_target}
        <tr>
            <th class="nowrap-grn" style="width:15%;">
                {cb_msg module='grn.customization' key='customization.group_list.target' replace='true'}
            </th>
            <td>
                {assign var='targets' value=$customization_targets->getCustomizationTargetList()}
                {assign var='users_info' value=$customization_targets->getCustomizationUserSelectedInfo()}
                {if $targets|@count}
                    <table class="list_column">
                        <tr>
                            <th nowrap="">{cb_msg module='grn.grn' key='GRN_GRN-471' replace='true'}</th>
                        </tr>
                        {foreach from=$targets item=item}
                            <tr>
                                {if 'user' == $item.type}
                                    {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
                                    <td>{grn_user_name uid=$item.tid users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
                                {elseif 'group' == $item.type}
                                    {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
                                    <td>{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
                                {elseif 'static_role' == $item.type}
                                    <td>{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
                                {elseif 'dynamic_role' == $item.type}
                                    <td>{grn_image image='role20.gif'}{$item.tid|escape}</td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                {/if}
            </td>
        </tr>
    {/if}

    <tr>
        <th class="nowrap-grn">
            {cb_msg module='grn.grn' key='GRN_GRN-1576' replace='true'}
        </th>
        <td>
            <div id="js">
            </div>
        </td>
    </tr>

    <tr valign="top">
        <th class="nowrap-grn">
            {cb_msg module='grn.grn' key='GRN_GRN-1577' replace='true'}
        </th>
        <td>
            <div id="css">
            </div>
        </td>
    </tr>

    <tr>
        <th class="nowrap-grn">
            {cb_msg module='grn.customization' key='customization.group_view.createdby' replace='true'}
        </th>
        <td>
            {grn_user_name uid=$customization_group->getCreator() name=$customization_group->getCreatorName()}
            {grn_date_format date=$customization_group->getCreateDateTime() format="DateTimeMiddle_YMDW_HM"}
        </td>
    </tr>

    <tr>
        <th class="nowrap-grn">
            {cb_msg module='grn.customization' key='customization.group_view.updatedby' replace='true'}
        </th>
        <td>
            {grn_user_name uid=$customization_group->getModifier() name=$customization_group->getModifierName()}
            {grn_date_format date=$customization_group->getModifyDateTime() format="DateTimeMiddle_YMDW_HM"}
        </td>
    </tr>
</table>

<style>
    {*
     * Set temp_file_upload_container don't display on screen
     * Automation testing: the file input element is not visible and selenium could not upload files when using "display = none;"
     *}
    {literal}
    #temp_file_upload_container,
    #html5_content .drop {
        width: 0px;
        height: 0px;
        overflow: hidden;
        border: none;
    }

    {/literal}
</style>
<div id="temp_file_upload_container">
    {include file="grn/attach_file.tpl"}
</div>

{grn_delete
title=$delete_info.title
page=$delete_info.page
handler='lnk_delete'
data=$delete_info.data
customization_group=$customization_group}

<script>
    {literal}
    /**
     * Initialize resource view
     */
    jQuery(function initialize_group_view() {
        var resourceData = {
            {/literal}
            resourceJS: {$resource_js|@json_encode},
            resourceCSS: {$resource_css|@json_encode}
            {literal}
        };
        grn.page.customization.group_view.init(resourceData);
    });
    {/literal}
</script>

{include file='grn/system_footer.tpl'}