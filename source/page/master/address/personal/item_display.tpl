{capture name='explanation'}{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-1' replace='true'}{/capture}
{* address/_book_index.tplのgrn_linkでエスケープされるのでしない *}
{assign var='application_name' value=$resources.application_name}
{include file='address/_book_index.tpl' config_id='personal' explanation=$smarty.capture.explanation userlist_page='user_item_display' private_book_page='book_item_display' private_book_id='-1' shared_book_page='book_item_display'}
