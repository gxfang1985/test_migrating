{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/base/base_delete_multi'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <div id="main_menu_part">
    <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='add_base' replace='true'}{/capture}{grn_link page='system/calendar/base/base_add' caption=$smarty.capture.tmp image='domain20.gif'}</span>
  </div>
  <table class="list_column">
	<colgroup>
	  <col width="1%" />
	  <col width="16%" />
	  <col width="16%" />
	  <col width="16%" />
	  <col width="16%" />
      <col width="16%" />
	</colgroup>
	<tbody>
	  <tr>
		<th>{include file='grn/checkall.tpl' elem_name='base-id[]'}</th>
		<th>{cb_msg module='grn.system.i18n.base' key='base_name' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.base' key='workday' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.base' key='workhours' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.base' key='calendar_workday' replace='true'}</th>
        <th>{cb_msg module='grn.system.i18n.base' key='calendar' replace='true'}</th>
	  </tr>
	  {foreach from=$bases item=base}
	  <tr>
	    <td><input type="checkbox" name="base-id[]" value="{$base.id}"></td>
	    {if strlen($base.local_name)}{assign var="base_name" value=$base.local_name}{else}{assign var="base_name" value=$base.name}{/if}
	    <td>{grn_link page="system/calendar/base/base_detail" caption=$base_name bid=$base.id}</td>
	    <td>
          {include file='system/calendar/base/_base_workday.tpl' base=$base}
        </td>
	    <td>
          {include file='system/calendar/base/_base_work_hours.tpl' base=$base}
        </td>
        <td>{if $base.apply_calendar}{cb_msg module='grn.system.i18n.base' key='apply' replace='true'}{else}{cb_msg module='grn.system.i18n.base' key='not_apply' replace='true'}{/if}</td>
	    <td>{$base.calendar.name}</td>
	  </tr>
	  {/foreach}
	</tbody>
  </table>
<div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='delete' replace='true'}{/capture}
{grn_button_submit caption=$smarty.capture.tmp onclick="if(!grn_is_checked(this.form,'base-id[]')) return false;"}
</form>
{include file='grn/system_footer.tpl'}
