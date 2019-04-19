
{foreach from=$system_js item=url}
    {grn_load_javascript file=$url}
{/foreach}

{foreach from=$application_js item=url}
        {grn_load_javascript file=$url}
{/foreach}

{foreach from=$application_init_data key=module item=init_data}
    {grn_customization_init_data module=$module init_data=$init_data}
{/foreach}

{if $is_forest}
    <script>grn.js.component.customization.logging.init('garoon'); </script>
{/if}

{foreach from=$user_js item=url}
    <script src="{$url}" type="text/javascript"></script>
{/foreach}

{foreach from=$user_css item=url}
    <link href="{$url}" rel="stylesheet" type="text/css">
{/foreach}

{foreach from=$event_info key=event_name item=event_data}
    {grn_customization_event_trigger event_name=$event_name data=$event_data trigger_event_on_load=$trigger_event_on_load}
{/foreach}
