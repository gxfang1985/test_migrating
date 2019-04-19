{assign var='ajax_prefix' value='space/application/discussion/ajax'}

{literal}
<script language="JavaScript" text="text/javascript">
__thisPage.update_discussion_comment_count_time = {/literal}'{grn_get_update_discussion_comment_count_time}'{literal};
__thisPage.threadIndex = {/literal}'{grn_pageurl page="space/application/discussion/index"}'{literal};
__thisPage.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
__thisPage.threadDetailUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/thread_detail"}'{literal};
__thisPage.threadCommentUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/thread_comment"}'{literal};
__thisPage.threadRightUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/thread_right"}'{literal};
__thisPage.threadCommentAddUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/command_thread_comment_add"}'{literal};
__thisPage.iFrame = null;
__thisPage.spid = {/literal}'{$spaceId}'{literal};
__thisPage.tid = '';
__thisPage.threadCommentListUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/comment_list"}'{literal};
__thisPage.newerCommentCountUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/newer_comment_count"}'{literal};
__thisPage.threadRightListUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/thread_right"}'{literal};
__thisPage.last_comment_no = '';
__thisPage.reply_comment_num = '';
__thisPage.ERRMSG_COMMENT_CONTENTS_IS_REQUIRED = {/literal}"{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-26' replace='true'}"{literal};
__thisPage.threadAddUrl = {/literal}'{grn_pageurl page="space/application/discussion/add" spid=$spaceId}'{literal};
__thisPage.text_switch_on = {/literal}'{cb_msg module="grn.space.discussion" key="GRN_SP_DISC-49" replace="true"}'{literal};
__thisPage.text_switch_release = {/literal}'{cb_msg module="grn.space.discussion" key="GRN_SP_DISC-50" replace="true"}'{literal};
__thisPage.text_switch_off = {/literal}'{cb_msg module="grn.space.discussion" key="GRN_SP_DISC-51" replace="true"}'{literal};
__thisPage.enable_follow_url = {/literal}'{grn_pageurl page="space/application/discussion/ajax/command_subscribe"}'{literal};

__thisPage.clearInitialText = function(onLoad)
{
    if((!onLoad) || (jQuery("#inp_srch").length && jQuery("#inp_srch").val() != ''))
    {
        jQuery("#lbl_srch").css("display","none");
    }
};

__thisPage.recoverInitialText = function()
{
    if(jQuery("#inp_srch").length && jQuery("#inp_srch").val() == '')
    {
        jQuery("#lbl_srch").css("display","block");
    }
};

jQuery(document).ready(function ()
{
    __thisPage.clearInitialText(true);
    __thisPage.iFrame = jQuery('#history_iframe')[0];
    __thisPage.history_callback();
    __thisPage.loadThreadDetail(location.hash);

    // init folder list
    grn.page.space.folder_list.init();
});

</script>
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.todo.todo;
    G.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
    G.form = 'todo_add';
    G.spaceId = {/literal}{$spaceId}{literal};
    G.pageurl = "{/literal}{grn_pageurl page='space/application/todo/ajax/todo_search_user'}{literal}";
})();
</script>

{/literal}
<iframe id="history_iframe" src="" style="display:none;"></iframe>
<div class="space-threadList-inner-grn js_left_part">
    <div class="space-discussion-search-grn">
        {if $fts}
        <form class="clearFix-cybozu" name="form_search" method="get" action="{grn_pageurl page=space/search}">
            <input type="hidden" name="searchRange" value="SPACE" />
            <input type="hidden" name="spid" value="{$spaceId}" />
            {include file='fts/_search_box.tpl' inputId='space-search-input-text'}
        </form>
        {else}
        <form name="form_search" method="get" action="{grn_pageurl page=space/application/discussion/search}">
            <input type="hidden" name="spid" value="{$spaceId}" />
            <input type="hidden" name="tid" id="tid_search" />
            <span class="space-discussion-searchBox-grn">
                <label id="lbl_srch" class="overlabel-forSearchBtn-grn" for="inp_srch" style="display:block;cursor:text;">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-7' replace='true'}</label>
                <input type="text" id="inp_srch" name="text" maxlength="100" value="" onfocus="__thisPage.clearInitialText(false)" onblur="__thisPage.recoverInitialText()" />
            </span>
            <span class="space-discussion-searchBtn-grn">
                <input type="submit" value="" />
            </span>
            <div class="clear_both_0px"></div>
        </form>
        {/if}
    </div>

    {if $isSpaceMember || $has_privilege}
        {strip}
            <div id="thread_add" class="space-button-grn">
                <a href="javascript:void(0);">
                    <span class='icon-addButton-grn'>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-8' replace='true'}</span>
                </a>
            </div>
        {/strip}
    {/if}
    <ul>
        {foreach from=$threads item=thread}
            {if $thread->isSystemUse()}
                {if $thread->isUnreadUnder() }
                    {assign var="class_name" value='space-threadList-unread-grn'}
                {else}
                    {assign var="class_name" value='space-threadList-read-grn'}
                {/if}
                <li class="js_discussion"><a href="#tid={$thread->getId()}" data-thread-id="{$thread->getId()}" id="thread_{$thread->getId()}" name="system_thread" class="{$class_name}">{$thread->getTitle()|escape}</a></li>
            {/if}
        {/foreach}
    </ul>
    <div class="space-threadList-border-grn"></div>
{if $isUsedFolder eq false}
    <ul>
        {foreach from=$threads item=thread}
            {if !$thread->isSystemUse()}
                {if $thread->isUnreadUnder() }
                    {assign var="class_name" value='space-threadList-unread-grn'}
                {else}
                    {assign var="class_name" value='space-threadList-read-grn'}
                {/if}
                <li class="js_discussion"><a href="#tid={$thread->getId()}" data-thread-id="{$thread->getId()}" id="thread_{$thread->getId()}" class="{$class_name}">{$thread->getTitle()|escape}</a></li>
            {/if}
        {/foreach}
    </ul>
{else}
    {strip}
    <div class="space_threadlist_tree_base_grn js_folder_list_container">
        <div id="tree_view">
            <div id="folder_tree" class="tree_style1_grn">
                <div class="ygtvitem">
                    {foreach from=$folderCollection item=folder}
                        {if $folder->getId() gt -1}
                        <div class="ygtvitem js_folder_list" data-space-id="{$spaceId}" data-folder-id="{$folder->getId()}">
                            <table cellspacing="0" cellpadding="0" border="0"
                                   class="ygtvtable ygtvdepth0 ygtv-collapsed ygtv-highlight0 menu_unselect_grn js_folder">
                                <tbody>
                                <tr class="ygtvrow">
                                    {if $folder->isExpanded() eq true}
                                    <td class="ygtvcell ygtvtm js_coll_exp_icon">
                                    {else}
                                    <td class="ygtvcell ygtvtp js_coll_exp_icon">
                                    {/if}
                                        {if $folder->isUnread()}
                                            <span class="unreadmark_grn js_unread_icon"></span>
                                        {/if}
                                        <a class="ygtvspacer" href="javascript:void(0);"></a>
                                    </td>
                                    <td class="ygtvcell ygtvhtml ygtvcontent js_folder_display">
                                        <div class="tree-node ">
                                            <a  href="javascript:void(0);" class="js_folder_name">{$folder->getFolderName()|escape}</a>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        {/if}
                        <ul class="space_threadlist_tree_children_grn js_discussion_list">
                            {if $folder->isExpanded() eq true}
                                {foreach from=$folder->ThreadCollection() item=discussion}
                                    {if $discussion->isUnreadUnder() eq FALSE}
                                        <li class="js_discussion">
                                            <a data-thread-id="{$discussion->getId()}" href="#tid={$discussion->getId()}"
                                               id="thread_{$discussion->getId()}"
                                               class="space-threadList-read-grn">{$discussion->getTitle()|escape}</a>
                                        </li>
                                    {else}
                                        <li class="js_discussion">
                                            <a data-thread-id="{$discussion->getId()}" href="#tid={$discussion->getId()}"
                                               id="thread_{$discussion->getId()}"
                                               class="space-threadList-unread-grn">{$discussion->getTitle()|escape}</a>
                                        </li>
                                    {/if}
                                {/foreach}
                            {/if}
                        </ul>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
        {if $isDisplayUncategorized eq TRUE}
            <div class="space-threadList-border-grn"></div>
            <ul class="js_discussion_list">
                {foreach from=$uncategorizedFolder->ThreadCollection() item=discussion}
                    {if $discussion->isUnreadUnder() eq FALSE}
                        <li class="js_discussion">
                            <a data-thread-id="{$discussion->getId()}" href="#tid={$discussion->getId()}"
                               id="thread_{$discussion->getId()}"
                               class="space-threadList-read-grn">{$discussion->getTitle()|escape}</a>
                        </li>
                    {else}
                        <li class="js_discussion">
                            <a data-thread-id="{$discussion->getId()}" href="#tid={$discussion->getId()}"
                               id="thread_{$discussion->getId()}"
                               class="space-threadList-unread-grn">{$discussion->getTitle()|escape}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        {/if}
    {/strip}
{/if}

</div>