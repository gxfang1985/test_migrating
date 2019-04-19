{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$uid}" />

 <table class="std_form">
  <tr>
   <th>{capture assign='grn_presence_GRN_PRSC_4'}{cb_msg module='grn.presence' key='GRN_PRSC-4' replace='true'}{/capture}{grn_show_input_title title=$grn_presence_GRN_PRSC_4}</th>
   <td>{grn_user_name uid=$uid}</td>
  </tr>
  <tr>
   <th>{capture assign='grn_presence_GRN_PRSC_1'}{cb_msg module='grn.presence' key='GRN_PRSC-1' replace='true'}{/capture}{grn_show_input_title title=$grn_presence_GRN_PRSC_1}</th>
   <td>{grn_select name='status' options=$options default=0}</td>
  </tr>
  <tr>
   <th>{capture assign='grn_presence_GRN_PRSC_2'}{cb_msg module='grn.presence' key='GRN_PRSC-2' replace='true'}{/capture}{grn_show_input_title title=$grn_presence_GRN_PRSC_2}</th>
   <td>{grn_text name="memo" size="50" value=$memo}</td>
  </tr>
  <tr>
   <td><br></td>
   <td>
       <div class="mTop10">
           {strip}
               {capture assign='grn_presence_GRN_PRSC_3'}{cb_msg module='grn.presence' key='GRN_PRSC-3' replace='true'}{/capture}
               {grn_button id='presence_button_save' ui='main' action='submit' spacing='normal' caption=$grn_presence_GRN_PRSC_3}
               {grn_button id='presence_button_cancel' action='cancel'}
           {/strip}
       </div>
   </td>
  </tr>
 </table>
</form>
{include file="grn/footer.tpl"}
