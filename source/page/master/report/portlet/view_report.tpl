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
{if $filter_id}
 {assign var=fragment value='type='|cat:$display_type|cat:'&fid='|cat:$filter_id}
{else}
 {assign var=fragment value='type='|cat:$display_type}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {capture name='grn_report_portlet_GRN_RPRT_PO_1'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-1' replace='true'}{/capture}{capture name='grn_report_portlet_GRN_RPRT_PO_2'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-2' replace='true'}{/capture}
                <a href='{grn_pageurl page='report/index'}#{$fragment}'>
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.grn_report_portlet_GRN_RPRT_PO_1}</span>
                    {$display_type_name}
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.grn_report_portlet_GRN_RPRT_PO_2}</span>
                </a>
                {if $portlet.name}
                    {assign var="title" value=$portlet.name}
                {else}
                    {assign var="title" value=$portlet.title}
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_report_grn">
{if $use_star}
{include file="star/star_init.tpl" list_id="files_list`$portlet.plid`" use_star=$use_star}
{/if}
<table class="list_column" style="{$font_size}" id="files_list{$portlet.plid}">
 <colgroup>
{if $use_star}
    <col width="1%">
{/if} 
     <col width="20%">
     <col width="20%">
{if $settings.creator}
     <col width="10%">
{/if}
 {if $settings.mtime}
     <col width="12%">
{/if}
 </colgroup>
 <tr>
  {if $use_star}
  <th nowrap></th>
  {/if}
  <th nowrap>{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-3' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-4' replace='true'}</th>
 {if $settings.creator}
  <th nowrap>{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-5' replace='true'}</th>
 {/if}
 {if $settings.mtime}
  <th nowrap>{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-6' replace='true'}</th>
 {/if}
 </tr>
 {foreach from=$report_list item=report}
 <tr>
  {if $use_star}
 <td>
 {grn_star_icon module="grn.report" star_infos=$star_infos unique_id=$report.id rid=$report.id}
 </td>
 {/if}
  <td nowrap>{grn_link page=$view_page image='report20.gif' caption="`$report.form_name`" truncated_caption=$subject_width_fix rid=$report.id}</td>
  <td nowrap>{grn_link page=$view_page caption="`$report.name`" truncated_caption=$subject_width rid=$report.id}</td>
  {if $settings.creator}
  <td nowrap>{grn_user_name uid=$report.creator name=$report.creator_name truncated=$name_width valid=$report.user_valid}</td>
  {/if}
  {if $settings.mtime}
  <td nowrap>{grn_date_format date=$report.mtime}</td>
 {/if}
</tr>
 {/foreach}
</table>
</div> <!--end of portal_frame -->
