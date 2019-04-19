{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$report_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{if ! $page_prefix}{assign var='page_prefix' value='report/system'}{/if}
{if ! $form}{assign var='disable_form' value=true}{/if}

{* メニュー、通知メッセージ *}
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_188'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-188' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/modify' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_188 image='modify20.gif' cid=$category_id fid=$form_id rid=$report_id}</span>
 <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_189'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-189' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/notification_modify' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_189 image='user20.gif' cid=$category_id fid=$form_id rid=$report_id}</span>
 <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_190'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-190' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/accessory' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_190 image='file20.gif' cid=$category_id fid=$form_id rid=$report_id}</span>
 <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_191'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-191' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_191 page=$page_prefix|cat:'/print' image='print20.gif' cid=$category_id fid=$form_id rid=$report_id}</span>
 <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_192'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-192' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/report_delete' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_192 image='delete20.gif' cid=$category_id fid=$form_id rid=$report_id}</span>
</div>

<table class="margin_top">
 <tr>
  <td nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-193' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-194' replace='true'}&nbsp;</td>
  <td>{grn_user_name uid=$report.creator name=$report.creator_name}&nbsp;{grn_date_format date=$report.ctime format="DateTimeMiddle_YMDW_HM"}</td>
 </tr>
 {if $report.modifier neq ''}
 <tr>
  <td nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-195' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-196' replace='true'}&nbsp;</td>
  <td>{grn_user_name uid=$report.modifier name=$report.modifier_name}&nbsp;{grn_date_format date=$report.mtime format="DateTimeMiddle_YMDW_HM"}</td>
 </tr>
 {/if}
 <tr valign="top">
  <td nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-199' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-200' replace='true'}&nbsp;</td>
  <td>{if $report.private}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-202' replace='true'}{else}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-201' replace='true'}{/if}</td>
 </tr>
 <tr valign="top">
  <td nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-197' replace='true'}</td><td>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-198' replace='true'}&nbsp;</td>
  <td>
  {grn_report_notification users=$notificationUsers}
   <small><div>
    {capture name='grn_report_detail'}{cb_msg module='grn.report' key='detail' replace='true'}{/capture}{grn_link page='report/system/detail' caption=$smarty.capture.grn_report_detail image='detail20.gif' rid=$report_id}
   </div></small>
  </td>
 </tr>
</table>

<hr>
{include file='report/_view.tpl' event_id=$event_id event=$event event_date=$event_date is_creator=true report=$report members=$members partners=$partners item_data_list=$item_data_list draft=false system=true}

<p></p>

<hr>

{if $follow_list}
 <hr>
 <a name="follow"></a>
 {* N件ナビゲーション *}
 {include file="grn/word_navi.tpl" navi=$navi.navi}
 <hr>
 {foreach from=$follow_list item=follow}
  <div>
   <table width="100%">
    <tr>
     <td width="50%" nowrap>{$follow.follow_id|escape}&nbsp;:{grn_user_name uid=$follow.creator name=$follow.creator_name users_info=$users_info}&nbsp;{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</td>
     <td width="50%" nowrap>{capture name='grn_report_system_GRN_RPRT_SY_207'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-207' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/follow_delete' cid=$category_id fid=$form_id rid=$report_id follow_id=$follow.id image='delete20.gif' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_207}</td>
    </tr>
   </table>
  <div class="margin_vert">
  {if $follow.html}
        {$follow.html|grn_noescape}
  {else}
        {if $enable_follow_autolink}
            {grn_format body=$follow.data report_follow_autolink=$report_id cid=$category_id}
        {else}
            {grn_format body=$follow.data}
        {/if}
  {/if}
  </div>
  {if $follow.attach_files}
   <tt>
   {foreach from=$follow.attach_files item=file}
    {grn_attach_file_link fid=$file.file dpage=$page_prefix|cat:"/file_download" vpage=$page_prefix|cat:"/file_view" name=$file.file_info.name size=$file.file_info.size mime=$file.file_info.mime cid=$category_id frm=$form_id rid=$report_id follow_id=$file.follow inline=$input_config.inline hash=$file.file_info.hash}<br>
   {/foreach}
   </tt>
  {/if}
 </div>
 <hr>
 {/foreach}
 {include file="grn/word_navi.tpl" navi=$navi.navi}
{/if}

{include file="grn/system_footer.tpl"}
