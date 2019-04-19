{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul style="line-height:2em">
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-61' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_62'}{cb_msg module='grn.system.user' key='GRN_SY_US-62' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/organization_export' oid='' caption=$smarty.capture.grn_system_user_GRN_SY_US_62}
 <li>{capture name='grn_system_user_GRN_SY_US_63'}{cb_msg module='grn.system.user' key='GRN_SY_US-63' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/organization_user_export' oid='' caption=$smarty.capture.grn_system_user_GRN_SY_US_63}
 <li>{capture name='grn_system_user_GRN_SY_US_699'}{cb_msg module='grn.system.user' key='GRN_SY_US-699' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/organization_name_export' oid='' caption=$smarty.capture.grn_system_user_GRN_SY_US_699}
 </ul>
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-64' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_65'}{cb_msg module='grn.system.user' key='GRN_SY_US-65' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/user_export' caption=$smarty.capture.grn_system_user_GRN_SY_US_65}
{if $is_admin}
 <li>{capture name='grn_system_user_GRN_SY_US_66'}{cb_msg module='grn.system.user' key='GRN_SY_US-66' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/user_organization_export' caption=$smarty.capture.grn_system_user_GRN_SY_US_66}
 <li>{capture name='grn_system_user_GRN_SY_US_67'}{cb_msg module='grn.system.user' key='GRN_SY_US-67' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/user_role_export' caption=$smarty.capture.grn_system_user_GRN_SY_US_67}
{/if}
 </ul>
{if $is_admin}
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-68' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_69'}{cb_msg module='grn.system.user' key='GRN_SY_US-69' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/role_export' caption=$smarty.capture.grn_system_user_GRN_SY_US_69}
 <li>{capture name='grn_system_user_GRN_SY_US_70'}{cb_msg module='grn.system.user' key='GRN_SY_US-70' replace='true'}{/capture}{grn_link image='export20.gif' page='system/user/role_user_export' caption=$smarty.capture.grn_system_user_GRN_SY_US_70}
 </ul>
{/if}
</ul>

{include file="grn/system_footer.tpl"}
