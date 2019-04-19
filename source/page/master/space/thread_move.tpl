{grn_space_show_expiration_date_warning space=$space}

{include file='grn/window_simple_dialog.tpl'}
{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/pager.js"}
{grn_load_javascript file="grn/html/component/space/thread_move/folder_tree.js"}
{grn_load_javascript file="grn/html/component/space/thread_move/thread_list.js"}
{grn_load_javascript file="grn/html/component/space/thread_move/service.js"}
{grn_load_javascript file="grn/html/component/space/thread_move/move_to_space_dialog.js"}
{grn_load_javascript file="grn/html/page/space/thread_move.js"}

{assign var="form_name" value=$smarty.template|basename}

<h2 style="display:inline;" class="space">{cb_msg module='grn.space' key='move_discussion-1' replace='true'}</h2>
<div class="sub_explanation">{cb_msg module='grn.space' key='move_discussion-2' replace='true'}</div>
<div id="menu_part"></div>
<table class="maincontents_list">
    <tbody>
    <tr>
        <td class="maincontents_list_td">
            <table class="table_plain_grn tree_style1_table_grn" style="width: 100%;">
                <tbody>
                <tr valign="top">
                    <td id="tree_part">
                        <!--tree_structure-->
                        {include file='space/folder_tree_thread.tpl'}
                        <!--tree_structure_end-->
                    </td>

                    <td width="90%" id="view_part">
                        <div id="spinner" style="position: absolute;">
                            {grn_image image='spinner.gif'}
                        </div>
                        <form id="view_part_content" name="{$form_name}" method="post" action="{grn_pageurl page='space/command_'|cat:$page_info.last}" style="visibility: hidden;">
                            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                            {include file="space/smart_word_navi_thread_move_list.tpl" navi=$navi.navi start_num=$navi.start_count end_num=$navi.end_count custom_class="js_naviTop"}
                            {strip}
                            <div class="list_menu">
                                {include file='grn/checkall.tpl' elem_name="ids[]" enable_shift_click=true space_flag=true}
                                {if $isSpaceMember || $isSpaceAdminOrOperator}
                                    {include file='space/change_folder_thread.tpl' pulldown_id='move_folder_top'}
                                {/if}
                                {if $isSpaceOperator}
                                    <span class="js_button_change_to_other_space aButtonStandard-grn button_disable_filter_grn"><a href="javascript:void(0);"><span>{cb_msg module='grn.space' key='move_discussion-3' replace='true'}</span></a></span>
                                {/if}
                            </div>
                            {/strip}
                            <table class="list_column list_column_grn" id="thread_list" name="list_item">
                                <colgroup>
                                    <col width="1%">
                                    <col width="99%">
                                </colgroup>
                                <tr>
                                    <th class="navi" nowrap></th>
                                    <th nowrap>{cb_msg module='grn.space' key='move_discussion-10' replace='true'}</th>
                                </tr>
                            </table>
                            <div id="empty_thread_list" class="list_message_grn" style="display:none">
                                <div class="list_message_balloon_grn">
                                    <span class="bold_grn">{cb_msg module='grn.space' key='move_discussion-4' replace='true'}</span>
                                </div>
                                <div class="balloon_arrow_down_grn"></div>
                                <div class="list_message_icon_grn">
                                    <span class="message_middle_icon_size_grn space_message_middle_icon_grn"></span>
                                </div>
                            </div>
                            {strip}
                            <div class="list_menu">
                                {include file='grn/checkall.tpl' elem_name="ids[]" enable_shift_click=true space_flag=true}
                                {if $isSpaceMember || $isSpaceAdminOrOperator}
                                    {include file='space/change_folder_thread.tpl' pulldown_id='move_folder_bottom'}
                                {/if}
                                {if $isSpaceOperator}
                                    <span class="js_button_change_to_other_space aButtonStandard-grn button_disable_filter_grn"><a href="javascript:void(0);"><span>{cb_msg module='grn.space' key='move_discussion-3' replace='true'}</span></a></span>
                                {/if}
                            </div>
                            {/strip}
                            {include file="space/smart_word_navi_thread_move_list.tpl" navi=$navi.navi start_num=$navi.start_count end_num=$navi.end_count custom_class="js_naviBottom"}
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<span id="thread_move_folder_content_span" style="display:none">{include file='space/_thread_move_folder.tpl'}</span>

{literal}
    <script language="JavaScript" type="text/javascript">

        YAHOO.util.Event.onDOMReady(function(){
            var options = {
                treeObj : obj_folder_tree,
                treeContainer : "#tree_view",
                threadListContainer : "#thread_list",
                emptyThreadListContainer : "#empty_thread_list",
                limit : {/literal}{$number_on_page}{literal}
            };
            grn.page.space.thread_move.init(options);
        });

    </script>
{/literal}