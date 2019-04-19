<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-7' replace='true'}</div>
<p></p>
<table class="std_form" id="setting_portlet_name">
    <tr>
        <th>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-10' replace='true'}</th>
        <td>{$portlet.title|escape}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-9' replace='true'}</th>
        <td>
            {if $isCategoryType}
                {capture name='grn_portal_personal_display_name_set'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-172' replace='true'}{/capture}{grn_radio name='display_name_mode' id='radio_normal' value='normal' caption=$smarty.capture.grn_portal_personal_display_name_set checked=$isNormal}
                <br>
                {grn_text name="title" value=$portlet.name size="50" disable_return_key=true class="mTop5"}
                <br>
                <br>
                {if $portletType == 'grn.bulletin.portlet' || $portletType == 'grn.link.link'}
                    {capture name='grn_portal_personal_category_name'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-173' replace='true'}{/capture}
                {elseif $portletType == 'grn.cabinet.portlet' || $portletType == 'grn.mail.data_list' || $portletType == 'grn.message.message'}
                    {capture name='grn_portal_personal_category_name'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-174' replace='true'}{/capture}
                {elseif $portletType == 'grn.workflow.workflow'}
                    {capture name='grn_portal_personal_category_name'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-175' replace='true'}{/capture}
                {elseif $portletType == 'grn.report.report'}
                    {capture name='grn_portal_personal_category_name'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-176' replace='true'}{/capture}
                {elseif $portletType == 'grn.rss.item_list'}
                    {capture name='grn_portal_personal_category_name'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-177' replace='true'}{/capture}
                {/if}
                {if $smarty.capture.grn_portal_personal_category_name}
                    {grn_radio name='display_name_mode' id='radio_category' value='category' caption=$smarty.capture.grn_portal_personal_category_name checked=$isCategory}
                {/if}
            {else}
                {grn_text name="title" value=$portlet.name size="50" disable_return_key=true}
            {/if}
        </td>
    </tr>
</table>

