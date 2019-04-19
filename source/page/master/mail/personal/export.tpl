{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
{assign var='form_name' value=$smarty.template|basename}
<p>
 <div class='explanation'>
  {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-186' replace='true'}
 </div>
</p>
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="get">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{literal}
<script language="JavaScript" type="text/javascript">
function pre_submit(f)
{
    function toExtractableFilename(file_name)
    {
       	file_name = file_name.replace(/[\?\*\/\\"':|<>]/g,'_');
        file_name = file_name.replace(/^(\s|┗|└)*/, '');
        file_name = encodeURIComponent(file_name);
        if (navigator.userAgent.toLowerCase().indexOf("msie") > -1) 
        {
            file_name = file_name.replace(/^(%C2%A0|%E2%94%94|%E2%94%97)*/, '');
        }
        file_name = file_name + ".zip";
        return file_name;
    }

    var obj_eml = document.getElementById("eml");
    var obj_mbox = document.getElementById("mbox");
    var obj_select= f.ncid;
    var file_name = '';
    if(obj_eml.checked == true)
    {
       for(i=0;i<obj_select.options.length;i++)
       {
            if(obj_select.options[i].selected == true)
            {
                file_name = obj_select.options[i].text;
                break;
            }
       }
       file_name = toExtractableFilename(file_name);  
       action = '{/literal}{grn_pageurl page='mail/personal/command_export'}{literal}';
       action = action.replace(/[?]/g,'');
       f.action  = action + '/-/'+ file_name + '?';
    }
    if(obj_mbox.checked == true)
    {
        f.action = '{/literal}{grn_pageurl page='mail/personal/command_export' postfix='mbox'}{literal}';
    }
    
}
</script>
{/literal}

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-187' replace='true'}</th>
  <td>{grn_select name='naccount' options=$user_account onchange="changeAccount(this,'change_folder_','ncid')"}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-188' replace='true'}</th>
  <td>
{foreach name=folder_data from=$folder_list.data item=folder}
 {if $folder_list.selected == $folder.aid}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}">{grn_mail_select_folders select_name="ncid" account_id=$folder.aid hide_root_folder='1' hide_garbage_folder='0'}</span>
 {else}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}" style="display:none">{grn_mail_select_folders select_name='ncid'|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid hide_root_folder='1' hide_garbage_folder='0'}</span>
 {/if}
{/foreach}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-189' replace='true'}</th>
  <td>
  {capture name='grn_mail_personal_GRN_MAIL_PE_190'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-190' replace='true'}{/capture}{grn_radio name='format' id='mbox' value='mbox' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_190 checked=TRUE }<br>
  {capture name='grn_mail_personal_GRN_MAIL_PE_191'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-191' replace='true'}{/capture}{grn_radio name='format' id='eml' value='eml' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_191 }<br>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_mail_personal_GRN_MAIL_PE_192'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-192' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_192 onclick="pre_submit(this.form);"}
      {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>
{/if}
{include file='grn/personal_footer.tpl'}
