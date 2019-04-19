{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div id="one_parts">
 <!--action--->
 <div id="action">
  <!--
  <div id="menubar_top">
   <ul id="menu">
    <li>{capture name='grn_system_application_GRN_SY_AP_1'}{cb_msg module='grn.system.application' key='GRN_SY_AP-1' replace='true'}{/capture}{grn_link page='system/application/add1' caption=$smarty.capture.grn_system_application_GRN_SY_AP_1 class='write20'}
   </ul>
  </div>
  -->
  <p>
  <div class="explanation">
   {cb_msg module='grn.system.application' key='GRN_SY_AP-2' replace='true'}
  </div>
  </p>
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-4' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-5' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-6' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-7' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-9' replace='true'}</th>
    {if $smarty.const.ON_FOREST != 1}
    <th nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-10' replace='true'}</th>
    {/if}
    <!--<th nowrap>&nbsp;</th>-->
   </tr>
{foreach from=$applications key=key item=application}
   <tr>
    <td nowrap>{if ! $application.active}<font color="red">{/if}{$key}{if ! $application.active}</font>{/if}</td>
 {if $application.active}
    <td nowrap><form name="{$page_info.last}" method="post" action="{grn_pageurl page='system/application/command_deactivate'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><input type="hidden" name="app_id" value="{$key}"><input type="submit" value="{cb_msg module='grn.system.application' key='GRN_SY_AP-11' replace='true'}"></form></td>
    <td nowrap>
{if !$application.not_rename}
     {grn_link page='system/application/app_changename' app_id=$key caption=$application.name image='modify20.gif'}
{else}
     {$smarty.capture.appname|grn_noescape}
{/if}
    </td>
    <td nowrap>{grn_default_appname app_id=$key}</td>
 {if ! $application.top_page}
    <td nowrap>&nbsp;</td>
 {else}
    <td nowrap><a href="{grn_pageurl page=$application.top_page app_id=$key}"target="appl_top_view">{cb_msg module='grn.system.application' key='GRN_SY_AP-12' replace='true'}{grn_image image='blank20.gif'}</a></td>
 {/if}
     {if $smarty.const.ON_FOREST != 1}
       {if ! $application.format}
          <td nowrap>{cb_msg module='grn.system.application' key='GRN_SY_AP-13' replace='true'}</td>
       {else}
          <td nowrap><form name="{$page_info.last}" method="post" action="{grn_pageurl page='system/application/command_initialize'}" onSubmit="return window.confirm('{cb_msg module='grn.system.application' key='GRN_SY_AP-14' replace='true'}');"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><input type="hidden" name="app_id" value="{$key}"><input type="submit" value="{cb_msg module='grn.system.application' key='GRN_SY_AP-15' replace='true'}"></form>
       {/if}
     {/if}
 {else}
    <td nowrap><form name="{$page_info.last}" method="post" action="{grn_pageurl page='system/application/command_activate'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><input type="hidden" name="app_id" value="{$key}"><input type="submit" value="{cb_msg module='grn.system.application' key='GRN_SY_AP-16' replace='true'}"></form></td>
    <td nowrap>&nbsp;</td>
    <td nowrap>&nbsp;</td>
    <td nowrap>&nbsp;</td>
    {if $smarty.const.ON_FOREST != 1}
    <td nowrap>&nbsp;</td>
    {/if}
 {/if}
 <!--
 {if !$application.not_uninstall}
    <td nowrap><form name="{$page_info.last}" method="post" action="{grn_pageurl page='system/application/command_delete'}" onSubmit="return window.confirm('{cb_msg module='grn.system.application' key='GRN_SY_AP-17' replace='true'}');"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><input type="hidden" name="app_id" value="{$key}"><input type="submit" value="{cb_msg module='grn.system.application' key='GRN_SY_AP-18' replace='true'}"></form>
 {else}
    <td nowrap>&nbsp;</td>
 {/if}
 -->
   </tr>
{/foreach}
  </table>
 </div>
 <!--action_end--->
</div>
{include file="grn/system_footer.tpl"}
