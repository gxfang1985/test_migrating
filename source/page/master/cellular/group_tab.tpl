{strip}

{if ! $accesskey}
    {assign var=accesskey value=1}
{/if}

<hr>

{if $tab.mode == 'm'}
    {cb_msg module='grn.cellular.common' key="tab_my_group"}
{else}
    {grn_cellular_link page=$tab.page gid='m' params=$tab.params caption_module='grn.cellular.common' caption_key="tab_my_group"}
{/if}
&nbsp;
{if $tab.mode == 'b' || $tab.mode == 'g' || $tab.mode == 'o'}
    {cb_msg module='grn.cellular.common' key="tab_group_tree"}
{else}
    {grn_cellular_link page=$tab.page gid='b' params=$tab.params caption_module='grn.cellular.common' caption_key="tab_group_tree"}
{/if}
&nbsp;
{if $tab.mode == 'h' || $tab.mode == 'u' || $tab.mode == 'q'}
    {cb_msg module='grn.cellular.common' key="tab_frequent"}
{else}
    {grn_cellular_link page=$tab.page gid='h' params=$tab.params caption_module='grn.cellular.common' caption_key="tab_frequent"}
{/if}
{if $tab.add}
    {foreach from=$tab.add item=one}
        &nbsp;
        {if $tab.mode == $one.mode}
            {$one.name}
        {else}
            {grn_cellular_link page=$tab.page gid=$one.mode params=$tab.params caption=$one.name}
        {/if}
    {/foreach}
{/if}

<hr>

{if $tab.mode == 'm'}
    {cb_msg module='grn.cellular.common' key="tab2_my_group"}<br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid accesskey=$accesskey params=$tab.params access_plugin=$access_plugin}
{/if}
{if $tab.mode == 'b'}
    {cb_msg module='grn.cellular.common' key="tab2_belonging_group"}
    /
    {grn_cellular_link page=$tab.page gid='g' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_group_tree"}
    /
    {grn_cellular_link page=$tab.page gid='o' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_oftenused_group"}
    <br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid accesskey=$accesskey params=$tab.params access_plugin=$access_plugin}
{/if}
{if $tab.mode == 'g'}
    {grn_cellular_link page=$tab.page gid='b' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_belonging_group"}
    /
    {cb_msg module='grn.cellular.common' key="tab2_group_tree"}
    /
    {grn_cellular_link page=$tab.page gid='o' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_oftenused_group"}
    <br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid accesskey=$accesskey params=$tab.params access_plugin=$access_plugin}
{/if}
{if $tab.mode == 'o'}
    {grn_cellular_link page=$tab.page gid='b' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_belonging_group"}
    /
    {grn_cellular_link page=$tab.page gid='g' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_group_tree"}
    /
    {cb_msg module='grn.cellular.common' key="tab2_oftenused_group"}
    <br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid accesskey=$accesskey params=$tab.params access_plugin=$access_plugin}
{/if}
{if $tab.mode == 'h'}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_prefix"}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_group"}
    /
    {grn_cellular_link page=$tab.page gid='u' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_user"}
    /
    {grn_cellular_link page=$tab.page gid='q' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_facility"}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_suffix"}
    <br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid accesskey=$accesskey params=$tab.params access_plugin=$access_plugin}
{/if}
{if $tab.mode == 'u'}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_prefix"}
    {grn_cellular_link page=$tab.page gid='h' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_group"}
    /
    {cb_msg module='grn.cellular.common' key="tab2_frequent_user"}
    /
    {grn_cellular_link page=$tab.page gid='q' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_facility"}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_suffix"}
    <br>
{/if}
{if $tab.mode == 'q'}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_prefix"}
    {grn_cellular_link page=$tab.page gid='h' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_group"}
    /
    {grn_cellular_link page=$tab.page gid='u' params=$tab.params caption_module='grn.cellular.common' caption_key="tab2_frequent_user"}
    /
    {cb_msg module='grn.cellular.common' key="tab2_frequent_facility"}
    {cb_msg module='grn.cellular.common' key="tab2_frequent_suffix"}
    <br>
{/if}
{/strip}
