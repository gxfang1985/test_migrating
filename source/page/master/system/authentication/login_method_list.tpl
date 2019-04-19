{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_login_method_list'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="lmid" value="">

<p>
 <div class="explanation">{cb_msg module='grn.system.authentication' key='GRN_SY_AU-18' replace='true'}</div>
</p>
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_authentication_GRN_SY_AU_19'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-19' replace='true'}{/capture}{grn_link page='system/authentication/login_method_add1' caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_19 image='write20.gif'}</span>
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
     <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-20' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-21' replace='true'}</th>
    </tr>
{foreach from=$login_method item=login_method}
    <tr valign="top">
     {if $login_method.is_default == 1}
      <td>&nbsp;</td>
     {else}
      <td><input type="checkbox" name="eid[]" value="{$login_method.lmid}"></td>
     {/if}
      <td>{grn_link page='system/authentication/login_method_view' caption=$login_method.display_name image='detail20.gif' lmid=$login_method.lmid}</td>
     {if $login_method.is_active == 1}
      <td nowrap><span class="font_red">{cb_msg module='grn.system.authentication' key='GRN_SY_AU-22' replace='true'}</span></td>
     {else}
      <td>{capture name='grn_system_authentication_GRN_SY_AU_23'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-23' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_23 class='button_submit1' onclick="this.form.lmid.value=`$login_method.lmid`;"}</td>
     {/if}
    </tr>
{/foreach}
   </table>
   <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-24' replace='true'}{capture name='grn_system_authentication_GRN_SY_AU_25'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-25' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_25 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}</p>
</form>

{include file='grn/system_footer.tpl'}
