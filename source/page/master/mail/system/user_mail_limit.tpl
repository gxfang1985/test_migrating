{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file="/grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<script language="JavaScript" type="text/javascript"><!--{literal}
    jQuery(function(){
        var mailbox_sizeEle = document.getElementById("mailbox_size");
        jQuery(mailbox_sizeEle).on("change", MailBoxSizeOnChange);
        MailBoxSizeOnChange();
        function MailBoxSizeOnChange()
        {
            var customsize = document.getElementById("customsize");
            var customize = document.getElementById("customize");
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

<div class="explanation">
{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-492' replace='true'}<span class="bold">{grn_user_name uid=$user_id nolink=TRUE}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-180' replace='true'}
</div>
<br>
<table class="std_form">
 <tr>
  <td colspan="2"><div class="sub_title">{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-181' replace='true'}</div></td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-182' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-183' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-184' replace='true'}</th>
  <td>{grn_select name='mailbox_size' options=$mailbox_size}
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
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-185' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-186' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-187' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-188' replace='true'}</th>
  <td>{grn_select name='receive_size' options=$receive_size}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-189' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-190' replace='true'}</th>
  <td>{grn_select name='send_size' options=$send_size}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_191'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-191' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_191}
       {grn_button_cancel page='mail/system/user_disk_size'}
  </td>
 </tr>
</table>

<p>
    <div class="notes">
     {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-192' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-193' replace='true'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-194' replace='true'} {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-195' replace='true'}
     <ul>
      <li><span class="required">{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-196' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-197' replace='true'}</span>
      <li><span class="required">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-198' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-199' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-200' replace='true'}</span>
      <li><span class="required">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-201' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-202' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-203' replace='true'}</span>
     </ul>
    </div>
<input type="hidden" name="uid" value="{$user_id|escape}">
</form>

{include file='grn/system_footer.tpl'}
