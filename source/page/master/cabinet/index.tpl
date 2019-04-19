{include file="grn/head.tpl"}
{include file="grn/header_no_siteposition.tpl"}

{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
{if $folder_id != 1}
    {if ! $folder_page}{assign var='folder_page' value=$page_info.all}{/if}
    {grn_site_position_category page=$folder_page positions=$folder}
{else}
    {include file="cabinet/_title_search.tpl"}
{/if}

{grn_load_javascript file="grn/html/download.js"}

<div class="mainarea">
    <div id="menu_part">
        <!--menubar-->
        <div id="smart_main_menu_part" >
            {if $folder.auth.write}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_193'}{cb_msg module='grn.cabinet' key='GRN_CAB-193' replace='true'}{/capture}{grn_link page="cabinet/add" caption=$smarty.capture.grn_cabinet_GRN_CAB_193 image="write20.gif" hid=$folder_id s_hid=$folder_id}</span>
            {/if}
            {if $folder_id}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_194'}{cb_msg module='grn.cabinet' key='GRN_CAB-194' replace='true'}{/capture}{grn_link page="cabinet/subscribe" caption=$smarty.capture.grn_cabinet_GRN_CAB_194 image="subscribe20.png" hid=$folder_id}</span>
                <span class="menu_item"><nobr><a href="javascript:;" onclick="__bundleDownLoad.showBundleDownloadWindow();">{grn_image image='downloadmore20.gif'}{cb_msg module='grn.grn' key='grn.download.bundle.download' replace='true'}</a></nobr> &nbsp; </span> &nbsp;
            {else}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_195'}{cb_msg module='grn.cabinet' key='GRN_CAB-195' replace='true'}{/capture}{grn_link page="cabinet/subscribe" caption=$smarty.capture.grn_cabinet_GRN_CAB_195 image="subscribe20.png" hid=$folder_id disabled=1}</span>
            {/if}
            <span class="menu_item">
                {include file='cabinet/_display_options.tpl'}
            </span>
        </div>
        <div id="smart_rare_menu_part">
            {if $use_fts}
                <form class="clearFix-cybozu" method="get" action="{grn_pageurl page='cabinet/search'}">
                    <input type="hidden" name="hid" value="{$folder_id}">
                    {include file='fts/_search_box.tpl'}
                </form>
            {else}
                <div align="right" valign="bottom" nowrap>
                    {capture name='grn_cabinet_GRN_CAB_62'}{cb_msg module='grn.cabinet' key='GRN_CAB-62' replace='true'}{/capture}{grn_simple_search caption=$app_name|cat:$smarty.capture.grn_cabinet_GRN_CAB_62 name='text' action='cabinet/search' page='cabinet/search' hid=$folder.hid s_hid=$folder.hid}
                </div>
            {/if}
        </div>
    </div>

    {include file='cabinet/_file_list.tpl' is_index=true}
    {include file='grn/_download.tpl' files=$files filename=$folder.name app='grn.cabinet'}

{include file="grn/footer.tpl"}
