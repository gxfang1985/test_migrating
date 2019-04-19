<table class="std_form">
    <tr>
        <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-218' replace='true'}</th>
        <td>{grn_charset name="charset" bom='TRUE'}</td>
    </tr>

    <tr>
        <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-219' replace='true'}</th>
        <td>
            {capture name='grn_portal_operation_GRN_POT_OP_220'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-220' replace='true'}{/capture}
            {grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_220   checked=0}&nbsp;{capture name='grn_portal_operation_GRN_POT_OP_221'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-221' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_221 checked=1}
        </td>
    </tr>

    <tr>
        <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-223' replace='true'}</th>
        <td>
            {capture name='grn_portal_operation_GRN_POT_OP_224'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-224' replace='true'}{/capture}
            {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_224}
            {foreach from=$language_codes item="language_code"}
                {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
                {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
            {/foreach}
        </td>
    </tr>

    <tr>
        <td>&nbsp;</td>
        <td>
           {capture name='grn_portal_operation_GRN_POT_OP_222'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-222' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_222}
           {grn_button_cancel page="portal/operation/html_portlet_list"}
        </td>
    </tr>
</table>
<hr>
<p>
