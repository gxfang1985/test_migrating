{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='work_hours_list_count' value=$base.work_hours_list|@count|max:1}

{include file='system/calendar/base/_base_work_hours_script.tpl' next_number=$work_hours_list_count+1}
<form name="{$form_name}" method="post"  action="{grn_pageurl page=$action_page}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
  {if $base.id}<input type="hidden" name="bid" value="{$base.id}" />{/if}
  <p></p>
  {include file='grn/show_validation_errors.tpl'}
  {include file='grn/indispensable.tpl'}
  <table class="std_form">
    <tbody>
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='base_name' replace='true'}</th>
        <td id="base-name">{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='name_required' replace='true'}{/capture}{grn_text_multilanguage element_name="base-name" form_name=$form_name values=$base.names error_message=$smarty.capture.tmp}</td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='base_code' replace='true'}<span class="attention">*</span></th>
        <td>
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='base_code' replace='true'}{/capture}{grn_text name='base-code' maxlength='100' size='50' title=$smarty.capture.tmp value='' disable_return_key=true value=$base.code}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='code_required' replace='true'}{/capture}{validate form=$form_name field="base-code" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.tmp}
        </td>
      </tr>
{include file='system/calendar/base/_base_input_optional.tpl' base=$base calendars=$calendars minute_interval=$minute_interval}
      <tr>
        <td></td>
        <td>
          <input type="button" style="" onclick="submit(this.form)" value="{cb_msg module='grn.system.i18n.base' key='set' replace='true'}" class="margin">
          <input type="button" onclick="history.back()" value="{cb_msg module='grn.system.i18n.base' key='cancel' replace='true'}" class="">
        </td>
      </tr>
    </tbody>
  </table>
</form>

{include file='grn/system_footer.tpl'}
