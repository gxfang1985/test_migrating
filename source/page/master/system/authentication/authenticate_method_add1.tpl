{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-68' replace='true'}
  </th>
  <td>
       {foreach from=$authenticate_driver key=index item=authenticate_driver}
        {if $authenticate_driver.type == $selected_authenticate_driver_type}
         {grn_radio name='driver_type' id=type$index value=$authenticate_driver.type caption=$authenticate_driver.title checked=true}<br>
        {else}
         {grn_radio name='driver_type' id=type$index value=$authenticate_driver.type caption=$authenticate_driver.title}<br>
        {/if}
       {/foreach}
  </td>
 </tr>
 <tr>
  <td colspan="2">
       <br/>
       {cb_msg module='grn.system.authentication' key='GRN_SY_AU-69' replace='true'}.{cb_msg module='grn.system.authentication' key='GRN_SY_AU-70' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_GRN_SY_AU_71'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-71' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_71}
       {capture name='grn_system_authentication_GRN_SY_AU_72'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-72' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_72 page='system/authentication/authenticate_method_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
