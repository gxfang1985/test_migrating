{capture name='prev_button'}
{capture name='grn_address_system_GRN_ADDR_SYS_62'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-62' replace='true'}{/capture}{grn_button_cancel class="margin" page='address/system/access_import1' charset=$charset skip=$skip bid=$form.hiddens.bid caption="<< "|cat:$smarty.capture.grn_address_system_GRN_ADDR_SYS_62}
{/capture}
{include file='address/_csv_columns.tpl'}
{include file='grn/std_import2.tpl' prev_button=$smarty.capture.prev_button column_explanation=$smarty.capture.explanation}
