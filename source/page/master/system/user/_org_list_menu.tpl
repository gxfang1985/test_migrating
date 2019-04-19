{if !$license_deny}
 {if $is_admin || !$is_root}
<div id="main_menu_part" style="margin-top: 5px; margin-bottom: 10px;">
  {if !$is_sandbox_page}
<span class="menu_item">
  {capture name='grn_system_user_GRN_SY_US_19'}{cb_msg module='grn.system.user' key='GRN_SY_US-19' replace='true'}{/capture}{grn_link image='user20.gif' page="$dir_name/org_user_add" oid=$org_id caption=$smarty.capture.grn_system_user_GRN_SY_US_19 element_id="system-org-user-add"}
</span>
  {/if}
  {if !$is_root}
<span class="menu_item">
  {capture name='grn_system_user_GRN_SY_US_20'}{cb_msg module='grn.system.user' key='GRN_SY_US-20' replace='true'}{/capture}{grn_link class='menu_item' image='modify20.gif' page="$dir_name/org_user_assign" oid=$org_id reset=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_20 element_id="system-org-user-assign"}
</span>
  {/if}
  {if !$is_nogroups && !$is_deactive}
<span class="menu_item">
   {if $is_root}
  {capture name='grn_system_user_GRN_SY_US_21'}{cb_msg module='grn.system.user' key='GRN_SY_US-21' replace='true'}{/capture}{grn_link image='organize20.gif' page="$dir_name/org_add" oid='' caption=$smarty.capture.grn_system_user_GRN_SY_US_21 element_id="system-org-add" disabled=$is_sandbox_status_not_initial}
   {else}
  {capture name='grn_system_user_GRN_SY_US_22'}{cb_msg module='grn.system.user' key='GRN_SY_US-22' replace='true'}{/capture}{grn_link image='organize20.gif' page="$dir_name/org_add" oid=$org_id caption=$smarty.capture.grn_system_user_GRN_SY_US_22 element_id="system-org-add" disabled=$is_sandbox_status_not_initial}
   {/if}
</span>
  {/if}
  {if !$is_nogroups && !$is_deactive}
<span class="menu_item">
   {if $is_root}
  {capture name='grn_system_user_GRN_SY_US_23'}{cb_msg module='grn.system.user' key='GRN_SY_US-23' replace='true'}{/capture}{grn_link image='order20.gif' page="$dir_name/org_order" caption=$smarty.capture.grn_system_user_GRN_SY_US_23 disabled=$is_sandbox_status_not_initial}
   {else}
  {capture name='grn_system_user_GRN_SY_US_24'}{cb_msg module='grn.system.user' key='GRN_SY_US-24' replace='true'}{/capture}{grn_link image='order20.gif' page="$dir_name/org_order" oid=$org_id caption=$smarty.capture.grn_system_user_GRN_SY_US_24 disabled=$is_sandbox_status_not_initial}
   {/if}
</span>
  {/if}
  {if $transferable && !$is_nogroups && !$is_deactive}
<span class="menu_item">
  {capture name='grn_system_user_GRN_SY_US_25'}{cb_msg module='grn.system.user' key='GRN_SY_US-25' replace='true'}{/capture}{grn_link image='manage20.gif' page="$dir_name/org_privilege_list" oid=$org_id reset=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_25}
</span>
  {/if}
</div>
 {/if}
{/if}
