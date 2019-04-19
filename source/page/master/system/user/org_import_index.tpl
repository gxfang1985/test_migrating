{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $is_sandbox_status_not_initial}
<div class="info_area_grn mBottom15 mTop15">
    <div class="icon_information_grn">
        <span>
            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-IMPORT-1' replace='true'}
        </span>
    </div>
</div>
{/if}
<ul style="line-height:2em">
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-295' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_296'}{cb_msg module='grn.system.user' key='GRN_SY_US-296' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/organization_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_296 disabled=$is_sandbox_status_not_initial}
 <li>{capture name='grn_system_user_GRN_SY_US_297'}{cb_msg module='grn.system.user' key='GRN_SY_US-297' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/organization_user_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_297}
 <li>{capture name='grn_system_user_GRN_SY_US_699'}{cb_msg module='grn.system.user' key='GRN_SY_US-699' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/organization_name_import1' oid='' caption=$smarty.capture.grn_system_user_GRN_SY_US_699 disabled=$is_sandbox_status_not_initial}
 </ul>
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-298' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_299'}{cb_msg module='grn.system.user' key='GRN_SY_US-299' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/user_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_299}
{if $is_admin}
 <li>{capture name='grn_system_user_GRN_SY_US_300'}{cb_msg module='grn.system.user' key='GRN_SY_US-300' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/user_organization_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_300}
 <li>{capture name='grn_system_user_GRN_SY_US_301'}{cb_msg module='grn.system.user' key='GRN_SY_US-301' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/user_role_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_301}
{/if}
 </ul>
{if $is_admin}
<li><span class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-302' replace='true'}</span>
 <ul>
 <li>{capture name='grn_system_user_GRN_SY_US_303'}{cb_msg module='grn.system.user' key='GRN_SY_US-303' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/role_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_303}
 <li>{capture name='grn_system_user_GRN_SY_US_304'}{cb_msg module='grn.system.user' key='GRN_SY_US-304' replace='true'}{/capture}{grn_link image='import20.gif' page='system/user/role_user_import1' caption=$smarty.capture.grn_system_user_GRN_SY_US_304}
 </ul>
{/if}
</ul>

{include file="grn/system_footer.tpl"}
