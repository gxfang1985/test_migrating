{grn_load_css file="grn/html/reply.css"}
{if !$ajax_load}
    {grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{/if}
{if ! $name}{assign var="name" value="reply_comment"}{/if}
{if ! $app_id}{assign var="app_id" value="space"}{/if}
<div class="replyForm-grn" id="reply_dialog" style="display:none;">
    <form id="follow_form_reply_comment" name="form_reply_comment" method="post" enctype="multipart/form-data" action="{grn_pageurl page=$form_action}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" id="cmmt_reply_comment_no" name="reply_comment_no">
        <input type="hidden" id="cmmt_id_reply_comment" name="reply_comment_id">

        {if $enable_mention}
        <input type="hidden" id="cmmt_reply_mention" name="mention">
        {/if}
        {$form_fields|grn_noescape}

        <div class="replyForm-inner-grn comment_std_grn">
            <div class="replyForm-header-grn" id="reply_dialog_header">
                <a class="replyForm-close-grn js_close" href="javascript:"></a>
                <span class="replyForm-headerTitle-grn">{cb_msg module='grn.grn' key='GRN_GRN-1538' replace='true'}</span>
            </div>
            <div class="replyForm-body-grn replyForm-body-grn form_text_base_grn">
                <span id="reply_comment_no"></span>
                <div id="error_msg_reply_comment"></div>
                <div class="mention_textarea_base_grn" id="{$name}_mention">
                    {if $enable_mention}
                        <div class="mention_textarea_ui_base_grn js_mention_button_area">
                            {strip}
                                <div class="mention_textarea_ui_grn">
                                    <button type="button"
                                            class="nowrap-grn mention_textarea_button_grn button_style_off_grn js_mention_button"
                                            id="{$name}_mention_button"
                                            aria-controls="{$name}_mention_list"
                                            aria-expanded="false">
                                        <span class="mention_mark_grn">{cb_msg module='grn' key='grn.mention_symbol' replace='true'}</span>
                                        <span class="mention_button_text_grn">{cb_msg module='grn' key='grn.mention' replace='true'}</span>
                                    </button>
                                </div>
                            {/strip}
                        </div>
                        <div class="js_mention_list"></div>
                    {/if}
                    <div class="form_text_base_grn">
                        <textarea id="reply_comment_text" name="{$input_name}"
                                  class="replyForm-textarea-grn form_textarea_grn"
                                  role="form"
                                  aria-label="{cb_msg module='grn' key='grn.comment.aria_label' replace='true'}"></textarea>
                    </div>
                </div>
                {include file="grn/attach_file35.tpl" fbox_id="reply_comment" isFollow=TRUE filename_width=200 progressbar_width=200}
                <div class="mTop5">
                    {strip}
                        {capture name="post_button_caption"}{cb_msg module='grn.grn' key='GRN_GRN-1541' replace='true'}{/capture}
                        {grn_button id='reply_comment_button' ui='main' caption=$smarty.capture.post_button_caption
                        onclick="$on_submit"}
                    {/strip}
                </div>
            </div>
        </div>
    </form>
</div>
{if $enable_mention}
    {literal}
    <script language="JavaScript" type="text/javascript">
        (function() {
            // Initialize Mention component
            var mention_settings = {
                {/literal}
                name: "{$name}_mention",
                element: "#{$name}_mention",
                accessPluginEncoded: "{$mention_access_plugin_encoded}",
                {literal}
            };

            var mention = new grn.js.component.common.ui.mention.Mention(mention_settings);
            mention.render();
        })();

    </script>
    {/literal}
{/if}
