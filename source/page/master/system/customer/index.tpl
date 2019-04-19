{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
{capture name='grn_system_customer_GRN_SY_CU_19'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-19' replace='true'}{/capture}{grn_link page='system/customer/modify' caption=$smarty.capture.grn_system_customer_GRN_SY_CU_19 image='modify20.gif'}
</div>

<p>
<table class="view_table">
 <tr>
  <th>{cb_msg module='grn.system.customer' key='GRN_SY_CU-20' replace='true'}</th>
  <td>{if $customer_data.customer_id}<span class="bold">{$customer_data.customer_id|escape}</span>{else}--{/if}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.customer' key='GRN_SY_CU-21' replace='true'}</th>
  <td>{if $customer_data.company_name}{$customer_data.company_name|escape}{else}--{/if}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.customer' key='GRN_SY_CU-22' replace='true'}</th>
  <td>{if $customer_data.company_name2}{$customer_data.company_name2|escape}{else}--{/if}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.customer' key='GRN_SY_CU-23' replace='true'}{cb_msg module='grn.system.customer' key='GRN_SY_CU-24' replace='true'}</dth>
  <td>{if $customer_data.logo_path}{grn_image_raw inline=TRUE image=$customer_data.logo_path}{else}--{/if}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.customer' key='GRN_SY_CU-25' replace='true'}</th>
  <td>
{if $customer_data.logo_file}
   {grn_filename dpage='grn/customer_image_download' name=$customer_data.logo_file.name hash=$customer_data.logo_file.hash inline=true}
{else}
   {grn_image image='grnlogo_white.png'}
{/if}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
