{if ! $page_prefix}{assign var='page_prefix' value='space/application'}{/if}
{if ! $file_prefix}{assign var='file_prefix' value=$page_prefix|cat:'/file'}{/if}
{if ! $todo_prefix}{assign var='todo_prefix' value=$page_prefix|cat:'/todo'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{if ! $discussion_vpage}{assign var='discussion_vpage' value='space/application/discussion/index'}{/if}
{if ! $todo_vpage}{assign var='todo_vpage' value='space/application/todo/view'}{/if}
<a class="space-threadRightList-gripClose-grn" href="javascript:void(0);" onclick="__thisPage.changeRightListStatus();" id="right_link"></a>
{if $write_auth}
    <div id="select_tab_my_todo" class="space-threadRightList-inner-grn" style="display:none">
        <div class="space-threadRightList-tabs-grn">
            <div class="space-threadRightList-tabCurrent-grn">
                <span>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-13' replace='true'}</span><span class="space-threadRightList-tabSeparator-grn"></span><a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('all_todo')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-14' replace='true'}</a>
            </div>
            <div class="space-threadRightList-tab-grn">
                <a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('all_file')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-16' replace='true'}</a>
            </div>
            <div class="clear_both"></div>
        </div>
        <div id="my_todo" class="space-threadRightList-body-grn">
            {include file="space/application/discussion/thread_right_todo_list.tpl" todo_list=$my_todo_list}
        </div>
    </div>
{/if}

<div id="select_tab_all_todo" class="space-threadRightList-inner-grn" {if $show_file_list}style="display:none"{/if}>
    <div class="space-threadRightList-tabs-grn">
        <div class="space-threadRightList-tabCurrent-grn">
            {if $write_auth}<a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('my_todo')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-13' replace='true'}</a><span class="space-threadRightList-tabSeparator-grn"></span>{/if}<span>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-14' replace='true'}</span>
        </div>
        <div class="space-threadRightList-tab-grn">
            <a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('all_file')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-16' replace='true'}</a>
        </div>
        <div class="clear_both"></div>
    </div>
    <div id="all_todo" class="space-threadRightList-body-grn">
        {include file="space/application/discussion/thread_right_todo_list.tpl" todo_list=$all_todo_list}
    </div>
</div>

<div id="select_tab_all_file" class="space-threadRightList-inner-grn" {if !$show_file_list}style="display:none"{/if}>
    <div class="space-threadRightList-tabs-grn">
        <div class="space-threadRightList-tab-grn">
            {if $write_auth}<a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('my_todo')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-13' replace='true'}</a><span class="space-threadRightList-tabSeparator-grn"></span>{/if}<a href="javascript:void(0)" onclick="__thisPage.chooseRightListTab('all_todo')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-14' replace='true'}</a>
        </div>
        <div class="space-threadRightList-tabCurrent-grn">
            <span>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-16' replace='true'}</span>
        </div>
        <div class="clear_both"></div>
    </div>
    <div id="all_file" class="space-threadRightList-body-grn">
        {include file="space/application/discussion/thread_right_file_list.tpl" file_list=$all_file_list}
    </div>
</div>
<div class="clear_both_0px"></div>
