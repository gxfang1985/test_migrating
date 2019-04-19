{include file='cellular/header.tpl'}
{strip}

{grn_cellular_pictogram key='config'}{cb_msg module='grn.cellular' key="menu_conf"}<br>
{cb_msg module='grn.cellular.conf' key="title_change_12"}<br>
<hr>
{cb_msg module='grn.cellular.conf' key="txt_change_12"}<br>
{cb_msg module='grn.cellular.conf' key="txt_change_12_2"}<br>
<br>
{grn_cellular_form method="post" page="cellular/conf/command_change_12"}
{cb_msg module='grn.cellular.conf' key="txt_width"}<br>
<input type=radio name=width_char value="14"{if $conf.width_char == 14} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_width1"}<br>
<input type=radio name=width_char value="18"{if $conf.width_char == 18} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_width2"}<br>
<input type=radio name=width_char value="30"{if $conf.width_char == 30} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_width3"}<br>
<input type=radio name=width_char value="38"{if $conf.width_char == 38} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_width4"}<br>

{grn_cellular_submit accesskey=1}
</form>

{/strip}
{include file='cellular/conf/footer.tpl'}
