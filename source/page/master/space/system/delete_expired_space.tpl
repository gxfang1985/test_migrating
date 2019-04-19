{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-1' replace='true'}</div>
<div class="attention">{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-2' replace='true'}</div>

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_delete_expired_space'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$category->getId()|escape}">
    <input type="hidden" name="filter_id" value="{$filter_id|escape}">

    <table class="std_form">
        <tr>
            <th nowrap>
                {cb_msg module='grn.space.system' key='delete_multi_expired_spaces-3' replace='true'}
            </th>
            <td>
                {grn_sentence image='folder20.gif' caption=$category->getCategoryName()|escape}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.space.system' key='delete_multi_expired_spaces-4' replace='true'}
            </th>
            <td>
                {grn_select_date date=$term_date prefix='term_' form_name=$form_name}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_space_delete_multi_expired_spaces_delete'}{cb_msg module='grn.space.system' key='delete_multi_expired_spaces-5' replace='true'}{/capture}
                {grn_button_submit class='margin' caption=$smarty.capture.grn_space_delete_multi_expired_spaces_delete}
                {grn_button_cancel page='space/system'|cat:'/category_list' cid=$category->getId() filter_id=$filter_id}
            </td>
        </tr>
    </table>
</form>

{include file="grn/system_footer.tpl"}
