{capture name='grn_rss_system_GRN_RSS_SY_1'}{cb_msg module='grn.rss.system' key='GRN_RSS_SY-1' replace='true'}{/capture}{capture name='grn_rss_system_GRN_RSS_SY_2'}{cb_msg module='grn.rss.system' key='GRN_RSS_SY-2' replace='true'}{/capture}{include file='rss/_std_form.tpl' config_id='system' post_page='rss/system/command_add' attention='1' explanation=$smarty.capture.grn_rss_system_GRN_RSS_SY_1 code_title='URL' code_explanation=$smarty.capture.grn_rss_system_GRN_RSS_SY_2}
