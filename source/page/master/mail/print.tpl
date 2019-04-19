{assign var="is_print_page" value=true}
{include file="grn/head.tpl"}

<style>
{literal}
.format_contents {
    margin:0;
    word-wrap: break-word;
}
{/literal}
</style>

<body class="print_body_grn">
    <div id="div_print_setting">
      <table class="table_plain_grn print_action_base_grn">
        <tbody>
          <tr>
            <td nowrap="">
              <table border="0" cellspacing="0" cellpadding="4" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="">
                      <font size="+1">{cb_msg module="grn.mail" key="PRINT_SETTING" replace="true"}</font>
                      <font size="-1">{cb_msg module="grn.mail" key="THIS_AREA_WILL_NOT_BE_PRINTED" replace="true"}</font>
                    </td>
                  </tr>
                </tbody>
              </table>
              <br />
              <table class="formTable">
                <colgroup>
                  <col nowrap>
                  <col nowrap>
                </colgroup>
                <tbody>
                  <tr>
                    <td align="right">{cb_msg module="grn.mail" key="FONT_SIZE" replace="true"}</td>
                    <td>
                      <select onchange="setFontSize(this.value)" id="FontSize">
                        <option value="8pt">8pt</option>
                        <option value="9pt">9pt</option>
                        <option value="10pt">10pt</option>
                        <option value="11pt">11pt</option>
                        <option value="12pt" selected="">12pt</option>
                        <option value="13pt">13pt</option>
                        <option value="14pt">14pt</option>
                        <option value="15pt">15pt</option>
                        <option value="16pt">16pt</option>
                        <option value="17pt">17pt</option>
                        <option value="18pt">18pt</option>
                        <option value="19pt">19pt</option>
                        <option value="20pt">20pt</option>
                      </select>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td align="right">{cb_msg module="grn.mail" key="LOCALE_SETTING" replace="true"}</td>
                    <td>
                      <select onchange="setLocale(this.value)" id="Locale">
                        <option value="user">{cb_msg module="grn.mail" key="USER_SETTING" replace="true"}</option>
                        <option value="system">{cb_msg module="grn.mail" key="SYSTEM_SETTING" replace="true"}</option>
                      </select>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td align="right"></td>
                      <td>
                          {strip}
                              <div class="mTop10 mBottom5">
                                  {capture name='grn_mail_PRINT'}{cb_msg module="grn.mail" key="PRINT" replace="true"}{/capture}
                                  {capture name='grn_mail_BACK'}{cb_msg module="grn.mail" key="BACK" replace="true"}{/capture}
                                  {grn_button id="mail_button_print" ui="main" spacing="normal" caption=$smarty.capture.grn_mail_PRINT onclick="doPrint();"}
                                  {grn_button id="mail_button_back" action="cancel" page="mail/view" page_param_mid=$mid caption=$smarty.capture.grn_mail_BACK}
                              </div>
                          {/strip}
                      </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </tbody>
      </table>      
    </div>
    <div id="view">
 <table border="0" cellspacing="10" cellpadding="0" style="font-size:100%;">
  <tr valign="top" align="left">
   <th nowrap>{grn_msg_switch module='grn.mail' key='GRN_MAIL-244'}</th>
   <td>{grn_mail_name type=$name_type name_format=$name_format name=$mail.from mid=$mail.id}</td>
  </tr>
  <tr valign="top" align="left">
   <th>{grn_msg_switch module='grn.mail' key='GRN_MAIL-245'}</th>
   <td>{grn_date_format_switch date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</td>
  </tr>
{if $mail.to neq '' || $mail.cc neq '' || ( $mail.sent && $mail.bcc neq '' ) }

{if $mail.to neq ''}
     <tr valign="top" align="left">
       <th>To:&nbsp;</th>
       <td>{grn_mail_name type=$name_type name_format=$name_format name=$mail.to mid=$mail.id}</td>
     </tr>
{/if}
{if $mail.cc neq ''}
     <tr valign="top" align="left">
       <th>Cc:&nbsp;</th>
       <td>{grn_mail_name type=$name_type name_format=$name_format name=$mail.cc mid=$mail.id}</td>
     </tr>
{/if}
{if $mail.sent and ($mail.bcc neq '')}
     <tr valign="top" align="left">
       <th>Bcc:&nbsp;</th>
       <td>{grn_mail_name type=$name_type name_format=$name_format name=$mail.bcc mid=$mail.id}</td>
     </tr>
{/if}

{/if}
  <tr valign="top" align="left">
   <th>{grn_msg_switch module='grn.mail' key='GRN_MAIL-247'}</th>
   <td>
{if $mail.subject eq ''}
 {grn_link page='mail/view' caption_module='grn.mail' caption_key='no_title' disabled=1}
     {else}
 {grn_link page='mail/view' caption=$mail.subject mid=$mail.mid disabled=1}
     {/if}
   </td>
  </tr>
 </table>
 <hr noshade>
<br>
{if $mail.html_data eq "1" && $can_show_html}
    <div id="mail_content">{$mail.data|grn_noescape}</div>
{else}
{grn_format body=$mail.data nolink=1}
{/if}
{if $mail.attach_file_type}
    <tt>
        {foreach from=$mail.attach_files item=attach_file key=file_key}
            <br>
            {if $mail.attach_file_type eq '2'}
                {grn_image image='clip8x20.gif'}{$attach_file.name|escape}
            {else}
                {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key mime=$attach_file.mime inline=$inline no_source=$mail.no_source no_rfc822link=1 disabled=true hash=$attach_file.hash}
            {/if}
        {/foreach}
    </tt>
{/if}
</div>
</body>
</html>
