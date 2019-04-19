{include file="grn/error_handler.tpl"}
{include file="grn/show_validation_errors.tpl"}
<div id="show_validation_errors" style="display: none"></div>
{grn_load_javascript file="grn/html/component/ajax_submit.js"}
<img id="ajax_submit_spinner" style="position: absolute;display: none;z-index: 101;" src="{$app_path}/grn/image/cybozu/image-mobile/spinner.gif?{$build_date}">
