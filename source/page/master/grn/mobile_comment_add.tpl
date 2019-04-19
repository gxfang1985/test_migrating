{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/component/mobile_clear_input.js"}
{if $mention}
{include file='grn/ajax/mobile_member_list_dialog.tpl' dialog_id='member_list_dialog_mention_input'}
{strip}
<div class="mobile_mention_textarea_base_grn" id="{$name}_mention">
    <div class="mobile_mention_textarea_ui_base_grn">
        <div class="mobile_mention_textarea_ui_grn"><button type="button" class="mobile_button_style_off_grn js_mention_button" id="{$name}_mention_button" aria-controls="{$name}_mention_list" aria-expanded="false">{cb_msg module='grn' key='grn.mention_symbol' replace='true'}{cb_msg module='grn' key='grn.mention' replace='true'}</button></div>
    </div>
    <div class="js_mention_list"></div>
    <div class="mobile-div-title-grn">
        {grn_textarea necessary=true name="comment_data" id="comment_data" value=$content rows="50" class="mobile-textarea-grn" disable_return_key=true}
    </div>
</div>
{/strip}
{else}
<div class="mobile-div-title-grn">
    {grn_textarea necessary=true name="comment_data" id="comment_data" value=$content rows="50" class="mobile-textarea-grn" disable_return_key=true}
</div>
{/if}
{if ! $hide_upload_file}
{include file="grn/mobile_attach_file.tpl" attached_files=$attach_files}
{/if}

{if $mention}
{literal}
<script>
    (function(){
        // Initialize Mention component
        var mention_settings = {
            {/literal}
            name: "{$name}_mention",
            element: "#{$name}_mention",
            accessPluginEncoded: "{$mention_access_plugin_encoded}"
            {literal}
        };
        var mobileMention = new grn.js.component.common.ui.mention.mobile.MobileMention(mention_settings);
        mobileMention.render();
    })();
</script>
{/literal}
{/if}