{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/base/command_base_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <p id="explanation">{cb_msg module='grn.system.i18n.base' key='confirm_delete_before' replace='true'}<span class="bold">{grn_sentence image='facilitygroup20.gif' caption=$base.name}</span>{cb_msg module='grn.system.i18n.base' key='confirm_delete_after' replace='true'}</p>
  <table class="std_form">
    <tbody>
      <tr>
        <td></td>
        <td>
          <input type="hidden" name="bid" value="{$base.id}">
          <input type="button" style="" onclick="submit(this.form)" value="{cb_msg module='grn.system.i18n.base' key='yes' replace='true'}" class="margin">
          <input type="button" onclick="history.back()" value="{cb_msg module='grn.system.i18n.base' key='no' replace='true'}" class="">
        </td>
      </tr>
    </tbody>
  </table>
</form>

{include file='grn/system_footer.tpl'}
