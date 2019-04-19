{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/i18n/locale/locale_delete_multi'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <div id="main_menu_part">
    <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-30' replace='true'}{/capture}{grn_link page='system/i18n/locale/locale_add' caption=$smarty.capture.tmp image='event20.gif'}</span>
  </div>
  <table class="list_column">
	<colgroup>
	  <col width="1%"></col>
	  <col width="20%"></col>
	  <col width="20%"></col>
	  <col width="20%"></col>
	  <col width="20%"></col>
	  <col width="20%"></col>	
	</colgroup>
	<tbody>
	  <tr>
		<th>{include file='grn/checkall.tpl' elem_name='locale-id[]'}</th>
		<th>{cb_msg module='grn.system.i18n.locale' key='Locale-31' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.locale' key='Locale-32' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.locale' key='Locale-33' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.locale' key='Locale-34' replace='true'}</th>
		<th>{cb_msg module='grn.system.i18n.locale' key='Locale-35' replace='true'}</th>
	  </tr>
	  {foreach from=$locales item=locale}
	  <tr>
	    <td><input type="checkbox" name="locale-id[]" value="{$locale.id}"></td>
	    <td>{grn_link page="system/i18n/locale/locale_detail" caption=$locale.name lid=$locale.id}</td>
	    <td>{cb_language_name code=$locale.language_code}</td>
	    <td>{grn_date_format format=$locale.long_date_format language=$locale.language_code}</td>
	    <td>{grn_date_format format=$locale.short_date_format language=$locale.language_code}</td>
	    <td>{grn_date_format format=$locale.time_format language=$locale.language_code}</td>
	  </tr>
	  {/foreach}
	</tbody>
  </table>
<div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
{capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-37' replace='true'}{/capture}
{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.tmp}
</form>
{include file='grn/system_footer.tpl'}
