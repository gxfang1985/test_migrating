{if ! $workflow_unvisible}
{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
 {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
 {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="fontsize" value='font-size:60%;'}
{else}
 {assign var="fontsize" value='font-size:80%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='workflow/index' fid=$settings.folder.fid}">
                    <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_16' replace='true'}</span>
                    {$settings.folder.name|escape}
                    <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_17' replace='true'}</span>
                </a>
                {if $portlet.name}
                    {assign var="title" value=$portlet.name}
                {else}
                    {assign var="title" value=$portlet.title}
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_workflow_grn">
<table class="list_column" style="{$font_size}">
 <colgroup>
{if $settings.number}
     <col width="11%">
{/if}
{if $settings.priority}
     <col width="10%">
{/if}
     <col width="20%">
     <col width="15%">
{if $folder_list.current_folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
{if $settings.status}
     <col width="12%">
{/if}
{if $settings.transactor}
     <col width="15%">
{/if}
{/if}
{if $settings.time}
     <col width="12%">
{/if}
 </colgroup>
 <tr>
 {if $settings.number}
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_18' replace='true'}</th>
 {/if}
 {if $settings.priority}
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_19' replace='true'}</th>
 {/if}
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_20' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_21' replace='true'}</th>
 {if $settings.folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
  {if $settings.status}
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_22' replace='true'}</th>
  {/if}
  {if $settings.transactor}
  <th nowrap>{if $settings.folder.type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_23' replace='true'}{else}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_24' replace='true'}{/if}</th>
  {/if}
 {/if}
 {if $settings.time}
  <th nowrap>{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_25' replace='true'}</th>
 {/if}
 </tr>
 {foreach from=$settings.folder.folderrelation item=petition}
 <tr>
 {if $settings.number}
  <td nowrap>{$petition.petition_number}</td>
 {/if}
 {if $settings.priority}
  <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
 {/if}
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$petition.fid pid=$petition.ptid}</nobr></td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.petition_name`" truncated_caption=$subject_width fid=$petition.fid pid=$petition.ptid}</nobr></td>
 {if $settings.folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}
  {if $settings.status}
  <td nowrap>
   {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
   <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_26' replace='true'}</span></span>
   {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
   <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_27' replace='true'}</span></span>
   {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_28' replace='true'}</span></span>
   {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
   <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_29' replace='true'}</span></span>
   {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
   <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_30' replace='true'}</span></span>
   {/if}
   </td>
  {/if}
  {if $settings.transactor}
   {if $settings.folder.type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}
   {* 送信一覧 *}
  <td nowrap>
    {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
     {* 却下の場合（却下したを表示） *}
{grn_user_name uid=$petition.transactor_id name=$petition.transactor_name truncated=$name_width valid=$petition.transactor_valid users_info=$users_info}
    {elseif $petition.status == GRN_WORKFLOW_STATUS_REMAND || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}
     {* 差し戻し/取り消し/取り戻しの場合（申請者を表示） *}
{grn_user_name uid=$petition.user_id name=$petition.user_name truncated=$name_width valid=$petition.user_valid users_info=$users_info}
    {else}
    {foreach from=$petition.transactor item=user}
{grn_user_name uid=$user._id name=$user.col_display_name truncated=$name_width valid=$user.col_valid users_info=$users_info}
    {foreachelse}
{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_31' replace='true'}
    {/foreach}
     {if $petition.transactor_num > $show_user_num}<span class="multiple_username"><span class="comma">,</span><span class="dots">{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_32' replace='true'}</span></span>{/if}
    {/if}
  </td>
   {else}
   {* 受信一覧 *}
  <td nowrap>{grn_user_name uid=$petition.user_id name=$petition.user_name truncated=$name_width valid=$petition.user_valid users_info=$users_info}</td>
   {/if}
  {/if}
 {/if}
 {if $settings.time}
  <td nowrap>{if $settings.folder.type != GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID}{grn_date_format date=$petition.ctime}{else}{grn_date_format date=$petition.mtime}{/if}</td>
 {/if}
</tr>
 {/foreach}
</table>
{/if}
</div> <!--end of portal_frame -->
