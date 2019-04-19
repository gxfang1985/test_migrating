{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_authenticate_method_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="">

<p>
 <div class="explanation">{cb_msg module='grn.system.authentication' key='GRN_SY_AU-39' replace='true'}</div>
 <div class="attention">{cb_msg module='grn.system.authentication' key='GRN_SY_AU-40' replace='true'}</div>
</p>

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_41'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-41' replace='true'}{/capture}{grn_link page='system/authentication/authenticate_method_add1' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_41 image='write20.gif'}</span>
</div>

<p>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="1%">
     <col width="98%">
     <col width="1%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
     <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-42' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-43' replace='true'}</th>
    </tr>
{foreach from=$authenticate_method item=authenticate_method}
    <tr valign="top">
     {if $authenticate_method.is_default == 1}
      <td>&nbsp;</td>
     {else}
      <td><input type="checkbox" name="eid[]" value="{$authenticate_method.amid}"></td>
     {/if}
      <td>{grn_link page='system/authentication/authenticate_method_view' caption=$authenticate_method.display_name image='detail20.gif' amid=$authenticate_method.amid}</td>
     {if $authenticate_method.is_active == 1}
      <td>{capture name='grn_system_authentication_GRN_SY_AU_44'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-44' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_44 class='button_submit1' onclick="this.form.amid.value=`$authenticate_method.amid`;"}</td>
     {else}
      <td>{capture name='grn_system_authentication_GRN_SY_AU_45'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-45' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_45 class='button_submit1' onclick="this.form.amid.value=`$authenticate_method.amid`;"}</td>
     {/if}
    </tr>
{/foreach}
   </table>
   <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-46' replace='true'}{capture name='grn_system_authentication_GRN_SY_AU_47'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-47' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_47 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}</p>

</form>

{include file='grn/system_footer.tpl'}
