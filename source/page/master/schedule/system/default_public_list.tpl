{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div class="explanation">
  {strip}
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-639' replace='true'}
    <span class="bold">{grn_user_name uid=$user_id}</span>
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-640' replace='true'}
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-641' replace='true'}
  {/strip}
</div>

{assign var='page_dir' value='schedule/system'}
{assign var='page_prefix' value='schedule/system/'}

<table width="100%" class="mTop10">
  <tr valign="top">
    <td width="60%">

      <form name="{$form_name}" method="post" action="{grn_pageurl page="`$page_prefix`default_public_delete_multi"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        {foreach from=$ous_params key=key item=item}
          <input type="hidden" name="{$key}" value="{$item|escape}">
        {/foreach}

        <div class="set_sub_menu_part_grn">
          <span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-642' replace='true'}</span>&nbsp;
          {if count($default_public_list) < 2}
            {assign var='disable_order' value=TRUE}
          {/if}
          {if count($default_public_list) == 0}
            {assign var='disable_delete_all' value=TRUE}
          {/if}
          <span class="m_small">{capture name='grn_schedule_system_GRN_SCH_SY_643'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-643' replace='true'}{/capture}{grn_link image='write20.gif' page="`$page_prefix`default_public_add" params=$ous_params reset=1 oid=$org_id uid=$user_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_643 element_id="`$page_prefix`default_public_add"}</span>
          <span class="m_small">{capture name='grn_schedule_system_GRN_SCH_SY_644'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-644' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`default_public_order" params=$ous_params oid=$org_id uid=$user_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_644 disabled=$disable_order element_id="`$page_prefix`default_public_order"}</span>
          <span class="m_small">{capture name='grn_schedule_system_GRN_SCH_SY_645'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-645' replace='true'}{/capture}{grn_link image='delete20.gif' page="`$page_prefix`default_public_delete_all" params=$ous_params oid=$org_id uid=$user_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_645 disabled=$disable_delete_all element_id="`$page_prefix`default_public_delete_all"}</span>
        </div>
        {strip}
          <div class="mTop5 mBottom5">
            <span class="mRight10">{include file='grn/checkall.tpl' elem_name='eid[]' schedule_flag=true}</span>
            <span class="m_small">{capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}</span>
          </div>
        {/strip}

        <table class="admin_list_table">
          <colgroup>
            <col width="3%">
            <col width="97%">
          </colgroup>
          <tr>
            <th></th>
            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-646' replace='true'}</th>
          </tr>
          {foreach from=$default_public_list item=item}
            {assign var='value' value="`$item.type`:`$item.id`"}
            <tr>
              <td>{grn_checkbox name='eid[]' id="eid_`$value`" value=$value}</td>
              {if 'user' == $item.type}
                {capture name='grn_get_group_path_string_eid'}u_{$item.id}{/capture}
                <td class="m_small">{grn_user_name uid=$item.id users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
              {elseif 'group' == $item.type}
                {capture name='grn_get_group_path_string_eid'}o_{$item.id}{/capture}
                <td class="m_small">{grn_organize_name gid=$item.id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
              {elseif 'static_role' == $item.type}
                <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$item.id}</td>
              {/if}
            </tr>
          {/foreach}
        </table>
        {strip}
          <div class="mTop5 mBottom5">
          <span class="mRight10">
            {include file='grn/checkall.tpl' elem_name='eid[]' schedule_flag=true}
          </span>
            <span class="m_small">
            {capture name='grn_grn_GRN_GRN_533'}{cb_msg module='grn.grn' key='GRN_GRN-533' replace='true'}{/capture}
              {grn_button_submit caption=$smarty.capture.grn_grn_GRN_GRN_533 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
          </span>
          </div>
        {/strip}
      </form>
    </td>
    <td width="30%"></td>
  </tr>
</table>

{include file='grn/system_footer.tpl'}
