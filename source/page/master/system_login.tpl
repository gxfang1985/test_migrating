{include file="grn/system_login_head.tpl"}

{if $necessary_password}
{capture name='grn_GRN_GRN_178'}{cb_msg module='grn' key='GRN_GRN-178' replace='true'}{/capture}
<form name="{$page_info.last}" method="POST" action="{$url|escape}" onsubmit="{literal}if (this._password.value.length == 0) { alert('{/literal}{$smarty.capture.grn_GRN_GRN_178}{literal}'); return false; } else return true;{/literal}">
{else}
<form name="{$page_info.last}" method="POST" action="{$url|escape}">
{/if}
<input type="hidden" name="_system" value="1">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
<div id="one_parts">
  <table class="login">
   <tr>
    <td colspan="2"><h2>{if $company_name}{$company_name|escape}{else}&nbsp;{/if}</h2></td>
   </tr>
   <tr>
    <td>{cb_msg module='grn' key='GRN_GRN-179' replace='true'}</td>
    <td>
{if $login_cookie}
       {capture name='grn_GRN_GRN_180'}{cb_msg module='grn' key='GRN_GRN-180' replace='true'}{/capture}{grn_text name="_account" size="50" value=$login_cookie.foreign_key title=$smarty.capture.grn_GRN_GRN_180  disable_return_key=true}
{else}
       {capture name='grn_GRN_GRN_181'}{cb_msg module='grn' key='GRN_GRN-181' replace='true'}{/capture}{grn_text name="_account" size="50" value="" title=$smarty.capture.grn_GRN_GRN_181 disable_return_key=true}
{/if}
    </td>
   </tr>
   <tr>
    <td>{cb_msg module='grn' key='GRN_GRN-182' replace='true'}</td>
    <td>{capture name='grn_GRN_GRN_183'}{cb_msg module='grn' key='GRN_GRN-183' replace='true'}{/capture}{grn_password name="_password" purpose='auth' class="password1" size="50" maxlength="64" autocomplete=$password_autocomplete title=$smarty.capture.grn_GRN_GRN_183}</td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>
{if $login_cookie}
       {capture name='grn_GRN_GRN_184'}{cb_msg module='grn' key='GRN_GRN-184' replace='true'}{/capture}{grn_checkbox name='use_cookie' id='checkbox1' value='1' caption=' $smarty.capture.grn_GRN_GRN_184 checked=true}
{else}
       {capture name='grn_GRN_GRN_185'}{cb_msg module='grn' key='GRN_GRN-185' replace='true'}{/capture}{grn_checkbox name='use_cookie' id='checkbox1' value='1' caption=' $smarty.capture.grn_GRN_GRN_185}
{/if}
    </td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td><input type="submit" class="login_margin" value="{cb_msg module='grn' key='GRN_GRN-186' replace='true'}"></td>
   </tr>
  </table>
 </div><!--action_end--->
</div>
</form>
</div><!--body_end-->
