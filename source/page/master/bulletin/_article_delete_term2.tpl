
<div id="one_parts">
 <div id="action">
 <p class="explanation">
 {cb_msg module='grn.bulletin' key='GRN_BLLT-258' replace='true'}<br>
  {cb_msg module='grn.bulletin' key='GRN_BLLT-259' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}<br>
  {cb_msg module='grn.bulletin' key='GRN_BLLT-260' replace='true'}<span class="bold">{grn_date_format date=$term_date format='DateFull_YMDW'}</span>&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-261' replace='true'}<br>
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-262' replace='true'}</div>
 </p>
<p class="explanation">{cb_msg module='grn.bulletin' key='GRN_BLLT-263' replace='true'}</p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_264'}{cb_msg module='grn.bulletin' key='GRN_BLLT-264' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_264}
  {capture name='grn_bulletin_GRN_BLLT_265'}{cb_msg module='grn.bulletin' key='GRN_BLLT-265' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_265 page=$page_prefix|cat:'/bulletin_list' cid=$category_id}
 </p>
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="term_date" value="{$term_format_date}">
<input type="hidden" name="cid" value="{$category_id}">
