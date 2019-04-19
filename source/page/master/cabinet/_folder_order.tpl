<div id="one_parts">
 <div id="action">
  <!----->
   <div class="sub_title">{cb_msg module='grn.cabinet' key='GRN_CAB-103' replace='true'}{cb_msg module='grn.cabinet' key='GRN_CAB-335' replace='true'}&nbsp;{grn_sentence caption=$folder.name image='folder20.gif'}</div>
   {grn_change_order form_name=$form_name select_name='order[]' options=$folder.children}
  <!----->
 </div>
</div>
<p>
 {capture name='grn_cabinet_GRN_CAB_104'}{cb_msg module='grn.cabinet' key='GRN_CAB-104' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_104 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
<input type="hidden" name="hid" value="{$folder_id}">
