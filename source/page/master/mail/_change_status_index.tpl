<a id="{$csid}" href='javascript:'>{cb_msg module='grn.mail' key='GRN_MAIL-440' replace='true'}<span class='mail-arrowDownDisable-grn'></span></a>
<div class='mail-dropdownContents'>
    <ul>
        <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="submit_form('unread');return false;">{cb_msg module='grn.mail' key='GRN_MAIL-465' replace='true'}</a></li>
        <li><a class="mail-statusNormal-grn" href="javascript:void(0);" onclick="submit_form('read');return false;">{cb_msg module='grn.mail' key='GRN_MAIL-464' replace='true'}</a></li>
        {if $options}
        <li><div class="border_partition_pulldown_grn"></div></li>
        {/if}
    {foreach name=option_data from=$options item=option}
            <li><a {if $option.class}class="{$option.class}" {else}style="color:#{$option.color}"{/if} href="javascript:void(0);" onclick="submit_change_status({$option.value});return false;">{$option.label}</a></li>
    {/foreach}
    </ul>
</div>