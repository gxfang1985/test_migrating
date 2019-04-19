{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='xxx'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p> </p>
<div id="main_menu_part">
  <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='modify' replace='true'}{/capture}{grn_link page='system/calendar/base/base_modify' caption=$smarty.capture.tmp image='modify20.gif' bid=$base.id}</span>
  <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='delete' replace='true'}{/capture}{grn_link page='system/calendar/base/base_delete' caption=$smarty.capture.tmp image='delete20.gif' bid=$base.id}</span>
</div>
  <p></p>
  <table class="view_table">
    <tbody>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='base_name' replace='true'}
        </th>
        <td>
          {if strlen($base.local_name)}{$base.local_name}{else}{$base.name}{/if}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='base_code' replace='true'}
        </th>
        <td>
          {$base.code}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='workday' replace='true'}
        </th>
        <td>
          {include file='system/calendar/base/_base_workday.tpl' base=$base}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='work_hours' replace='true'}
        </th>
        <td>
          {include file='system/calendar/base/_base_work_hours.tpl' base=$base}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='calendar_workday' replace='true'}
        </th>
        <td>
          {if $base.apply_calendar}{cb_msg module='grn.system.i18n.base' key='apply' replace='true'}{else}{cb_msg module='grn.system.i18n.base' key='not_apply' replace='true'}{/if}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.base' key='calendar' replace='true'}
        </th>
        <td>
          {$base.calendar.name}
        </td>
      </tr>
    </tbody>
  </table>
</form>{include file='grn/system_footer.tpl'}
