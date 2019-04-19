{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file="/grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<script language="JavaScript" type="text/javascript"><!--{literal}
    jQuery(function(){
        var mailbox_sizeEle = document.getElementById("mailbox_size");
        jQuery(mailbox_sizeEle).on("change",  MailBoxSizeOnChange);
        MailBoxSizeOnChange();

        function MailBoxSizeOnChange(){
            var customsize = document.getElementById("customsize");
            var customize= document.getElementById("customize");
            var customsizeWarning = document.getElementById("customsizeWarning");
            if(mailbox_sizeEle.value == -10){
                customsize.style.display = '';
                var customValue = mailbox_sizeEle.options[0].value;
                if(customValue > 0){
                    if(customize.value == '' && customsizeWarning.style.display != ''){
                        customize.value = customValue;
                    }
                }
            }else{

                customize.value = '';
                customsize.style.display = 'none';
                customsizeWarning.style.display = 'none';
            }
        }
    });
{/literal} --></script>
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-229' replace='true'}</div></p>
<table class="std_form">
 <tr>
  <td colspan="2"><div class="sub_title">{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-230' replace='true'}</div></td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-231' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-232' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-233' replace='true'}</th>
  <td>{grn_select name='mailbox_size' options=$mailbox_size }
  <span id="customsize" >{grn_text name="customize" size="7" maxlength="6" id="customize" value=$customize style="height:14px"}MB</span>
       <div id="customsizeWarning">
           <font color="red" style="font-size:10pt;">
           {capture name='GRN_MAIL_SY_494'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-494' replace='true'}{/capture}
           {validate form=$form_name criteria="isRegExp" field="customize" expression='/^\d+$/' message=$smarty.capture.GRN_MAIL_SY_494}
           {validate form=$form_name criteria="isRange" field="customize" low="1" high="999999" message=$smarty.capture.GRN_MAIL_SY_494}
           </font>
       </div>
  </td>
 </tr>
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-234' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-235' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-236' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-237' replace='true'}</th>
  <td>{grn_select name='receive_size' options=$receive_size}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-238' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-239' replace='true'}</th>
  <td>{grn_select name='send_size' options=$send_size}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_240'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-240' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_240}
       {grn_button_cancel page='system/application_list' app_id='mail'}
  </td>
 </tr>
</table>

<p>
    <div class="notes">
     {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-241' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-242' replace='true'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-243' replace='true'} {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-244' replace='true'}
     <ul>
      <li><span class="required">{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-245' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-246' replace='true'}</span>
      <li><span class="required">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-247' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-248' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-249' replace='true'}</span>
      <li><span class="required">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-250' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-251' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-252' replace='true'}</span>
     </ul>
    </div>

</form>

{include file='grn/system_footer.tpl'}
