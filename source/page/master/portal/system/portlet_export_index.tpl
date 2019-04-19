{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_portal_system_GRN_POT_SY_348'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-348' replace='true'}{/capture}{grn_link image='export20.gif' page='portal/system/html_portlet_export1' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_348}
<li>{capture name='grn_portal_system_GRN_POT_SY_517'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-517' replace='true'}{/capture}{grn_link image='export20.gif' page='portal/system/html_portlet_name_export' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_517}
{if $smarty.const.ON_FOREST !== 1}
<li>{capture name='grn_portal_system_GRN_POT_SY_349'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-349' replace='true'}{/capture}{grn_link image='export20.gif' page='portal/system/php_portlet_export1' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_349}
<li>{capture name='grn_portal_system_GRN_POT_SY_518'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-518' replace='true'}{/capture}{grn_link image='export20.gif' page='portal/system/php_portlet_name_export' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_518}
{/if}
</ul>

{include file="grn/system_footer.tpl"}
