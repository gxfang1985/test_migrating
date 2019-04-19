{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post"  action="{grn_pageurl page='system/i18n/locale/command_locale_add'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  {include file='grn/show_validation_errors.tpl'}
  {include file='grn/indispensable.tpl'}
  <table class="std_form">
    <tbody>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-13' replace='true'}</th>
        <td id="locale-name">{capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-14' replace='true'}{/capture}{grn_text_multilanguage element_name="locale-name" values=$locale_names form_name=$form_name error_message=$smarty.capture.tmp}</td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-15' replace='true'}<span class="attention">*</span></th>
        <td>
          {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-15' replace='true'}{/capture}{grn_text name='locale-code' maxlength='100' size='50' title=$smarty.capture.tmp value=$locale_code disable_return_key=true}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-16' replace='true'}{/capture}{validate form=$form_name field="locale-code" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.tmp}
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-17' replace='true'}</th>
        <td><select name="language" id="language">
            {foreach from=$language_code_list item=language_code}
            <option value="{$language_code}" {if $language_code == $selected_language}selected{/if}>{cb_language_name code=$language_code}</option>
            {/foreach}
        </select></td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-18' replace='true'}</th>
        <td><select name="long-date-format" id="long-date-format">
            {foreach from=$long_date_format_list.$selected_language item=long_date_format_item key=long_date_format_key}
            <option value="{$long_date_format_key}" {if $long_date_format_key == $long_date_format}selected{/if}>{grn_date_format format=$long_date_format_item language=$current_language}</option>
            {/foreach}
            {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-19' replace='true'}{/capture}{validate form=$form_name field="long-date-format" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.tmp}
        </select></td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-20' replace='true'}</th>
        <td><select name="short-date-format" id="short-date-format">
            {foreach from=$short_date_format_list.$selected_language item=short_date_format_item key=short_date_format_key}
            <option value="{$short_date_format_key}" {if $short_date_format_key == $short_date_format}selected{/if}>{grn_date_format format=$short_date_format_item language=$current_language}</option>
            {/foreach}
            {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-21' replace='true'}{/capture}{validate form=$form_name field="short-date-format" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.tmp}
        </select></td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.locale' key='Locale-22' replace='true'}</th>
        <td><select name="time-format" id="time-format">
            {foreach from=$time_format_list.$selected_language item=time_format_item key=time_format_key}
            <option value="{$time_format_key}" {if $time_format_key == $time_format}selected{/if}>{grn_date_format format=$time_format_item language=$current_language}</option>
            {/foreach}
            {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-21' replace='true'}{/capture}{validate form=$form_name field="time-format" criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.tmp}
        </select></td>
      </tr>
      <tr>
        <td></td>
        <td>
          {capture name='tmp'}{cb_msg module='grn.system.i18n.locale' key='Locale-24' replace='true'}{/capture}
          {grn_button_submit caption=$smarty.capture.tmp}
          {grn_button_cancel page="system/i18n/locale/locale"}
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script>{literal}
jQuery(function (){
    jQuery("#language").on("change", function(){
        var longDateFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}":[
                {foreach from=$long_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };
        var shortDateFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}":[
                {foreach from=$short_date_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };
        var timeFormats = {
            {/literal}{foreach from=$language_code_list item=l name="lang_list"}
            "{$l}":[
                {foreach from=$time_format_list.$l item=format name="format_list"}
                "{grn_date_format format=$format language=$l}"{if !$smarty.foreach.format_list.last},{/if}
                {/foreach}]
            {if !$smarty.foreach.lang_list.last},{/if}
            {/foreach}{literal}
        };

        function updateSelectBox( elementId, formats ) {
            var select_elm = jQuery("#" + elementId);
            select_elm.find("option").each(function(idx, elm){
                jQuery(elm).remove();
            });

            for( var i = 0, formatsLength = formats.length; i < formatsLength; i++ ){
                var format = formats[i];
                var option = document.createElement("option");
                option.setAttribute("value", i);
                option.innerHTML = format;
                select_elm.append(option);
            }
        }

        updateSelectBox( "long-date-format", longDateFormats[jQuery("#language").val()] );
        updateSelectBox( "short-date-format", shortDateFormats[jQuery("#language").val()] );
        updateSelectBox( "time-format", timeFormats[jQuery("#language").val()] );
    });
});


{/literal}</script>
{include file='grn/system_footer.tpl'}
