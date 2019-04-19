{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{include file='message/_title_search.tpl'}
{grn_load_javascript file="js/dist/message.js"}

<div class="mainarea">
<!--delete-->
{grn_delete title=$delete_all_info.title page=$delete_all_info.page no_confirm=$delete_all_info.no_confirm data=$delete_all_info.data handler=$delete_all_info.handler}
{grn_delete title=$delete_multi_info.title page=$delete_multi_info.page no_confirm=$delete_multi_info.no_confirm data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target before_delete=$delete_multi_info.before_delete}
{grn_load_javascript file="grn/html/folder_select.js"}
{literal}
    <script type="text/javascript">
        function on_before_show_popup(form)
        {
            //get create message
            var checks = jQuery(form).find("input[name='ids[]']");
            var count = 0;
            checks.each(function(idx, elm){
                var temp = elm.value.split(",");
                if( ( temp[2] == "1" ) && ( temp[3] !="2" ) )
                {
                    count++;
                }
            });
            var span_create_message = jQuery(form).find("span.create_message_count").get(0);
            if(span_create_message){
                span_create_message.innerHTML = count;
            }
            //not show popup
            if( count == 0)
            {
                var div_create_message = jQuery(form).find("div.create_message").eq(0);
                if(div_create_message.length > 0){
                    div_create_message.hide();
                }
                return false;
            }
            else //show popup
            {
                return true;
            }
        }

        {/literal}{if $use_star && $category.type neq '4'}{literal}
        function grn_message_on_update_star(star_ele, params)
        {
            var status = GRN_StarList.getStatus(star_ele);
            var mid = params.mid;
            GRN_StarList.getItems('message_list').each(function(){
                var item_params = GRN_StarList.parseParam(this);
                if(item_params.mid == mid){
                  GRN_StarList.setStatus(this, status);
                }
            });
        }{/literal}{/if}{literal}
    </script>
{/literal}
<!--delete-->
{if $use_star && $category.type neq '4'}
{include file="star/star_init.tpl" list_id="message_list" on_update="grn_message_on_update_star" use_star=true}
{/if}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="menu_part" >
    <div id="smart_main_menu_part">
        <span class="menu_item">{capture name='grn_message_GMSG_MSG_1'}{cb_msg module='grn.message' key='GMSG_MSG_1' app_name=$app_name noescape='true'}{/capture}{grn_link page='message/send' caption=$smarty.capture.grn_message_GMSG_MSG_1 image='msg20.gif' cid=$cid}</span>
        <span class="menu_item">{capture name='grn_message_GRN_MSG_227'}{cb_msg module='grn.message' key='GRN_MSG-227' replace='true'}{/capture}{grn_link page='message/folder_add' caption=$smarty.capture.grn_message_GRN_MSG_227 image='folder20.gif' cid=$cid}</span>
        {if $has_sibling_folders}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_228'}{cb_msg module='grn.message' key='GRN_MSG-228' replace='true'}{/capture}{grn_link page='message/category_order' caption=$smarty.capture.grn_message_GRN_MSG_228 image='order20.gif' cid=$cid}</span>
        {else}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_229'}{cb_msg module='grn.message' key='GRN_MSG-229' replace='true'}{/capture}{grn_link page='message/category_order' caption=$smarty.capture.grn_message_GRN_MSG_229 image='order20.gif' disabled=true}</span>
        {/if}
        {if $category.type eq "4"}{assign var='disabled' value=1}{/if}{* garbage folder *}
        <span class="menu_item">{capture name='grn_message_GRN_MSG_230'}{cb_msg module='grn.message' key='GRN_MSG-230' replace='true'}{/capture}{grn_link page='message/folder_view' cid=$cid caption=$smarty.capture.grn_message_GRN_MSG_230 image='detail20.gif' disabled=$disabled}</span>
        <span class="menu_item">{include file='message/_display_options.tpl'}</span>
    </div>
    <div id="smart_rare_menu_part" style="white-space:nowrap;">
        {if $use_fts}
            {if $category.type neq '3' && $category.type neq '4'}
                <form class="clearFix-cybozu" method="get" action="{grn_pageurl page='message/search'}">
                    <input type="hidden" value="{$cid}" name="dcid">
                    {include file='fts/_search_box.tpl' textName='search_text'}
                </form>
            {/if}
        {else}
            {capture name='grn_message_GRN_MSG_73'}{cb_msg module='grn.message' key='GRN_MSG-73' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_message_GRN_MSG_73 name='search_text' action='message/search' page='message/search' dcid=$cid}
        {/if}
    </div>
</div>
<!--menubar_end-->

<table class="maincontents_list">
    <tbody>
        <tr>
            <td class="maincontents_list_td">
                <form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    <table style="width:100%">
                        <tr valign="top">
                            <td id="tree_part">
                                <!--tree_structure-->
                                {include file='grn/org_tree_26.tpl'}
                                <!--tree_structure_end-->
                            </td>
                            <td id="view_part" width="90%">
                                <div id="moving_box" style="display:none;">
                                    <span id="moving_notice" style="color:#ff0000;"></span>
                                    <a href="javascript:void(0);" onclick="GRN_ListView_Util.UndoDrapDrop('message_list');">{cb_msg module='grn.message' key='GRN_MSG-409' replace='true'}</a>
                                </div>
                                {if $category.memo != ''}
                                    <div class="margin_bottom">
                                        {include file='grn/memo.tpl' category_memo=$category.memo}
                                    </div>
                                {/if}

                                {if $category.type eq '4'}
                                    <div class="smart_sub_title_right" style="float:none;text-align:right;">{cb_msg module='grn.message' key='GRN_MSG-233' replace='true'}&nbsp;<span class="bold">{$savedays}</span>&nbsp;{cb_msg module='grn.message' key='GRN_MSG-234' replace='true'}</div>
                                {/if}
                                {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                                {include file="grn/smart_word_navi_310.tpl" navi_right=$smarty.capture.navi_right navi=$navi_info.navi}

                                <div class="list_menu">
                                    {capture name='grn_message_GRN_MSG_404'}{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}{/capture}
                                    <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="ids[]" enable_shift_click=true}</span>  
                                    <span class="list_menu_item">{capture name='grn_message_GRN_MSG_238'}{cb_msg module='grn.message' key='GRN_MSG-238' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.grn_message_GRN_MSG_238 onclick="return false;"}</span>  
                                    <span class="list_menu_item">
                                        <select onchange="onChangeFolderSelect(this, 'dcid2', ['moveto', 'moveto2']);" id="dcid1" name="dcid">
                                            <option value="-1">{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}</option>
                                            {foreach from=$message_select_folders key=folder_id item=folder_name}
                                            <option value="{$folder_id|escape}">{$folder_name|escape}</option>
                                            {/foreach}</select>
                                    {capture name='grn_message_GRN_MSG_239'}{cb_msg module='grn.message' key='GRN_MSG-239' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_GRN_MSG_239 id='moveto' onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='move';" disabled=true}</span>
                                    <div id="js_additional_options_top"></div>
                                </div>

                                <table class="list_column" id="message_list">
                                    <colgroup>
                                        <col width="1%">
                                        {if $use_star && ($category.type neq '4')}
                                            <col width="1%">
                                        {/if}
                                        <col width="30%">
                                        <col width="25%">
                                        <col width="22%">
                                        <col width="22%">
                                    </colgroup>
                                    <tr>
                                        <th class="navi" nowrap></th>
                                        {if $use_star && ($category.type neq '4')}
                                            <th class="navi" nowrap></th>
                                        {/if}
                                        {if $sort == 'tlu'}
                                            <th nowrap>{capture name='grn_message_GRN_MSG_240'}{cb_msg module='grn.message' key='GRN_MSG-240' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_240 page=$page_info.all cid=$cid sort='tld' sp=0 reverse=1}</th>
                                        {else}
                                            {if $sort == 'tld'}
                                                <th nowrap>{capture name='grn_message_GRN_MSG_241'}{cb_msg module='grn.message' key='GRN_MSG-241' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_241 page=$page_info.all cid=$cid sort='tlu' sp=0}</th>
                                            {else}
                                                <th nowrap>{capture name='grn_message_GRN_MSG_242'}{cb_msg module='grn.message' key='GRN_MSG-242' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_242 page=$page_info.all cid=$cid sort='tld' sp=0 disable=1}</th>
                                            {/if}
                                        {/if}

                                        {capture name="switch_sort"}
                                            {if $sw_sort == 'ctime'}
                                                <input type="button" value="{cb_msg module='grn.message' key='GRN_MSG-243' replace='true'}" onclick="location.href='{grn_pageurl page=$page_info.all cid=$cid sw_sort='last_mtime'}'">
                                            {elseif $sw_sort == 'last_mtime'}
                                                <input type="button" value="{cb_msg module='grn.message' key='GRN_MSG-244' replace='true'}" onclick="location.href='{grn_pageurl page=$page_info.all cid=$cid sw_sort='ctime'}'">
                                            {/if}
                                            {if $sort == 'ctu'}
                                                {grn_title_sort page=$page_info.all cid=$cid sort='ctd' sp=0 reverse=1}
                                            {elseif $sort == 'ctd'}
                                                {grn_title_sort page=$page_info.all cid=$cid sort='ctu' sp=0}
                                            {elseif $sort == 'mtu'}
                                                {grn_title_sort page=$page_info.all cid=$cid sort='mtd' sp=0 reverse=1}
                                            {elseif $sort == 'mtd'}
                                                {grn_title_sort page=$page_info.all cid=$cid sort='mtu' sp=0}
                                            {else}
                                                {if $sw_sort == 'ctime'}
                                                    {grn_title_sort page=$page_info.all cid=$cid sort='ctd' sp=0 disable=1}
                                                {elseif $sw_sort == 'last_mtime'}
                                                    {grn_title_sort page=$page_info.all cid=$cid sort='mtd' sp=0 disable=1}
                                                {/if}
                                            {/if}
                                        {/capture}

                                        {if $category.type eq '1' || $category.type eq '3' || $category.type eq null} {* 受信箱/下書き/一般フォルダ *}
                                            {if $sort == 'cuu'}
                                                <th nowrap>{capture name='grn_message_GRN_MSG_245'}{cb_msg module='grn.message' key='GRN_MSG-245' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_245 page=$page_info.all cid=$cid sort='cud' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'cud'}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_246'}{cb_msg module='grn.message' key='GRN_MSG-246' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_246 page=$page_info.all cid=$cid sort='cuu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_247'}{cb_msg module='grn.message' key='GRN_MSG-247' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_247 page=$page_info.all cid=$cid sort='cud' sp=0 disable=1}</th>
                                                {/if}
                                            {/if}

                                            <th nowrap>
                                                {$smarty.capture.switch_sort|grn_noescape}
                                            </th>
                                        {elseif $category.type eq '2'}{* 送信箱 *}
                                            <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-248' replace='true'}</th>
                                            <th nowrap>{$smarty.capture.switch_sort|grn_noescape}</th>
                                        {elseif $category.type eq '4'}{* ごみ箱 *}
                                            {if $sort == 'cuu'}
                                                <th nowrap>{capture name='grn_message_GRN_MSG_249'}{cb_msg module='grn.message' key='GRN_MSG-249' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_249 page=$page_info.all cid=$cid sort='cud' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'cud'}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_250'}{cb_msg module='grn.message' key='GRN_MSG-250' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_250 page=$page_info.all cid=$cid sort='cuu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_251'}{cb_msg module='grn.message' key='GRN_MSG-251' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_251 page=$page_info.all cid=$cid sort='cud' sp=0 disable=1}</th>
                                                {/if}
                                            {/if}

                                            {if $sw_sort == 'ctime'}
                                                {if $sort == 'ctu'}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_252'}{cb_msg module='grn.message' key='GRN_MSG-252' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_252 page=$page_info.all cid=$cid sort='ctd' sp=0 reverse=1}</th>
                                                {else}
                                                    {if $sort == 'ctd'}
                                                        <th nowrap>{capture name='grn_message_GRN_MSG_253'}{cb_msg module='grn.message' key='GRN_MSG-253' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_253 page=$page_info.all cid=$cid sort='ctu' sp=0}</th>
                                                    {else}
                                                        <th nowrap>{capture name='grn_message_GRN_MSG_254'}{cb_msg module='grn.message' key='GRN_MSG-254' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_254 page=$page_info.all cid=$cid sort='ctd' sp=0 disable=1}</th>
                                                    {/if}
                                                {/if}
                                            {elseif $sw_sort == 'last_mtime'}
                                                {if $sort == 'mtu'}
                                                    <th nowrap>{capture name='grn_message_GRN_MSG_255'}{cb_msg module='grn.message' key='GRN_MSG-255' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_255 page=$page_info.all cid=$cid sort='mtd' sp=0 reverse=1}</th>
                                                {else}
                                                    {if $sort == 'mtd'}
                                                        <th nowrap>{capture name='grn_message_GRN_MSG_256'}{cb_msg module='grn.message' key='GRN_MSG-256' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_256 page=$page_info.all cid=$cid sort='mtu' sp=0}</th>
                                                    {else}
                                                        <th nowrap>{capture name='grn_message_GRN_MSG_257'}{cb_msg module='grn.message' key='GRN_MSG-257' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_257 page=$page_info.all cid=$cid sort='mtd' sp=0 disable=1}</th>
                                                    {/if}
                                                {/if}
                                            {/if}
                                        {else}{* その他 *}
                                            <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-261' replace='true'}</th>
                                            <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-262' replace='true'}</th>
                                        {/if}
                                        <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-263' replace='true'}</th>
                                    </tr>
                                    {foreach from=$messages.message item=message key=rid name="message_loop"}
                                        {capture assign="message_key"}{$rid}_{$message.mid}_{$message.is_sender}_{$message.type}{/capture}
                                        <tr class="{if $message.unread}unread_color{else}{if $smarty.foreach.message_loop.iteration % 2 == 0}lineone{else}linetwo{/if}{/if}" id="message_list-row_{$message_key}">
                                            <td nowrap>
                                                <span class="drag_handle" id="draghandle_{$message_key}" onmouseover="if(typeof(GRN_ListView_Util) != 'undefined') GRN_ListView_Util.initDrapDropItem('item_{$message_key}');">{grn_image image='grippy.png'}</span>
                                                <input id="item_{$message_key}" type="checkbox" name="ids[]" value="{$rid},{$message.mid},{$message.is_sender},{$message.type}" onmouseover="if(typeof(GRN_ListView_Util) != 'undefined') GRN_ListView_Util.initDrapDropItem('item_{$message_key}');"/>
                                            </td>
                                            {if $use_star && ($category.type neq '4')}
                                                <td nowrap>
                                                    {grn_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid rid=$rid mid=$message.mid cid=$cid type=$message.type}
                                                </td>
                                            {/if}
                                            <td nowrap>
                                                {if $message.type eq '0'} {* 受信メッセージ *}
                                                    {if $message.attach_file} {* 添付ファイル付き *}
                                                        {if $message.update}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_u_clip8.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid}
                                                        {else}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_clip8.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid}
                                                        {/if}
                                                    {else}{* 添付ファイルなし *}
                                                        {if $message.update}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_u.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid}
                                                        {else}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid}
                                                        {/if}
                                                    {/if}
                                                {elseif $message.type eq '1'} {* 送信メッセージ *}
                                                    {if $message.attach_file} {* 添付ファイル付き *}
                                                        {if $message.update}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_su_clip8.gif' cid=$cid rid=$rid mid=$message.mid}
                                                        {else}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_s_clip8.gif' cid=$cid rid=$rid mid=$message.mid}
                                                        {/if}
                                                    {else}{* 添付ファイルなし *}
                                                        {if $message.update}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_su.gif' cid=$cid rid=$rid mid=$message.mid}
                                                        {else}
                                                            {grn_link page='message/view' caption=$message.subject truncated_caption=$subject_width image='msg20_s.gif' cid=$cid rid=$rid mid=$message.mid}
                                                        {/if}
                                                    {/if}
                                                {else}{* 下書き *}
                                                    {if $message.attach_file}
                                                        {grn_link page='message/draft_view' caption=$message.subject truncated_caption=$subject_width image='draft_clip30x20.gif' cid=$cid rid=$rid mid=$message.mid}
                                                    {else}
                                                        {grn_link page='message/draft_view' caption=$message.subject truncated_caption=$subject_width image='draft20.gif' cid=$cid rid=$rid mid=$message.mid}
                                                    {/if}
                                                {/if}
                                            </td>
                                            <td nowrap>{grn_user_name uid=$message.creator_uid name=$message.creator_name users_info=$users_info truncated=$name_width}</td>
                                            <td nowrap>
                                                {if $message.unread}
                                                    {grn_date_format date=$message.ctime}
                                                {else}
                                                    {grn_date_format date=$message.mtime}
                                                {/if}
                                            </td>
                                            <td nowrap>
                                                {if $message.type eq '0'}          {* 受信メッセージ *}
                                                    {if $message.need_confirm eq '1'} {* 確認が必要なメッセージ *}
                                                        {if $message.confirmed neq '1'}  {* 未確認状態 *}
                                                            {cb_msg module='grn.message' key='GRN_MSG-264' replace='true'}
                                                        {/if}
                                                        {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
                                                            {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
                                                                <div class="notify_off">{cb_msg module='grn.message' key='GRN_MSG-265' replace='true'}</div>
                                                            {/if}
                                                        {/if}
                                                    {else}{* 確認が不必要なメッセージ *}
                                                        {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
                                                            {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
                                                                <div class="notify_off">{cb_msg module='grn.message' key='GRN_MSG-266' replace='true'}</div>
                                                            {/if}
                                                        {else}
                                                            &nbsp;
                                                        {/if}
                                                    {/if}
                                                {elseif $message.type eq '2'}      {* 下書き *}
                                                    {if $message.attach_file}
                                                        {grn_format_filesize size=$message.attach_files_size unit="KB"}
                                                    {else}
                                                        &nbsp;
                                                    {/if}
                                                {else}{* 送信メッセージ *}
                                                    {if $message.need_confirm eq '1'}     {* 確認が必要なメッセージ *}
                                                        {capture name='grn_message_GRN_MSG_267'}{cb_msg module='grn.message' key='GRN_MSG-267' replace='true'}{/capture}
                                                        {grn_link caption=$smarty.capture.grn_message_GRN_MSG_267 page='message/read_status' cid=$cid rid=$rid mid=$message.mid}
                                                        {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
                                                            {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
                                                                <div class="notify_off">{cb_msg module='grn.message' key='GRN_MSG-268' replace='true'}</div>
                                                            {/if}
                                                        {/if}
                                                    {else}{* 確認が不必要なメッセージ *}
                                                        {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
                                                            {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
                                                                <div class="notify_off">{cb_msg module='grn.message' key='GRN_MSG-269' replace='true'}</div>
                                                            {/if}
                                                        {else}
                                                            &nbsp;
                                                        {/if}
                                                    {/if}
                                                {/if}
                                            </td>
                                        </tr>
                                    {/foreach}
                                </table>
                                <div class="list_menu">
                                    <nobr>
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="ids[]" enable_shift_click=true}</span>  
                                        <span class="list_menu_item">{capture name='grn_message_GRN_MSG_270'}{cb_msg module='grn.message' key='GRN_MSG-270' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi2" caption=$smarty.capture.grn_message_GRN_MSG_270 onclick="return false;"}</span>
                                        <span class="list_menu_item">
                                        <select onchange="onChangeFolderSelect(this, 'dcid1', ['moveto', 'moveto2']);" id="dcid2" name="dcid2">
                                            <option value="-1">{cb_msg module='grn.message' key='GRN_MSG-404' replace='true'}</option>
                                            {foreach from=$message_select_folders key=folder_id item=folder_name}
                                                <option value="{$folder_id|escape}">{$folder_name|escape}</option>
                                            {/foreach}</select>
                                            {capture name='grn_message_GRN_MSG_271'}{cb_msg module='grn.message' key='GRN_MSG-271' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_GRN_MSG_271 id='moveto2' onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='move';" disabled=true}</span>
                                        <div id="js_additional_options_bottom"></div>
                                    </nobr>
                                </div>
                                <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi_info.navi}</nobr></div>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="cmd">
                    <input type="hidden" name="cid" value="{$cid}">
                    <input type="hidden" name="ctype" value="{$category.type}">
                </form>
            </td>
        </tr>
    </tbody>
</table>
<!--end of maincontents_list-->

{*** DRAG N' DROP ***}

{include file='grn/dragdrop_list2tree.tpl'}
{literal}
<script language="javascript">
    YAHOO.util.Event.onDOMReady(function(){
        var GRN_DDList2Tree_Message = function(){
            GRN_DDList2Tree_Message.superclass.constructor.apply(this, arguments);
        }
        YAHOO.extend(GRN_DDList2Tree_Message, GRN_DDList2Tree);

        var options = { list_id:'message_list',
                item_name:'ids[]',
                csrf_ticket:'{/literal}{$csrf_ticket}{literal}',
                async_url: '{/literal}{grn_pageurl page=message/command_move_ajax}',
                source:{ldelim}name:'cid',value:{$cid}{rdelim},
                target_oid_key: 'dcid',
                drag_msg: {ldelim}singular: '{cb_msg module='grn.message' key='GRN_MSG-406' replace='true'}', plural: '{cb_msg module='grn.message' key='GRN_MSG-407' replace='true'}'{rdelim},
                moving_notice:'{cb_msg module='grn.message' key='GRN_MSG-408' replace='true'}'{literal}
        };
        GRN_ListView_Util.InitDragDrop(GRN_DDList2Tree_Message, options);
    });
    new grn.js.page.message.Index();
</script>
{/literal}
{*** END: DRAG N' DROP ***}

{include file='grn/footer.tpl'}
