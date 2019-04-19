<p></p>
<div class="explanation">{cb_msg module='grn.cabinet' key='GRN_CAB-303' replace='true'}</div>
{if $folder_name}{grn_sentence caption=$folder_name image='folder20.gif'}{else}<br>{/if}
<p></p>
<table class="std_form">
    <tr>
        <th>{capture name='grn_cabinet_GRN_CAB_305'}{cb_msg module='grn.cabinet' key='GRN_CAB-305' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_305}</th>
        <td>
          {grn_select name='cabinet_order_by' id='cabinet_order_by' options=$item_options}
          <input id="order_asc" type="radio" name="order" value="1" {if $order_setting.order == 1}checked{/if}><label id="order_asc_label" onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="order_asc">{cb_msg module='grn.cabinet' key='GRN_CAB-307' replace='true'}</label>
          <input id="order_des" type="radio" name="order" value="2" {if $order_setting.order == 2}checked{/if}><label id="order_des_label" onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="order_des">{cb_msg module='grn.cabinet' key='GRN_CAB-308' replace='true'}</label>
       </td>
    </tr>
    <tr>
        <td><br></td>
        <td>
            {capture name='grn_cabinet_GRN_CAB_309'}{cb_msg module='grn.cabinet' key='GRN_CAB-309' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_309}
            {grn_button_cancel page=$cancel_page hid=$folder_id}
        </td>
    </tr>
</table>
<input type="hidden" name="hid" value="{$folder_id}">
