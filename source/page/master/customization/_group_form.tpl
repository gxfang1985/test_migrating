{include file="grn/`$page_prefix`head.tpl"}
{include file="grn/`$page_prefix`header.tpl"}
{grn_load_javascript file="grn/html/component/editable_table.js"}
{grn_load_javascript file="grn/html/page/customization/resource.js"}
{grn_load_javascript file="grn/html/component/string.js"}

<h2 class="system inline_block_grn">{$page_title}</h2>
<div class="explanation mTop5">
    <p>{cb_msg module='grn.grn' key='GRN_GRN-1580' replace='true'}</p>
    {cb_msg module='grn.customization' key='customization.group_form.upload.explanation' replace='true'}
</div>
{assign var='form_name' value=$smarty.template|basename}

<div class="attention js_validate_area" style="display:none;"></div>

<form name="{$form_name}" method="post" action="{grn_pageurl page=$command_page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}">
    {foreach from=$command_params key=key item=item}
        <input type="hidden" name="{$key}" value="{$item|escape}">
    {/foreach}
    {strip}
        <table class="std_form mTop10">
            <tbody>
            <tr>
                <th class="nowrap-grn" style="width:15%;">
                    {cb_msg module='grn.grn' key='GRN_GRN-1573' replace='true'}
                </th>
                <td>
                    <div class="mLeft10">
                    <span class="radiobutton_base_grn">
                        {capture name='grn_grn_GRN_GRN_1574'}{cb_msg module='grn.grn' key='GRN_GRN-1574' replace='true'}{/capture}
                        {grn_radio id="apply" name="apply_status" value="1" caption=$smarty.capture.grn_grn_GRN_GRN_1574 checked=$apply}
                    </span>
                    <span class="radiobutton_base_grn">
                        {capture name='grn_grn_GRN_GRN_1575'}{cb_msg module='grn.grn' key='GRN_GRN-1575' replace='true'}{/capture}
                        {grn_radio id="do_not_apply" name="apply_status" value="0" caption=$smarty.capture.grn_grn_GRN_GRN_1575 checked=$not_apply}
                    </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th class="nowrap-grn" style="width:15%;">
                    {capture name='field_group_name'}{cb_msg module='grn.customization' key='customization.group_form.field_group_name' replace='true'}{/capture}
                    {grn_show_input_title title=$smarty.capture.field_group_name necessary=1}
                </th>
                <td>
                    <div class="mLeft10">
                        {grn_text name="name" size="50" maxlength="100" value=$customization_group->getName() disable_return_key=true}
                    </div>
                </td>
            </tr>
            {if $require_target}
                <tr>
                    <th class="nowrap-grn" style="width:15%;">
                        {cb_msg module='grn.customization' key='customization.group_list.target' replace='true'}
                    </th>
                    <td>
                        <div id="target_id" class="move_list_grn mLeft10">
                            {include file="customization/selected_target_list.tpl"}
                        </div>
                    </td>
                </tr>
            {/if}
            <tr>
                <th class="nowrap-grn">
                    {cb_msg module='grn.grn' key='GRN_GRN-1576' replace='true'}
                </th>
                <td>
                    <div id="js" class="move_list_grn mLeft10">
                    </div>
                </td>
            </tr>
            <tr>
                <th class="nowrap-grn">
                    {cb_msg module='grn.grn' key='GRN_GRN-1577' replace='true'}
                </th>
                <td>
                    <div id="css" class="move_list_grn mTop10 mLeft15">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <div>
                        {if $screen_type eq "add"}
                            {capture name='grn_customization_form_button_save'}{cb_msg module='grn.customization' key='customization.group_add.button.save' replace='true'}{/capture}
                            {capture name='grn_customization_form_button_cancel'}{cb_msg module='grn.customization' key='customization.group_add.button.cancel' replace='true'}{/capture}
                        {else}
                            {capture name='grn_customization_form_button_save'}{cb_msg module='grn.customization' key='customization.group_modify.button.save' replace='true'}{/capture}
                            {capture name='grn_customization_form_button_cancel'}{cb_msg module='grn.customization' key='customization.group_modify.button.cancel' replace='true'}{/capture}
                        {/if}
                        {grn_button_submit class='margin js_submit_btn' button_type='submit' caption=$smarty.capture.grn_customization_form_button_save}
                        {grn_button_cancel caption=$smarty.capture.grn_customization_form_button_cancel}
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    {/strip}
</form>

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

<script>
    {literal}
    /**
     * Initialize resource view
     */
    jQuery(function initialize_resource_view() {
        var resourceData = {
            {/literal}
            resourceJS: {$resource_js|@json_encode},
            resourceCSS: {$resource_css|@json_encode}
            {literal}
        };
        grn.page.customization.resource.init(resourceData);
        grn.page.customization.resource.checkHTML5SupportUploadFiles();
    });
    {/literal}
</script>

{include file="grn/`$page_prefix`footer.tpl"}
