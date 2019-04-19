{capture name='explanation'}{cb_msg module='grn.rss.personal' key='GRN_RSS_PE-10' replace='true'}{/capture}
{include file='grn/std_popup_delete.tpl' config_id='personal' form_name='rss/personal/separator_delete' post_page='rss/personal/command_separator_delete' explanation=$smarty.capture.explanation}
