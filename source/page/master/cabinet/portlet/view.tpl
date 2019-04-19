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
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {if $folder}
                    {capture name='portlet_title'}{$folder.name|grn_noescape}{/capture}
                    {capture name='portlet_title_left'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-1' replace='true'}{/capture}
                    {capture name='portlet_title_right'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-2' replace='true'}{/capture}
                {else}
                    {capture name='portlet_title'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-3' replace='true'}{/capture}
                {/if}
                {if $folder.hid == 1}
                    <a href="{grn_pageurl page='cabinet/index' top=$folder.hid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_left|escape}</span>
                        {$smarty.capture.portlet_title|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_right|escape}</span>
                    </a>
                {else}
                    <a href="{grn_pageurl page='cabinet/index' hid=$folder.hid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};"> - </span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_left|escape}</span>
                        {$smarty.capture.portlet_title|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$smarty.capture.portlet_title_right|escape}</span>
                    </a>
                {/if}
            </span>

        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_cabinet_grn">
{if $use_star}
{include file="star/star_init.tpl" list_id="files_list`$portlet.plid`" use_star=$use_star}
{/if}
<table class="list_column" style="{$font_size}" id="files_list{$portlet.plid}">
 <colgroup>
  {if $use_star}
 <col width="1%">
  {/if} 
{if $portlet.settings.show_columns.title}
  <col width="19%">
{/if}
{if $portlet.settings.show_columns.filename}
  <col width="20%">
{/if}
{if $portlet.settings.show_columns.modifier}
  <col width="20%">
{/if}
{if $portlet.settings.show_columns.mtime}
  <col width="20%">
{/if}
{if $portlet.settings.show_columns.size}
  <col width="20%">
{/if}
 </colgroup>
 <tr>
  {if $use_star}
  <th nowrap></th>
  {/if}
  {if $portlet.settings.show_columns.title}
  <th nowrap>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-4' replace='true'}</th>
  {/if}
  {if $portlet.settings.show_columns.filename}
  <th nowrap>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-5' replace='true'}</th>
  {/if}
  {if $portlet.settings.show_columns.modifier}
  <th nowrap>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-6' replace='true'}</th>
  {/if}
  {if $portlet.settings.show_columns.mtime}
  <th nowrap>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-7' replace='true'}</th>
  {/if}
  {if $portlet.settings.show_columns.size}
  <th nowrap>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-8' replace='true'}</th>
  {/if}
 </tr>
{foreach from=$files item=file}
 <tr>
 {if $use_star}
 <td>
 {grn_star_icon module="grn.cabinet" star_infos=$star_infos unique_id=$file.id fid=$file.id hid=$folder.hid}
 </td>
 {/if}
 {if $portlet.settings.show_columns.title}
  <td nowrap>
  {if $file.title}
    {grn_link page='cabinet/view' caption=$file.title image='file20.gif' hid=$folder.hid fid=$file.id truncated_caption=$config.subject_width}
  {else}
    {grn_link page='cabinet/view' caption=$file.filename image='file20.gif' hid=$folder.hid fid=$file.id truncated_caption=$config.subject_width}
  {/if}
  </td>
 {/if}
 {if $portlet.settings.show_columns.filename}
  <td nowrap><a class="with_lang" href='{grn_pageurl page="cabinet/download" hid=$folder.hid fid=$file.id postfix=$file.filename ticket=$download_ticket}'>{grn_image image='disk20.gif'}<nobr></nobr>{$file.filename|escape:"html"}</a></td>
 {/if}
 {if $portlet.settings.show_columns.modifier}
  <td nowrap style="{$fontsize}">
   {grn_user_name uid=$file.modifier_uid name=$file.modifier_name truncated=$config.name_width users_info=$users_info}
  </td>
 {/if}
 {if $portlet.settings.show_columns.mtime}
  <td nowrap style="{$fontsize}">
   {grn_date_format date=$file.mtime format="DateTimeCompact"}
  </td>
 {/if}
 {if $portlet.settings.show_columns.size}
  <td nowrap style="{$fontsize}">{grn_format_filesize size=$file.size unit="KB" round='ceil'}</td>
 {/if}
 </tr>
{/foreach}
</table>
</div> <!--end of portal_frame -->
