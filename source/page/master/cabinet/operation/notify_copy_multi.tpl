{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file='grn/common.tpl'}
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
{capture name='explanation1'}{cb_msg module='grn.cabinet' key='GRN_CAB-296' replace='true'}{/capture}
{capture name='explanation2'}{cb_msg module='grn.cabinet' key='GRN_CAB-297' replace='true'}{/capture}
{include file='grn/_copy_multi.tpl'
          object="folder"
          classification="notify"
          display_model=false
          confirm_link="cabinet/operation/ajax_notify_copy_multi_confirm"
          form_page="cabinet/operation/notify_copy_multi"
          cancel_page="cabinet/operation/notify_list"}
{include file='grn/footer.tpl'}
