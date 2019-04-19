{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
    {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
    {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
    {assign var="fontsize" value='font-size:60%;'}
{else}
    {assign var="fontsize" value='font-size:80%;'}
{/if}
<table class="list_column" style="{$font_size}">
    <tr>
        {if $history_list}
        <th nowrap>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-46' replace='true'}</th>
        {if ! $no_space_name}
            <th nowrap>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-54' replace='true'}</th>
        {/if}
        {if ! $no_abstract}
            <th nowrap>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-47' replace='true'}</th>
        {/if}
        {if ! $no_sender_name}
            <th nowrap>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-48' replace='true'}</th>
        {/if}
        {if ! $no_timestamp}
            <th nowrap>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-49' replace='true'}</th>
        {/if}
    </tr>
    {foreach from=$history_list key=nid item=notify}
        <tr valign="top">
            {grn_notification_data_row
            notify=$notify
            data_type='history'
            space_cols=$space_cols
            subject_cols=$subject_cols
            abstract_cols=$abstract_cols
            name_cols=$name_cols
            checkbox=0
            no_space_name=$no_space_name
            no_abstract=$no_abstract
            no_name=$no_sender_name
            no_date=$no_timestamp
            fontsize=$fontsize
            users_info=$users_info
            is_portlet=TRUE}
        </tr>
    {/foreach}
    {/if}
</table>