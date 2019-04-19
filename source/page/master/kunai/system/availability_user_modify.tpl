{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='kunai/system/command_'|cat:$page_info.last}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="itype" value="{$itype}">
  <input type="hidden" name="itid" value="{$itid}">
  <p></p>
  <table class="std_form">
    <tr>
      <th>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-21' replace='true'}</th>
      <td>
        {if $itype == 'user'}
          {grn_user_name uid=$availability->getUserId()}
        {elseif $itype == 'group'}
          {grn_organize_name gid=$availability->getGroupId()}
        {elseif $itype == 'static_role'}
          {grn_image image='role20.gif'}{grn_role_name rid=$availability->getStaticRoleId()}
        {elseif $itype == 'dynamic_role'}
          {grn_image image='role20.gif'}{$availability->getDynamicRole()|escape}
        {/if}
      </td>
    </tr>
    <tr>
      <th>{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-22' replace='true'}</th>
      <td>
        {assign var='app_status' value=$availability->getAppStatus()}
        {foreach from=$apps item=app}
          {capture name='app_name'}{if 'schedule' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-2' replace='true'}
                                   {elseif 'message' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-3' replace='true'}
                                   {elseif 'workflow' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-4' replace='true'}
                                   {elseif 'mail' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-5' replace='true'}
                                   {elseif 'address' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-6' replace='true'}
                                   {elseif 'space' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-32' replace='true'}
                                   {elseif 'bulletin' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-33' replace='true'}
                                   {elseif 'report' == $app}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-34' replace='true'}{/if}
          {/capture}
          {grn_checkbox name=$app id="app_$app" value='1' checked=$app_status.$app caption=$smarty.capture.app_name}&nbsp;
        {/foreach}
      </td>
    </tr>
    <tr>
      <td></td>
      <td>
        {capture name='grn_kunai_system_GRN_KUNAI_SY_23'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-23' replace='true'}{/capture}
        {grn_button_submit class='margin' caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_23}
        {grn_button_cancel}
      </td>
    </tr>
  </table>
</form>