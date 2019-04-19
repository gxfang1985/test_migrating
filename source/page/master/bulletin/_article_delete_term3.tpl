
<div id="one_parts">
 <div id="action">
 <p class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-532' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-533' replace='true'}
 </p>
 <p class="explanation">
  {cb_msg module='grn.bulletin' key='GRN_BLLT-534' replace='true'}<br>
  {cb_msg module='grn.bulletin' key='GRN_BLLT-535' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}<br>
  {cb_msg module='grn.bulletin' key='GRN_BLLT-536' replace='true'}<span class="bold">{grn_date_format date=$term_date format='DateFull_YMDW'}</span>&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-537' replace='true'}<br>
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-538' replace='true'}</div>
 </p>
<p class="explanation">{cb_msg module='grn.bulletin' key='GRN_BLLT-539' replace='true'}</p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_540'}{cb_msg module='grn.bulletin' key='GRN_BLLT-540' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_540}
  {capture name='grn_bulletin_GRN_BLLT_541'}{cb_msg module='grn.bulletin' key='GRN_BLLT-541' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_541 page=$page_prefix|cat:'/bulletin_list' cid=$category_id}
 </p>
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="term_date" value="{$term_format_date}">
<input type="hidden" name="cid" value="{$category_id}">
