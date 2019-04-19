{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div id="main_menu_part">
  <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-1' replace='true'}{/capture}{grn_link page='system/i18n/locale/locale_modify' caption=$smarty.capture.tmp image='modify20.gif' lid=$lid}</span>
  <span class="menu_item">{capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-2' replace='true'}{/capture}{grn_link page='system/i18n/locale/locale_delete' caption=$smarty.capture.tmp image='delete20.gif' lid=$lid}</span>
</div>
  <p></p>
  <table class="view_table">
    <tbody>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-3' replace='true'}
        </th>
        <td>
          {$locale_name}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-4' replace='true'}
        </th>
        <td>
          {$locale_code}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-5' replace='true'}
        </th>
        <td>
          {cb_language_name code=$language_code}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-6' replace='true'}
        </th>
        <td>
          {grn_date_format format=$long_date_format language=$language_code}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-7' replace='true'}
        </th>
        <td>
          {grn_date_format format=$short_date_format language=$language_code}
        </td>
      </tr>
      <tr>
        <th>
          {cb_msg module='grn.system.i18n.locale' key='Locale-8' replace='true'}
        </th>
        <td>
          {grn_date_format format=$time_format language=$language_code}
        </td>
      </tr>
    </tbody>
  </table>
{include file='grn/system_footer.tpl'}
