{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{if $submit_user}
{cb_msg module='grn.address.cellular' key="search_users"}
{elseif $submit_group}
{cb_msg module='grn.address.cellular' key="search_groups"}
{else}
{cb_msg module='grn.address.cellular' key="search1"}
{/if}

{include file="cellular/group_tab.tpl" tabmode="s"}

{grn_cellular_form method=post page="$pagepath/search1" search_flag="$search_flag" gid=$gid}
<input type=text name=s_text value="{$str|escape}" istyle="1" mode="hiragana"><BR>
<input type=submit accesskey="1" name="submit_user" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.address.cellular' key="search_users"}"><br>
<input type=submit accesskey="2" name="submit_group" value="{grn_cellular_pictogram key="num2"}{cb_msg module='grn.address.cellular' key="search_groups"}"><br>
</form>
{foreach item=lists from=$lists}
    {grn_cellular_pictogram key="building"}
    <a href="{grn_cellular_pageurl page="$pagepath/list" gid=$lists.gid}">{$lists.name|escape}</a><BR>
{/foreach}

{if $before}
    <a href="{grn_cellular_pageurl page="$pagepath/search1"  pg=$before_page s_text=$str gid=$gid submit_group=true}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
{/if}
{if $next}
    <a href="{grn_cellular_pageurl page="$pagepath/search1"  pg=$next_page s_text=$str gid=$gid submit_group=true}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}


{foreach item=data_for_view from=$datas_for_view}
    {grn_cellular_pictogram key="person"}
    <a href="{grn_cellular_pageurl page="$pagepath/view" uid=$data_for_view.mid}">
    {$data_for_view.name|escape}
    </a>
    <br>
    {if count($data_for_view.item_codes)>0}
{foreach from=$data_for_view.item_codes key=item_key item=item_code}
&nbsp;&nbsp;{grn_cellular_display_field item_code=$item_code item_data=$data_for_view.items.$item_key}
{/foreach}
    {/if}
    
{/foreach}


{if $navi}<BR>
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search1" sp=$navi.previous_page_start_position sf=$navi.params.sf}">
        {cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;&nbsp;
    {/if}

    {if $navi.next_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search1" sp=$navi.next_page_start_position sf=$navi.params.sf}">
        {cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
{/if}

<br>

{grn_cellular_link page="cellular/menu" caption_module='grn.address.cellular' caption_key="link_back"}

<hr>
{/strip}
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=7 caption_module='grn.address.cellular' caption_key="link_address"}<BR>
{grn_cellular_link page="$pagepath/my_address_select" aid=$aid accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>
{include file="cellular/footer.tpl"}
