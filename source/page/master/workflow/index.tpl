{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{include file='workflow/_title_search.tpl'}
<div class="mainarea">
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="menu_part" >
    <div id="smart_main_menu_part">
        <span class="menu_item"><nobr>{capture name='grn_workflow_apply'}{cb_msg module='grn.workflow' key='apply' replace='true'}{/capture}{grn_link image='write20.gif' page='workflow/send' caption=$smarty.capture.grn_workflow_apply}</nobr></span>
        {if $is_proxy_petition}
            <span class="menu_item"><nobr>{capture name='grn_workflow_apply_per_pro_2'}{cb_msg module='grn.workflow' key='apply_per_pro_2' replace='true'}{/capture}{grn_link image='substitute_application20.gif' page='workflow/send_proxy' caption=$smarty.capture.grn_workflow_apply_per_pro_2}</nobr></span>
        {/if}
        <span class="menu_item">
            {include file='workflow/_display_options.tpl'}
        </span>
    </div>
    <div id="rare_menu_part">
        {capture name="grn_workflow_GRN_WKF_5"}{cb_msg module='grn.workflow' key='GRN_WKF_5' replace='true'}{/capture}
        {if $folder_list.temp_folder.fid == $folder_id}{assign var='search_disabled' value='true'}{/if}
        {grn_simple_search caption=$smarty.capture.grn_workflow_GRN_WKF_5 name='search_text' action='workflow/search' page='workflow/search' fid=$folder_id|escape disabled=$search_disabled}
    </div>
</div>

{capture name='grn_workflow_GRN_WKF_4'}{cb_msg module='grn.workflow' key='GRN_WKF_4' replace='true'}{/capture}

<table class="maincontents_list"><tbody>
    <tr>
        <td class="maincontents_list_td">
            <table width="100%">
                <tr valign="top">
                    <td id="tree_part" width="23%">
                        <div id="tree_structure">
                            <div>
                                <div class="parent">
                                    {if $folder_list.new_folder.fid == $folder_id || $folder_list.unprocessed_folder.fid == $folder_id || $folder_list.finish_folder.fid == $folder_id}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.new_folder.fid caption=$folder_list.new_folder.name  image='folder20.gif' focus=TURE}{* 最新一覧 *}
                                    {else}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.new_folder.fid caption=$folder_list.new_folder.name  image='folder20.gif'}{* 最新一覧 *}
                                    {/if}
                                    <div class="clear_both"><div class="border-partition-common-grn"></div></div>
                                    {if $folder_list.out_folder.fid == $folder_id}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.out_folder.fid caption=$folder_list.out_folder.name  image='sentbox20.gif' focus=TURE}{* 送信一覧 *}
                                    {else}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.out_folder.fid caption=$folder_list.out_folder.name  image='sentbox20.gif'}{* 送信一覧 *}
                                    {/if}
                                    
                                    {if $folder_list.in_folder.fid == $folder_id}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.in_folder.fid caption=$folder_list.in_folder.name  image='inbox20.gif' focus=TURE}{* 受信一覧 *}
                                    {else}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.in_folder.fid caption=$folder_list.in_folder.name  image='inbox20.gif'}{* 受信一覧 *}
                                    {/if}
                                    
                                    {if $folder_list.temp_folder.fid == $folder_id}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.temp_folder.fid caption=$folder_list.temp_folder.name  image='unsentbox20.gif' focus=TURE}{* 下書き *}
                                    {else}
                                        {grn_structure_link page='workflow/index' fid=$folder_list.temp_folder.fid caption=$folder_list.temp_folder.name  image='unsentbox20.gif'}{* 下書き *}
                                    {/if}
                                    
                                    {if $folder_list.proxy_approval_folder || $folder_list.approval_plan_folder || $category}
                                        <div class="clear_both"><div class="border-partition-common-grn"></div></div>
                                    {/if}
                                    
                                    {if $folder_list.proxy_approval_folder}
                                        {if $folder_list.proxy_approval_folder.fid == $folder_id}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.proxy_approval_folder.fid caption=$folder_list.proxy_approval_folder.name  image='folder20.gif' focus=TURE}{* 代理承認 *}
                                        {else}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.proxy_approval_folder.fid caption=$folder_list.proxy_approval_folder.name  image='folder20.gif'}{* 代理承認 *}
                                        {/if}
                                    {/if}
                                    
                                    {if $folder_list.approval_plan_folder}
                                        {if $folder_list.approval_plan_folder.fid == $folder_id}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.approval_plan_folder.fid caption=$folder_list.approval_plan_folder.name  image='folder20.gif' focus=TRUE}{* 承認予定一覧 *}
                                        {else}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.approval_plan_folder.fid caption=$folder_list.approval_plan_folder.name  image='folder20.gif'}{* 承認予定一覧 *}
                                        {/if}
                                    {/if}
                                    
                                    {if $category}
                                        <div class="clear_both"><div class="border-partition-common-grn"></div></div>
                                        {if $folder_list.public_folder.fid == $folder_id}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.public_folder.fid caption=$folder_list.public_folder.name  image='folder20.gif' focus=TRUE}{* 公開一覧 *}
                                        {else}
                                            {grn_structure_link page='workflow/index' fid=$folder_list.public_folder.fid caption=$folder_list.public_folder.name  image='folder20.gif'}{* 公開一覧 *}
                                        {/if}
                                    {/if}
                                </div>
        
                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID }
                                    {include file="workflow/_category_structure_indent.tpl" no_extra=1}
                                    <!--category_tree_end-->
                                {/if}
                    </td>
                    <td id="view_part" width="77%">
                        {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_NEW_ID || $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID || $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_FINISH_ID}
                            {* 最新一覧表示 *}
                            <div class="list_subtitle">{$folder_list.unprocessed_folder.name}</div>
                            <form name="{$form_name}/unprocessing" method="post" action="{grn_pageurl page='workflow/handle'}">
                                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                <input type="hidden" name="fid" value="{$folder_list.unprocessed_folder.fid}">
                                <input type="hidden" name="cmd" value="">
                                <input type="hidden" name="sort" value="{$sort}">
                                {capture name="unprocessed_navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$unprocessed_navi_info.start_count end_num=$unprocessed_navi_info.end_count all_num=$unprocessed_navi_info.count}{/capture}
                                {include file="grn/smart_word_multi_navi.tpl" navi=$unprocessed_navi_info.navi navi_right=$smarty.capture.unprocessed_navi_right}
                                <table class="list_menu" width="100%">
                                    <tr>
                                        <td nowrap>
                                            <select name="offset" id="series_select" {if $folder_list.unprocessed_folder.count == 0}disabled{/if}>
                                                {foreach from=$folder_list.unprocessed_folder.folderrelation item=petition name=unprocessed}
                                                    <option value="{$smarty.foreach.unprocessed.iteration+$unprocessed_navi_info.start_count-2}">{$smarty.foreach.unprocessed.iteration+$unprocessed_navi_info.start_count-1}</option>
                                                {/foreach}
                                            </select>
                                            {capture name='grn_workflow_key_8_2'}{cb_msg module='grn.workflow' key='key_8_2' replace='true'}{/capture}
                                            {if $folder_list.unprocessed_folder.count == 0}{grn_button_submit caption=$smarty.capture.grn_workflow_key_8_2 onclick="cmd.value='batch';" disabled='true'}{else}{grn_button_submit caption=$smarty.capture.grn_workflow_key_8_2 onclick="cmd.value='batch';"}{/if}
                                        </td>
                                    </tr>
                                </table>
                                
                                <table class="list_column">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="11%">
                                        <col width="5%">
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="12%">
                                        <col width="15%">
                                        <col width="12%">
                                    </colgroup>
                                    <tr>
                                        <th nowrap></th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'pnu'}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort='pnd' sort_result=$sort_result sp=0 sf=2 reverse=1}
                                            {elseif  $sort == 'pnd'}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort='pnu' sort_result=$sort_result sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort='pnd' sort_result=$sort_result sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                        <th nowrap>
                                            {if $sort == 'fnu'}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort='fnd' sort_result=$sort_result sp=0 sf=2 reverse=1}
                                            {elseif $sort == 'fnd'}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort='fnu' sort_result=$sort_result sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort='fnd' sort_result=$sort_result sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'ctu'}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort='ctd' sort_result=$sort_result sp=0 sf=2 reverse=1}
                                            {elseif $sort == 'ctd'}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort='ctu' sort_result=$sort_result sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort='ctd' sort_result=$sort_result sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                    </tr>
                                    {if $folder_list.unprocessed_folder.count == 0}
                                        <tr>
                                            <td colspan="8">
                                                {cb_msg module='grn.workflow' key='no_unprocessed_application' replace='true'}
                                            </td>
                                        </tr>
                                    {else}
                                        {foreach from=$folder_list.unprocessed_folder.folderrelation item=petition name=unprocessed}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                <td class="navi" style="background-color: rgb(255, 255, 255);"><input type="button" class="buttonStandard-grn series_select_button_width" value="{$smarty.foreach.unprocessed.iteration+$unprocessed_navi_info.start_count-1}" onClick="cmd.value='batch';document.getElementById('series_select').value='{$smarty.foreach.unprocessed.iteration+$unprocessed_navi_info.start_count-2}';this.form.submit();"></td>
                                                <td nowrap>{$petition.petition_number|escape}</td>
                                                <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$folder_id fid=$folder_list.unprocessed_folder.fid pid=$petition.ptid}</nobr></td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$folder_id fid=$folder_list.unprocessed_folder.fid pid=$petition.ptid}</nobr></td>
                                                <td nowrap>
                                                    {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
                                                        <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                                                        <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                        <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
                                                        <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
                                                        <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
                                                    {/if}
                                                </td>
                                                <td nowrap>{grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}</td>
                                                <td nowrap>{grn_date_format date=$petition.ctime}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                </table>
                                <div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$unprocessed_navi_info.navi}</nobr></div>
                            </form>
                            <div style="line-height: 1em;">&nbsp;</div>
                                <div class="list_subtitle">
                                    {$folder_list.finish_folder.name}
                                </div>
                                <form name="{$form_name}/finished" method="post" action="{grn_pageurl page='workflow/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                    <input type="hidden" name="fid" value="{$folder_list.finish_folder.fid}">
                                    {capture name="finish_navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$finish_navi_info.start_count end_num=$finish_navi_info.end_count all_num=$finish_navi_info.count}{/capture}
                                    {include file="grn/smart_word_multi_navi.tpl" navi=$finish_navi_info.navi navi_right=$smarty.capture.finish_navi_right}
                                    <div class="list_menu">
                                        <nobr>
                                            <span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`/finished" elem_name="pids[]"}</span>
                                            <span class="list_menu_item">
                                                {if $folder_list.finish_folder.count == 0}
                                                    {grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 onclick="if( ! grn_is_checked( this.form, 'pids[]' ) ) return false;" disabled='true'}
                                                {else}
                                                    {grn_delete title=$delete_info_multi_finish.title page=$delete_info_multi_finish.page no_confirm=$delete_info_multi_finish.no_confirm data=$delete_info_multi_finish.data handler=$delete_info_multi_finish.handler multi_target=$delete_info_multi_finish.multi_target form_target=$delete_info_multi_finish.form_target}
                                                    {grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi_finish1" onclick="return false;"}
                                                {/if}
                                            </span>
                                        </nobr>
                                    </div>
                                    <table class="list_column">
                                        <colgroup>
                                            <col width="5%">
                                            <col width="11%">
                                            <col width="5%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="12%">
                                            <col width="15%">
                                            <col width="12%">
                                        </colgroup>
                                        <tr>
                                            <th nowrap>&nbsp;</th>
                                            <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
                                            <th nowrap>
                                                {if $sort_result == 'pnu'}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort_result='pnd' sort=$sort sp=0 sf=2 reverse=1}
                                                {elseif  $sort_result == 'pnd'}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort_result='pnu' sort=$sort sp=0 sf=2}
                                                {else}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.new_folder.fid sort_result='pnd' sort=$sort sp=0 sf=2 disable=1}
                                                {/if}
                                            </th>
                                            <th nowrap>
                                                {if $sort_result == 'fnu'}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort_result='fnd' sort=$sort sp=0 sf=2 reverse=1}
                                                {elseif $sort_result == 'fnd'}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort_result='fnu' sort=$sort sp=0 sf=2}
                                                {else}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.new_folder.fid sort_result='fnd' sort=$sort sp=0 sf=2 disable=1}
                                                {/if}
                                            </th>
                                            <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
                                            <th nowrap>{cb_msg module='grn.workflow' key='result' replace='true'}</th>
                                            <th nowrap>{cb_msg module='grn.workflow' key='accepted_rejected' replace='true'}</th>
                                            <th nowrap>
                                                {if $sort_result == 'ctu'}
                                                  {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort_result='ctd' sort=$sort sp=0 sf=2 reverse=1}
                                                {elseif $sort_result == 'ctd'}
                                                  {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort_result='ctu' sort=$sort sp=0 sf=2}
                                                {else}
                                                  {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.new_folder.fid sort_result='ctd' sort=$sort sp=0 sf=2 disable=1}
                                                {/if}
                                            </th>
                                        </tr>
                                        {if $folder_list.finish_folder.count == 0}
                                            <tr>
                                                <td colspan="8">
                                                        {cb_msg module='grn.workflow' key='no_application_result' replace='true'}
                                                 </td>
                                            </tr>
                                        {else}
                                            {foreach from=$folder_list.finish_folder.folderrelation item=petition}
                                                <tr class="{cycle values='linetwo,lineone'}">
                                                    <td nowrap><input type="checkbox" name="pids[]" value="{$petition.ptid}"></td>
                                                    <td nowrap>{$petition.petition_number|escape}</td>
                                                    <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
                                                    <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$folder_id fid=$folder_list.finish_folder.fid pid=$petition.ptid}</nobr></td>
                                                    <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$folder_id fid=$folder_list.finish_folder.fid pid=$petition.ptid}</nobr></td>
                                                    <td nowrap>
                                                        {if $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                                                            <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                            <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
                                                            <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
                                                        {/if}
                                                    </td>
                                                    <td nowrap>
                                                        {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                            {* 却下の場合（却下した人を表示） *}
                                                            {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name valid=$petition.transactor_valid truncated=$name_width users_info=$users_info}
                                                        {else}
                                                            {foreach from=$petition.transactor item=user}
                                                                {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid truncated=$name_width users_info=$users_info}
                                                            {foreachelse}
                                                                {cb_msg module='grn.workflow' key='pass_along_only_bracket' replace='true'}
                                                            {/foreach}
                                                            {if $petition.transactor_num > $show_user_num}<span class="multiple_username"><span class="comma">,</span><span class="dots">{cb_msg module='grn.workflow' key='three_dots' replace='true'}</span></span>{/if}
                                                        {/if}
                                                    </td>
                                                    <td nowrap>{grn_date_format date=$petition.ctime}</td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                    </table>
                                    <div class="list_menu">
                                        <table>
                                            <tr>
                                                <td nowrap>
                                                    <span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`/finished" elem_name="pids[]"}</span>
                                                    {if $folder_list.finish_folder.count == 0}
                                                        {grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 onclick="if( ! grn_is_checked( this.form, 'pids[]' ) ) return false;" disabled='true'}
                                                    {else}
                                                        {grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi_finish2" onclick="return false;"}
                                                    {/if}
                                                    &nbsp;&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$finish_navi_info.navi}</nobr></div>
                                </form>
                        {elseif $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
                            {* 代理承認 *}
                            <form name="{$form_name}/proxy_approval" method="post" action="{grn_pageurl page='workflow/handle'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                <input type="hidden" name="fid" value="{$folder_list.current_folder.fid}">
                                <input type="hidden" name="cmd" value="">
                                <input type="hidden" name="sort" value="{$sort}">
                                {include file="grn/smart_word_multi_navi.tpl" navi=$navi_info.navi}
                                <table class="navi" width="100%">
                                    <tr>
                                        <td nowrap>
                                            <select name="offset" id="series_select" {if $folder_list.current_folder.count == 0}disabled{/if}>
                                                {foreach from=$folder_list.current_folder.folderrelation item=petition name=proxy_approval}
                                                    <option value="{$smarty.foreach.proxy_approval.iteration+$navi_info.start_count-2}">{$smarty.foreach.proxy_approval.iteration+$navi_info.start_count-1}</option>
                                                {/foreach}
                                            </select>
                                            &nbsp;
                                            {capture name='grn_workflow_key_8_2'}{cb_msg module='grn.workflow' key='key_8_2' replace='true'}{/capture}
                                            {if $folder_list.current_folder.count == 0}
                                                {grn_button_submit caption=$smarty.capture.grn_workflow_key_8_2 onclick="cmd.value='batch';" disabled='true'}
                                            {else}
                                                {grn_button_submit caption=$smarty.capture.grn_workflow_key_8_2 onclick="cmd.value='batch';"}
                                            {/if}
                                        </td>
                                    </tr>
                                </table>
        
                                <table class="list_column">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="11%">
                                        <col width="5%">
                                        <col width="20%">
                                        <col width="15%">
                                        <col width="5%">
                                        <col width="15%">
                                        <col width="15%">
                                        <col width="12%">
                                    </colgroup>
                                    <tr>
                                        <th nowrap></th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'pnu'}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 reverse=1}
                                            {elseif  $sort == 'pnd'}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnu' sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                        <th nowrap>
                                            {if $sort == 'fnu'}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 reverse=1}
                                            {elseif $sort == 'fnd'}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnu' sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'mtu'}
                                                {capture name='grn_workflow_accept_delegated_user'}{cb_msg module='grn.workflow' key='accept_delegated_user' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_accept_delegated_user page=$page_info.all fid=$folder_list.current_folder.fid sort='mtd' sp=0 sf=2 reverse=1}
                                            {elseif $sort == 'mtd'}
                                                {capture name='grn_workflow_accept_delegated_user'}{cb_msg module='grn.workflow' key='accept_delegated_user' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_accept_delegated_user page=$page_info.all fid=$folder_list.current_folder.fid sort='mtu' sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_accept_delegated_user'}{cb_msg module='grn.workflow' key='accept_delegated_user' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_accept_delegated_user page=$page_info.all fid=$folder_list.current_folder.fid sort='mtd' sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'ctu'}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 reverse=1}
                                            {elseif $sort == 'ctd'}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctu' sp=0 sf=2}
                                            {else}
                                                {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 disable=1}
                                            {/if}
                                        </th>
                                    </tr>
                                    {if $folder_list.current_folder.count == 0}
                                        <tr>
                                            <td colspan="6">
                                                {cb_msg module='grn.workflow' key='no_unprocessed_application' replace='true'}
                                            </td>
                                        </tr>
                                    {else}
                                        {foreach from=$folder_list.current_folder.folderrelation item=petition name=proxy_approval}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                <td class="navi"><input type="button" class="buttonStandard-grn series_select_button_width" value="{$smarty.foreach.proxy_approval.iteration+$navi_info.start_count-1}" onClick="cmd.value='batch';document.getElementById('series_select').value='{$smarty.foreach.proxy_approval.iteration+$navi_info.start_count-2}';this.form.submit();"></td>
                                                <td nowrap>{$petition.petition_number|escape}</td>
                                                <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$petition.fid pid=$petition.ptid}</nobr></td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$petition.fid pid=$petition.ptid}</nobr></td>
                                                <td nowrap>
                                                    {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
                                                        <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                                                        <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                        <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
                                                        <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
                                                    {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
                                                        <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
                                                    {/if}
                                                </td>
                                                <td nowrap>{grn_user_name uid=$petition.fuser_id truncated=$name_width users_info=$users_info}</td>
                                                <td nowrap>{grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}</td>
                                                <td nowrap>{grn_date_format date=$petition.ctime}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                </table>
                                <div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$navi_info.navi}</nobr></div>
                            </form>
                        {elseif $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID}
                            {* 承認予定一覧 *}
                            <div class="margin_bottom">
                                <div>
                                    <img src="{$app_path}/grn/image/cybozu/approval_plan_step13.gif?{$build_date}" align="absmiddle">&nbsp;{cb_msg module='grn.workflow' key='colon_path_step' replace='true'}
                                    &nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/approval_plan_dispose13.gif?{$build_date}" align="absmiddle">&nbsp;{cb_msg module='grn.workflow' key='colon_processing' replace='true'}
                                    &nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/approval_plan_user13.gif?{$build_date}" align="absmiddle">&nbsp;{cb_msg module='grn.workflow' key='my_path_step' replace='true'}
                                </div>
                            </div>
                            <input type="hidden" name="fid" value="{$folder_id}">
                            {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                            {include file="grn/smart_word_multi_navi.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}
                            <table class="list_column">
                                <colgroup>
                                    <col width="11%">
                                    <col width="5%">
                                    <col width="20%">
                                    <col width="20%">
                                    <col width="12%">
                                    <col width="15%">
                                    <col width="12%">
                                </colgroup>
                                <tr>
                                    <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
                                    <th nowrap>
                                        {if $sort == 'pnu'}
                                            {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 reverse=1}
                                        {elseif  $sort == 'pnd'}
                                            {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnu' sp=0 sf=2}
                                        {else}
                                            {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 disable=1}
                                        {/if}
                                    </th>
                                    <th nowrap>
                                        {if $sort == 'fnu'}
                                            {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 reverse=1}
                                        {elseif $sort == 'fnd'}
                                            {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnu' sp=0 sf=2}
                                        {else}
                                            {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 disable=1}
                                        {/if}
                                    </th>
                                    <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
                                    <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
                                    <th nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
                                    <th nowrap>
                                        {if $sort == 'ctu'}
                                            {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 reverse=1}
                                        {elseif $sort == 'ctd'}
                                            {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctu' sp=0 sf=2}
                                        {else}
                                            {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 disable=1}
                                        {/if}
                                    </th>
                                </tr>
                                {if $folder_list.current_folder.count == 0}
                                    <tr>
                                        <td colspan="7">
                                            {$folder_list.current_folder.name}{cb_msg module='grn.workflow' key='no_application_in' replace='true'}
                                        </td>
                                    </tr>
                                {else}
                                    {foreach from=$folder_list.current_folder.folderrelation item=petition}
                                        <tr class="{cycle values='linetwo,lineone'}">
                                            <td nowrap>{$petition.petition_number|escape}</td>
                                            <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
                                            <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$petition.fid pid=$petition.ptid}</nobr></td>
                                            <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$petition.fid pid=$petition.ptid}</nobr></td>
                                            <td nowrap>
                                                {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
                                                    <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
                                                {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                                                    <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
                                                {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                    <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
                                                {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
                                                    <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
                                                {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
                                                    <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
                                                {/if}
                                            </td>
                                            <td nowrap>{grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}</td>
                                            <td nowrap>{if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}{grn_date_format date=$petition.ctime}{else}{grn_date_format date=$petition.mtime}{/if}</td>
                                        </tr>
                                    <tr class="{cycle values='linetwo,lineone'}">
                                        <td>&nbsp;</td>
                                        <td colspan="6" nowrap="nowrap">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="1" valign="top"><div class="approval_plan_state">{cb_msg module='grn.workflow' key='process_status' replace='true'}</div></td>
                                                    <td>
                                                        <div class="approval_plan_step">
                                                            {grn_workflow_pathstep_progress uid=$login.id path_steps=$petition.path_steps app_path=$app_path pid=$petition.ptid status=$petition.status puid=$petition.user_id}
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                   {/foreach}
                                {/if}
                            </table>
                            <div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$navi_info.navi}</nobr></div>
                        {else}
                            {* 最新・代理承認以外の一覧表示 *}
                            <form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                <input type="hidden" name="fid" value="{$folder_id}">
                                {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
                                {include file="grn/smart_word_multi_navi.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}

                                {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                    <div class="list_menu">
                                        <nobr>
                                            <span class="list_menu_item">{include file='workflow/checkall.tpl' elem_name="pids[]"}</span>
                                            <span>
                                                {grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}{grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi1" onclick="return false;"}
                                            </span>
                                        </nobr>
                                    </div>
                                {/if}

                                <table class="list_column">
                                    <colgroup>
                                        {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
                                            <col width="5%">
                                            <col width="11%">
                                            <col width="5%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="12%">
                                            <col width="15%">
                                        {else}
                                            <col width="5%">
                                            <col width="11%">
                                            <col width="5%">
                                            <col width="34%">
                                            <col width="33%">
                                        {/if}
                                        <col width="12%">
                                    </colgroup>
                                    <tr>
                                        <th nowrap></th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
                                        <th nowrap>
                                            {if $sort == 'pnu'}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='pnd' sp=0 sf=2 reverse=1}
                                                {else}
                                                   {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 reverse=1}
                                                {/if}
                                            {elseif  $sort == 'pnd'}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='pnu' sp=0 sf=2}
                                                {else}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnu' sp=0 sf=2}
                                                {/if}
                                            {else}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='pnd' sp=0 sf=2 disable=1}
                                                {else}
                                                    {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_list.current_folder.fid sort='pnd' sp=0 sf=2 disable=1}
                                                {/if}
                                            {/if}
                                        </th>
                                        <th nowrap>
                                            {if $sort == 'fnu'}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='fnd' sp=0 sf=2 reverse=1}
                                                {else}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 reverse=1}
                                                {/if}
                                            {elseif $sort == 'fnd'}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='fnu' sp=0 sf=2}
                                                {else}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnu' sp=0 sf=2}
                                                {/if}
                                            {else}
                                                {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='fnd' sp=0 sf=2 disable=1}
                                                {else}
                                                    {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_list.current_folder.fid sort='fnd' sp=0 sf=2 disable=1}
                                                {/if}
                                            {/if}
                                        </th>
                                        <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
                                        {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
                                            <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
                                            <th nowrap>{if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}{cb_msg module='grn.workflow' key='processor' replace='true'}{else}{cb_msg module='grn.workflow' key='item_type_5' replace='true'}{/if}</th>
                                            <th nowrap>
                                                {if $sort == 'ctu'}
                                                    {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='ctd' sp=0 sf=2 reverse=1}
                                                    {else}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 reverse=1}
                                                    {/if}
                                                {elseif $sort == 'ctd'}
                                                    {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='ctu' sp=0 sf=2}
                                                    {else}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctu' sp=0 sf=2}
                                                    {/if}
                                                {else}
                                                    {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid cid=$category_id sort='ctd' sp=0 sf=2 disable=1}
                                                    {else}
                                                        {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_list.current_folder.fid sort='ctd' sp=0 sf=2 disable=1}
                                                    {/if}
                                                {/if}
                                            </th>
                                        {else}
                                            <th nowrap>
                                                {if $sort == 'utu'}
                                                    {capture name='grn_workflow_key_28'}{cb_msg module='grn.workflow' key='key_28' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_key_28 page=$page_info.all fid=$folder_list.current_folder.fid sort='utd' sp=0 sf=2 reverse=1}
                                                {elseif $sort == 'utd'}
                                                    {capture name='grn_workflow_last_modified'}{cb_msg module='grn.workflow' key='last_modified' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_last_modified page=$page_info.all fid=$folder_list.current_folder.fid sort='utu' sp=0 sf=2}
                                                {else}
                                                    {capture name='grn_workflow_last_modified'}{cb_msg module='grn.workflow' key='last_modified' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_last_modified page=$page_info.all fid=$folder_list.current_folder.fid sort='utd' sp=0 sf=2 disable=1}
                                                {/if}
                                            </th>
                                        {/if}
                                    </tr>
                                    {if $folder_list.current_folder.count == 0}
                                        <tr>
                                            {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
                                                <td colspan="8">
                                            {else}
                                                <td colspan="6">
                                            {/if}
                                                {$folder_list.current_folder.name}{cb_msg module='grn.workflow' key='no_application_in' replace='true'}
                                            </td>
                                        </tr>
                                    {else}
                                        {foreach from=$folder_list.current_folder.folderrelation item=petition}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                <td nowrap>
                                                    {if GRN_WORKFLOW_FOLDER_TYPE_OUT_ID == $folder_list.current_folder.type}
                                                        {if (GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status && $petition.cancel_confirm) || GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status || GRN_WORKFLOW_STATUS_FINISHED == $petition.status || GRN_WORKFLOW_STATUS_REJECTION == $petition.status}
                                                            <input type="checkbox" name="pids[]" value="{$petition.ptid}">
                                                        {/if}
                                                    {elseif $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                                        <input type="checkbox" name="pids[]" value="{$petition.ptid}">
                                                    {/if}
                                                </td>
                                                <td nowrap>{$petition.petition_number|escape}</td>
                                                <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`"     truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$folder_id fid=$folder_list.current_folder.fid pid=$petition.ptid}</nobr></td>
                                                <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$folder_id fid=$folder_list.current_folder.fid pid=$petition.ptid}</nobr></td>
                                                {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
                                                    <td nowrap>
                                                        {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
                                                            <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
                                                            <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                            <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
                                                            <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
                                                        {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
                                                            <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
                                                        {/if}
                                                    </td>
                                                    {if $folder_list.current_folder.type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}
                                                        {* 送信一覧 *}
                                                        <td nowrap>
                                                            {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
                                                                {* 却下の場合（却下した人を表示） *}
                                                                {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name valid=$petition.transactor_valid truncated=$name_width users_info=$users_info}
                                                            {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}
                                                                {* 取り消し/取り戻しの場合（申請者を表示） *}
                                                                {grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}
                                                            {else}
                                                                {foreach from=$petition.transactor item=user}
                                                                    {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid truncated=$name_width users_info=$users_info}
                                                                {foreachelse}
                                                                    {if $petition.status == GRN_WORKFLOW_STATUS_REMAND}
                                                                        {grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}
                                                                    {else}
                                                                        {cb_msg module='grn.workflow' key='pass_along_only_bracket' replace='true'}
                                                                    {/if}
                                                                {/foreach}
                                                                {if $petition.transactor_num > $show_user_num}<span class="multiple_username"><span class="comma">,</span><span class="dots">{cb_msg module='grn.workflow' key='three_dots' replace='true'}</span></span>{/if}
                                                            {/if}
                                                        </td>
                                                    {else}
                                                        {* 受信一覧 *}
                                                        <td nowrap>{grn_user_name uid=$petition.user_id name=$petition.user_name valid=$petition.user_valid truncated=$name_width users_info=$users_info}</td>
                                                    {/if}
                                                {/if}
                                                <td nowrap>{if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}{grn_date_format date=$petition.ctime}{else}{grn_date_format date=$petition.mtime}{/if}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                </table>
                                {if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
                                    <div class="list_menu">
                                        <table>
                                            <tr>
                                                <td nowrap>
                                                    <span class="list_menu_item">{if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}{include file='workflow/checkall.tpl' elem_name="pids[]"}{/if}</span>
                                                    {grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi2" onclick="return false;"}&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                {/if}
                                <div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$navi_info.navi}</nobr></div>
                            </form>
                        {/if}
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</tbody>
</table>
<!--end of maincontents_list-->
{include file="grn/footer.tpl"}
