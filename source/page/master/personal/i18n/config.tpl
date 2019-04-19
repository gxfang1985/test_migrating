{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{if $user_db_language == '' && $smarty.const.ON_FOREST ==1}
<div class="margin_top">
    <span class="attention">{cb_msg module='grn.personal.i18n' key='attention' replace='true'}</span>
</div>
{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/i18n/command_config'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><p></p>

{if $smarty.const.ON_FOREST!==1}
  <table id="form1" class="std_form">
    <tbody>
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-4' replace='true'}</th>
        <td>
          <select name="locale" id="locale">
            {if $user_modified}
            <option class="user-modified-locale" value="{$user_locale_setting.col_locale}" selected>{$selected_locale_name}{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-17' replace='true'}</option>
            {/if}
            {foreach from=$locales item=locale}
            <option value="{$locale.id}" {if $locale.id == $user_locale_setting.col_locale && !$user_modified}selected{/if}>{$locale.name}</option>
            {/foreach}
            <option id="blank-locale" value="" {if $user_locale_setting && !$user_locale_setting.col_locale}selected{/if}>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-5' replace='true'}</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>
{/if}
  <div id="caption-specific" class="sub_title margin_top">{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-6' replace='true'}</div>
  <table id="form2" class="std_form">
    <tbody>
    {if $smarty.const.ON_FOREST!==1}
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='timezone' replace='true'}</th>
        <td width="300">
          {grn_select_timezone select_timezone=$timezone}
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-1' replace='true'}</th>
        <td>
          <select name="language" id="language">
            {foreach from=$language_code_list item=language_code}
            <option value="{$language_code}" {if $language_code == $selected_language}selected{/if}>{cb_language_name code=$language_code}</option>
            {/foreach}
          </select>
        </td>
      </tr>
    {/if}
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-7' replace='true'}</th>
        <td>
          <select name="long-date-format" id="long-date-format"{if $user_db_language == '' && $smarty.const.ON_FOREST==1} disabled{/if}>
            {foreach from=$long_date_format_list.$selected_language item=long_date_format key=long_date_format_key}
            <option value="{$long_date_format_key}" {if $long_date_format == $current_setting.col_long_date_format}selected{/if}>{grn_date_format format=$long_date_format language=$selected_language}</option>
            {/foreach}
            </select>
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-8' replace='true'}</th>
        <td>
          <select name="short-date-format" id="short-date-format"{if $user_db_language == '' && $smarty.const.ON_FOREST==1} disabled{/if}>
            {foreach from=$short_date_format_list.$selected_language item=short_date_format key=short_date_format_key}
            <option value="{$short_date_format_key}" {if $short_date_format == $current_setting.col_short_date_format}selected{/if}>{grn_date_format format=$short_date_format language=$selected_language}</option>
            {/foreach}
            </select>
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-9' replace='true'}</th>
        <td>
          <select name="time-format" id="time-format"{if $user_db_language == '' && $smarty.const.ON_FOREST==1} disabled{/if}>
            {foreach from=$time_format_list.$selected_language item=time_format key=time_format_key}
            <option value="{$time_format_key}" {if $time_format == $current_setting.col_time_format}selected{/if}>{grn_date_format format=$time_format language=$selected_language}</option>
            {/foreach}
          </select>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
          <input type="submit" style="" onclick="grn_onsubmit_common(this.form)" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-2' replace='true'}" class="margin"{if $user_db_language == '' && $smarty.const.ON_FOREST==1} disabled{/if}>
          <input type="button" onclick="history.back()" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-16' replace='true'}" class="">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script>{literal}
jQuery(function(){
    var isOnForest = {/literal}{if $smarty.const.ON_FOREST == 1}true{else}false{/if}{literal};

    function onLanguageChanged() {
        var longDateFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}": [
                {foreach from=$long_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };
        var shortDateFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}": [
                {foreach from=$short_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };
        var timeFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}": [
                {foreach from=$time_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };

        function updateSelectBox(elementId, formats) {
            var select_elm = jQuery("#" + elementId);
            select_elm.find("option").each(function (idx, elm) {
                jQuery(elm).remove();
            });

            for (var i = 0, formatsLength = formats.length; i < formatsLength; i++) {
                var format = formats[i];
                var option = document.createElement("option");
                option.setAttribute("value", i);
                option.innerHTML = format;
                select_elm.append(option);
            }
        }

        updateSelectBox("long-date-format", longDateFormats[jQuery("#language").val()]);
        updateSelectBox("short-date-format", shortDateFormats[jQuery("#language").val()]);
        updateSelectBox("time-format", timeFormats[jQuery("#language").val()]);
    }

    if (!isOnForest && (jQuery("#language").length > 0)) {
        jQuery("#language").on("change", function () {
            onLanguageChanged();
        });
    }

    var locales = {
        {/literal}{foreach from=$locales item=l key=k name="locale_list"}
        "{$l.id}": {literal}{{/literal}
            "name": "{$l.name}",
            "language": "{$l.language}",
            "longDateFormat": "{$l.longDateFormat}",
            "shortDateFormat": "{$l.shortDateFormat}",
            "timeFormat": "{$l.timeFormat}"
            {literal}}{/literal}{if !$smarty.foreach.locale_list.last},{/if}
        {/foreach}{literal}
    };

    {/literal}
    {if $user_locale_setting && !$user_locale_setting.col_locale}
    locales.blank_locale = {literal}{{/literal}
        "language": "{$user_locale_setting.language_code}",
        "longDateFormat": "{grn_date_format format=$current_setting.col_long_date_format language=$selected_language}",
        "shortDateFormat": "{grn_date_format format=$current_setting.col_short_date_format language=$selected_language}",
        "timeFormat": "{grn_date_format format=$current_user_setting.col_time_format language=$selected_language}"
        {literal}};{/literal}
    {/if}
    {literal}

    function updateBlankLocaleData() {
        blankLocaleData = new Object();
        blankLocaleData['language'] = jQuery("#language").val();
        var long_date_format_elm = jQuery("#long-date-format").get(0);
        blankLocaleData['longDateFormat'] = long_date_format_elm.options[long_date_format_elm.selectedIndex].innerHTML;
        var short_data_format_elm = jQuery("#short-date-format").get(0);
        blankLocaleData['shortDateFormat'] = short_data_format_elm.options[short_data_format_elm.selectedIndex].innerHTML;
        var time_format_elm = jQuery("#time-format").get(0);
        blankLocaleData['timeFormat'] = time_format_elm.options[time_format_elm.selectedIndex].innerHTML;

        locales["blank_locale"] = blankLocaleData;
    }

    if (!isOnForest) {
        var local_elm = jQuery("#locale");
        local_elm.on("change", function () {
            var selected_locale = "";
            if (local_elm.get(0).options[local_elm.get(0).selectedIndex].id == "blank-locale") {
                selected_locale = "blank_locale";
            }
            else {
                selected_locale = local_elm.val();
            }

            jQuery(".user-modified-locale").each(function (idx, elm) {
                elm.parentNode.removeChild(elm);
            });

            if (!(selected_locale in locales)) {
                return;
            }

            if (jQuery("#language").length > 0) {
                jQuery("#language").val(locales[selected_locale].language);
            }

            function updateSelectBox(element_id, value) {
                jQuery("#" + element_id).find("option").each(function (idx, elm) {
                    if (elm.text == value) {
                        jQuery("#" + element_id).val(elm.value);
                    }
                });
            }

            onLanguageChanged();

            updateSelectBox("long-date-format", locales[selected_locale].longDateFormat);
            updateSelectBox("short-date-format", locales[selected_locale].shortDateFormat);
            updateSelectBox("time-format", locales[selected_locale].timeFormat);
        });
    }

    jQuery.each([jQuery("#language"), jQuery("#long-date-format"), jQuery("#short-date-format"), jQuery("#time-format")], function (idx, elm) {
        if (!(elm.length > 0)) {
            return;
        }

        elm.on("change", function () {
            var old_locale_value = "";
            if (!isOnForest) {
                old_locale_value = jQuery("#locale").val();
            }
            if (old_locale_value != "") {
                var modifiedLocaleNode = jQuery("#user-modified-locale");
                if (!(modifiedLocaleNode.length > 0)) {
                    modifiedLocaleNode = document.createElement("option");
                    modifiedLocaleNode.setAttribute("id", "user-modified-locale");
                    modifiedLocaleNode.setAttribute("value", old_locale_value);
                    modifiedLocaleNode.text = locales[old_locale_value].name + "{/literal}{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-17' replace='true'}{literal}";
                    if (grn.browser.msie && !isOnForest) {
                        jQuery("#locale").prepend(modifiedLocaleNode);
                    } else {
                        jQuery(modifiedLocaleNode).insertBefore(jQuery("#locale").find("option").get(0));
                    }
                }

                jQuery("#locale").find("option").each(function (idx, elm) {
                    elm.selected = false;
                });

                modifiedLocaleNode.selected = true;
            } else {
                if (!isOnForest) {
                    updateBlankLocaleData();
                }
            }
        });
    });
});
{/literal}</script>
{*
{include file="grn/for-screenshot.tpl"}
<script>
GrnDoc_Clip("1", "#caption-basic");
GrnDoc_Clip("2", "table#form1 tbody tr:nth-child(1) th");
GrnDoc_Clip("3", "table#form1 tbody tr:nth-child(1) td");
GrnDoc_Clip("4", "#caption-specific");
GrnDoc_Clip("5", "table#form2 tbody tr:nth-child(1) th");
GrnDoc_Clip("6", "table#form2 tbody tr:nth-child(1) td");
GrnDoc_Clip("7", "table#form2 tbody tr:nth-child(2) th");
GrnDoc_Clip("8", "table#form2 tbody tr:nth-child(2) td");
GrnDoc_Clip("9", "table#form2 tbody tr:nth-child(3) th");
GrnDoc_Clip("10", "table#form2 tbody tr:nth-child(3) td");
GrnDoc_Clip("11", "table#form2 tbody tr:nth-child(4) th");
GrnDoc_Clip("12", "table#form2 tbody tr:nth-child(4) td");
GrnDoc_Clip("13", "table#form2 tbody tr:nth-child(5) td:nth-child(2) input:nth-child(1)");
GrnDoc_Clip("14", "table#form2 tbody tr:nth-child(5) td:nth-child(2) input:nth-child(2)");
</script>
*}
{include file='grn/personal_footer.tpl'}
