{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{strip}
{capture name='grn_system_GRN_SY_AP_99'}{cb_msg module='grn.system.application' key='GRN_SY_AP-99' replace='true'}{/capture}
<table class="view_table mTop10 mBottom15" style="width:80%;">
    <tr>
        <th class="nowrap-grn" style="width:20%;">{cb_msg module='grn.system.application' key='GRN_SY_AP-82' replace='true'}</th>
        <td class="nowrap-grn" style="width:80%;">
            <span class="mRight15">{$external_access_setting_text}</span>
            <a href="{grn_pageurl page='system/application/external_access_detail'}">{grn_image image="detail20.gif"}{$smarty.capture.grn_system_GRN_SY_AP_99}</a>
        </td>
    </tr>
</table>
 <form name="{$form_name}" method="post" action="{grn_pageurl page="system/application/availability_user_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <input type="hidden" name="selected_dynamic_roles[string]" value="">
 <input type="hidden" name="selected_static_roles[string]" value="">
 <input type="hidden" name="selected_groups[string]" value="">
 <input type="hidden" name="selected_users[string]" value="">
{foreach from=$ours_params key=key item=item}
 <input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}

 <p></p>
 <div  class="set_sub_menu_part_grn">
 <span class="sub_title mRight10">{cb_msg module='grn.system.application' key='GRN_SY_AP-60' replace='true'}{cb_msg module='grn.system.application' key='GRN_SY_AP-61' replace='true'}{$user_total}{if $user_total > 1}{cb_msg module='grn.system.application' key='GRN_SY_AP-62' replace='true'}{else}{cb_msg module='grn.system.application' key='GRN_SY_AP-75' replace='true'}{/if}</span>
 {if $user_total == 0}
  {assign var='disable_delete_all' value=true}
 {/if}
 <span class="m_small">{capture name='grn_system_GRN_SY_AP_58'}{cb_msg module='grn.system.application' key='GRN_SY_AP-58' replace='true'}{/capture}{grn_link image='write20.gif' page="system/application/availability_user_add" reset=1 caption=$smarty.capture.grn_system_GRN_SY_AP_58 }</span>
 <span class="m_small">{capture name='grn_system_GRN_SY_AP_59'}{cb_msg module='grn.system.application' key='GRN_SY_AP-59' replace='true'}{/capture}{grn_link image='delete20.gif' page="system/application/availability_user_delete_all" caption=$smarty.capture.grn_system_GRN_SY_AP_59 disabled=$disable_delete_all}</span>
 </div>
 <div class="mTop5 mBottom5">
 <span class="mRight10">{include file='system/application/checkall.tpl' elem_name='eid[]' disabled=$disable_delete_all}</span>
 <span class="m_small">{capture name='grn_system_GRN_SY_AP_63'}{cb_msg module='grn.system.application' key='GRN_SY_AP-63' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_GRN_SY_AP_63 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; else grn_onsubmit_common(this.form, 'eid[]');"}</span>
 </div>
 <table class="admin_list_table list_column_grn list_column_style3_grn app_permission_set_base_grn" style="width: auto;">
 <tr>
  <th></th>
  <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-55' replace='true'}</th>
  <th>{cb_msg module='grn.system.application' key='GRN_SY_AP-56' replace='true'}</th>
  <th> </th>
 </tr>
{foreach from=$targets item=target key=type_target}
{foreach from=$target item=data key=data_id}
 <tr valign="middle">
 {if $type_target == 'dynamic_role'}
    {capture name='tmp'}{assign var=tmp value='dynamic_role:'|cat:$data_id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    <td class="m_small">{grn_image image='role20.gif'}{$data_id|escape}</td>
     <td class="iconapps nowrap-grn">
        {include file='grn/_apps.tpl'}
     </td>
     <td> {capture name='grn_system_GRN_SY_AP_50'}{cb_msg module='grn.system.application' key='GRN_SY_AP-50' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/application/availability_user_modify" params=$ours_params type=dynamic_role id=$data_id caption=$smarty.capture.grn_system_GRN_SY_AP_50 }</td>
 {elseif $type_target == 'cb_role'}
    {capture name='tmp'}{assign var=tmp value='role:'|cat:$data_id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$data_id}</td>
     <td class="iconapps">
         {include file='grn/_apps.tpl'}
     </td>
     <td> {capture name='grn_system_GRN_SY_AP_50'}{cb_msg module='grn.system.application' key='GRN_SY_AP-50' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/application/availability_user_modify" params=$ours_params type=cb_role id=$data_id caption=$smarty.capture.grn_system_GRN_SY_AP_50 }</td>
 {elseif $type_target == 'cb_group'}
    {capture name='tmp'}{assign var=tmp value='group:'|cat:$data_id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    {capture name='grn_get_group_path_string_eid'}o_{$data_id}{/capture}
    <td class="m_small">{grn_organize_name gid=$data_id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid groups_info=$groups_info}</td>
     <td class="iconapps">
         {include file='grn/_apps.tpl'}
     </td>
     <td> {capture name='grn_system_GRN_SY_AP_50'}{cb_msg module='grn.system.application' key='GRN_SY_AP-50' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/application/availability_user_modify" params=$ours_params type=cb_group id=$data_id caption=$smarty.capture.grn_system_GRN_SY_AP_50 }</td>
 {elseif $type_target == 'cb_user'}
    {capture name='tmp'}{assign var=tmp value='user:'|cat:$data_id}{/capture}
    <td>{grn_checkbox name='eid[]' id=$tmp value=$tmp}</td>
    {capture name='grn_get_group_path_string_eid'}u_{$data_id}{/capture}
    <td class="m_small">{grn_user_name uid=$data_id users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid users_info=$users_info}</td>
    <td class="iconapps">
        {include file='grn/_apps.tpl'}
    </td>
     <td>
         {capture name='grn_system_GRN_SY_AP_50'}{cb_msg module='grn.system.application' key='GRN_SY_AP-50' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/application/availability_user_modify" params=$ours_params type=cb_user id=$data_id caption=$smarty.capture.grn_system_GRN_SY_AP_50 }

     </td>
 {/if}
 </td>
 </tr>
 {/foreach}
{/foreach}
 </table>
  <div class="mTop5 mBottom5">
 <span class="mRight10">{include file='system/application/checkall.tpl' elem_name='eid[]' disabled=$disable_delete_all}</span>
 <span class="m_small">{capture name='grn_system_GRN_SY_AP_57'}{cb_msg module='grn.system.application' key='GRN_SY_AP-57' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_GRN_SY_AP_57 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; else grn_onsubmit_common(this.form, 'eid[]');"}</span>
 </div>
 </form>
{/strip}
{literal}
<script type="text/javascript">
<!--
function grn_onsubmit_common( form, name )
{
    if( typeof form.elements[name] == "undefined" ) return;
    var src = form.elements[name];
    var selected_dynamic_roles = form.elements['selected_dynamic_roles[string]'];
    selected_dynamic_roles.value = '';
    var selected_static_roles = form.elements['selected_static_roles[string]'];
    selected_static_roles.value = '';
    var selected_groups = form.elements['selected_groups[string]'];
    selected_groups.value = '';
    var selected_users = form.elements['selected_users[string]'];
    selected_users.value = '';
    var udelim = ':';
    if( typeof src.length == "undefined" )
    {
        src = new Array(src);
    }
    for( i = 0 ; i < src.length ; i ++ )
    {
        var chk = src[i];
        if( ! chk.checked ) continue;
        var chk_id = chk.value;
        var chk_value = chk.value.split(':');
        if( chk_value.length == 2 )
        {
            if( chk_value[0] == 'dynamic_role' )
            {
                if( selected_dynamic_roles.value == '' ) selected_dynamic_roles.value += chk_value[1];
                else selected_dynamic_roles.value += udelim + chk_value[1];
            }
            else if( chk_value[0] == 'role' )
            {
                if( selected_static_roles.value == '' ) selected_static_roles.value += chk_value[1];
                else selected_static_roles.value += udelim + chk_value[1];
            }
            else if( chk_value[0] == 'group' )
            {
                if( selected_groups.value == '' ) selected_groups.value += chk_value[1];
                else selected_groups.value += udelim + chk_value[1];
            }
            else if( chk_value[0] == 'user' )
            {
                if( selected_users.value == '' )selected_users.value += chk_value[1];
                else selected_users.value += udelim + chk_value[1];
            }
        }
        var child = document.getElementById(chk_id);
        child.disabled="disabled";
    }
}
//-->
</script>
{/literal}

{include file="grn/system_footer.tpl"}
