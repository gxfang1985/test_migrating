{capture name='prev_button'}
{capture name='grn_address_operation_GRN_ADDR_OP_89'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-89' replace='true'}{/capture}{grn_button_cancel class="margin" page='address/operation/import1' charset=$charset skip=$skip bid=$form.hiddens.bid caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_89}
{/capture}
{capture name='cancel_button'}
{grn_button_cancel class="margin" page='address/index' bid=$form.hiddens.bid}
{/capture}
{include file='address/_csv_columns.tpl'}
{include file='grn/std_import2.tpl' prev_button=$smarty.capture.prev_button cancel_button=$smarty.capture.cancel_button column_explanation=$smarty.capture.explanation}