{capture name='list_title'}{cb_msg module="grn.space" key="space_mobile-6" replace='true'}{/capture}
{include file='grn/mobile_member_index.tpl' trigger_create='true' list_title=$smarty.capture.list_title request_page='space/mobile/ajax/member_list'}
