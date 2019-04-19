{**
Options...
enable      : Enable richeditor
switch_name : Input name for editor switch button ( default "editor" )
class       : Textarea class name ( default null )
name        : Input name for data ( default "data" )
html        : Initial html data ( default null )
text        : Initial text data ( default null )
cols        : Number of column for edit area ( default 100 )
rows        : Number of row for edit area ( default 8 )
width       : Width of textarea ( default null )
height      : Height of textarea ( default null )
mention     : Enable mention
mention_params: Parameters used for Mention component (default null)
mention_access_plugin_encoded : Access plugin
**}

{** initialize parameters **}
{if ! $switch_name}{assign var="switch_name" value="editor"}{/if}
{if ! $name}{assign var="name" value="data"}{/if}
{assign var="id" value="`$name`_editor_id"}
{if ! $cols}{assign var="cols" value="100"}{/if}
{if ! $rows}{assign var="rows" value="8"}{/if}
{if $html}
    {assign var="richeditor_on" value=true}
    {assign var="data" value=$html}
{else}
    {assign var="richeditor_on" value=false}
    {assign var="data" value=$text}
{/if}
{if $width}{assign var="style" value="width:`$width`px;"}{/if}
{if $height}{assign var="style" value="`$style`height:`$height`px;"}{/if}
{if $settings !== 0 && $settings !== 1 && $settings !== 2}
    {assign var="settings" value=0}
{/if}
{grn_richeditor_supported_browser}

{capture name=switcher}
{strip}
        {if $comment}
            <span class="sub_title inline_block_grn">{cb_msg module='grn' key='grn.comment' replace='true'}</span>
        {/if}
        {if $enable && $supported_browser}
            {if $comment}
                <span class="mRight5 mLeft5">：</span>
            {/if}
            {if !$ajax_load}
                {grn_load_javascript file="tinymce/dist/tinymce.js"}
            {/if}
            <div class="switch_textformat_grn">
                <span class="radiobutton_base_grn"><input type="radio" name="{$switch_name}" id="{$switch_name}_off" value="0" {if !$richeditor_on}checked{/if}><label for="{$switch_name}_off" onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'">{cb_msg module='grn.re' key='plain-text' replace='true'}</label></input></span>
                <span class="radiobutton_base_grn"><input type="radio" name="{$switch_name}" id="{$switch_name}_on" value="1" {if $richeditor_on}checked{/if}><label for="{$switch_name}_on"  onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'">{cb_msg module='grn.re' key='rich-text' replace='true'}</label></input></span>
            </div>
        {else}
            <input type="radio" name="{$switch_name}" id="{$switch_name}_off" value="0" checked style="display:none">
        {/if}
    {/strip}
{/capture}

{if $mention}
    {strip}
    <div class="mention_textarea_base_grn" id="{$name}_mention">
        <div class="mention_textarea_ui_base_grn">
            <div class="mention_textarea_ui_grn">
                <button type="button" class="nowrap-grn mention_textarea_button_grn button_style_off_grn js_mention_button" id="{$name}_mention_button" aria-controls="{$name}_mention_list" aria-expanded="false">
                    <span class="mention_mark_grn">{cb_msg module='grn' key='grn.mention_symbol' replace='true'}</span>
                    <span class="mention_button_text_grn">{cb_msg module='grn' key='grn.mention' replace='true'}</span>
                </button>
            </div>
            {$smarty.capture.switcher|grn_noescape}
        </div>
        <div class="js_mention_list"></div>
        <div class="form_text_base_grn">
            {capture name='placeholder_comment'}{cb_msg module='grn' key='grn.comment.placeholder_comment' replace='true'}{/capture}
            {grn_textarea name=$name cols=$cols rows=$rows id=$id class=$class style=$style
            placeholder=$smarty.capture.placeholder_comment title=$smarty.capture.placeholder_comment}
        </div>
    </div>
    {/strip}
    {grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{else}
    <div class="mBottom3">
        {$smarty.capture.switcher|grn_noescape}
    </div>
    <div class="form_text_base_grn">{grn_textarea name=$name cols=$cols rows=$rows id=$id class=$class style=$style }</div>
{/if}
<input type="hidden" id="initial_textarea_{$id}" value="{$data}">

{if !$ajax_load}
{grn_load_css file="grn/html/component/editor/ui.css"}
{grn_load_javascript file="grn/html/component/editor/editor.js"}
{/if}
<script>
    jQuery(document).on('grn.textarea:initialized', function() {ldelim}
        var ed = grn.component.editor;

        ed.Editor.locale = "{$html_lang}";
        ed.Editor.confirm_message = "{cb_msg module='grn.re' key='confirm' replace='true'}";
        ed.Editor.image_upload_url = "{grn_pageurl page='re/add_image'}";
        ed.Editor.image_download_url = "{grn_pageurl page='re/command_get'}";
        ed.Editor.grn_color_palette = "{grn_pageurl page='re/grn_color_palette'}";
        ed.Editor.allowed = "{$enable}" ? true : false;
        ed.Editor.setting_type = "{$settings}";

        var editor = new ed.Editor(
                "{$id}",
                "{$switch_name}",
                 {$settings});

        // Initialize Mention component
        {if $mention}
            {literal}
                var mention_settings = {
                    {/literal}
                    name: "{$name}_mention",
                    element: "#{$name}_mention",
                    accessPluginEncoded: "{$mention_access_plugin_encoded}",
                    textEditor: editor
                    {literal}
                };
            {/literal}
            new grn.js.component.common.ui.mention.Mention(mention_settings).render();
        {/if}
    {rdelim});
</script>