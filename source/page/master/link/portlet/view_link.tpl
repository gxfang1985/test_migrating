{if $settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
    {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}

<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
        {if $category}
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='link/index' cid=$category.cid type=$settings.type}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-19' replace='true'}</span>
                    {$category.title|escape}
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-20' replace='true'}</span>
                </a>
            </span>
        </td>
        <td align="right">
            {if $settings.type eq 'personal'}
            <span>
                <a href="{grn_pageurl page='link/add' cid=$category.cid type=$settings.type}" class="action_base_grn">
                <span title="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-21' replace='true'}" class="icon_add_grn icon_only_grn">
                        <span class="courteous_element_grn">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-21' replace='true'}</span>
                    </span>
                </a>
                </span>
            {elseif $management == 1}
            <span>
                <a href="{grn_pageurl page='link/operation/add' cid=$category.cid type=$settings.type}" class="action_base_grn">
                    <span title="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-22' replace='true'}" class="icon_add_grn icon_only_grn">
                        <span class="courteous_element_grn">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-22' replace='true'}</span>
                    </span>
                </a>
            </span>
            {/if}
        {else}
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='link/index'}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                    {cb_msg module='grn.link.portlet' key='GRN_LNK_PO-23' replace='true'}
                </a>
            </span>
        {/if}
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_link_grn">{strip}
{if $set_popup}
    <table class="list_column" style="{$font_size}">
        <colgroup>
        {section name=col loop=$settings.col_size}
            <col width="{$settings.col_width}%">
            <col width="0%">
        {/section}
        </colgroup>
        {assign var='col_count' value=1}
        {foreach from=$link item=item}
            {if $col_count == 1}
            <tr>
            {/if}
            {if $item.type eq 'line'}
                {if $col_count != 1}
                    {section name=col_padding loop=$settings.col_size-$col_count+1}
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    {/section}
                {/if}
                {assign var='col_count' value=1}
                </tr>
                <tr>
                    <td colspan="{$settings.col_span}">
                        <div class="border-partition-common-grn"></div>
                    </td>
                </tr>
            {else}
                {if $item.sid > 0}
                    <td nowrap>
                        <ul class="link_porlet">
                            <li>
                                {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url target='_blank'}
                                {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='window20.gif'}
                            </li>
                        </ul>
                    </td>
                {else}
                    <td nowrap>
                        <ul class="link_porlet">
                            <li>
                                {capture name='grn_link_portlet_GRN_LNK_PO_24'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-24' replace='true'}{/capture}
                                {grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width target='_blank' title=$smarty.capture.grn_link_portlet_GRN_LNK_PO_24 no_script=true}
                                {capture name='grn_link_portlet_GRN_LNK_PO_25'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-25' replace='true'}{/capture}
                                {grn_link_raw page=$item.url caption='' image='window20.gif' title=$smarty.capture.grn_link_portlet_GRN_LNK_PO_25 no_script=true}
                            </li>
                        </ul>
                    </td>
                {/if}
                <td nowrap>
                    {capture name='grn_link_portlet_GRN_LNK_PO_26'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-26' replace='true'}{/capture}
                    {grn_link image='detail20.gif' page='link/view' caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_26 cid=$category.cid  lid=$item.lid type=$settings.type}
                </td>
                {if $col_count == $settings.col_size}
                    {assign var='col_count' value=1}
                    </tr>
                {else}
                    {assign var='col_count' value=$col_count+1}
                {/if}
            {/if}
        {/foreach}
    </table>
{else}
    <table class="list_column" style="{$font_size}">
        <colgroup>
        {section name=col loop=$settings.col_size}
            <col width="{$settings.col_width}%">
            <col width="0%">
        {/section}
        </colgroup>
        {assign var='col_count' value=1}
        {foreach from=$link item=item}
            {if $col_count == 1}
                <tr>
            {/if}
            {if $item.type eq 'line'}
                {if $col_count != 1}
                    {section name=col_padding loop=$settings.col_size-$col_count+1}
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    {/section}
                {/if}
                {assign var='col_count' value=1}
                </tr>
                <tr>
                    <td colspan="{$settings.col_span}">
                        <div class="border-partition-common-grn"></div>
                    </td>
                </tr>
            {else}
                {if $item.sid > 0}
                    <td nowrap>
                        <ul class="link_porlet">
                            <li>
                                {grn_sso_link caption=$item.title truncated_caption=$subject_width sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url}
                                {grn_sso_link caption='' sso_id=$item.sid app_id="link" id_list=$item.sso_param redirect_url=$item.url image='blank20.gif' target='_blank'}
                            </li>
                        </ul>
                    </td>
                {else}
                    <td nowrap>
                        <ul class="link_porlet">
                            <li>
                                {grn_link_raw page=$item.url caption=$item.title truncated_caption=$subject_width no_script=true}
                                {capture name='grn_link_portlet_GRN_LNK_PO_27'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-27' replace='true'}{/capture}
                                {grn_link_raw page=$item.url caption='' image='blank20.gif' target='_blank' title=$smarty.capture.grn_link_portlet_GRN_LNK_PO_27 no_script=true}
                            </li>
                        </ul>
                    </td>
                {/if}
                <td nowrap>
                    <span>
                        <a href="{grn_pageurl page='link/view' cid=$category.cid lid=$item.lid type=$settings.type}">
                            {capture name='grn_link_portlet_GRN_LNK_PO_28'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-28' replace='true'}{/capture}
                            {grn_image image='detail20.gif' alt=$smarty.capture.grn_link_portlet_GRN_LNK_PO_28}
                            <span class="courteous_element_grn">{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-28' replace='true'}</span>
                        </a>
                    </span>
                </td>
                {if $col_count == $settings.col_size}
                    {assign var='col_count' value=1}
                    </tr>
                {else}
                    {assign var='col_count' value=$col_count+1}
                {/if}
            {/if}
        {/foreach}
    </table>
{/if}{/strip}
</div> <!--end of portal_frame -->
