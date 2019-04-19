{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-315' replace='true'}</th>
  <td>
{if $set.is_personal_config}
  {capture name='grn_system_user_GRN_SY_US_316'}{cb_msg module='grn.system.user' key='GRN_SY_US-316' replace='true'}{/capture}{grn_radio name='is_personal_config' id='personal_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_316 checked=true  onclick="enablePersonalConfig(this.form)"}
  {capture name='grn_system_user_GRN_SY_US_317'}{cb_msg module='grn.system.user' key='GRN_SY_US-317' replace='true'}{/capture}{grn_radio name='is_personal_config' id='personal_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_317 onclick="setDisabled(this.form,'4:5:6:7:8:9','on',this)"}
{else}
  {capture name='grn_system_user_GRN_SY_US_318'}{cb_msg module='grn.system.user' key='GRN_SY_US-318' replace='true'}{/capture}{grn_radio name='is_personal_config' id='personal_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_318 onclick="enablePersonalConfig(this.form)"}
  {capture name='grn_system_user_GRN_SY_US_319'}{cb_msg module='grn.system.user' key='GRN_SY_US-319' replace='true'}{/capture}{grn_radio name='is_personal_config' id='personal_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_319 checked=true onclick="setDisabled(this.form,'4:5:6:7:8:9','on',this)"}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-320' replace='true'}</th>
  <td>
{if $set.is_empty_login}
  {capture name='grn_system_user_GRN_SY_US_321'}{cb_msg module='grn.system.user' key='GRN_SY_US-321' replace='true'}{/capture}{grn_radio name='is_empty_login' id='empty_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_321 checked=true}
  {capture name='grn_system_user_GRN_SY_US_322'}{cb_msg module='grn.system.user' key='GRN_SY_US-322' replace='true'}{/capture}{grn_radio name='is_empty_login' id='empty_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_322}
{else}
  {capture name='grn_system_user_GRN_SY_US_323'}{cb_msg module='grn.system.user' key='GRN_SY_US-323' replace='true'}{/capture}{grn_radio name='is_empty_login' id='empty_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_323}
  {capture name='grn_system_user_GRN_SY_US_324'}{cb_msg module='grn.system.user' key='GRN_SY_US-324' replace='true'}{/capture}{grn_radio name='is_empty_login' id='empty_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_324 checked=true}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-325' replace='true'}</th>
  <td>
  {grn_select_numbers select_name='password_length' options=$set.password_length.options padding='&nbsp;&nbsp;' selected=$set.password_length.selected}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-326' replace='true'}
  </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-327' replace='true'}</th>
   <td>
{if $set.expiration_interval > 0}
   {capture name='grn_system_user_GRN_SY_US_328'}{cb_msg module='grn.system.user' key='GRN_SY_US-328' replace='true'}{/capture}{grn_radio name='is_expiration' id='expiration_on' value='0' onclick="isExpiration(this.form,'on');" caption=$smarty.capture.grn_system_user_GRN_SY_US_328}<br>
   {grn_radio name='is_expiration' id='expiration_off' value='1' onclick="isExpiration(this.form,'off');" caption='' checked=true}
   {grn_text name='expiration_interval' value=$set.expiration_interval size='10' maxlength='3'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-329' replace='true'}&nbsp;&nbsp;(1&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-330' replace='true'}&nbsp;999)
{else}
   {capture name='grn_system_user_GRN_SY_US_331'}{cb_msg module='grn.system.user' key='GRN_SY_US-331' replace='true'}{/capture}{grn_radio name='is_expiration' id='expiration_on' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_331 onclick="isExpiration(this.form,'on');" checked=true}<br>
   {grn_radio name='is_expiration' id='expiration_off' value='1' caption='' onclick="isExpiration(this.form,'off');"}
   {grn_text name='expiration_interval' value='30' size='10' maxlength='3'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-332' replace='true'}&nbsp;&nbsp;(1&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-333' replace='true'}&nbsp;999)
{/if}
   <font color="red">{capture name='grn_system_user_GRN_SY_US_334'}{cb_msg module='grn.system.user' key='GRN_SY_US-334' replace='true'}{/capture}{validate form=$form_name criteria="isRange" field="expiration_interval" low="1" high="999" message=$smarty.capture.grn_system_user_GRN_SY_US_334}</font>
 </td>
 </tr>
 <tr>
   <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-335' replace='true'}</th>
   <td>
{if $set.warning_before > 0}
   {capture name='grn_system_user_GRN_SY_US_336'}{cb_msg module='grn.system.user' key='GRN_SY_US-336' replace='true'}{/capture}{grn_radio name='is_warning' id='warning_on' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_336 onclick="isWarning(this.form,'on');"}<br>
   {grn_radio name='is_warning' id='warning_off' value='1' caption='' onclick="isWarning(this.form,'off');" checked=true}
   {grn_text name='warning_before' value=$set.warning_before|escape size='10' maxlength='3'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-337' replace='true'}&nbsp;&nbsp;(1&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-338' replace='true'}&nbsp;999)
{else}
   {capture name='grn_system_user_GRN_SY_US_339'}{cb_msg module='grn.system.user' key='GRN_SY_US-339' replace='true'}{/capture}{grn_radio name='is_warning' id='warning_on' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_339 onclick="isWarning(this.form,'on');" checked=true}<br>
   {grn_radio name='is_warning' id='warning_off' value='1' caption='' onclick="isWarning(this.form,'off');"}
   {grn_text name='warning_before' value='10' size='10' maxlength='3'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-340' replace='true'}&nbsp;&nbsp;(1&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-341' replace='true'}&nbsp;999)
{/if}
   <font color="red">
     {capture name='grn_system_user_GRN_SY_US_342'}{cb_msg module='grn.system.user' key='GRN_SY_US-342' replace='true'}{/capture}{validate form=$form_name criteria="isRange" field="warning_before" low="1" high="999" message=$smarty.capture.grn_system_user_GRN_SY_US_342}
     {if $warning_before_is_greater}
         {cb_msg module='grn.system.user' key='GRN_SY_US-343' replace='true'}
     {/if}
   </font>
 </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-344' replace='true'}</th>
  <td>
{if $set.strong_password.enable}
  {capture name='grn_system_user_GRN_SY_US_345'}{cb_msg module='grn.system.user' key='GRN_SY_US-345' replace='true'}{/capture}{grn_radio name='is_strong_password' id='is_strong_password_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_345 checked=true onclick='display_on("strong_password_box")'}
  {capture name='grn_system_user_GRN_SY_US_346'}{cb_msg module='grn.system.user' key='GRN_SY_US-346' replace='true'}{/capture}{grn_radio name='is_strong_password' id='is_strong_password_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_346 onclick='display_off("strong_password_box")'}
{else}
  {capture name='grn_system_user_GRN_SY_US_347'}{cb_msg module='grn.system.user' key='GRN_SY_US-347' replace='true'}{/capture}{grn_radio name='is_strong_password' id='is_strong_password_on' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_347 onclick='display_on("strong_password_box")'}
  {capture name='grn_system_user_GRN_SY_US_348'}{cb_msg module='grn.system.user' key='GRN_SY_US-348' replace='true'}{/capture}{grn_radio name='is_strong_password' id='is_strong_password_off' value='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_348 checked=true onclick='display_off("strong_password_box")'}
{/if}
  <div id="strong_password_box" class="margin_top" style="margin-left: 1em; {if !$set.strong_password.enable}display:none{/if}">
    {capture name='grn_system_user_GRN_SY_US_349'}{cb_msg module='grn.system.user' key='GRN_SY_US-349' replace='true'}{/capture}{grn_checkbox name="pwd_alpha" id="pwd_alpha" caption=$smarty.capture.grn_system_user_GRN_SY_US_349 value="1" checked=$set.strong_password.options.alpha onclick="strongPasswdOptionChange(this)"}<br />
    {capture name='grn_system_user_GRN_SY_US_350'}{cb_msg module='grn.system.user' key='GRN_SY_US-350' replace='true'}{/capture}<div style="margin-left: 1em">{grn_checkbox name="pwd_alphamix" id="pwd_alphamix" caption=$smarty.capture.grn_system_user_GRN_SY_US_350 value="2" checked=$set.strong_password.options.alphamix onclick="strongPasswdOptionChange(this)"}</div>
    {capture name='grn_system_user_GRN_SY_US_351'}{cb_msg module='grn.system.user' key='GRN_SY_US-351' replace='true'}{/capture}{grn_checkbox name="pwd_numeral" id="pwd_numeral" caption=$smarty.capture.grn_system_user_GRN_SY_US_351 value="4" checked=$set.strong_password.options.numeral onclick="strongPasswdOptionChange(this)"}<br />
    {capture name='grn_system_user_GRN_SY_US_352'}{cb_msg module='grn.system.user' key='GRN_SY_US-352' replace='true'}{/capture}{grn_checkbox name="pwd_symbol" id="pwd_symbol" caption=$smarty.capture.grn_system_user_GRN_SY_US_352 value="8" checked=$set.strong_password.options.symbol onclick="strongPasswdOptionChange(this)"}<br />
    {capture name='grn_system_user_GRN_SY_US_353'}{cb_msg module='grn.system.user' key='GRN_SY_US-353' replace='true'}{/capture}{grn_checkbox name="pwd_banned_words" id="pwd_banned_words" caption=$smarty.capture.grn_system_user_GRN_SY_US_353 value="16" checked=$set.strong_password.options.banned_words onclick="strongPasswdOptionChange(this)"}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_user_GRN_SY_US_354'}{cb_msg module='grn.system.user' key='GRN_SY_US-354' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_354}
       {grn_button_cancel page='system/common_list' id='user'}
  </td>
 </tr>
</table>

</form>

<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
{if ! $set.is_personal_config}
    setDisabled(d,'0:1:2:3:4:5','on',d.expiration_on);
{else}
  {if $set.expiration_interval == 0}
  	isExpiration(d,'on');
  {/if}
  {if $set.warning_before == 0}
  	isWarning(d,'on');
  {/if}
{/if}
    initStrongPasswordOptions(d);

{literal}
function enablePersonalConfig( form )
{
    setDisabled( form, '5:6:7:8:9:10', 'off', form.is_personal_config[0] );
    if ( form.is_expiration[0].checked ) isExpiration( form, 'on' );
    if ( form.is_warning[0].checked ) isWarning( form, 'on' );
}

function isExpiration( form, flag )
{
    setDisabled( form,'0',flag,form.expiration_interval );
    setDisabled( form, '0:1:2', flag, form.is_warning[0] );
    if ( flag == 'off' ) {
        if ( form.is_warning[0].checked ) isWarning( form, 'on' );
    }
}

function isWarning( form, flag )
{
    setDisabled(form,'0',flag,form.warning_before);
}

function initStrongPasswordOptions( form )
{
    var ele = form.elements;
    ele['pwd_alphamix'].disabled = !ele['pwd_alpha'].checked;
}

function strongPasswdOptionChange( opt )
{
    var elements = opt.form.elements;
    
    if( !elements['pwd_alpha'].checked
        && !elements['pwd_numeral'].checked
        && !elements['pwd_symbol'].checked
        && !elements['pwd_banned_words'].checked)
    {
        opt.checked = true;
        return;
    }
    
    if( opt.name == 'pwd_alpha' )
    {
        elements['pwd_alphamix'].disabled = !opt.checked;
        elements['pwd_alphamix'].checked = false;
    }
}

{/literal}

//-->
</script>

{include file="grn/system_footer.tpl"}
