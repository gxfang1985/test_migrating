{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_portal_system_GRN_POT_SY_141'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-141' replace='true'}{/capture}{grn_link image='import20.gif' page='portal/system/html_portlet_import' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_141 element_id='portal/system/html_portlet_import'}
<li>{capture name='grn_portal_system_GRN_POT_SY_531'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-531' replace='true'}{/capture}{grn_link image='import20.gif' page='portal/system/html_portlet_name_import1' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_531 element_id='portal/system/html_portlet_name_import1'}
{if $smarty.const.ON_FOREST !== 1}
<li>{capture name='grn_portal_system_GRN_POT_SY_142'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-142' replace='true'}{/capture}{grn_link image='import20.gif' page='portal/system/php_portlet_import' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_142 element_id='portal/system/php_portlet_import'}
<li>{capture name='grn_portal_system_GRN_POT_SY_532'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-532' replace='true'}{/capture}{grn_link image='import20.gif' page='portal/system/php_portlet_name_import1' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_532 element_id='portal/system/php_portlet_name_import1'}
{/if}
</ul>

{include file="grn/system_footer.tpl"}
