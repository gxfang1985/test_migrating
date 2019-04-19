{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="refresh" value="">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

    <table class="std_form">{strip}
        <tr>
            <th nowrap>
                {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-22' replace='true'}
            </th>
            <td>
                {grn_select name='font_size' options=$font_options}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-23' replace='true'}
            </th>
            <td>
                {if $settings.use_turnup == '1'}
                    {assign var='use_turnup_checked' value='TRUE'}
                {/if}
                {capture name='grn_portal_portlet_GRN_POT_PO_24'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-24' replace='true'}{/capture}
                {grn_checkbox name='use_turnup' id='use_turnup' value='1' caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_24 checked=$use_turnup_checked}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>
                {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-25' replace='true'}
            </th>
            <td>
                {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.turnup_size padding=$select1.padding}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>
                {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-26' replace='true'}
            </th>
            <td>
                {if $settings.display_type == '0'}{assign var='display_type_0_checked' value='TRUE'}{/if}
                {if $settings.display_type == '1'}{assign var='display_type_1_checked' value='TRUE'}{/if}
                {if $settings.display_type == '2'}{assign var='display_type_2_checked' value='TRUE'}{/if}
                {if $settings.display_type == '3'}{assign var='display_type_3_checked' value='TRUE'}{/if}
                <table class="admin_list_table">
                    <tr>
                        <td style="text-align:center">{grn_radio name="display_type" id="0" value="0" caption="" checked=$display_type_0_checked}</td>
                        <td style="text-align:center">{grn_radio name="display_type" id="1" value="1" caption="" checked=$display_type_1_checked}</td>
                        <td style="text-align:center">{grn_radio name="display_type" id="2" value="2" caption="" checked=$display_type_2_checked}</td>
                        <td style="text-align:center">{grn_radio name="display_type" id="3" value="3" caption="" checked=$display_type_3_checked}</td>
                    </tr>
                    <tr>
                        <td style="text-align:center">{capture name='grn_portal_portlet_GRN_POT_PO_27'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-27' replace='true'}{/capture}{grn_image image='menu32.gif' alt=$smarty.capture.grn_portal_portlet_GRN_POT_PO_27}<br>{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-28' replace='true'}</td>
                        <td style="text-align:center">{capture name='grn_portal_portlet_GRN_POT_PO_29'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-29' replace='true'}{/capture}{grn_image image='menu32.gif' alt=$smarty.capture.grn_portal_portlet_GRN_POT_PO_29}&nbsp;{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-30' replace='true'}</td>
                        <td style="text-align:center">{capture name='grn_portal_portlet_GRN_POT_PO_31'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-31' replace='true'}{/capture}{grn_image image='menu32.gif' alt=$smarty.capture.grn_portal_portlet_GRN_POT_PO_31}<br>{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-32' replace='true'}</td>
                        <td style="text-align:center">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-33' replace='true'}<br>{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-34' replace='true'}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_portal_portlet_GRN_POT_PO_35'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-35' replace='true'}{/capture}
                {grn_button_submit class="margin" caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_35}
                {if $display == 'set-system'}
                    {capture name='grn_portal_portlet_GRN_POT_PO_36'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-36' replace='true'}{/capture}
                    {grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_36 page='portal/system/view' pid=$portlet.pid}
                {elseif $display == 'set-operation'}
                    {capture name='grn_portal_portlet_GRN_POT_PO_37'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-37' replace='true'}{/capture}
                    {grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_37 page='portal/operation/view' pid=$portlet.pid}
                {else}
                    {capture name='grn_portal_portlet_GRN_POT_PO_38'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-38' replace='true'}{/capture}
                    {grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_38 page='portal/personal/view' pid=$portlet.pid}
                {/if}
            </td>
        </tr>
    </table>{/strip}

</form>
