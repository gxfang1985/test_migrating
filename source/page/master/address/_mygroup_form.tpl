 <p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
 <table class="std_form">
  <tr valign="top">
   <th>{capture name='grn_address_GRN_ADDR_250'}{cb_msg module='grn.address' key='GRN_ADDR-250' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_GRN_ADDR_250 necessary=1}</th>
   <td>{capture name='grn_address_GRN_ADDR_251'}{cb_msg module='grn.address' key='GRN_ADDR-251' replace='true'}{/capture}{validate form=$form_name field="group_name" criteria="notEmpty" message=$smarty.capture.grn_address_GRN_ADDR_251 transform="cb_trim" append="validation_errors"}
       {grn_text necessary=true name="group_name" value=$group_name size="50" disable_return_key=true}<br>
    <div class="br">&nbsp;</div>
   </td>
  </tr>
  <tr valign="top">
   <th>{capture name='grn_address_GRN_ADDR_252'}{cb_msg module='grn.address' key='GRN_ADDR-252' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_GRN_ADDR_252}</th>
   <td>{grn_textarea name="memo" rows="5" cols="50" value=$memo}</td>
  </tr>
  <tr>
   <td><br></td>
   <td>
    <div class="mTop10">
     {strip}
      {grn_button id='address_book_button_add' ui='main' action='submit' spacing='normal' caption=$submit_caption}
      {grn_button id='address_book_button_cancel' action='cancel' page=$cancel_page page_param_mgid=$mygroup_id}
     {/strip}
    </div>
   </td>
  </tr>
 </table>
 
<input type="hidden" name="mgid" value="{$mygroup_id|escape}">