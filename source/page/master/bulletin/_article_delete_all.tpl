{if ! $articles.delete_numbers}
 <p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-188' replace='true'}
</p>
 <p>
  <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-189' replace='true'}" onclick="history.back()">
 </p>
{else}
 {if $delete_continue}
<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-190' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-191' replace='true'}
</p> 
 {/if}
 {assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$submit_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-192' replace='true'}<br>
 {if $category}
{cb_msg module='grn.bulletin' key='GRN_BLLT-193' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-194' replace='true'}{capture name='grn_bulletin_GRN_BLLT_195'}{cb_msg module='grn.bulletin' key='GRN_BLLT-195' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_195 image='category20.gif' class='bold'}
{/if}
<br>
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-196' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_197'}{cb_msg module='grn.bulletin' key='GRN_BLLT-197' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_197}
  {capture name='grn_bulletin_GRN_BLLT_198'}{cb_msg module='grn.bulletin' key='GRN_BLLT-198' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_198}
 </p>
<input type="hidden" name="cid" value="{$category_id}">
</form>
{/if}
