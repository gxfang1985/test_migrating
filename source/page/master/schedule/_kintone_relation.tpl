{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/schedule/multi_view/util.js"}
{grn_load_javascript file="grn/html/component/user_org_facility_suggest_list.js"}
{grn_load_javascript file="grn/html/component/schedule/multi_view/member_list.js"}
{grn_load_javascript file="grn/html/page/schedule/kintone_relation_user_picker.js"}
{grn_load_javascript file="grn/html/page/schedule/kintone_relation.js"}
{if $use_type == 'add' || $use_type == 'modify'}
    {grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
    {grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
    {assign var="navi_num" value="10"}
    <script language="JavaScript" text="text/javascript">
    jQuery(function(){literal}
    {{/literal}
        var __thisPage = grn.page.schedule.kintoneRelation;
        __thisPage.setResource("add", "{cb_msg module='grn.schedule' key='GRN_SCH-810' replace='true'}");
        __thisPage.setResource("edit", "{cb_msg module='grn.grn' key='GRN_GRN-1431' replace='true'}");
        __thisPage.setResource("delete", "{cb_msg module='grn.schedule' key='GRN_SCH-811' replace='true'}");
        __thisPage.setResource("naviNum", "{$navi_num|escape}");
        __thisPage.setBaseTable("{$table_tag|escape}");
        __thisPage.setSelectTag("{$select_tag|escape}");

        jQuery("#{$select_tag|escape}").change(__thisPage.insertItems);
    {literal}
    });{/literal}
    </script>
    {grn_schedule_kintone_relation use_type=$use_type event_id=$event_id event_menu=$event_menu kintone_dialog_mode=$kintone_dialog_mode selected_item=$selected_item kintone_app=$kintone_app kintone_record=$kintone_record field_code=$field_code}

    {strip}
        <div class="overlay" style="display: none;" id="kintone_overlay"></div>
        <div class="msgbox msgbox_grn" style="min-width: 700px;display: none;" id="kintone_dialog">
            <div class="title">
                <div class="msgbox_title_grn float_left" id="kintone_dialog_title"></div>
                <a href="javascript:void(0);" onclick="grn.page.schedule.kintoneRelation.closeDialog('kintone_dialog');" title="{cb_msg module='grn.grn' key='GRN_GRN-846' replace='true'}"><div class="subWindowClose-grn"></div></a>
                <div class="clear_both_0px"></div>
            </div>
            <div class="content" style="height: 400px;display: none;" id="kintone_content_error"></div>
            <div class="content" style="height: 400px;" id="kintone_content_spinner">
                <div class="tAlignCenter-grn mTop30">
                    <div class="spinnerBoxBase-grn">
                        <div class="spinnerBox-grn"></div>
                    </div>
                </div>
            </div>
            <div class="content" style="min-height: 200px;display: none;" id="kintone_content_record">
                <div class="mBottom10">
                    <div id="app_list_select"></div>
                    <div class="clear_both_0px"></div>
                    <div class="float_left mTop5" id="kintone_add_record_section">
                        <a id="kintone_add_record_button" class="icon_add_grn" href="javascript:void(0);">
                            {cb_msg module='grn.schedule' key='GRN_SCH-1063' replace='true'}
                        </a>
                    </div>
                    <div class="nowrap-grn float_right">
                        <div class="search_navi">
                            <div class="searchbox-grn searchbox-kintone">
                                <div id="searchbox-select-cybozu"></div>
                                <div id="searchbox-user-cybozu" class="input-text-outer-cybozu searchbox-user-cybozu mRight10">
                                    <input maxlength="100" class="input-text-cybozu keyword_kintone_search_user js_input_incremental_search" placeholder="{cb_msg module='grn.schedule' key='GRN_SCH-1064' replace='true'}" autocomplete="off" id="keyword_kintone_search_user" type="text" >
                                    <input type="hidden" id="kintone_user_code_name" value=""/>
                                </div>
                                <div id="searchbox-keyword-cybozu" class="input-text-outer-cybozu searchbox-kintone-keyword">
                                    <input maxlength="100" class="input-text-cybozu mRight10" placeholder="{cb_msg module='grn.schedule' key='GRN_SCH-1065' replace='true'}" autocomplete="off" id="keyword_kintone_search_key" type="text" onKeyPress="if(event.keyCode == 13) grn.page.schedule.kintoneRelation.searchRecord();">
                                    <button id="search-kintone-submit-button" class="buttonStandard-grn" type="button" onclick="grn.page.schedule.kintoneRelation.searchRecord()">{cb_msg module='grn.schedule' key='GRN_SCH-1066' replace='true'}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clear_both_0px"></div>
                </div>
                <div class="relation_list_table_base_grn">
                    <table class="list_column relation_list_table_grn" id="record_list">
                    </table>
                </div>
                <div class="list_paging_grn mTop5">
                    <span id="top_page_on" style="display: none;" class="mRight7">
                        <a onclick="grn.page.schedule.kintoneRelation.pageNavigation('top');" class="action_grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}" href="javascript:void(0);">
                            <span class="arrow_first_button_grn"></span>
                        </a>
                    </span>
                    <span id="top_page_off" class="action_disable_grn mRight7"><span class="arrow_first_button_grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}"></span></span>
                    <span id="prev_page_on" style="display: none;" class="mRight7">
                        <a onclick="grn.page.schedule.kintoneRelation.pageNavigation('prev');" class="action_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-445' replace='true'} {$navi_num|escape} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}" href="javascript:void(0);">
                            <span class="arrow_left_button_grn"></span>
                        </a>
                    </span>
                    <span id="prev_page_off" class="action_disable_grn mRight7"><span class="arrow_left_button_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-445' replace='true'} {$navi_num|escape} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"></span></span>
                    <span id="next_page_on" style="display:none;" class="mRight7" >
                        <a onclick="grn.page.schedule.kintoneRelation.pageNavigation('next');" class="action_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-446' replace='true'} {$navi_num|escape} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}" href="javascript:void(0);">
                            <span class="arrow_right_button_grn"></span>
                        </a>
                    </span>
                    <span id="next_page_off" class="action_disable_grn mRight7"><span class="arrow_right_button_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-446' replace='true'} {$navi_num|escape} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"></span></span>
                    <span class="sub_title numberList vAlignMiddle-grn mLeft10">
                        <span id="start_num">0</span>-<span id="end_num">0</span>
                    </span>
                </div>
            </div>
            <div class="buttonArea-grn mTop10">
                <span class="mRight15 aButtonStandard-grn aButtonMain-grn aButtonSubmit-grn" id="active_button" style="display: none;">
                    <a href="javascript:void(0);" role="button" onclick="grn.page.schedule.kintoneRelation.addRelation();">
                        <span class="buttonSpacePlus-grn">{cb_msg module='grn.schedule' key='GRN_SCH-993' replace='true'}</span>
                    </a>
                </span>
                <span class="button_standard_disable_grn mRight15" id="inactive_button"><a href="javascript:void(0);"><span>{cb_msg module='grn.schedule' key='GRN_SCH-993' replace='true'}</span></a></span>
                <span class="aButtonStandard-grn"><a href="javascript:void(0);" onclick="grn.page.schedule.kintoneRelation.closeDialog('kintone_dialog');"><span>{cb_msg module='grn.schedule' key='cancel_button' replace='true'}</span></a></span>
            </div>
        </div>
        <div class="msgbox msgbox_grn" style="display: none;" id="menu_change_dialog">
            <div class="title">
                <div class="msgbox_title_grn float_left"></div>
                <a href="javascript:void(0);" onclick="grn.page.schedule.kintoneRelation.closeDialog('menu_change_dialog');" title="{cb_msg module='grn.grn' key='GRN_GRN-846' replace='true'}"><div class="subWindowClose-grn"></div></a>
                <div class="clear_both_0px"></div>
            </div>
            <div class="content" style="min-height: 150px;">
                <div class="icon_attention32_grn mBottom5"></div>
                <div class="daialog_message_grn">
                    {cb_msg module='grn.schedule' key='GRN_SCH-994' replace='true'}<br>{cb_msg module='grn.schedule' key='GRN_SCH-995' replace='true'}
                </div>
            </div>
            <div class="buttonArea-grn">
                <span class="aButtonStandard-grn mRight15"><a href="javascript:void(0);" id="yes_button"><span>{cb_msg module='grn.common' key='yes' replace='true'}</span></a></span>
                <span class="aButtonStandard-grn"><a href="javascript:void(0);" onclick="grn.page.schedule.kintoneRelation.closeDialog('menu_change_dialog');"><span>{cb_msg module='grn.common' key='no' replace='true'}</span></a></span>
            </div>
        </div>
    {/strip}
    {include file='grn/window_simple_dialog.tpl' dialog_version=2}
{/if}
