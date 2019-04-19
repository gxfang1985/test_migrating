{grn_load_javascript file="/grn/html/mobile_error_handler.js"}
{literal}
<script text="text/javascript">
    grn.component.mobile_error_handler.Msg = {
        'theme':"{/literal}{$data_theme}{literal}",
        'Error':'{/literal}{cb_msg module="fw.error" key="Error"|escape:javascript}{literal}',
        'Cause':'{/literal}{cb_msg module="fw.error" key="Cause"|escape:javascript}{literal} ',
        'CounterMeasure':'{/literal}{cb_msg module="fw.error" key="Counter Measure"|escape:javascript}{literal}',
        'OK':'{/literal}{cb_msg module="grn.common" key="ok" replace="true"}{literal}',
        'GRN_GRN_33':'{/literal}{cb_msg module="grn" key="GRN_GRN-33" replace="true"}{literal}',
        'GRN_GRN_34':'{/literal}{cb_msg module="grn" key="GRN_GRN-34" replace="true"}{literal}',
        'GRN_GRN_35':'{/literal}{cb_msg module="grn" key="GRN_GRN-35" replace="true"}{literal}',
        'GRN_GRN_36':'{/literal}{cb_msg module="grn" key="GRN_GRN-36" replace="true"}{literal}',
        'GRN_GRN_37':'{/literal}{cb_msg module="grn" key="GRN_GRN-37" replace="true"}{literal}',
        'GRN_GRN_38':'{/literal}{cb_msg module="grn" key="GRN_GRN-38" replace="true"}{literal}',
        'show_backtrace':"{/literal}{$show_backtrace}{literal}"
    };
</script>
{/literal}
