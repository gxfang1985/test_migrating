{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/i18n/locale/command_locale_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <p id="explanation">{cb_msg module='grn.system.i18n.locale' key='Locale-9' replace='true'} <span class="bold person20">{$locale.name}</span> {cb_msg module='grn.system.i18n.locale' key='Locale-10' replace='true'}</p>
  <table class="std_form">
    <tbody>
      <tr>
        <td>
          <input type="hidden" name="lid" value="{$locale.id}">
          <input type="button" onclick="submit(this.form)" value="{cb_msg module='grn.system.i18n.locale' key='Locale-11' replace='true'}" class="margin">
	  {grn_button_cancel page="system/i18n/locale/locale_detail" lid=$locale.id}
        </td>
      </tr>
    </tbody>
  </table>
</form>

{include file='grn/system_footer.tpl'}
