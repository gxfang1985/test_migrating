<table class="global_navi_title js_search_bar" cellpadding="0" cellmargin="0" style="padding:0px;">
    <tbody>
    <tr>
        <td width="100%" class="nowrap-grn">
            {grn_image image="notify20.gif" border="0" class="global_navi_title_img_grn" alt=""}<span class="global_navi_title_text_grn">{$page_title}</span>
        </td>
        <td align="right" valign="bottom" nowrap>
            {capture name='grn_notification_GRN_NTFC_143'}{cb_msg module='grn.notification' key='GRN_NTFC-143' replace='true'}{/capture}{grn_notification_search caption=$smarty.capture.grn_notification_GRN_NTFC_143 name='search_text' module_id=$module_id}
        </td>
    </tr>
    </tbody>
</table>