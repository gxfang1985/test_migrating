{include file='cellular/header.tpl'}
{strip}

{grn_cellular_pictogram key='config'}{cb_msg module='grn.cellular' key="menu_conf"}<br>
{cb_msg module='grn.cellular.conf' key="title_menu"}<br>
<hr>

<a href="{grn_cellular_pageurl page='cellular/conf/change_11'}">
{cb_msg module='grn.cellular.conf' key="link_change_11"}
</a><br>
{cb_msg module='grn.cellular.conf' key="menu_tree2"}
{cb_msg module='grn.cellular.conf' key="menu_list" num=`$conf.item_num`}<br>
<br>

<a href="{grn_cellular_pageurl page='cellular/conf/change_12'}">
{cb_msg module='grn.cellular.conf' key="link_change_12"}
</a><br>
{cb_msg module='grn.cellular.conf' key="menu_tree2"}
{cb_msg module='grn.cellular.conf' key="menu_width" num=`$conf.width_char`}<br>
<br>

{if !$unusable_mail_flag}
{grn_cellular_pictogram key='mail'}
<a href="{grn_cellular_pageurl page='cellular/conf/change_13'}">
{cb_msg module='grn.cellular.conf' key="link_change_13"}
</a><br>
{cb_msg module='grn.cellular.conf' key="menu_tree2"}
{if $conf.webmail}
{cb_msg module='grn.cellular.conf' key="menu_mail01"}
{else}
{cb_msg module='grn.cellular.conf' key="menu_mail02"}
{/if}
<br>
{/if}
<hr>

{/strip}
{include file='cellular/footer.tpl'}
