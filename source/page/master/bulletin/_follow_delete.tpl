 <p>{cb_msg module='grn' key='grn.comment.delete.confirm' replace='true'}<br>
 {cb_msg module='grn.bulletin' key='GRN_BLLT-544' replace='true'}<span class="bold">{$article.follow_data|escape:"html"}</span>{cb_msg module='grn.bulletin' key='GRN_BLLT-545' replace='true'}
 </p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_546'}{cb_msg module='grn.bulletin' key='GRN_BLLT-546' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_546}
  {capture name='grn_bulletin_GRN_BLLT_547'}{cb_msg module='grn.bulletin' key='GRN_BLLT-547' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_547}
 </p>
<input type="hidden" name="cid" value="{$article.cid}">
<input type="hidden" name="aid" value="{$article.aid}">
<input type="hidden" name="follow_id" value="{$article.follow_id}">
