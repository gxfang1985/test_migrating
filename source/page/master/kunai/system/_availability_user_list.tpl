{**
 *  KUNAIの利用ユーザーの一覧画面のテンプレート
 *  @param  array          display_apps        display application(s) controlled by kunai
 *  @param  int            display_apps_count  display application(s) count
 *  @param  collection     dynamic_roles       dynamic role collection
 *  @param  collection     groups              group collection
 *  @param  collection     static_roles        static role collection
 *  @param  collection     users               user collection
 *  @param  int            total_count         item count that all collections contain
 *  @param  string         page_prefix         一覧の画面名のプレフィックス
 *}

<table width="100%">
  <tr valign="top">
    <td width="60%">
      <form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'availability_user_delete_multi'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
         <input type="hidden" name="selected_dynamic_roles[string]" value="">
         <input type="hidden" name="selected_static_roles[string]" value="">
         <input type="hidden" name="selected_groups[string]" value="">
         <input type="hidden" name="selected_users[string]" value="">
        <div>
          <span class="sub_title">{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-18' replace='true'}&nbsp;{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-19' replace='true'}{$total_count}&nbsp;{if $total_count > 1}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-20' replace='true'}{else}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-16' replace='true'}{/if}</span>&nbsp;
          {if $total_count == 0}{assign var='disable_delete_all' value=TRUE}{/if}
          <span class="m_small">{capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_add" reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1518 }</span>
          <span class="m_small">{capture name='grn_kunai_system_GRN_KUNAI_SY_17'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-17' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`availability_user_delete_all" caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_17 disabled=$disable_delete_all}</span>
        </div>
        <div>
          <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp;
          <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; else grn_onsubmit_common(this.form, 'eid[]');"}</span>
        </div>
        <table class="admin_list_table">
          <colgroup>
            <col width="3%">
            <col width="30%">
            {if $display_apps_count == 1}
              <col width="60%" align="center">
            {elseif $display_apps_count == 2}
              <col width="30%" align="center">
              <col width="30%" align="center">
            {elseif $display_apps_count == 3}
              <col width="20%" align="center">
              <col width="20%" align="center">
              <col width="20%" align="center">
            {elseif $display_apps_count == 4}
              <col width="15%" align="center">
              <col width="15%" align="center">
              <col width="15%" align="center">
              <col width="15%" align="center">
            {elseif $display_apps_count == 5}
              <col width="12%" align="center">
              <col width="12%" align="center">
              <col width="12%" align="center">
              <col width="12%" align="center">
              <col width="12%" align="center">
            {/if}
            <col width="7%">
          </colgroup>
          <tr>
            <th></th>
            <th nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-21' replace='true'}</th>
            {foreach from=$display_apps key=key item=item}
              {if 'schedule' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-2' replace='true'}</th>
              {elseif 'message' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-3' replace='true'}</th>
              {elseif 'workflow' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-4' replace='true'}</th>
              {elseif 'mail' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-5' replace='true'}</th>
              {elseif 'address' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-6' replace='true'}</th>
              {elseif 'space' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-32' replace='true'}</th>
              {elseif 'bulletin' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-33' replace='true'}</th>
              {elseif 'report' == $item}
                <th style="text-align:center" nowrap>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-34' replace='true'}</th>
              {/if}
            {/foreach}
            <th nowrap>&nbsp;</th>
          </tr>
          <!-- dynamic role -->
          {foreach from=$dynamic_roles item=dynamic_role}
            <tr>
              <td>{grn_checkbox name='eid[]' id='dynamic_role:'|cat:$dynamic_role->getDynamicRole() value='dynamic_role:'|cat:$dynamic_role->getDynamicRole()}</td>
              <td class="m_small">{grn_image image='role20.gif'}{$dynamic_role->getDynamicRole()|escape}</td>
              {assign var='app_status' value=$dynamic_role->getAppStatus()}
              {foreach from=$display_apps item=app}
                <td align="center">{if $app_status.$app}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-606' replace='true'}</span>{/if}</td>
              {/foreach}
              <td class="m_small" nowrap>{capture name='grn_grn_GRN_GRN_608'}{cb_msg module='grn.grn' key='GRN_GRN-608' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_modify" caption=$smarty.capture.grn_grn_GRN_GRN_608 itype='dynamic_role' itid=$dynamic_role->getDynamicRole()}</td>
            </tr>
          {/foreach}
          <!-- static_roles -->
          {foreach from=$static_roles item=static_role}
            <tr>
              <td>{grn_checkbox name='eid[]' id='static_role:'|cat:$static_role->getStaticRoleId() value='static_role:'|cat:$static_role->getStaticRoleId()}</td>
              <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$static_role->getStaticRoleId()}</td>
              {assign var='app_status' value=$static_role->getAppStatus()}
              {foreach from=$display_apps item=app}
                <td align="center">{if $app_status.$app}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-606' replace='true'}</span>{/if}</td>
              {/foreach}
              <td class="m_small" nowrap>{capture name='grn_grn_GRN_GRN_608'}{cb_msg module='grn.grn' key='GRN_GRN-608' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_modify" caption=$smarty.capture.grn_grn_GRN_GRN_608 itype='static_role' itid=$static_role->getStaticRoleId()}</td>
            </tr>
          {/foreach}
          <!-- group -->
          {foreach from=$groups item=group}
            <tr>
              <td>{grn_checkbox name='eid[]' id='group:'|cat:$group->getGroupId() value='group:'|cat:$group->getGroupId()}</td>
              {capture name='grn_get_group_path_string_eid'}o_{$group->getGroupId()}{/capture}
              <td class="m_small">{grn_organize_name gid=$group->getGroupId()}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
              {assign var='app_status' value=$group->getAppStatus()}
              {foreach from=$display_apps item=app}
                <td align="center">{if $app_status.$app}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-606' replace='true'}</span>{/if}</td>
              {/foreach}
              <td class="m_small" nowrap>{capture name='grn_grn_GRN_GRN_608'}{cb_msg module='grn.grn' key='GRN_GRN-608' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_modify" caption=$smarty.capture.grn_grn_GRN_GRN_608 itype='group' itid=$group->getGroupId()}</td>
            </tr>
          {/foreach}
          <!-- users -->
          {foreach from=$users item=user}
            <tr>
              <td>{grn_checkbox name='eid[]' id='user:'|cat:$user->getUserId() value='user:'|cat:$user->getUserId()}</td>
              {capture name='grn_get_group_path_string_eid'}u_{$user->getUserId()}{/capture}
              <td class="m_small">{grn_user_name uid=$user->getUserId()}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
              {assign var='app_status' value=$user->getAppStatus()}
              {foreach from=$display_apps item=app}
                <td align="center">{if $app_status.$app}{grn_image image='check20.gif'}{else}<span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-606' replace='true'}</span>{/if}</td>
              {/foreach}
              <td class="m_small" nowrap>{capture name='grn_grn_GRN_GRN_608'}{cb_msg module='grn.grn' key='GRN_GRN-608' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`availability_user_modify" caption=$smarty.capture.grn_grn_GRN_GRN_608 itype='user' itid=$user->getUserId()}</td>
            </tr>
          {/foreach}
        </table>
        <div>
          <span>{include file='grn/checkall.tpl' elem_name='eid[]'}</span>&nbsp;
          <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false; else grn_onsubmit_common(this.form, 'eid[]');"}</span>
        </div>
      </form>
    </td>
    <td width="30%">
    </td>
  </tr>
</table>

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
            else if( chk_value[0] == 'static_role' )
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