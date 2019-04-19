<div id="one_parts">
 <div id="action">
  <!----->
  <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-2' replace='true'}{cb_msg module='grn.link' key='GRN_LNK-187' replace='true'}&nbsp;{grn_sentence image='category20.gif' caption=$category.title}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_categories}
  <!----->
 </div><!--action_end--->
</div>
<p>
 <input class="line" type="submit" value="{cb_msg module='grn.link.operation' key='GRN_LNK_OP-20' replace='true'}" onclick="grn_onsubmit_common(this.form);">{grn_button_cancel class="line"}
</p>
<input type="hidden" name="pcid" value="{$category.cid}">
