{include file="grn/system_pwd_expired_head.tpl"}

<form name="{$page_info.last}" method="POST" action="{$url|escape}">
<input type="hidden" name="_system" value="2">
<input type="hidden" name="_exec" value="">
<input type="hidden" name="_uid" value="{$pwd_expired.uid}">
<input type="hidden" name="_pwd_ticket" value="{$pwd_expired.ticket}">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
<br>
<div id="one_parts">
{if $pwd_expired.expiration_days > 0}
    <span class="font_red">{cb_msg module='grn' key='GRN_GRN-47' replace='true'}{$pwd_expired.expiration_days}{cb_msg module='grn' key='GRN_GRN-48' replace='true'}&nbsp;</span>
    <input type="button" value="{cb_msg module='grn' key='GRN_GRN-49' replace='true'}" onClick="this.form._exec.value='0';this.form.submit();">
{else}
    <span class="font_red">{cb_msg module='grn' key='GRN_GRN-50' replace='true'}</span>
{/if}
  <br><br><div class="br">&nbsp;</div>
  <table class="login">
    <tr>
      <td>{cb_msg module='grn' key='GRN_GRN-51' replace='true'}</td>
      <td>
        {$pwd_expired.account}
      </td>
    </tr>
    <tr>
      <td>{cb_msg module='grn' key='GRN_GRN-52' replace='true'}</td>
      <td>
        {capture name='grn_GRN_GRN_53'}{cb_msg module='grn' key='GRN_GRN-53' replace='true'}{/capture}{grn_password name="_password" purpose='init' size=50 maxlength=64 title=$smarty.capture.grn_GRN_GRN_53 disable_return_key=true}
      </td>
    </tr>
    <tr>
      <td>{cb_msg module='grn' key='GRN_GRN-54' replace='true'}</td>
      <td>
        {capture name='grn_GRN_GRN_55'}{cb_msg module='grn' key='GRN_GRN-55' replace='true'}{/capture}{grn_password name="_retype" purpose='init' size=50 maxlength=64 title=$smarty.capture.grn_GRN_GRN_55}
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" class="login_margin" value="{cb_msg module='grn' key='GRN_GRN-56' replace='true'}" onClick="this.form._exec.value='1';"></td>
    </tr>
  </table>
 </div><!--action_end--->
</div>
</form>
</div><!--body_end-->
