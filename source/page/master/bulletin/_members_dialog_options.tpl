{if $show_members_dialog || $show_maintainer_dialog}
    {if $page_prefix eq "bulletin/system"}
        {assign var='ajax_url' value='bulletin/system/ajax/member_list_dialog'|cb_pageurl}
    {else}
        {assign var='ajax_url' value='bulletin/ajax/member_list_dialog'|cb_pageurl}
    {/if}
    {include file="grn/ajax/member_list_dialog_script.tpl" url=$ajax_url app_id='bulletin'}
{/if}
{if $show_members_dialog}
{if $show_up_line}<li style="border-bottom:1px solid #ccc;"></li>{/if}
<li class="display_options_dialog_ch"><span class="span-member-dialog"><a href="javascript:void(0);" class="dialog_link" id="user_list_dialog_authority_read_{$category_id}" border="0">{grn_image image='user_b20.png'}{cb_msg module='grn.bulletin' key='GRN_BLLT-662' replace='true'}</a></span></li>
<li class="display_options_dialog_ch"><span class="span-member-dialog"><a href="javascript:void(0);" class="dialog_link" id="user_list_dialog_notification_{$category_id}_{$article_id}" border="0">{grn_image image='user_b20.png'}{cb_msg module='grn.bulletin' key='GRN_BLLT-663' replace='true'}</a></span></li>
{if $show_bottom_line}<li style="border-bottom:1px solid #ccc;">{/if}
{/if}
{if $show_maintainer_dialog}
<li class="display_options_dialog_ch"><span class="span-member-dialog"><a href="javascript:void(0);" class="dialog_link" id="maintainer_list_dialog_{$article_id}" border="0">{grn_image image='user_b20.png'}{cb_msg module='grn.bulletin' key='GRN_BLLT-652' replace='true'}</a></span></li>
{/if}
