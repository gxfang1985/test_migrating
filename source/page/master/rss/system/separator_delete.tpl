{capture name='explanation'}{cb_msg module='grn.rss.system' key='GRN_RSS_SY-10' replace='true'}{/capture}
{include file='grn/std_delete.tpl' config_id='system' post_page='rss/system/command_separator_delete' explanation=$smarty.capture.explanation}
