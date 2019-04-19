{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
        {strip}
{assign var='count_message' value= $messages.message|@count}{*Compute message list to show result info*}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    {include file='grn/mobile_breadcrumb.tpl'}
    {if $count_message gt 0}
        <ul data-role="listview" data-theme="c"
            class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn" id="my_space_list">
            {foreach from = $messages.message item=message key=rid name="message_loop"}
            <li data-icon="false">
                {if $message.type eq '0'} {* receive *}
                    <a href="{grn_pageurl page='message/mobile/view' unread=$message.unread cid=$cid rid=$rid mid=$message.mid sp=$sp}" class="mobile-list-text-grn mobile_list_table_grn">
                {elseif $message.type eq '1'} {* sent *}
                    <a href="{grn_pageurl page='message/mobile/view' cid=$cid rid=$rid mid=$message.mid sp=$sp}" class="mobile-list-text-grn mobile_list_table_grn">
                {else}{* draft *}
                    <a href="{grn_pageurl page='message/mobile/draft_view' cid=$cid rid=$rid mid=$message.mid sp=$sp}" class="mobile-list-text-grn mobile_list_table_grn">
                {/if}
                    <div class="mobile_list_table_td_grn">
                        <div class="mobile_list_lines_grn">
                            <ul>
                                <li>
                                    {if $message.unread || $message.update}
                                        <span class="mobile_list_icon_unread_grn"></span>
                                    {/if}
                                    <span class="mobile_list_users_grn">
                                    {grn_user_name
                                        uid=$message.creator_uid
                                        name=$message.creator_name
                                        users_info=$users_info
                                        truncated=$name_width only_text=true
                                    }
                                    </span>
                                    <span class="mobile_list_date_grn">
                                        {if $message.unread}
                                            {grn_date_format date=$message.ctime}
                                        {else}
                                            {grn_date_format date=$message.mtime}
                                        {/if}
                                    </span>
                                </li>
                                <li>
                                    {if $message.attach_file}
                                        <span class="mobile_list_content_grn mobile_list_textposition_1icon_grn">
                                            {$message.subject}
                                        </span>
                                        <span class="mobile_list_icon_attachmentssub_grn mobile_list_iconposition_grn"></span>
                                    {else}
                                        <span class="mobile_list_content_grn">
                                            {$message.subject}
                                        </span>
                                    {/if}
                                </li>
                                <li>
                                    <span class="mobile_list_subcontent_grn"></span>
                                </li>
                            </ul>
                        </div>
                    </div><!--table-cell-->
                    <span class="mobile_list_icon_arraylist_grn"></span>
                </a>
                </li>
            {/foreach}
        </ul>
    {else}
        <div class="mobile_balloon_grn">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-74' replace='true'}</div>
        <div class="mobile_balloon_down_grn"><div class="mobile_triangle_grn"></div></div>
        <div class="mobile_balloon_icon_grn"><div class="mobile_app_message_b_grn"></div></div>
    {/if}
    {assign var=navi value=$navi_info.navi}
    <div class="mobile_paging_grn" style="border-top: 0">
        {if $navi.previous_page_start_position != -1}
        <a class="mobile_back_first_grn" href="{grn_pageurl page=$navi_info.page sp=0 params=$navi.params }"></a>
        {else}
        <a href="javascript:void(0);" class="mobile_back_first_grn mobile_base_disable_grn "></a>
        {/if}
        {if $navi.previous_page_start_position != -1}
        <a class="mobile_back_grn" href="{grn_pageurl page=$navi_info.page sp=$navi.previous_page_start_position params=$navi.params }" ></a>
        {else}
        <a href="javascript:void(0);" class="mobile_back_grn mobile_base_disable_grn "></a>
        {/if}
        {if $navi.next_page_start_position != -1}
        <a class="mobile_advance_grn" href="{grn_pageurl page=$navi_info.page sp=$navi.next_page_start_position params=$navi.params }" ></a>
        {else}
        <a href="javascript:void(0);" class="mobile_advance_grn mobile_base_disable_grn "></a>
        {/if}
        <span class="mobile_page_text_grn">{$navi_info.start_count}-{$navi_info.end_count}</span>
    </div>
</div>
{*include file='grn/mobile_folder_list.tpl'*}
{/strip}