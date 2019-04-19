{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{if $is_sandbox_status_not_initial}
<div class="info_area_grn mBottom15 mTop15">
    <div class="icon_information_grn">
        <span>
            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-COMMON-2' replace='true'}
        </span>
    </div>
</div>
{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/i18n/command_common_set'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <table class="std_form margin_bottom">
    <tbody>
    {if $smarty.const.ON_FOREST!==1}
      <tr>
        <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-1' replace='true'}</th>
        <td>
          <table>
            <tr>
              <td>
                <select multiple="multiple" id="display-language-selected" name="display-language-selected[]" size="5" {if $is_sandbox_status_not_initial}disabled{/if}>
                  {foreach from=$display_languages item=language_code}
                  <option value="{$language_code}">{cb_language_name code=$language_code}</option>
                  {/foreach}
                  {if $os == 'mac'}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {else}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {/if}                  
                </select>
              </td>
              <td>
                <input type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-4' replace='true'}" onclick="AddMember( 'system/i18n/common_set', 'display-language-candidate[]', 'display-language-selected[]');" {if $is_sandbox_status_not_initial}disabled{/if}/><br />
                <input type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-5' replace='true'}" onclick="RemoveMember( 'system/i18n/common_set', 'display-language-selected[]');" {if $is_sandbox_status_not_initial}disabled{/if}/>
              </td>
              <td>
                <select multiple="multiple" id="display-language-candidate" name="display-language-candidate[]" size="5" {if $is_sandbox_status_not_initial}disabled{/if}>
                  {foreach from=$language_candidates item=language_code}
                  <option value="{$language_code}">{cb_language_name code=$language_code}</option>
                  {/foreach}
                  {if $os == 'mac'}
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
      <tr>
        <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-2' replace='true'}</th>
        <td>
          <table>
            <tr>
              <td>
                <select multiple="multiple" id="timezone-selected" name="timezone-selected[]" size="5">
                  {foreach from=$display_timezones item=timezone_name}
                  <option value="{$timezone_name}">{cb_msg module='fw.timezone' key=$timezone_name}</option>
                  {/foreach}
                  {if $os == 'mac'}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {else}
                  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                  {/if}
                </select>
              </td>
              <td>
                <input type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-4' replace='true'}" onclick="AddMember( 'system/i18n/common_set', 'timezone-candidate[]', 'timezone-selected[]');" /><br />
                <input type="button" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-5' replace='true'}" onclick="RemoveMember( 'system/i18n/common_set', 'timezone-selected[]');" />
              </td>
              <td>
                <table>
                  <tr>
                    <td>
                      <select id="timezone-type" name="timezone-type" onchange="GRN_System_I18N_CommonSet.switchTimezoneRegion(this.options[this.selectedIndex].value);">
                        {foreach from=$timezone_regions item=timezone_region}
                        <option value="{$timezone_region}">{cb_msg module='fw.timezone' key=$timezone_region}</option>
                        {/foreach}
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <select  multiple="multiple" id="timezone-candidate" name="timezone-candidate[]" size="5">
                        {foreach from=$timezone_candidates item=timezone_name}
                        <option value="{$timezone_name}">{cb_msg module='fw.timezone' key=$timezone_name}</option>
                        {/foreach}
                        {if $os == 'mac'}
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
          </table>
        </td>
      </tr>
    {/if}
      <tr>
        <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-3' replace='true'}</th>
        <td>
          <table>
            <tr>
              <td>
                {cb_msg module='grn.system.i18n' key='GRN_SY_I18N-8' replace='true'}
              </td>
              <td>
	            <select name="print-language" id="print-language">
		          {foreach from=$language_code_list item=language_code}
		          <option value="{$language_code}" {if $language_code == $print_language}selected{/if}>{cb_language_name code=$language_code}</option>
		          {/foreach}
	            </select>
              </td>
            </tr>
            <tr>
              <td>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-9' replace='true'}</td>
              <td>
                <select name="print-long-date-format" id="print-long-date-format">
		          {foreach from=$long_date_format_list.$print_language item=iter_long_date_format key=long_date_format_key}
		          <option value="{$long_date_format_key}" {if $iter_long_date_format==$print_long_date_format}selected{/if}>{grn_date_format format=$iter_long_date_format language=$print_language}</option>
		          {/foreach}
	            </select>
              </td>
            </tr>
            <tr>
              <td>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-15' replace='true'}</td>
              <td>
                <select name="print-short-date-format" id="print-short-date-format">
		          {foreach from=$short_date_format_list.$print_language item=iter_short_date_format key=short_date_format_key}
		          <option value="{$short_date_format_key}" {if $iter_short_date_format==$print_short_date_format}selected{/if}>{grn_date_format format=$iter_short_date_format language=$print_language}</option>
		          {/foreach}
	            </select>
              </td>
            </tr>
            <tr>
              <td>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-16' replace='true'}</td>
              <td>
                <select name="print-time-format" id="print-time-format">
		          {foreach from=$time_format_list.$print_language item=iter_time_format key=time_format_key}
		          <option value="{$time_format_key}" {if $iter_time_format==$print_time_format}selected{/if}>{grn_date_format format=$iter_time_format language=$print_language}</option>
		          {/foreach}
		        </select>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    {if $smarty.const.ON_FOREST!==1}
      <tr>
        <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-17' replace='true'}</th>
        <td>
          <table>
            <tr>
              <td>
                {capture name='tmp'}{cb_msg module="grn.system.i18n" key="GRN_SY_I18N-10" replace="true"}{/capture}{grn_checkbox caption=$smarty.capture.tmp name="locale-change" id="locale-change" checked=$locale_change value=1}
              </td>
            </tr>
            <tr>
              <td>
                {capture name='tmp'}{cb_msg module="grn.system.i18n" key="GRN_SY_I18N-11" replace="true"}{/capture}{grn_checkbox caption=$smarty.capture.tmp name="base-change" id="base-change" checked=$base_change value=1}
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-18' replace='true'}
        </th>
        <td>
          {capture name='tmp'}{cb_msg module="grn.system.i18n" key="GRN_SY_I18N-19" replace="true"}{/capture}{grn_checkbox caption=$smarty.capture.tmp name="enable-nickname" id="enable-nickname" value="1" checked=$enable_nickname}
        </td>
      </tr>
    {/if}
      <tr>
       <th>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-20' replace='true'}
       </th>
       <td>
       <table>
         <tr>
           <td valign=top>{capture name='tmp'}{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-21' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.tmp}</td>
           <td>
               {grn_select id = 'default_locale' name='default_locale' options=$default_locale_options}
           </td>
         </tr>
         <tr>
           <td valign=top>{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-22' replace='true'}</td>
           <td>
               {grn_select id='region' name='region' options=$region_options onchange='change_timezone();'}
               {grn_select id='timezone' name='timezone' options=$timezone_options}<br>
           </td>
         </tr>
       </table>
       </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
          <input type="submit" style="" onclick="grn_onsubmit_common(this.form)" value="{cb_msg module='grn.system.i18n' key='GRN_SY_I18N-13' replace='true'}" class="margin">
          {grn_button_cancel page="/system/common_list" id="i18n"}
        </td>
      </tr>
    </tbody>
  </table>
</form>
{cb_locale_selection
 language_id="print-language"
 language_code_list=$language_code_list

 long_date_format_id="print-long-date-format"
 short_date_format_id="print-short-date-format"
 time_format_id="print-time-format"

 long_date_format_list=$long_date_format_list
 short_date_format_list=$short_date_format_list
 time_format_list=$time_format_list
}

{literal}
<script type="text/javascript">
if(document.getElementById('timezone-candidate') != null)
{
    var GRN_System_I18N_CommonSet = {
        allTimezoneOptions : (function(){
                                 var options = [],
                                     elements = document.getElementById('timezone-candidate').getElementsByTagName('option'),
                                     elementsLength = elements.length;
                                 for( var i=0; i<elementsLength; i+=1 ){
                                     options.push(elements[i].cloneNode(true));
                                 }
                                 return options;
                             }()),
        switchTimezoneRegion : function(region) {
            var options = this.allTimezoneOptions,
                max = options.length,
                regionLength = region.length;

            document.getElementById('timezone-candidate').innerHTML = '';
            
            for( var i=0; i<max; i+=1 ){
                if( region === '(All)' || region === options[i].value.substr(0, regionLength) || options[i].value === '' ){
                    document.getElementById('timezone-candidate').appendChild(options[i].cloneNode(true));
                }
            }
        }
    };
}
var tzOpt = new Array();
window.onload = function() {
  var region = document.getElementById('region');
  var select = document.getElementById('timezone');

  var len = select.options.length;
  for(var i = 0; i < len; i++) {
    tzOpt.push(select.options[i]);
  }
}

function change_timezone() {
  var region = document.getElementById('region');
  var select = document.getElementById('timezone');
  select.innerHTML = "";

  var n = 0;
  for(var i = 0; i < tzOpt.length; i++) {
    if(region.selectedIndex == 0 || tzOpt[i].value.indexOf(region.value, 0) == 0)    {
      select.options[n++] = tzOpt[i];
    }
  }

  select.selectedIndex = 0;
}

</script>
{/literal}
{include file='grn/system_footer.tpl'}
