{grn_load_javascript file="grn/html/page/space/mobile/discussion/index.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<script language="JavaScript" text="text/javascript">
(function(){literal}{{/literal}
    var G = grn.component.define_cybozu_browser;
    G.addToolBarItem(
            "my_space", "{cb_msg module='grn.kunai' key='GRN_KUNAI-1' replace='true'}",
            '{grn_pageurl page="space/mobile/index"}'
    );
    {if $isSpaceMember}
    G.addToolBarItem(
            "discussion_add", "{cb_msg module='grn.kunai' key='GRN_KUNAI-2' replace='true'}",
            '{grn_pageurl page="space/mobile/application/discussion/add" spid=$space_id}'
    );
    {/if}
    G.addToolBarItem(
            "member_view", "{cb_msg module='grn.kunai' key='GRN_KUNAI-6' replace='true'}",
            '{grn_pageurl page="space/mobile/member_list" spid=$space_id}'
    );
{literal}}{/literal})();
</script>
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    {include file='grn/mobile_breadcrumb.tpl' not_need_withList=false is_space=true}
    {grn_space_show_expiration_date_warning space=$space is_mobile=true}
    <div class="mobile-tab-grn">
        {strip}
        <div class="mobile_left_grn mobile_selected_grn">
            <span>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-45' replace='true'}</span>
        </div>
        <div class="mobile_right_grn mobile_unselected_grn">
            <a data-ajax="false" href="{grn_pageurl page='space/mobile/application/todo/index' spid=$space_id uid=$login.id}">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-72' replace='true'}</a>
        </div>
        {/strip}
    </div>
    <div class="mobile_separation_line_grn"></div>
    <div class="mobile-padding-leftright-grn mobile_discussion_list_grn">
        {if $has_folder_view}
        <ul data-role="listview" data-theme="{$data_theme}" data-space-id="{$space_id}" id="categorized_discussion_list" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_folderlist_grn">
            <script id="template_discussion" type="text/template">
                <li data-icon="false" style="padding-left: 8px !important;">
                    <span class="mobile_list_icon_unread_grn"></span>
                    <div class=" mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn" style="margin-left: 8px !important;"></div>
                    <a class="mobile_folderlist_list_text_grn ui-btn">
                        <span class="mobile_folderlist_text_overflow_grn"></span>
                        <span class="mobile_folderlist_icon_arraylist_grn"></span>
                    </a>
                </li>
            </script>
            {foreach from=$thread_collection_for_view item=folder}
                <li class="folder" data-icon="false" data-folder-id="{$folder.id}" data-folder-expanded="{$folder.expanded}" style="padding-left: 0px !important;">
                    {if $folder.unread}
                        <span class="mobile_list_icon_unread_grn"></span>
                    {else}
                        <span class="mobile_list_icon_unread_grn" style="display:none;"></span>
                    {/if}
                    {if $folder.expanded}
                        <div style="margin-left: 0px !important;" class="mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn mobile_folderlist_icon_arrowopen_grn"></div>
                    {else}
                        <div style="margin-left: 0px !important;" class="mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn mobile_folderlist_icon_arrowclose_grn"></div>
                    {/if}
                    <a class="mobile_folderlist_list_text_grn ui-btn">
                        <span class="mobile_folderlist_text_overflow_grn">{$folder.name|escape}</span>
                    </a>
                </li>
                {if $folder.expanded}
                    {foreach from=$folder.threads item=thread}
                        {if $thread.to_show_body}
                            {assign var='page_to_turn' value='body'}
                        {else}
                            {assign var='page_to_turn' value='detail'}
                        {/if}
                        <li data-icon="false" style="padding-left: 8px !important;" class="js_parent_folder_{$folder.id}">
                            {if $thread.unread}
                                <span class="mobile_list_icon_unread_grn"></span>
                            {/if}
                            <div class=" mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn" style="margin-left: 8px !important;" onclick="location.href='{grn_pageurl page='space/mobile/application/discussion/'|cat:$page_to_turn spid=$space_id tid=$thread.id}'"></div>
                            <a class="mobile_folderlist_list_text_grn ui-btn" href="{grn_pageurl page='space/mobile/application/discussion/'|cat:$page_to_turn spid=$space_id tid=$thread.id}">
                                <span class="mobile_folderlist_text_overflow_grn">{$thread.title|escape}</span>
                                <span class="mobile_folderlist_icon_arraylist_grn"></span>
                            </a>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        <ul data-role="listview" data-theme="{$data_theme}" id="discussion_list" class="mobile-ul-top-grn mobile-ul-bottom-grn">
            {include file='space/mobile/application/discussion/discussion_list.tpl'}
        </ul>
        {include file='grn/mobile_list_more_view.tpl' request_page='space/mobile/application/discussion/ajax/discussion_list' list_id='discussion_list'}
        {else}
        <ul data-role="listview" data-theme="{$data_theme}" id="discussion_list" class="mobile-ul-top-grn mobile-ul-bottom-grn">
            {include file='space/mobile/application/discussion/discussion_list.tpl'}
        </ul>
        {include file='grn/mobile_list_more_view.tpl' request_page='space/mobile/application/discussion/ajax/discussion_list' list_id='discussion_list'}
        {/if}
    </div>
</div>