{capture name='explanation'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-224' replace='true'}{/capture}
{capture name='grn_address_system_GRN_ADDR_SYS_225'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-225' replace='true'}{/capture}{assign var='application_name' value=$smarty.capture.grn_address_system_GRN_ADDR_SYS_225}
{include file='address/_book_index.tpl' config_id='system' explanation=$smarty.capture.explanation private_book_page='item_list' private_book_id='-1' shared_book_page='item_list'}
