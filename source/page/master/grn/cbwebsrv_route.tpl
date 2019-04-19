{grn_load_javascript file="grn/html/component/window_simple_dialog.js"}
{grn_load_javascript file="grn/html/component/transit_search.js"}
{grn_load_template_one_time file="grn/window_simple_dialog.tpl"}
{strip}
<span class="{$button_class}" role="button">
    <a class="js_route_button_element" title="{$error_message}" href="javascript:void (0)" data-route='{$json_route_data}'>
        <span>{$caption}</span>
    </a>
</span>
{/strip}
{literal}
<script type='text/javascript'>
    jQuery(document).ready(function () {
        new grn.component.TransitSearch('{/literal}{$route_data_container_selector}{literal}');
    });
</script>
{/literal}
