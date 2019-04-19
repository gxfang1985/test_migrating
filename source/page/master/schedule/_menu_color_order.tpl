<div id="one_parts">
 <div id="action">
   {grn_change_order form_name=$form_name select_name='order[]' options=$category.children}
 </div><!--action_end-->
</div>
<p>
 <input class="margin" type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-200' replace='true'}" onclick="grn_onsubmit_common(this.form);">
 {grn_button_cancel page='schedule/system/menu_set'}
</p>

