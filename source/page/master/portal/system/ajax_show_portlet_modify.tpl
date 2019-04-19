{grn_load_javascript file="grn/html/text_multilanguage.js"}
<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-16' replace='true'}</div>

<table class="std_form" id="setting_portlet_name">
    <tr>
        <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-19' replace='true'}</th>
        <td>{$portlet.title|escape}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-18' replace='true'}</th>
        <td>
            {if $isCategoryType}
                {capture name='grn_portal_system_display_name_set'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-535' replace='true'}{/capture}{grn_radio name='display_name_mode' id='radio_normal' value='normal' caption=$smarty.capture.grn_portal_system_display_name_set checked=$isNormal}
                {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name values=$multiLanguageInfoArray.values}
                <br>
                <br>
                {if $portletType == 'grn.bulletin.portlet' || $portletType == 'grn.link.link'}
                    {capture name='grn_portal_system_category_name'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-536' replace='true'}{/capture}
                {elseif $portletType == 'grn.cabinet.portlet' || $portletType == 'grn.mail.data_list' || $portletType == 'grn.message.message'}
                    {capture name='grn_portal_system_category_name'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-537' replace='true'}{/capture}
                {elseif $portletType == 'grn.workflow.workflow'}
                    {capture name='grn_portal_system_category_name'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-538' replace='true'}{/capture}
                {elseif $portletType == 'grn.report.report'}
                    {capture name='grn_portal_system_category_name'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-539' replace='true'}{/capture}
                {elseif $portletType == 'grn.rss.item_list'}
                    {capture name='grn_portal_system_category_name'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-540' replace='true'}{/capture}
                {/if}
                {if $smarty.capture.grn_portal_system_category_name}
                    {grn_radio name='display_name_mode' id='radio_category' value='category' caption=$smarty.capture.grn_portal_system_category_name checked=$isCategory}
                {/if}
            {else}
                {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name values=$multiLanguageInfoArray.values}
            {/if}
        </td>
    </tr>
</table>
