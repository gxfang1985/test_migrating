{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="acco"}
<hr>
{grn_cellular_form name=$form_name method=post page="$pagepath/$from" }
{foreach from=$user_account item=account}
<input type=hidden name=text value="{$text|escape}">
<input type=radio name=aid value="{$account.aid}"{if $account.checked} checked{/if}>
{$account.name|escape}<BR>
&nbsp;&nbsp;{$account.email|escape}<BR>
{/foreach}
<BR>
 <input type=submit name=submit value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.mail.cellular' key="account_modify_button"}" accesskey=1 ><br>
</form>

<hr>

{grn_cellular_link page="$pagepath/list" aid=$aid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
