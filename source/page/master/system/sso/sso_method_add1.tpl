{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.sso' key='GRN_SY_SS-22' replace='true'}</th>
  <td>
       {foreach from=$sso_driver key=index item=sso_driver}
        {if $index === 0}
         {grn_radio name='driver_type' id=type$index value=$sso_driver.type caption=$sso_driver.title checked=true}<br>
        {else}
         {grn_radio name='driver_type' id=type$index value=$sso_driver.type caption=$sso_driver.title}<br>
        {/if}
       {/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.sso' key='GRN_SY_SS-23' replace='true'}</th>
  <td>{grn_select name='said' options=$application_options}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_sso_GRN_SY_SS_24'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-24' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_sso_GRN_SY_SS_24}
       {capture name='grn_system_sso_GRN_SY_SS_25'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-25' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_sso_GRN_SY_SS_25 page='system/sso/sso_method_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
