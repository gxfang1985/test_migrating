
<div id="main_menu_part">
{if $file.modifiable}
 {if $file.locked == 'other'}
 <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-242' replace='true'}" disabled="true">
 {else}
  {if $lockable}
   {include file="bulletin/_file_update.tpl" page=$page_prefix|cat:"/file_update" cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id csrf_ticket=$csrf_ticket}
 <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-243' replace='true'}" onclick="javascript:document.forms.form_file_update.submit();">
  {else}
 <input type="button" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-244' replace='true'}" onclick="javascript:location.href='{grn_pageurl page=$page_prefix|cat:"/file_upload" cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id}';">
  {/if}
 {/if}
 <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_245'}{cb_msg module='grn.bulletin' key='GRN_BLLT-245' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/file_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_245 image='modify20.gif' cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id}</span>
{/if}
{if $file.deletable}
 {capture name='grn_bulletin_GRN_BLLT_246'}{cb_msg module='grn.bulletin' key='GRN_BLLT-246' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/file_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_246 image='delete20.gif' cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id}
{/if}
</div>
<!--menubar_end-->

{if $file.locked == 'other'}
 {if ! $file.deletable}
<p>
<div>{cb_msg module='grn.bulletin' key='GRN_BLLT-247' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-248' replace='true'}</div>
<p>
 {else}
  {assign var="form_name" value=$smarty.template|basename}
<p>
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_file_unlock'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid"       value="{$category_id}">
<input type="hidden" name="aid"       value="{$article_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="fid"       value="{$file.id}">
<div>{cb_msg module='grn.bulletin' key='GRN_BLLT-249' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-250' replace='true'}
<input type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-251' replace='true'}"></div></form>
<p>
 {/if}
{elseif $file.locked == 'login'}
<p>
 {assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_file_unlock'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid"       value="{$category_id}">
<input type="hidden" name="aid"       value="{$article_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="fid"       value="{$file.id}">
<div>{cb_msg module='grn.bulletin' key='GRN_BLLT-252' replace='true'}<input type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-253' replace='true'}"></div>
</form>
<p>
{/if}

{include file="grn/file_view.tpl" download_page=$page_prefix|cat:"/file_download" restore_page=$page_prefix|cat:"/file_restore" linkparams=$linkparams name_width=$config.name_width}
