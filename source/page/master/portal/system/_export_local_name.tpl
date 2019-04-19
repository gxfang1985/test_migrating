<table class="std_form">
    <tr>
        <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-523' replace='true'}</th>
        <td>{grn_charset name="charset" bom='TRUE'}</td>
    </tr>

    <tr>
        <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-524' replace='true'}</th>
        <td>
            {capture name='grn_portal_system_GRN_POT_SY_525'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-525' replace='true'}{/capture}
            {grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_525   checked=0}&nbsp;{capture name='grn_portal_system_GRN_POT_SY_526'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-526' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_526 checked=1}
        </td>
    </tr>

    <tr>
        <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-528' replace='true'}</th>
        <td>
            {capture name='grn_portal_system_GRN_POT_SY_522'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-522' replace='true'}{/capture}
            {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_522}
            {foreach from=$language_codes item="language_code"}
                {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
                {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
            {/foreach}
        </td>
    </tr>

    <tr>
        <td>&nbsp;</td>
        <td>
           {capture name='grn_portal_system_GRN_POT_SY_527'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-527' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_527}
           {grn_button_cancel page="portal/system/portlet_export_index"}
        </td>
    </tr>
</table>
<hr>
<p>
