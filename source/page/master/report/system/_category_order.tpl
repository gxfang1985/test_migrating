<div id="one_parts">
 <div id="action">
  <!----->
   <div class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-493' replace='true'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-571' replace='true'}&nbsp;{grn_sentence image='category20.gif' caption=$category.name}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_categories}
  <!----->
 </div><!--action_end--->
</div>
<p>
 <input class="margin" type="submit" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-407' replace='true'}" onclick="grn_onsubmit_common(this.form);">{grn_button_cancel}
</p>
<input type="hidden" name="pcid" value="{$category.cid}">
