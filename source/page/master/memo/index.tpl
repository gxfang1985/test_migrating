{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='memo/_title_search.tpl'}
 
 <div class="mainarea">
 <!--menubar-->
{grn_delete title=$delete_all_info.title page=$delete_all_info.page no_confirm=$delete_all_info.no_confirm data=$delete_all_info.data handler=$delete_all_info.handler}
{grn_delete title=$delete_multi_info.title page=$delete_multi_info.page data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target}
{grn_load_javascript file="grn/html/folder_select.js"}
{literal}
    <script type="text/javascript">
        function on_before_show_popup(form)
        {
            //get create message
            var checks = form.select('input[name="eid[]"]');
            var count = 0;
            checks.each(function(e){
                var temp = e.value.split(",")
                if( ( temp[2] == "1" ) && ( temp[3] !="2" ) )
                {
                    count++;
                }
            });
            var span_create_message = form.select('span.create_message_count')[0];
            if(span_create_message){
                span_create_message.update(count);
            }
            //not show popup
            if( count == 0)
            {
                var div_create_message = form.select('div.create_message')[0];
                if(div_create_message){
                    div_create_message.hide();
                }
                return false;
            }
            else //show popup
            {
                return true;
            }
        }
    </script>
{/literal}

<div id="menu_part">
    <div id="smart_main_menu_part">
        {capture name='grn_memo_GRN_MEM_178'}{cb_msg module='grn.memo' key='GRN_MEM-178' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.memo' key='GRN_MEM-179' replace='true'}{/capture}
        {grn_link page='memo/add' caption=$smarty.capture.grn_memo_GRN_MEM_178 image='memo20.gif' class='menu_item' did=$folder_id element_id='memo-add'}
        {if $limit_size != 0}
            {capture name='grn_memo_GRN_MEM_109'}{cb_msg module='grn.memo' key='GRN_MEM-109' replace='true'}{/capture}{grn_link page='memo/file_add'   caption=$smarty.capture.grn_memo_GRN_MEM_109 image='file20.gif'   class='menu_item' did=$folder_id}
        {/if}
        {capture name='grn_memo_GRN_MEM_110'}{cb_msg module='grn.memo' key='GRN_MEM-110' replace='true'}{/capture}{grn_link page='memo/folder_add' caption=$smarty.capture.grn_memo_GRN_MEM_110 image='folder20.gif' class='menu_item' did=$folder_id element_id="memo-folder-add"}
        {if ! $folder_id}
            {if $root_folders_count > 1}
                {capture name='grn_memo_GRN_MEM_111'}{cb_msg module='grn.memo' key='GRN_MEM-111' replace='true'}{/capture}{grn_link page='memo/folder_top_order' caption=$smarty.capture.grn_memo_GRN_MEM_111 image='order20.gif' class='menu_item' did=$folder_id}
            {else}
                {capture name='grn_memo_GRN_MEM_112'}{cb_msg module='grn.memo' key='GRN_MEM-112' replace='true'}{/capture}{grn_link page='memo/folder_top_order' caption=$smarty.capture.grn_memo_GRN_MEM_112 image='order20.gif' class='menu_item' disabled=true}
            {/if}
        {else}
            {if $current.child_count > 1}
                {capture name='grn_memo_GRN_MEM_113'}{cb_msg module='grn.memo' key='GRN_MEM-113' replace='true'}{/capture}{grn_link page='memo/folder_order' caption=$smarty.capture.grn_memo_GRN_MEM_113 image='order20.gif' class='menu_item' did=$folder_id}
            {else}
                {capture name='grn_memo_GRN_MEM_114'}{cb_msg module='grn.memo' key='GRN_MEM-114' replace='true'}{/capture}{grn_link page='memo/folder_order' caption=$smarty.capture.grn_memo_GRN_MEM_114 image='order20.gif' class='menu_item' disabled=true}
            {/if}
        {/if}
        {if ! $folder_id}
            {capture name='grn_memo_GRN_MEM_115'}{cb_msg module='grn.memo' key='GRN_MEM-115' replace='true'}{/capture}{grn_link page='memo/folder_view' caption=$smarty.capture.grn_memo_GRN_MEM_115 image='detail20.gif' class='menu_item' did=$folder_id disabled=true}
        {else}
            {capture name='grn_memo_GRN_MEM_116'}{cb_msg module='grn.memo' key='GRN_MEM-116' replace='true'}{/capture}{grn_link page='memo/folder_view' caption=$smarty.capture.grn_memo_GRN_MEM_116 image='detail20.gif' class='menu_item' did=$folder_id}
        {/if}
        <span class="menu_item">
            {include file='memo/_display_options.tpl'}
        </span>
    </div>
    <div id="smart_rare_menu_part" style="white-space:nowrap;">
        {capture name='grn_memo_GRN_MEM_40'}{cb_msg module='grn.memo' key='GRN_MEM-40' replace='true'}{/capture}
        {grn_simple_search caption=$app_name|cat:$smarty.capture.grn_memo_GRN_MEM_40 name='text' action='memo/search' page='memo/search' did=$folder_id sdid=$folder_id}
    </div>
</div>
<!--menubar_end-->

<table class="maincontents_list">
    <tbody>
        <tr>
            <td class="maincontents_list_td">
                {assign var='form_name' value=$smarty.template|basename}
                <form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    <table id="main_table" width="100%">
                        <tr valign="top">
                            <td id="tree_part" width="10%">
                                {include file='grn/org_tree_26.tpl'}
                            </td>
                            <td id="view_part" width="90%">
                                <div class="margin_bottom">
                                    {if $current.memo != ''}
                                        {include file='grn/memo.tpl' category_memo=$current.memo}
                                    {/if}
                                </div>
                                <div style="text-align:right;">
                                    <div class="smart_sub_title_right" style="float:none;">&nbsp;&nbsp;
                                        {cb_msg module='grn.memo' key='GRN_MEM-119' replace='true'}&nbsp;
                                        {if $total_size > $limit_size && $limit_size != -1}<font color="red">{/if}
                                        {grn_format_filesize size=$total_size round='ceil' unit='MB'}
                                        {if $total_size < 1048576 && $total_size > 0}{cb_msg module='grn.memo' key='GRN_MEM-120' replace='true'}{/if}
                                        {if $total_size > $limit_size && $limit_size != -1}</font>{/if}
                                        {if $limit_size > 0}&nbsp;/&nbsp;{grn_format_filesize size=$limit_size unit='MB'}{/if}
                                    </div>
                                </div>
                                {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                                {include file="grn/smart_word_navi_310.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}
                                <div class="list_menu">
                                    <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
                                    <span class="list_menu_item"><nobr>{capture name='grn_memo_GRN_MEM_124'}{cb_msg module='grn.memo' key='GRN_MEM-124' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi1" caption=$smarty.capture.grn_memo_GRN_MEM_124 onclick="return false;"}</nobr></span>
                                    {strip}
                                        <span>{include file="memo/_folder_menu.tpl" move_folder=1 param_name="mdid" onchange="onChangeFolderSelect(this, mdid2, [btn_move1, btn_move2]);"}{capture name='grn_memo_GRN_MEM_125'}{cb_msg module='grn.memo' key='GRN_MEM-125' replace='true'}{/capture}{grn_button_submit id="btn_move1" caption=$smarty.capture.grn_memo_GRN_MEM_125 onclick="if(!grn_is_checked(this.form,'eid[]')) return false; cmd.value='move';" disabled=true}</span>
                                    {/strip}
                                </div>
                                <table class="list_column" width="100%">
                                    <colgroup>
                                        {if $folder_id}
                                            <col width="1%">
                                            <col width="30%">
                                            <col width="35%">
                                            <col width="35%">
                                        {else}
                                            <col width="1%">
                                            <col width="30%">
                                            <col width="35%">
                                            <col width="20%">
                                            <col width="15%">
                                        {/if}
                                    </colgroup>
                                    <tr valign="top">
                                        <th nowrap></th>
                                        {if $sort == 'tlu'}
                                            <th nowrap>{capture name='grn_memo_GRN_MEM_126'}{cb_msg module='grn.memo' key='GRN_MEM-126' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_126 page=$page_info.all did=$folder_id sort='tld' sp=0 reverse=1}</th>
                                        {else}
                                            {if $sort == 'tld'}
                                                <th nowrap>{capture name='grn_memo_GRN_MEM_127'}{cb_msg module='grn.memo' key='GRN_MEM-127' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_127 page=$page_info.all did=$folder_id sort='tlu' sp=0}</th>
                                            {else}
                                                <th nowrap>{capture name='grn_memo_GRN_MEM_128'}{cb_msg module='grn.memo' key='GRN_MEM-128' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_128 page=$page_info.all did=$folder_id sort='tld' sp=0 disable=1}</th>
                                            {/if}
                                        {/if}

                                        <th nowrap><div style="padding-top: 2px;">{cb_msg module='grn.memo' key='GRN_MEM-129' replace='true'}</div></th>
                                        {if ! $folder_id}
                                            <th nowrap><div style="padding-top: 2px;">{cb_msg module='grn.memo' key='GRN_MEM-130' replace='true'}</div></th>
                                        {/if}

                                        {if $sort == 'mtu'}
                                            <th nowrap>{capture name='grn_memo_GRN_MEM_131'}{cb_msg module='grn.memo' key='GRN_MEM-131' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_131 page=$page_info.all did=$folder_id sort='mtd' sp=0 reverse=1}</th>
                                        {else}
                                            {if $sort == 'mtd'}
                                                <th nowrap>{capture name='grn_memo_GRN_MEM_132'}{cb_msg module='grn.memo' key='GRN_MEM-132' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_132 page=$page_info.all did=$folder_id sort='mtu' sp=0}</th>
                                            {else}
                                                <th nowrap>{capture name='grn_memo_GRN_MEM_133'}{cb_msg module='grn.memo' key='GRN_MEM-133' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_memo_GRN_MEM_133 page=$page_info.all did=$folder_id sort='mtd' sp=0 disable=1}</th>
                                            {/if}
                                        {/if}
                                    </tr>
                                    {foreach from=$items item=item}
                                        <tr class="{cycle values='linetwo,lineone'}">
                                            <td><input type="checkbox" name="eid[]" value="{$item.id}"></td>
                                            {if $item.type != 'file'}
                                                {if $item.data.file_count}
                                                    <td>{grn_link page='memo/view' caption=$item.data.title image='memo20_clip8.gif' iid=$item.id did=$folder_id truncated_caption=$config.subject_width class='memo-item'}</td>
                                                {else}
                                                    <td>{grn_link page='memo/view' caption=$item.data.title image='memo20.gif' iid=$item.id did=$folder_id truncated_caption=$config.subject_width class='memo-item'}</td>
                                                {/if}
                                                <td>{$item.data.data|cb_mb_truncate:$config.truncate_width|escape}</td>
                                                {if ! $folder_id}
                                                    {if $item.folder}
                                                        <td>{grn_link page='memo/index' caption=$item.folder.name image='folder20.gif' did=$item.folder.id truncated_caption=$config.truncate_width class='memo-item'}</td>
                                                    {else}
                                                        <td>{grn_link page='memo/index' caption_module='grn.memo' caption_key='lastest_folder_name' image='folder20.gif' truncated_caption=$config.truncate_width class='memo-item'}</td>
                                                    {/if}
                                                {/if}
                                                <td>{grn_date_format date=$item.data.mtime format="DateTimeCompact"}</td>
                                            {else}
                                                {if strlen($item.data.title)}
                                                    <td>{grn_link page='memo/file_view' caption=$item.data.title image='file20.gif' iid=$item.id did=$folder_id truncated_caption=$config.subject_width class='memo-item'}</td>
                                                {else}
                                                    <td>{grn_link page='memo/file_view' caption=$item.data.filename image='file20.gif' iid=$item.id did=$folder_id truncated_caption=$config.subject_width class='memo-item'}</td>
                                                {/if}
                                                {capture name='grn_memo_GRN_MEM_186'}{cb_msg module='grn.memo' key='GRN_MEM-186' replace='true'}{/capture}
                                                {capture name='grn_memo_GRN_MEM_187'}{cb_msg module='grn.memo' key='GRN_MEM-187' replace='true'}{/capture}
                                                <td>{grn_link page='memo/file_download' caption='' image='downloadbutton20.gif' iid=$item.id alt=$smarty.capture.grn_memo_GRN_MEM_186 postfix=$item.data.filename ticket=$download_ticket}&nbsp;
                                                    {grn_link page='memo/file_upload' caption='' image='uploadbutton20.gif' iid=$item.id pid='index' index_return=1 alt=$smarty.capture.grn_memo_GRN_MEM_187}&nbsp;
                                                    {$item.data.filename|escape}
                                                </td>
                                                {if ! $folder_id}
                                                    {if $item.folder}
                                                        <td>{grn_link page='memo/index' caption=$item.folder.name image='folder20.gif' did=$item.folder.id truncated_caption=$config.truncate_width}</td>
                                                    {else}
                                                        <td>{grn_link page='memo/index' caption_module='grn.memo' caption_key='lastest_folder_name' image='folder20.gif' truncated_caption=$config.truncate_width}</td>
                                                    {/if}
                                                {/if}
                                                <td>{grn_date_format date=$item.data.mtime format="DateTimeCompact"}</td>
                                            {/if}
                                        </tr>
                                    {/foreach}
                                </table>
                                <div class="list_menu">
                                    <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>
                                    <span class="list_menu_item"><nobr>{capture name='grn_memo_GRN_MEM_134'}{cb_msg module='grn.memo' key='GRN_MEM-134' replace='true'}{/capture}{grn_button_submit id="btn_delete_multi2" caption=$smarty.capture.grn_memo_GRN_MEM_134 onclick="return false;"}</nobr></span>
                                    {strip}
                                        <span>{include file="memo/_folder_menu.tpl" move_folder=1 param_name="mdid2" onchange="onChangeFolderSelect(this, mdid, [btn_move1, btn_move2]);"}{capture name='grn_memo_GRN_MEM_135'}{cb_msg module='grn.memo' key='GRN_MEM-135' replace='true'}{/capture}{grn_button_submit id="btn_move2" caption=$smarty.capture.grn_memo_GRN_MEM_135 onclick="if(!grn_is_checked(this.form,'eid[]')) return false; cmd.value='move';" disabled=true}</span>
                                    {/strip}
                                </div>
                                <div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi_info.navi}</nobr></div>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="cmd">
                    <input type="hidden" name="did" value="{$folder_id}">
                </form>
            </td>
        </tr>
    </tbody>
</table>
<!--end of maincontents_list-->
{include file='grn/footer.tpl'}
