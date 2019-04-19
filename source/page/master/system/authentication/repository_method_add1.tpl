{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication' key='GRN_SY_AU-65' replace='true'}
  </th>
  <td>
       {foreach from=$repository_driver key=index item=repository_driver}
        {if $repository_driver.type == $selected_repository_driver_type}
         {grn_radio name='driver_type' id=type$index value=$repository_driver.type caption=$repository_driver.title checked=true}<br>
        {else}
         {grn_radio name='driver_type' id=type$index value=$repository_driver.type caption=$repository_driver.title}<br>
        {/if}
       {/foreach}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_GRN_SY_AU_66'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-66' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_66}
       {capture name='grn_system_authentication_GRN_SY_AU_67'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-67' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_67 page='system/authentication/repository_method_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
