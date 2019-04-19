{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_address_system_GRN_ADDR_SYS_71'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-71' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_71 page='address/system/book_add' image='write20.gif' element_id="system_shared_address_book_add"}</span>
<span class="menu_item">{capture name='grn_address_system_GRN_ADDR_SYS_72'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-72' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_72 page='address/system/book_order' image='order20.gif'}</span>
</div>

  <p>
  <table class="list_column" width="100%">
   <colgroup>
    <col width="50%">
    <col width="30%">
    <col width="20%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-73' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-74' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-75' replace='true'}</th>
   </tr>
{foreach from=$books item=book}
   <tr valign="top">
    <td nowrap>
     {grn_link caption=$book.display_name page='address/system/book_view' bid=$book.oid image='person20.gif'}
    </td>
    <td nowrap>{$book.id|escape}</td>
    <td nowrap>{$book.type|escape}</td>
   </tr>
{/foreach}
  </table>

{include file='grn/system_footer.tpl'}
