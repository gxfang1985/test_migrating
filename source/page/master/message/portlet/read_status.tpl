{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
    {assign var="style" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
    {assign var="style" value=''}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
    {assign var="style" value='font-size:70%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {$page_title}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_message_acknowledgement_status_grn">
    <table class="list_column" style="{$font_size}border-bottom: 0 solid">{strip}
        <tr>
            <td>
                <div class="sub_title">
                    {$app_name} {include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}
                </div>
            </td>
        </tr>
    </table>{/strip}
    <form name="read_confirm" method="post" action="{grn_pageurl page='message/portlet/command_confirm_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <table class="list_column" style="{$font_size}border-bottom:0 solid">{strip}
            <colgroup>
                <col width="40%">
                <col width="20%">
                <col width="{if $settings.time}20%{else}0%{/if}">
                <col width="{if $settings.folder}20%{else}0%{/if}">
            </colgroup>
            <tr>
                <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-58' replace='true'}</th>
                <th nowrap>{$app_name}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-59' replace='true'}</th>
                <th nowrap>{if $settings.time}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-60' replace='true'}{/if}</th>
                <th nowrap>{if $settings.folder }{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-61' replace='true'}{/if}</th>
            </tr>
            {foreach from=$messages item=message}
            <tr valign="top">
                {if $message.has_files}
                    {assign var="class_clip" value="_clip8"}
                {else}
                    {assign var="class_clip" value=''}
                {/if}
                {if $message.status eq 0}
                    {* unread *}
                    {assign var="unread" value="1"}
                    {assign var="class_update" value=''}
                {else}
                    {* update/read *}
                    {assign var="unread" value="0"}
                    {if $message.status eq 1}
                        {* update *}
                        {assign var="class_update" value="_u"}
                    {else}
                        {* read *}
                        {assign var="class_update" value=''}
                    {/if}
                {/if}
                <td nowrap>
                    <input type="checkbox" name="read[]" id="read_confirm" value="{$message.mid}">
                    {grn_link page='message/view' caption=$message.subject image="msg20`$class_update``$class_clip`.gif" unread=$unread cid=$message.cid rid=$message.rid mid=$message.mid truncated_caption=$subject_width}
                </td>
                <td nowrap>
                    {capture name='grn_message_portlet_GRN_MSG_PO_62'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-62' replace='true'}{/capture}
                    {capture name='grn_message_portlet_GRN_MSG_PO_63'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-63' replace='true'}{/capture}
                    {grn_link page="message/read_status" cid=$message.cid rid=$message.rid mid=$message.mid caption=$message.confirmed_num|cat:$smarty.capture.grn_message_portlet_GRN_MSG_PO_62|cat:$message.addressee_num|cat:$smarty.capture.grn_message_portlet_GRN_MSG_PO_63}
                </td>
                <td nowrap {$fontsize}>{if $settings.time}{grn_date_format date=$message.time}{/if}</td>
                <td nowrap {$fontsize}>{if $settings.folder}{$message.folder_name|escape}{/if}</td>
            </tr>
            {/foreach}
            <tr>
                <td nowrap colspan="4">
                    <div class="portlet_form_base_grn mTop7">
                        <span class="element_grn mRight3">
                            {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-64' replace='true'}
                        </span>
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="var form = jQuery(this).parents('form');if(! grn_is_checked(form.get(0), 'read[]')) return false;form.find('[name=cmd]').attr('value','confirm');form.submit();return false;">
                                <span>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-65' replace='true'}</span>
                            </a>
                        </span>
                    </div>
                </td>
            </tr>
        </table>{/strip}
        <table class="list_column" width="100%" style="{$font_size}border-top:0 solid">{strip}
            <tr>
                <td style="padding:0" nowrap>
                    <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi_info.navi}</nobr></div>
                </td>
            </tr>
        </table>{/strip}
        <input type="hidden" name="cmd">
        <input type="hidden" name="plid" value="{$portlet.plid}">
    </form>
</div> <!--end of portal_frame -->
