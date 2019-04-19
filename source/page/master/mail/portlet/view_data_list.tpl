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
                {if $portlet.name}
                    {assign var="title" value=$portlet.name}
                {else}
                    {assign var="title" value=$portlet.title}
                {/if}
                {if $account_name && $settings.folder_name}
                    <a href="{grn_pageurl page='mail/index' aid=$aid cid=$cid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-2' replace='true'}</span>
                        {$account_name|escape}
                        &nbsp;
                        {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-3' replace='true'}
                        &nbsp;
                        {$settings.folder_name|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-4' replace='true'}</span>
                    </a>
                {elseif $account_name}
                    <a href="{grn_pageurl page='mail/index'}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                    {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-5' replace='true'}</a>
                {else}
                    <a href="{grn_pageurl page='mail/index'}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                    {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-6' replace='true'}</a>
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_mail_grn">
{if $has_mails}
{if $use_star}{include file="star/star_init.tpl" list_id="mail_list"|cat:$portlet.plid}{/if}
<table class="list_column" style="{$font_size}" id="mail_list{$portlet.plid}">
 <colgroup>
  <col width="{if $use_star}1%{else}{/if}">
  <col width="1%">
  <col width="40%">
  <col width="{if $settings.status}10%{else}0%{/if}">
  <col width="{if $settings.sender}20%{else}0%{/if}">
  <col width="{if $settings.time}20%{else}0%{/if}">
  <col width="{if $settings.remarks}10%{else}0%{/if}">
 </colgroup>
 <tr>
  {if $use_star}<th nowrap></th>{/if}{*star*}
  <th nowrap></th>
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-7' replace='true'}</th>
 {if $settings.status}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-8' replace='true'}</th>
 {else}
  {assign var="no_status" value="1"}
  <th></th>
 {/if}
 {if $settings.sender}
  {if $sent_folder}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-9' replace='true'}</th>
  {else}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-10' replace='true'}</th>
  {/if}
 {else}
  {assign var="no_name" value="1"}
  <th></th>
 {/if}
 {if $settings.time}
  {if $settings.order eq 'recept'}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-11' replace='true'}</th>
  {else}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-12' replace='true'}</th>
  {/if}
 {else}
  {assign var="no_date" value="1"}
  <th></th>
 {/if}
 {if $settings.remarks}
  <th nowrap>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-13' replace='true'}</th>
 {else}
  {assign var="no_remarks" value="1"}
  <th></th>
 {/if}
 </tr>
 {foreach from=$mails item=mail key=mid}
  {include file="mail/_index.tpl" no_checkbox=1 no_name=$no_name no_date=$no_date no_remarks=$no_remarks no_status=$no_status fontsize=$fontsize use_star=$use_star no_stripe=1}
 {/foreach}
</table>
{/if}
{grn_load_javascript file="grn/html/page/mail/mail.js"}
<script language="javascript">
    var __thisPage = grn.page.mail.mail;
</script>
<script language="javascript">
   __thisPage.IMG_PATH = '{$app_path}/grn/image/cybozu/';
   __thisPage.ajax_mail_preview_url = '{grn_pageurl page="mail/ajax_mail_preview"}';
   __thisPage.csrf_ticket = '{$csrf_ticket}';
   __thisPage.from_portlet = true;
</script>
</div> <!--end of portal_frame -->
