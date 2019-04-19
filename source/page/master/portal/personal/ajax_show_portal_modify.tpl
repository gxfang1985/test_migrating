<div class="explanation">{cb_msg module='grn.portal.personal' key='GRMSG_POT_PE_4' app_name=$app_name}</div>
<p></p>
<div id="error_msg_portal_name_modify" class="attention" style="display: none;">
    <span class="bold">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|escape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-38' replace='true'}</span>
</div>
{include file='grn/indispensable.tpl'}
<table id="setting_portal_name" class="std_form">
    <tr>
        <th>{capture name='grn_portal_personal_GRN_POT_PE_37'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-37' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_37 necessary=TRUE}</th>
        <td>
            {grn_text necessary=true name="title" value=$portal.title size="50" disable_return_key=true id="portalName-label-line-value-def"}
        </td>
    </tr>
</table>
