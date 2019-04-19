{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cellular/system/command_login_method_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_cellular_system_GRN_CLLL_SY_8'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-8' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_8 necessary=true}
  </th>
  <td>
       {capture name='grn_cellular_system_GRN_CLLL_SY_9'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-9' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_9 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$login_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_cellular_system_GRN_CLLL_SY_10'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-10' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_10}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}

      <div class="mTop7 mBottom10">
          {capture name='grn_system_authentication_login_GRN_SY_AU_LO_38'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-38' replace='true'}{/capture}{grn_checkbox name='use_multi' id='system_use_multi_repository' value='1' caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_38  checked=$use_multi_repository disabled=$disabled_multi_repository}
      </div>

      <div id="system_multi_repository_table"{if !$use_multi_repository} style="display:none"{/if}>
          <p>{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-39' replace='true'}</p>
          <table class="list_column" style="width:100%;" border="1" cellspacing="0" cellpadding="2">
              <tr>
                  <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-31' replace='true'}</th>
                  <th nowrap>{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-72' replace='true'}</th>
                  <th nowrap>{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-40' replace='true'}</th>
              </tr>
              {foreach from=$repository_method_multi_options item=repository_method}
                  <tr valign="top">
                      <td>{$repository_method.display_name}</td>
                      <td>
                          {if $repository_method.driver_type == $smarty.const.GRN_AUTH_REPOSITORY_LDAP}
                              {include file="system/authentication/repository/_view_affix_condition.tpl" driver_settings=$repository_method.driver_settings}
                          {/if}
                      </td>
                      <td class="nowrap-grn">
                          {if $repository_method.selected}
                              {assign var="checked_1" value=true}
                              {assign var="checked_0" value=false}
                          {else}
                              {assign var="checked_1" value=false}
                              {assign var="checked_0" value=true}
                          {/if}
                          {capture name='grn_system_authentication_login_GRN_SY_AU_LO_41'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-41' replace='true'}{/capture}
                          {grn_radio name="multi_rmid[`$repository_method.rmid`]" id="multi_rmid_`$repository_method.rmid`_1" value=1 checked=$checked_1 caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_41}
                          {capture name='grn_system_authentication_login_GRN_SY_AU_LO_42'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-42' replace='true'}{/capture}
                          {grn_radio name="multi_rmid[`$repository_method.rmid`]" id="multi_rmid_`$repository_method.rmid`_0" value=0 checked=$checked_0 caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_42}
                      </td>
                  </tr>
              {/foreach}
          </table>
      </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_cellular_system_GRN_CLLL_SY_11'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-11' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_11}
       {capture name='grn_cellular_system_GRN_CLLL_SY_12'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-12' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_12 page='cellular/system/login_method_view'}
  </td>
 </tr>
</table>

</form>

{grn_load_javascript file="grn/html/page/cellular/system/login_method_modify.js"}

{include file='grn/system_footer.tpl'}
