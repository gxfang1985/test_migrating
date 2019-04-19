{if $settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}
{grn_load_javascript file="grn/html/wm.js"}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='mail/index' disabled=1}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_new_mail_grn">
{if $disable_mail}
<table class="list_column" style="{$font_size}">
 <colgroup>
  <col width="100%">
 </colgroup>
 <tr><td>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-1' replace='true'}</td></tr>
</table>
{else}
  <div id="mail_view_{$plid}">{include file='mail/portlet/check_mails.tpl'}</div>
  {if $check_mails && $has_account}
    {grn_load_javascript file="grn/html/page/mail/portlet.js"}
    {literal}
     <script language="JavaScript" type="text/javascript">
     mailPortlet.valueStore.mail_view_{/literal}{$plid}{literal}
        = mailPortlet.createCheckMailsParameter( "mail_view_{/literal}{$plid}{literal}",
                                                 "received_mail_count_{/literal}{$plid}{literal}",
                                                 "mail/portlet/check_mails",
                                                 {
                                                     plid: "{/literal}{$plid}{literal}",
                                                     csrf_ticket: "{/literal}{$csrf_ticket}{literal}",
                                                     _notimecard: "1",
                                                     b_on_login: "{/literal}{$b_on_login}{literal}"
                                                 },
                                                 { 'X-Cybozu-Session-No-Prolonging': 'true'},
                                                 "POST",
                                                 {/literal}{$check_span*1000}{literal},
                                                 "{/literal}{cb_msg module='grn' key='GRN_GRN-1' replace='true'}{literal}");
     setTimeout('mailPortlet.getNumberOfNewMails(mailPortlet.valueStore.mail_view_{/literal}{$plid}{literal})', 5000);
     </script>
   {/literal}
  {/if}
{/if}
</div> <!--end of portal_frame -->
