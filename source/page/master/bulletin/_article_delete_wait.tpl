{if ! $articles.delete_numbers}
 <p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-84' replace='true'}
</p>
 <p>
  <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-85' replace='true'}" onclick="history.back()">
 </p>
{else}
 {if $delete_continue}
<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-86' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-87' replace='true'}
</p> 
 {/if}
 {assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_bulletin_delete_wait'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-88' replace='true'}<br>
 {if $category}
{cb_msg module='grn.bulletin' key='GRN_BLLT-89' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-90' replace='true'}{capture name='grn_bulletin_GRN_BLLT_91'}{cb_msg module='grn.bulletin' key='GRN_BLLT-91' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_bulletin_GRN_BLLT_91 image='category20.gif' class='bold'}
{/if}
{cb_msg module='grn.bulletin' key='GRN_BLLT-92' replace='true'}{grn_sentence caption=$articles.delete_numbers class='bold'}<br>
 <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-93' replace='true'}</div></p>
 <p>
  {capture name='grn_bulletin_GRN_BLLT_94'}{cb_msg module='grn.bulletin' key='GRN_BLLT-94' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_94}
  {capture name='grn_bulletin_GRN_BLLT_95'}{cb_msg module='grn.bulletin' key='GRN_BLLT-95' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_95}
 </p>
<input type="hidden" name="cid" value="{$category_id}">
</form>
{/if}
