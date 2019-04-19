{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

<table class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;">
    <tbody>
        <tr>
            <td width="100%" valign="bottom" nowrap>{grn_image image="star20.gif"}{$page_title}</td>
        </tr>
    </tbody>
</table>
<div class="mainarea">
    {grn_delete title=$delete_multi_info.title page=$delete_multi_info.page no_confirm=$delete_multi_info.no_confirm data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target}
    {assign var='form_name' value=$smarty.template|basename}
    <table class="maincontents_list">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <form name="{$form_name}" method="post" action="{grn_pageurl page='star/delete_multi'}">
                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                        <table width="100%">
                            <tr valign="top">
                                <td id="tree_part" width="23%">
                                    <div class="tree_item">
                                        {if !$selected.category }
                                            <span class="hilight bold">
                                                {capture name='grn_star_GRN_STAR_3'}{cb_msg module='grn.star' key='GRN_STAR-3' replace='true'}{/capture}
                                                {grn_link page='star/index' caption=$smarty.capture.grn_star_GRN_STAR_3}
                                            </span>
                                        {else}
                                            {capture name='grn_star_GRN_STAR_3'}{cb_msg module='grn.star' key='GRN_STAR-3' replace='true'}{/capture}
                                            {grn_link page='star/index' caption=$smarty.capture.grn_star_GRN_STAR_3}
                                        {/if}
                                    </div>
                                    {foreach from=$menus item=menu}
                                        <div class="tree_item">
                                            {if $menu.category == $selected.category}
                                                <span class="hilight bold">
                                                    {grn_link image="node20.gif" page=$page_info.all app_id=$menu.category caption=$menu.title}
                                                </span>
                                            {else}
                                                {grn_link image="node20.gif" page=$page_info.all app_id=$menu.category caption=$menu.title}
                                            {/if}
                                        </div>
                                    {/foreach}
                                </td>
                                <td id="view_part" width="70%">
                                    {if $over_maximum}
                                        <div class="attention">
                                            <span class="bold">
                                                <span class="nowrap-grn">
                                                    <span class="subnotify16" name="#">
                                                        {cb_msg module='grn.star' key='GRN_STAR-34' replace='true'}
                                                    </span>
                                                </span>
                                            </span>
                                        </div>
                                    {/if}
                                    {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                                    {include file="grn/smart_word_navi_310.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}
                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name='star[]'}</span>
                                        <span class="list_menu_item">{capture name='grn_star_GRN_STAR_7'}{cb_msg module='grn.star' key='GRN_STAR-7' replace='true'}{/capture}{grn_button_submit id='btn_delete_multi1' caption=$smarty.capture.grn_star_GRN_STAR_7 onclick="return false;/*if( ! grn_is_checked( this.form, 'star[]' ) ) return false;*/"}</span>
                                    </div>
                                    <table class="list_column">
                                        <colgroup>
                                            <col width="1%">
                                            <col width="50%">
                                            <col width="49%">
                                            {*<col width="20%">
                                            <col width="15%">*}
                                        </colgroup>
                                        <tr>
                                            <th nowrap></th>
                                            <th nowrap>{cb_msg module='grn.star' key='GRN_STAR-8' replace='true'}</th>
                                            <th nowrap>
                                                {if $sort == 'ctu'}
                                                    {capture name='grn_star_GRN_STAR_11'}{cb_msg module='grn.star' key='GRN_STAR-11' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_star_GRN_STAR_11 page='star/index' sort='ctd' rev=1 reverse=1 app_id='message' app_id=$app_id|escape:'url'}
                                                {else}
                                                    {if $sort == 'ctd'}
                                                        {capture name='grn_star_GRN_STAR_11'}{cb_msg module='grn.star' key='GRN_STAR-11' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_star_GRN_STAR_11 page='star/index' sort='ctu' rev=0 reserve=0 app_id='message' app_id=$app_id|escape:'url'}
                                                    {else}
                                                        {capture name='grn_star_GRN_STAR_11'}{cb_msg module='grn.star' key='GRN_STAR-11' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_star_GRN_STAR_11 page='star/index' sort='td' rev=0 reserve=0 app_id='message' disable=1 app_id=$app_id|escape:'url'}
                                                    {/if}
                                                {/if}
                                            </th>
                                        </tr>
                                        {foreach from=$star_list key=star_id item=star}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                <td nowrap><input type="checkbox" value="{$star_id}" name="star[]" /></td>
                                                <td nowrap>
                                                    {if $star.module_id eq 'grn.message'}
                                                        {if $star.org_data.mtype eq '2'}
                                                            {grn_link page='message/draft_view' caption=$star.subject truncated_caption=$subject_with mid=$star.unique_id rid=$star.org_data.rid cid=$star.org_data.cid image='msg_star20.gif'}
                                                        {else}
                                                            {grn_link page='message/view' caption=$star.subject truncated_caption=$subject_with mid=$star.unique_id image='msg_star20.gif'}
                                                        {/if}
                                                    {elseif $star.module_id eq 'grn.mail'}
                                                        {if $star.org_data.type eq '2'}
                                                            {grn_link page="mail/draft_view" caption=$star.subject truncated_caption=$subject_with mid=$star.unique_id image="mail_star20.gif"}
                                                        {else}
                                                            {grn_link page="mail/view" caption=$star.subject truncated_caption=$subject_with mid=$star.unique_id image="mail_star20.gif"}
                                                        {/if}
                                                    {elseif $star.module_id eq 'grn.cabinet'}
                                                        {grn_link page="cabinet/view" caption=$star.subject truncated_caption=$subject_with params=$star.org_data image="file_star20.gif"}
                                                    {elseif $star.module_id eq 'grn.schedule'}
                                                        {grn_link page="schedule/view" caption=$star.subject truncated_caption=$subject_with params=$star.org_data image="event_star20.gif"}
                                                    {elseif $star.module_id eq 'grn.report'}
                                                        {if $star.org_data.draft}
                                                            {grn_link page="report/view_draft" caption=$star.subject truncated_caption=$subject_with rid=$star.org_data.rid image="report_star20.gif"}
                                                        {else}
                                                            {grn_link page="report/view" caption=$star.subject truncated_caption=$subject_with rid=$star.org_data.rid image="report_star20.gif"}
                                                        {/if}
                                                    {elseif $star.module_id eq 'grn.bulletin'}
                                                        {if $star.org_data.type eq 'draft'}
                                                            {grn_link page="bulletin/draft_view" caption=$star.subject truncated_caption=$subject_with aid=$star.org_data.aid image="bulletin_star20.gif"}
                                                        {elseif $star.org_data.type eq 'wait'}
                                                            {grn_link page="bulletin/wait_view" caption=$star.subject truncated_caption=$subject_with aid=$star.org_data.aid image="bulletin_star20.gif"}
                                                        {else}
                                                            {grn_link page="bulletin/view" caption=$star.subject truncated_caption=$subject_with cid=$star.org_data.cid aid=$star.org_data.aid image="bulletin_star20.gif"}
                                                        {/if}
                                                    {elseif $star.module_id eq 'grn.space'}
                                                        {grn_link page="space/application/discussion/index" caption=$star.subject truncated_caption=$subject_with spid=$star.org_data.spid fragment=$star.org_data.tid image="spaceDiscussion_star20.png"}
                                                    {/if}
                                                </td>
                                                <td nowrap>{grn_date_format date=$star.ctime format="DateTimeCompact"}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    
                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name='star[]'}</span>
                                        <nobr>
                                            {capture name='grn_star_GRN_STAR_7'}{cb_msg module='grn.star' key='GRN_STAR-7' replace='true'}{/capture}
                                            {grn_button_submit id='btn_delete_multi2' caption=$smarty.capture.grn_star_GRN_STAR_7 onclick="return false;/*if( ! grn_is_checked( this.form, 'star[]' ) ) return false;*/"}
                                        </nobr>
                                    </div>
                                    <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi_info.navi}</nobr></div>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="app_id" value="{$app_id}">
                    </form>
                </td>
            </tr>
        </tbody>
    </table><!--end of maincontents_list-->

{include file="grn/footer.tpl"}
