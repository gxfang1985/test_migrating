<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-308' replace='true'}<br>
 {if strlen($category_name)}
{cb_msg module='grn.bulletin' key='GRN_BLLT-309' replace='true'}{grn_sentence caption=$category_name image='category20.gif' class='bold'}
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-310' replace='true'}{capture name='grn_bulletin_GRN_BLLT_311'}{cb_msg module='grn.bulletin' key='GRN_BLLT-311' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_311 image='category20.gif' class='bold'}
{/if}
<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-312' replace='true'}{grn_sentence caption=$articles.delete_numbers class='bold'}<br>
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-313' replace='true'}</div></p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_314'}{cb_msg module='grn.bulletin' key='GRN_BLLT-314' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_314}
  {capture name='grn_bulletin_GRN_BLLT_315'}{cb_msg module='grn.bulletin' key='GRN_BLLT-315' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_315}
 </p>
{foreach from=$eid item=aid}
<input type="hidden" name="eid[]" value="{$aid}">
{/foreach}
<input type="hidden" name="cid" value="{$category_id}">
