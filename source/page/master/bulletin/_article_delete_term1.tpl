<div class="explanation">{cb_msg module='grn.bulletin' key='GRN_BLLT-517' replace='true'}<br />{cb_msg module='grn.bulletin' key='GRN_BLLT-518' replace='true'}</div>
<div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-519' replace='true'}</div>
<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-520' replace='true'}
  </th>
  <td>
{if $category}
      {grn_sentence caption=$category.name image='category20.gif'}
{else}
      {capture name='grn_bulletin_GRN_BLLT_521'}{cb_msg module='grn.bulletin' key='GRN_BLLT-521' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_521 image='category20.gif'}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin' key='GRN_BLLT-522' replace='true'}
  </th>
  <td>
      {grn_select_date date=$term_date prefix='term_' form_name=$form_name}{cb_msg module='grn.bulletin' key='GRN_BLLT-523' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_bulletin_GRN_BLLT_524'}{cb_msg module='grn.bulletin' key='GRN_BLLT-524' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_524}
       {grn_button_cancel page=$page_prefix|cat:'/bulletin_list' cid=$category_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id}">

