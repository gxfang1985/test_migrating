{include file="grn/url_builder.tpl"}
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{grn_load_javascript file="grn/html/component/window_simple_dialog.js"}
<script id="template_window_simple_dialog_v2" type="text/template">
<div class="subWindowBase-grn" id="window_dialog_v2" role="dialog">
    <div class="subwindow_title_grn" id="window_dialog_header">
      <span class="subwindow_title_base_grn nowrap-grn"><a href="javascript:void(0)" id="back_button" class="icon_back_grn icon_inline_grn mLeft10">{cb_msg module='grn.grn' key='grn.dialog.link.go_back' replace='true'}</a><h2 id="window_title" class="subWindowTitleText-grn nowrap-grn inline_block_grn"></h2></span>
      <a href="javascript:;"><div id="window_dialog_close" class="subWindowClose-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"></div></a>
      <div class="clear_both_0px"></div>
    </div>
    <div class="subWindowContent-grn" id="window_content">
        <div class="content" style="min-height: 120px;">
            <div class="tAlignCenter-grn" style=" margin-top: 30px; margin-right: auto; margin-left: auto; width: 570px; height: 90px;">
            </div>
        </div>
    </div>
</div>
</script>
<script id="template_window_simple_dialog_v1" type="text/template">
<div class="subWindowBase-grn" id="window_dialog_v1" style="display:none;">
    <table class="subWindowTable-grn">
        <tr id="window_dialog_header">
            <td class="subWindowTitleLeft-grn"><div id="window_title" class="subWindowTitleText-grn"></div></td>
            <td class="subWindowTitleRight-grn"><div id="window_dialog_close"  class="subWindowClose-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"></div></td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="subWindowContent-grn" id="window_content">
                    {grn_image image='spinner.gif'}
                </div>
            </td>
        </tr>
    </table>
</div>
</script>
