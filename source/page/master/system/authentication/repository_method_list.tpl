{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/repository_method_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
 <div class="explanation">{cb_msg module='grn.system.authentication' key='GRN_SY_AU-29' replace='true'}</div>
</p>
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_30'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-30' replace='true'}{/capture}{grn_link page='system/authentication/repository_method_add1' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_30 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_73'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-73' replace='true'}{/capture}{grn_link page='system/authentication/repository_method_order' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_73 image='order20.gif' disabled=$disable_link_to_order}</span>
</div>

<p>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="1%">
     <col width="99%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-31' replace='true'}</th>
    </tr>
{foreach from=$repository_method item=repository_method}
    <tr valign="top">
     {if $repository_method.is_default == 1}
      <td>&nbsp;</td>
      <td>{grn_image image='detail20.gif' alt=$repository_method.display_name}{$repository_method.display_name}</td>
     {else}
      <td><input type="checkbox" name="eid[]" value="{$repository_method.rmid}"></td>
      <td>{grn_link page='system/authentication/repository_method_view' caption=$repository_method.display_name image='detail20.gif' rmid=$repository_method.rmid}</td>
     {/if}
    </tr>
{/foreach}
   </table>
   <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-32' replace='true'}{capture name='grn_system_authentication_GRN_SY_AU_33'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-33' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_33 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}</p>
</form>

{include file='grn/system_footer.tpl'}
