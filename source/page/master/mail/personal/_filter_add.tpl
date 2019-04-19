{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-31' replace='true'}</th>
  <td>{grn_image image='mailaccount20.gif'}{$set.account|escape}

{if $set.stop}
       <br><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
{/if}
  </td>
 </tr>
 <tr>
  <td><br></td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_personal_GRN_MAIL_PE_33'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-33' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_33 append="validation_errors"}{capture name='grn_mail_personal_GRN_MAIL_PE_34'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-34' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_34 necessary=TRUE}</th>
  <td>{capture name='grn_mail_personal_GRN_MAIL_PE_35'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-35' replace='true'}{/capture}{grn_text name="title" value=$filter.title size="50" title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_35 disable_return_key=true}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-36' replace='true'}</th>
  <td>
       <select name="kind">
{if $filter.kind == 2}
        <option value="1">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-37' replace='true'}
        <option value="2" selected>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-38' replace='true'}
{else}
        <option value="1" selected>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-39' replace='true'}
        <option value="2">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-40' replace='true'}
{/if}
       </select>
       <div class="margin_top">
       {include file="grn/mail_filter.tpl"}
       </div>
  </td>
 </tr>
{if $use_status}
 <tr valign="top">
  <th nowrap>{capture name='grn_mail_personal_GRN_MAIL_PE_41'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-41' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_41}</th>
  <td>
{grn_select name="status" options=$status_infos}
       {*grn_mail_select_folders select_name="folder" account_id=$set.aid selected_folder_id=$filter.cid hide_root_folder='1' exception_value='-1' exception_item='（選択してください）' exception_value2='0' exception_item2='（新規作成）'*}
      <div class="margin_top">
       <span class="sub_explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-42' app_name=$app_name}</span>
      </div>
  </td>
 </tr>
{else}
<input type="hidden" name="status" value="{$set.status_id}">
{/if}
 <tr valign="top">
  <th nowrap>{capture name='grn_mail_personal_GRN_MAIL_PE_44'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-44' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_44 necessary=TRUE}</th>
  <td>
       {capture name='grn_mail_personal_GRN_MAIL_PE_45'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-45' replace='true'}{/capture}{validate form=$form_name field="folder" criteria="isNumber" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_45 append="validation_errors"}
{if $set.use_garbage == 1}
       {capture name='grn_mail_personal_GRN_MAIL_PE_46'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-46' replace='true'}{/capture}{capture name='grn_mail_personal_GRN_MAIL_PE_47'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-47' replace='true'}{/capture}{grn_mail_select_folders select_name="folder" account_id=$set.aid selected_folder_id=$filter.cid hide_root_folder='1' exception_value='-1' exception_item=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_46 exception_value2='0' exception_item2=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_47}
{else}
       {capture name='grn_mail_personal_GRN_MAIL_PE_48'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-48' replace='true'}{/capture}{capture name='grn_mail_personal_GRN_MAIL_PE_49'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-49' replace='true'}{/capture}{grn_mail_select_folders select_name="folder" account_id=$set.aid selected_folder_id=$filter.cid hide_root_folder='1' hide_garbage_folder='1' exception_value='-1' exception_item=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_48 exception_value2='0' exception_item2=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_49}
{/if}
      <div class="margin_top">
       <span class="sub_explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-50' replace='true'}</span>
      </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {include file="$button_file"}
  </td>
 </tr>
</table>
