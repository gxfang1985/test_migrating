{grn_space_show_expiration_date_warning space=$space}

{grn_load_javascript file="grn/html/page/space/folder_setting.js"}

<h2 style="display: inline;" class="space">{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-5" replace="true"}</h2>

<div class="explanation mBottom15">{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-7" replace="true"}</div>

<div class="attention js_required_folder_name" style="display: none"><span class="bold"><span class="nowrap-grn "><span class="subnotify16" name="#">{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-14" replace="true"}</span></span></span></div>
<div class="move_list_grn mLeft10">
    {strip}
        <div class="list_menu">
            <span class="small_button_base_grn mRight10 js_check_unchecked_all">
                <span class="aButtonStandard-grn">
                    <a href="javascript:void(0);">
                        <span class="listcheck_button_grn"></span>
                    </a>
                </span>
            </span>
            <span class="aButtonStandard-grn button_disable_filter_grn mRight10 js_up_row">
                <a href="javascript:void(0);" class="button_min_width1_grn">
                    <span>{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-12" replace="true"}</span>
                </a>
            </span>
            <span class="aButtonStandard-grn button_disable_filter_grn js_down_row">
                <a href="javascript:void(0);" class="button_min_width1_grn">
                    <span>{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-13" replace="true"}</span>
                </a>
            </span>
        </div>
    <table class="list_column js_folder_setting_container" style="width: auto; min-width: 500px;">
        <tbody>
        <tr>
            <th style="width:5px;"></th>
            <th>
                {cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-1" replace="true"}<span class="attention">*</span>
            </th>
            <th class="move_list_action_grn"></th>
        </tr>
        </tbody>
    </table>
    <table class="js_folder_deleted" style="display: none"></table>
    <div class="list_menu">
        <span class="small_button_base_grn mRight10 js_check_unchecked_all">
            <span class="aButtonStandard-grn">
                <a href="javascript:void(0);">
                    <span class="listcheck_button_grn"></span>
                </a>
            </span>
        </span>
        <span class="aButtonStandard-grn mRight10 button_disable_filter_grn js_up_row">
            <a href="javascript:void(0);" class="button_min_width1_grn">
                <span>{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-12" replace="true"}</span>
            </a>
        </span>
        <span class="aButtonStandard-grn button_disable_filter_grn js_down_row">
            <a href="javascript:void(0);" class="button_min_width1_grn">
                <span>{cb_msg module="grn.space.folder" key="GRN_SP_FOLDER-13" replace="true"}</span>
            </a>
        </span>
    </div>
        <div class="mTop20">
            {capture name="grn_space_todo_GRN_SP_FOLDER_9"}{cb_msg module='grn.space.folder' key='GRN_SP_FOLDER-9' replace='true'}{/capture}
            {grn_button class="js_rows_submit" action='submit' ui='main' caption=$smarty.capture.grn_space_todo_GRN_SP_FOLDER_9 spacing='normal'}
            {capture name="grn_space_todo_GRN_SP_FOLDER_10"}{cb_msg module='grn.space.folder' key='GRN_SP_FOLDER-10' replace='true'}{/capture}
            {grn_button action='cancel' class="js_rows_cancel" caption=$smarty.capture.grn_space_todo_GRN_SP_FOLDER_10 }
        </div>
    {/strip}
</div>