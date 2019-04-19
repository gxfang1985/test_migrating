<?php
/***
 * @param $parameters
 *
 * @return string
 */
function smarty_function_grn_customization_event_trigger($parameters)
{
    $event_name = cb_at($parameters, 'event_name', '');
    $data = cb_at($parameters, 'data', []);
    if ( ! empty($data['no_trigger'])) {
        return '';
    }

    $json_data = json_encode($data);
    $trigger_event_on_load = cb_at($parameters, 'trigger_event_on_load', false);
    if ($trigger_event_on_load) {
        return "<script>jQuery(function(){garoon.events.trigger( '$event_name', $json_data );}); </script>";
    } else {
        return "<script>garoon.events.trigger( '$event_name', $json_data ); </script>";
    }
}
