<div id="one_parts">
 <div id="action">
  <!----->
   <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_subcategory_1' replace='true'}{cb_msg module='grn.workflow.system' key='w_subcategory_2' replace='true'}&nbsp;{grn_sentence image='category20.gif' caption=$category.name}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_categories}
  <!----->
 </div><!--action_end--->
</div>
<p>
 <input class="margin" type="submit" value="{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}" onclick="grn_onsubmit_common(this.form);">{grn_button_cancel}
</p>
<input type="hidden" name="pcid" value="{$category.cid}">
