{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
<span class="mail-ButtonStatus-grn">
{assign var='aid' value=$category.aid|escape}
{assign var='cid' value=$category.cid|escape}
{assign var='reverse' value=$reverse|escape}
{assign var='email' value=$email|escape}
 {* ステータスの絞り込み *}
<a id="{$stid}" href='javascript:'>{cb_msg module='grn.mail' key='GRN_MAIL-427' replace='true'}<span class='mail-ButtonStatusArrowDown-grn'></span></a>
<div class='mail-dropdownContents'>
    <ul>
        <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="location.href='?aid={$aid}&cid={$cid}&sid=0&email={$email}&sort={$sort_col|escape}&reverse={$reverse}';return false;"><span class="pulldown_menu_select_mark_{if $filter == 'unread' || $status_id != '0'}none_{/if}grn"></span>{cb_msg module="grn.mail" key="GRN_MAIL-466" replace='true'}</a></li>
        {if $unread_filter}
            <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="location.href='?aid={$aid}&cid={$cid}&sid=0&filter=unread&email={$email}&sort={$sort_col|escape}&reverse={$reverse}';return false;"><span class="pulldown_menu_select_mark_{if $filter != 'unread'}none_{/if}grn"></span>{cb_msg module="grn.mail" key="GRN_MAIL-467" replace='true'}</a></li>
        {/if}
        {if $options}
            <li><div class="border_partition_pulldown_grn"></div></li>
        {/if}
    {foreach name=option_data from=$options item=option}
            <li><a {if $option.class}class="{$option.class}" {else}style="color:#{$option.color}"{/if} href="javascript:void(0);" onclick="location.href='?aid={$aid}&cid={$cid}&sid={$option.value}&email={$email}&sort={$sort_col|escape}&reverse={$reverse}';return false;"><span class="pulldown_menu_select_mark_{if $filter == 'unread' || $status_id != $option.value}none_{/if}grn"></span>{$option.label}</a></li>
    {/foreach}
    </ul>
</div>
<input type="hidden" name="aid" value="{$category.aid|escape}">
<input type="hidden" name="cid" value="{$category.cid|escape}">
<input type="hidden" name="sort" value = "{$sort_col|escape}">
<input type="hidden" name="reverse" value = "{$reverse|escape}">
<input type="hidden" name="email" value = "{$email|escape}">
</span>
