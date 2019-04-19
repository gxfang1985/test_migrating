 {if $category_memo != ''}
  <div class="memo mBottom10">
   <div class="memo_title">{cb_msg module='grn.grn' key='GRN_GRN-158' replace='true'}</div>
   <!-- {$category_memo|grn_autolink|nl2br} -->
   {grn_format body=$category_memo}
  </div>
 {/if}
