{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_delete_expired_space_confirmation'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$category->getId()|escape}">
    <input type="hidden" name="term_date" value="{$term_date_string}">
    <input type="hidden" name="filter_id" value="{$filter_id|escape}">

    <div id="one_parts">
        <div id="action">
            <p class="explanation">
                {cb_msg module='grn.space.system' key='delete_multi_expired_spaces-6' replace='true'}<br>
                {cb_msg module='grn.space.system' key='delete_multi_expired_spaces-3' replace='true'}{grn_sentence image='folder20.gif' caption=$category->getCategoryName()|escape class='bold'}<br>
                {cb_msg module='grn.space.system' key='delete_multi_expired_spaces-4' replace='true'}<span class="bold">{grn_date_format date=$term_date format='DateFull_YMDW'}</span><br>
            </p>
            <div class="attention">{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-7' replace='true'}</div>
            <p class="explanation">{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-8' replace='true'}</p>
            <p>
                {capture name='grn_space_button_yes'}{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-9' replace='true'}{/capture}
                {grn_button_submit class='margin' caption=$smarty.capture.grn_space_button_yes}

                {capture name='grn_space_button_no'}{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-10' replace='true'}{/capture}
                {grn_button_cancel caption=$smarty.capture.grn_space_button_no page='space/system'|cat:'/category_list' cid=$category->getId() filter_id=$filter_id}
            </p>
        </div>
    </div>
</form>

{include file="grn/system_footer.tpl"}
