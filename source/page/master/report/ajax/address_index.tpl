  <div id="tab_portal" class="tab_portal">
    <div class="tab_menu">
     {if $access.shared_address}
      {foreach from=$books item=book}
      <table class="tab" border="0" cellspacing="0" cellpadding="0">
        <tr height="24" style="cursor:default" nowrap>
         {if $book.oid == $book_id}
          <td id="tab_left_{$book.oid}" class="tab_left_on" style="padding: 0px;"></td>
          <td id="tab_{$book.oid}" class="tab_on" style="font-size:11pt;" nowrap>
            <a href="javascript:void(0);" onclick="GRN_ReportAddress.switchBook({$book.oid});">{grn_image image='person20.gif'}{$book.display_name|escape}</a>
          </td>
          <td id="tab_right_{$book.oid}" class="tab_right_on" nowrap></td>
         {else}
          <td id="tab_left_{$book.oid}" class="tab_left_off" style="padding: 0px;"></td>
          <td id="tab_{$book.oid}" class="tab_off" style="font-size:11pt" nowrap>
            <a href="javascript:void(0);" onclick="GRN_ReportAddress.switchBook({$book.oid});">{grn_image image='person20.gif'}{$book.display_name|escape}</a>
          </td>
          <td id="tab_right_{$book.oid}" class="tab_right_off" nowrap></td>
         {/if}
        </tr>
      </table>
      {/foreach}
     {/if}
    </div>
    <div class="tab_menu_end"></div>
  </div><!--end of tab_portal-->

 <div id="select_area" class="addressSlectArea-grn">
  {include file='report/ajax/_address_select.tpl' personal_sort_key_use=$builtin_items.personal_sort_key.use view_set=$view_set cards=$cards init=true}
 </div>
