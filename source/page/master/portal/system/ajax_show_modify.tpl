{grn_load_javascript file="grn/html/text_multilanguage.js"}
<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-137' replace='true'}</div>
<p></p>
<div id="error_msg_portal_name_modify" class="attention" style="display: none;">
    <span class="bold">{cb_msg module='grn.portal.system' key='GRN_POT_SY-139' replace='true'}</span>
</div>
{include file='grn/indispensable.tpl'}
<table id="setting_portal_name" class="std_form">
    <tr>
        <th>{capture name='grn_portal_system_GRN_POT_SY_138'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-138' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_138 necessary=false}</th>
        <td>{grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name values=$multiLanguageInfoArray.values form_name=$form_name error_message="dummy_error_msg"}</td>
    </tr>
</table>
