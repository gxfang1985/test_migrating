{include file='cellular/header.tpl'}
{strip}

{grn_cellular_pictogram key='config'}{cb_msg module='grn.cellular' key="menu_conf"}<br>
{cb_msg module='grn.cellular.conf' key="title_change_13"}<br>
<hr>
{cb_msg module='grn.cellular.conf' key="txt_change_13"}<br>
{cb_msg module='grn.cellular.conf' key="txt_change_13_2"}<br>
<br>
{grn_cellular_form method="post" page="cellular/conf/command_change_13"}

{grn_cellular_pictogram key='mail'}{cb_msg module='grn.cellular.conf' key="txt_webmeil"}<br>

<input type=radio name=webmail value="1"{if $conf.webmail == 1} checked{/if}>
{cb_msg module='grn.cellular.conf' key="menu_mail01"}<br>

<input type=radio name=webmail value="0"{if $conf.webmail == 0} checked{/if}>
{cb_msg module='grn.cellular.conf' key="menu_mail02"}<br>

{grn_cellular_submit accesskey=1}
</form>

{/strip}
{include file='cellular/conf/footer.tpl'}
