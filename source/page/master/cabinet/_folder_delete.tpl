 <p>{cb_msg module='grn.cabinet' key='GRN_CAB-207' replace='true'}<br>
{grn_sentence caption=$folder.name image='folder20.gif' class='bold'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-208' replace='true'} <br>
<br>
 </p>
 <p>
  {capture name='grn_cabinet_GRN_CAB_211'}{cb_msg module='grn.cabinet' key='GRN_CAB-211' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_211}
  {capture name='grn_cabinet_GRN_CAB_212'}{cb_msg module='grn.cabinet' key='GRN_CAB-212' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_212}
 </p>
<input type="hidden" name="hid" value="{$folder.hid}">
