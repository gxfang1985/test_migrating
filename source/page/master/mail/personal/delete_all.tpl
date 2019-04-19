{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
{literal}
<script language="javascript" type="text/javascript">
<!--
    function get_date(f)
    {
        // get account info
        var item_account_name = jQuery(f).find("span.account_name:first-child");
        var account_info = document.getElementById("account").options[document.getElementById("account").selectedIndex].text;
        var account_name = truncate(account_info, 30, "...");

        var tmp_div = jQuery("<div id='tmpdiv'></div>");
        var tmp_div_text = tmp_div.text(account_name);
        account_name = tmp_div_text.html();

        item_account_name.html(account_name);
        var account_id = document.getElementById("account").options[document.getElementById("account").selectedIndex].value;
        var input_aid = document.createElement("input");
        input_aid.setAttribute("type", "hidden");
        input_aid.setAttribute("name", "aid");
        input_aid.setAttribute("value", account_id);
        f.appendChild(input_aid);

        // get year info
        var term_year = document.getElementById("term_year").options[document.getElementById("term_year").selectedIndex].value;
        var input_year = document.createElement("input");
        input_year.setAttribute("type", "hidden");
        input_year.setAttribute("name", "term_year");
        input_year.setAttribute("value", term_year);
        f.appendChild(input_year);

        // get month info
        var term_month = document.getElementById("term_month").options[document.getElementById("term_month").selectedIndex].value;
        var input_month = document.createElement("input");
        input_month.setAttribute("type", "hidden");
        input_month.setAttribute("name", "term_month");
        input_month.setAttribute("value", term_month);
        f.appendChild(input_month);

        // get day info
        var term_day = document.getElementById("term_day").options[document.getElementById("term_day").selectedIndex].value;
        var input_day = document.createElement("input");
        input_day.setAttribute("type", "hidden");
        input_day.setAttribute("name", "term_day");
        input_day.setAttribute("value", term_day);
        f.appendChild(input_day);

        // update item date
        var str_date = term_year + ' {/literal}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-244' replace='true'}{literal}  ' + term_month + ' {/literal}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-245' replace='true'}{literal} ' + term_day + ' {/literal}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-246' replace='true'}{literal} ';
        var item_date = jQuery(f).find("span.term_date_popup_display:first-child");
        item_date.html(str_date);
    }
//-->
</script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <div class="explanation">
    {$explanation}<br>
   </div>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-248' replace='true'}</th>
  <td>
       {grn_select name='account' options=$user_account}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-249' replace='true'}</th>
  <td>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-253' replace='true'} {grn_select_date prefix='term_' date=$date form_name=$form_name}&nbsp;{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-254' replace='true'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler before_delete=$delete_info.before_delete}
       {capture name='grn_mail_personal_GRN_MAIL_PE_251'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-251' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_251 id="btn_delete" onclick="return false;"}
       {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>
{/if}
{include file='grn/personal_footer.tpl'}
