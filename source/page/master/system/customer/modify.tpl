{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{cb_pageurl page='system/customer/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
 <div class="explanation">{cb_msg module='grn.system.customer' key='GRN_SY_CU-1' replace='true'}</div>
</p>
<table class="std_form">
 <tr>
  <th>{capture name='grn_system_customer_GRN_SY_CU_2'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-2' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_customer_GRN_SY_CU_2}</th>
  <td>{if $customer_data.customer_id}{$customer_data.customer_id|escape}{else}--{/if}</td>
 </tr>
 <tr>
  <th>{capture name='grn_system_customer_GRN_SY_CU_3'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-3' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_customer_GRN_SY_CU_3}</th>
  <td>{capture name='grn_system_customer_GRN_SY_CU_4'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-4' replace='true'}{/capture}{grn_text necessary=true name="company_name" value=$customer_data.company_name size="50" title=$smarty.capture.grn_system_customer_GRN_SY_CU_4 disable_return_key=true}</td>
 </tr>
 <tr>
  <th>{capture name='grn_system_customer_GRN_SY_CU_5'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-5' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_customer_GRN_SY_CU_5}</th>
  <td>{capture name='grn_system_customer_GRN_SY_CU_6'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-6' replace='true'}{/capture}{grn_text necessary=true name="company_name2" value=$customer_data.company_name2 size="50" title=$smarty.capture.grn_system_customer_GRN_SY_CU_6 disable_return_key=true}</td>
 </tr>
  <th>{capture name='grn_system_customer_GRN_SY_CU_7'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-7' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_customer_GRN_SY_CU_7}</th>
  <td>{grn_text name="logo_path" value=$customer_data.logo_path size="50" maxlength="255"}
  </td>
 </tr>
 <tr>
  <th>{capture name='grn_system_customer_GRN_SY_CU_9'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-9' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_customer_GRN_SY_CU_9}</th>
  <td>{grn_file name="logo_file" size="40"}<br>
      {if $customer_data.logo_file}{grn_filename dpage='grn/customer_image_download' name=$customer_data.logo_file.name}{capture name='grn_system_customer_GRN_SY_CU_10'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-10' replace='true'}{/capture}{grn_checkbox name="delete_logo" id="delete_logo" value="1" caption=$smarty.capture.grn_system_customer_GRN_SY_CU_10}{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="sub_explanation">
    {cb_msg module='grn.system.customer' key='GRN_SY_CU-11' replace='true'}<span class="bold">URL</span>{cb_msg module='grn.system.customer' key='GRN_SY_CU-12' replace='true'}<span class="bold">{cb_msg module='grn.system.customer' key='GRN_SY_CU-13' replace='true'}</span>{cb_msg module='grn.system.customer' key='GRN_SY_CU-14' replace='true'}<br>
    {cb_msg module='grn.system.customer' key='GRN_SY_CU-15' replace='true'}<span class="bold">{cb_msg module='grn.system.customer' key='GRN_SY_CU-16' replace='true'}</span>{cb_msg module='grn.system.customer' key='GRN_SY_CU-17' replace='true'}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_system_customer_GRN_SY_CU_18'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-18' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_customer_GRN_SY_CU_18}
   {grn_button_cancel page='system/customer/index'}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
