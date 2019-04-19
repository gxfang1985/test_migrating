{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/i18n/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><p></p>
<div class="subtitme"></div>
<table class="std_form">
  <tbody>
  {if $nickname_enabled}
    <tr>
        <th id="th-1">{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-10' replace='true'}</th>
        <td id="td-1">
          <table>
            <tr>
              <td>
                <select id="language-selected" name="language-selected[]" multiple="multiple" size="5">
                  {foreach from=$user_name_languages item=user_name_language}
                  <option value="{$user_name_language.language_code}">{cb_language_name code=$user_name_language.language_code}</option>
                  {/foreach}
                  {if $os == 'mac'}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {else}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {/if}
                </select>
              </td>
              <td>
                <input type="button" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-14' replace='true'}" onclick="AddMember( 'personal/i18n/common_set', 'language-candidate[]', 'language-selected[]');" />
                <br />
                <input type="button" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-15' replace='true'}" onclick="RemoveMember( 'personal/i18n/common_set', 'language-selected[]');"/>
              </td>
              <td>
                <select id="language-candidate" name="language-candidate[]" multiple="multiple" size="5">
                {foreach from=$language_code_list item=language_code}
                <option value="{$language_code}">{cb_language_name code=$language_code}</option>
                {/foreach}
                {if $os == 'mac' }
                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                {else}
                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                {/if}
                </select>
              </td>
            </tr>
          </table>
        </td>
      </tr>
  {/if}
      <tr>
        <th id="th-2" nowrap>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-18' replace='true'}</th>
        <td id="td-2">{grn_mail_charset name='receiving_email_charset' default=$receiving_email_charset hide_select_encoding_msg=1 disable_onchange=1 force_locale=1}</td>
      </tr>
      <tr>
        <td></td>
        <td>
          <input type="submit" style="" onclick="grn_onsubmit_common(this.form)" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-2' replace='true'}" class="margin">
          <input type="button" onclick="history.back()" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-16' replace='true'}" class="">
        </td>
      </tr>
  </tbody>
  </table>
</form>
{*
{include file="grn/for-screenshot.tpl"}
<script>
  GrnDoc_Clip("1", "#th-1");
  GrnDoc_Clip("2", "#td-1");
  GrnDoc_Clip("3", "#th-2");
  GrnDoc_Clip("4", "#td-2");
</script>
*}
{include file='grn/personal_footer.tpl'}
