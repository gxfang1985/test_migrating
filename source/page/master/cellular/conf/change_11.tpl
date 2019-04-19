{include file='cellular/header.tpl'}
{strip}

{grn_cellular_pictogram key='config'}{cb_msg module='grn.cellular' key="menu_conf"}<br>
{cb_msg module='grn.cellular.conf' key="title_change_11"}<br>
<hr>
{cb_msg module='grn.cellular.conf' key="txt_change_11"}<br>
<br>
<form method=post action="{grn_cellular_pageurl page="cellular/conf/command_change_11"}">
{cb_msg module='grn.cellular.conf' key="txt_list"}<br>
<input type=radio name=item_num value="10"{if $conf.item_num == 10} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_list1"}<br>
<input type=radio name=item_num value="20"{if $conf.item_num == 20} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_list2"}<br>
<input type=radio name=item_num value="30"{if $conf.item_num == 30} checked{/if}>
{cb_msg module='grn.cellular.conf' key="radio_list3"}<br>
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{grn_cellular_submit accesskey=1}
</form>

{/strip}
{include file='cellular/conf/footer.tpl'}
