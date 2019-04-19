{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/common.tpl'}
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
{capture name='explanation1'}{cb_msg module='grn.bulletin' key='GRN_BLLT-615' replace='true'}{/capture}
{capture name='explanation2'}{cb_msg module='grn.bulletin' key='GRN_BLLT-616' replace='true'}{/capture}
{include file='grn/_copy_multi.tpl'
          object="category"
          classification="access"
          display_model=true
          confirm_link="bulletin/system/ajax_access_copy_multi_confirm"
          form_page="bulletin/system/access_copy_multi"
          cancel_page="bulletin/system/access_list"}
{include file='grn/system_footer.tpl'}
