{if !$data_theme}{assign var='data_theme' value='c'}{/if}
{if !$file_dpage}{assign var='file_dpage' value='space/mobile/file_download'}{/if}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file='favour/mobile/_favour_common.tpl'}
<script language="JavaScript" text="text/javascript">
document.title = document.title+' - '+'{$discussion_obj->getTitle()|escape:javascript}';
</script>
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-style-grn">
    {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
    <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
        <li>
            {strip}
            {if $use_star}
                {include file="grn/mobile_star_init.tpl"}
                {grn_mobile_star_icon module=$module star_infos=$star_infos submdl=$sub_module unique_id=$discussion_obj->getId() spid=$space_id tid=$discussion_obj->getId()}
            {/if}
            <span>{$discussion_obj->getTitle()|escape}</span>
            {/strip}
        </li>
    </ul>
    {if $discussion_obj->getContent() || $attach_files}
        {if $discussion_obj->isUnread()}
            <div class="mobile-textspace-unread-grn">
        {else}
            <div class="mobile-textspace-div-grn">
        {/if}
        <span class="mobile-font-normal-grn">{if $discussion_obj->isRichText()}{$discussion_obj->getContent()|grn_mobile_link_format}{else}{grn_mobile_format body=$discussion_obj->getContent()}{/if}</span>
        {if $attach_files}
            <div class="mobile-attachmentButton-grn">
                {foreach from=$attach_files item=file}
                    {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage spid=$space_id tid=$discussion_obj->getId() fid=$file.id}
                {/foreach}
            </div>
        {/if}
                {include file="grn/mobile_comment_operating.tpl" deletable=false}
            </div>
    {/if}
</div>