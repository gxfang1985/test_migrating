{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_delete title=$delete_file.title page=$delete_file.page handler=$delete_file.handler data=$delete_file.data}
<!--menubar-->
{if ! $auth.write}{assign var="link_disabled" value=1}{/if}
<div id="main_menu_part">
    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.bulletin' key='GRN_BLLT-285' replace='true'}" aria-label="{cb_msg module='grn.bulletin' key='GRN_BLLT-285' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=bulletin/draft_file_upload aid=$article_id fid=$file.id}';">{cb_msg module='grn.bulletin' key='GRN_BLLT-285' replace='true'}</button></span>
    <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_286'}{cb_msg module='grn.bulletin' key='GRN_BLLT-286' replace='true'}{/capture}{grn_link page='bulletin/draft_file_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_286 image='modify20.gif' aid=$article_id fid=$file.id alt=''}</span>
    <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_287'}{cb_msg module='grn.bulletin' key='GRN_BLLT-287' replace='true'}{/capture}{grn_link page='bulletin/draft_file_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_287 image='delete20.gif' aid=$article_id fid=$file.id id='lnk_delete' script='javascript:void(0);' alt=''}</span>
</div>
<!--menubar_end-->
{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}
{include file="grn/file_view.tpl" download_page="bulletin/draft_file_download" restore_page="bulletin/draft_file_restore" linkparams=$linkparams auth=$auth}
{include file="grn/footer.tpl"}
