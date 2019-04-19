 <p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-526' replace='true'}<br>
{grn_sentence caption=$article.title image='bulletin20.gif' class='bold'}<br>
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-527' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_528'}{cb_msg module='grn.bulletin' key='GRN_BLLT-528' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_528}
  {capture name='grn_bulletin_GRN_BLLT_529'}{cb_msg module='grn.bulletin' key='GRN_BLLT-529' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_529}
 </p>
<input type="hidden" name="aid" value="{$article.aid}">
<input type="hidden" name="cid" value="{$category_id}">
