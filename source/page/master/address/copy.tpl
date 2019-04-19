{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{capture name='grn_address_GRN_ADDR_95'}{cb_msg module='grn.address' key='GRN_ADDR-95' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_address_GRN_ADDR_95 class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.address' key='GRN_ADDR-96' replace='true'}<br>
<span class="bold">{grn_sentence caption=$card.subject class='person20'}</span>
</p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
     {capture name='grn_address_GRN_ADDR_97'}{cb_msg module='grn.address' key='GRN_ADDR-97' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_GRN_ADDR_97 necessary=true}
  </th>
  <td>
  {foreach from=$books item=book}
      <nobr>
      {capture name='grn_address_GRN_ADDR_98'}{cb_msg module='grn.address' key='GRN_ADDR-98' replace='true'}{/capture}
      {validate form=$form_name field='bids' criteria='grn_noCheck' message=$smarty.capture.grn_address_GRN_ADDR_98 append="validation_errors"}
      {grn_checkbox name='bids[]' id=$book.oid value=$book.oid caption=$book.display_name}&nbsp;
      </nobr>
  {/foreach}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <p>
       {strip}
           {capture name='grn_address_GRN_ADDR_99'}{cb_msg module='grn.address' key='GRN_ADDR-99' replace='true'}{/capture}
           {grn_button id='address_book_button_copy' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_address_GRN_ADDR_99}
           {grn_button id='address_book_button_cancel' action='cancel' page='address/view' page_param_bid=$book_id page_param_cid=$card_id}
       {/strip}
   </p>
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$book_id}">
<input type="hidden" name="cid" value="{$card_id}">
</form>

{include file='grn/footer.tpl'}
