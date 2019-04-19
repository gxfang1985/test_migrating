{grn_load_javascript file="grn/html/star.js"}
{grn_load_javascript file="grn/html/page/space/discussion/index.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo_edit.js"}
{grn_load_javascript file="grn/html/page/space/application/join_leave.js"}
{include file='grn/window_simple_dialog.tpl'}
{grn_load_javascript file="grn/html/component/space.js"}
{grn_load_javascript file="grn/html/component/member_list_dialog.js"}
{literal}
<script language="JavaScript" text="text/javascript">
    grn.msg = {};
    grn.msg.OK = '{/literal}{cb_msg module='grn.common' key='ok' replace='true'}{literal}';
    grn.msg.CANCEL = '{/literal}{cb_msg module='grn.common' key='cancel' replace='true'}{literal}';
    grn.msg.YES = '{/literal}{cb_msg module='grn.common' key='yes' replace='true'}{literal}';
    grn.msg.NO = '{/literal}{cb_msg module='grn.common' key='no' replace='true'}{literal}';
    grn.csrfTicket = '{/literal}{$csrf_ticket}{literal}';
    // prevent textarea run auto initialization
    grn.component.textarea.disableAutoInit = true;
</script>
{/literal}
{include file="space/error_handler.tpl"}
{include file="grn/browser.tpl"}

{grn_load_css file="grn/html/component/editor/ui.css"}
{grn_load_javascript file="tinymce/dist/tinymce.js"}
{grn_load_javascript file="grn/html/component/editor/editor.js"}
{grn_load_javascript file="grn/html/page/space/folder_list.js"}

<div id="space_content">

<div id="spinner">
    {grn_image image='spinner.gif'}
</div>

</div>
<div id="hidden_upload" style="display:none;">
    {include file="grn/attach_file35.tpl" upload_ticket=$upload_ticket fbox_id="thread_comment" isFollow=TRUE filename_width=200 progressbar_width=170}
</div>
{literal}
    <script language="JavaScript" type="text/javascript">
        jQuery(function () {
            var inputParams = {/literal}{$params|@json_encode}{literal};

            if (inputParams == null) {
                if (!location.hash) {
                    {/literal}{if $sf}{literal}
                    location.hash = {/literal}"#tid={$tid}&sp={$sp}"{literal};
                    {/literal}{/if}{literal}
                }
                var urlParams = grn.component.url.parseQueryString(window.location.search);
                var hashParams = grn.component.url.parseHash(window.location.hash);

                inputParams = jQuery.extend(urlParams, hashParams);
            }

            var paramNames = ["spid", "tid", "nid", "nhid", "fnid"];

            var sendData = {};
            Object.keys(inputParams).forEach(function (name) {
                if (paramNames.indexOf(name) != -1) {
                    sendData[name] = inputParams[name];
                }
            });

            if (window.location.href.indexOf("space/top") != -1) {
                sendData["top"] = 1;
            }

            var requestPage = new grn.component.ajax.request({
                        grnUrl: "space/application/discussion/ajax/index",
                        method: "post",
                        data: sendData
                    }
            );

            requestPage.on("errorClosed", function(){
                location.replace( grn.component.url.page("space/index") );
            });

            requestPage.send().done(function (data) {
                jQuery("#space_content").html(data.discussion_index);

                // init textarea
                if ( jQuery(".autoexpand").length > 0 )
                {
                    jQuery(".autoexpand").each(function(){
                        grn_autoexpand_textarea(jQuery(this)[0]);
                    });
                    jQuery(document).trigger('grn.textarea:initialized');
                }

                // update site position
                var sitePosition = jQuery("#hidden_siteposition").find(".global_navi");
                jQuery("#body").children(".global_navi").replaceWith(sitePosition);

                // update back link
                var backLink = jQuery("#hidden_backlink").find(".footer_back_grn");
                jQuery("#footer").find(".footer_back_base_grn").html(backLink);

                // load upload attachment
                var hiddenUploadContent = jQuery("#hidden_upload");
                var uploadContent = document.getElementById("upload_content");
                if (uploadContent != null)
                {
                    uploadContent.appendChild(hiddenUploadContent[0]);
                    hiddenUploadContent.show();
                }
            });
        });
    </script>
{/literal}

{include file="grn/_show_popup_fixed_link.tpl"}

<!-- reply comment -->
{capture name=form_fields}
    <input type="hidden" id="tid_reply_comment" name="tid">
    <input type="hidden" id="spid_reply_comment" name="spid">
    <input type="hidden" id="cmmt_reply_istodo" name="reply_comment_istodo">
    <input type="hidden" id="cmmt_reply_todo_id" name="reply_comment_todo_id">
{/capture}
{include file="grn/_reply_comment.tpl"
    on_submit="__thisPage.threadCommentAdd('reply_comment');"
    form_action="space/application/discussion/command_comment_add"
    input_name="thread_comment_add"
    enable_mention=true
    form_fields=$smarty.capture.form_fields
}
<!-- end reply comment -->

{include file="space/application/todo/todo_add.tpl"}
{include file="grn/_favour_common.tpl"}