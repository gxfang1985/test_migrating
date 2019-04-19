<div id="one_parts">
 <div id="action">
  <!----->
   <div class="sub_title">{cb_msg module='grn.bulletin' key='GRN_BLLT-199' replace='true'}{cb_msg module='grn.bulletin' key='GRN_BLLT-651' replace='true'}&nbsp;{grn_sentence caption=$category.name image='category20.gif'}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.children}
  <!----->
 </div><!--action_end--->
</div>
<p>
 <input class="margin" type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-200' replace='true'}" onclick="grn_onsubmit_common(this.form);">{grn_button_cancel}
</p>
<input type="hidden" name="cid" value="{$category_id}">
