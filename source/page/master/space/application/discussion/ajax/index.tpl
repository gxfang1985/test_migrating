{assign var='thread_comment_height' value='130'}
{assign var='thread_comment_width' value='495'}
<script language="JavaScript" text="text/javascript">
    var __thisPage = grn.page.space.discussion.index;
    __thisPage.textareaHeight = {$thread_comment_height};
    __thisPage.textareaWidth = {$thread_comment_width};
</script>

<!-- discussion area -->
<table id="discussion_area" class="space-discussion-grn">
    <tbody>
        <tr>
            <td class="space-threadList-grn">
                {$thread_list_component->fetch()}

            </td>
            <td class="space-thread-grn" id="space-thread-container">
                <div class="space-thread-inner-grn">
                    <!-- thread main -->
                    <div id="thread_main" class="space-threadMain-grn">
                        <div class="space-threadMain-inner-grn">
                            {include file="star/star_init.tpl" list_id="thread_star_list" star_not_load_js=TRUE}
                            <div class="space-threadTextBody-grn" id="thread_body">
                            </div>

                            <!-- follow -->
                            <div class="space-thread-follows-grn" id="thread-follows" style="display:none">
                                <div class="space-thread-followForm-grn comment_std_grn">
                                    <form id="follow_form_thread_comment" class="space_thread_form_grn" name="follow_form" method="post" enctype="multipart/form-data" action="{grn_pageurl page=space/application/discussion/command_comment_add}">
                                        <div id="error_msg_thread_comment"></div>
                                        {include file="grn/richeditor.tpl"
                                            enable=TRUE switch_name=thread_comment_add_editor
                                            name=thread_comment_add
                                            height=$thread_comment_height
                                            class="form_textarea_grn"
                                            mention=TRUE
                                            app_id="space"
                                            mention_params=$mention_params
                                            mention_access_plugin_encoded=$mention_access_plugin_encoded}
                                        <div id="upload_content"></div>
                                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                        <input type="hidden" id="tid_for_comment" name="tid" value="">
                                        <input type="hidden" id="spid" name="spid" value="{$space_id}">
                                        <input type="hidden" name="mention" />
                                        <div class="mTop7">
                                            {strip}
                                                {capture name="grn_space_discussion_GRN_SP_DISC_35"}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-35' replace='true'}{/capture}
                                                {grn_button id='thread_comment_button' ui='main' caption=$smarty.capture.grn_space_discussion_GRN_SP_DISC_35 onclick="__thisPage.threadCommentAdd('thread_comment');"}
                                            {/strip}
                                        </div>
                                    </form>
                                </div>
                                <div id="thread_comments" data-mention-access-plugin="{$mention_access_plugin_encoded}" class="space-thread-comments-grn">
                                </div>
                            </div>
                            <!-- end of follow -->
                        </div>
                    </div>
                    <!-- end of thread main -->
                </div>
            </td>
            <td class="space-thread-right-grn" id="space-thread-right-container">
                <!-- rightList -->
                <div class="space-threadRightList-grn" id="right_list" style="width:230px;">
                </div>
               <!-- end of rightList -->
            </td>
        </tr>
    </tbody>
    <!-- end of thread -->
</table>
<!-- end of discussion area -->
