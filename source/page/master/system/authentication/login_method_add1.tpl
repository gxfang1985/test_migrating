{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-26' replace='true'}
  </th>
  <td>
       {foreach from=$login_driver key=index item=login_driver}
        {if $login_driver.type == $selected_login_driver_type}
         {grn_radio name='driver_type' id=type$index value=$login_driver.type caption=$login_driver.title checked=true}<br>
        {else}
         {grn_radio name='driver_type' id=type$index value=$login_driver.type caption=$login_driver.title}<br>
        {/if}
       {/foreach}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_GRN_SY_AU_27'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-27' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_27}
       {capture name='grn_system_authentication_GRN_SY_AU_28'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-28' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_28 page='system/authentication/login_method_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
