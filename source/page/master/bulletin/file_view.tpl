{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{if $file.modifiable || $file.deletable}
    <div id="main_menu_part">
        {if $file.modifiable}
            {if $file.locked == 'other'}
                <span class="aButtonStandard-grn button_disable_filter_grn"><button type="button" tabindex="0" title="{cb_msg module='grn.bulletin' key='GRN_BLLT-207' replace='true'}" aria-label="{cb_msg module='grn.bulletin' key='GRN_BLLT-207' replace='true'}" class="mRight10" aria-disabled="true">{cb_msg module='grn.bulletin' key='GRN_BLLT-207' replace='true'}</button></span>
            {else}
                {if $lockable && $file.locked != 'login'}
                    {include file="bulletin/_file_update.tpl" page='bulletin/file_update' cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id csrf_ticket=$csrf_ticket}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.bulletin' key='GRN_BLLT-208' replace='true'}" aria-label="{cb_msg module='grn.bulletin' key='GRN_BLLT-208' replace='true'}" class="mRight10" onclick="javascript:document.forms.form_file_update.submit();">{cb_msg module='grn.bulletin' key='GRN_BLLT-208' replace='true'}</button></span>
                {else}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.bulletin' key='GRN_BLLT-209' replace='true'}" aria-label="{cb_msg module='grn.bulletin' key='GRN_BLLT-209' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=bulletin/file_upload cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id}';">{cb_msg module='grn.bulletin' key='GRN_BLLT-209' replace='true'}</button></span>
                {/if}
            {/if}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_210'}{cb_msg module='grn.bulletin' key='GRN_BLLT-210' replace='true'}{/capture}{grn_link page='bulletin/file_modify' caption=$smarty.capture.grn_bulletin_GRN_BLLT_210 image='modify20.gif' cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id alt=''}</span>
        {/if}

        {if $file.deletable}
            {grn_delete title=$delete_file.title page=$delete_file.page data=$delete_file.data handler=$delete_file.handler}
            <span class="menu_item">{capture name='grn_bulletin_GRN_BLLT_211'}{cb_msg module='grn.bulletin' key='GRN_BLLT-211' replace='true'}{/capture}{grn_link page='bulletin/file_delete' caption=$smarty.capture.grn_bulletin_GRN_BLLT_211 image='delete20.gif' cid=$category_id aid=$article_id follow_id=$follow_id fid=$file.id id='lnk_delete' script='javascript:void(0)' alt=''}</span>
        {/if}
        {grn_image image='spacer20.gif'}
    </div>
    <!--menubar_end-->
{/if}
{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

{if $file.locked == 'other'}
    {if ! $is_admin}
        <div>{cb_msg module='grn.bulletin' key='GRN_BLLT-212' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-213' replace='true'}</div>
        <p>
    {else}
        {assign var="form_name" value=$smarty.template|basename}
        <form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/command_file_unlock'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="cid" value="{$category_id}">
            <input type="hidden" name="aid" value="{$article_id}">
            <input type="hidden" name="follow_id" value="{$follow_id}">
            <input type="hidden" name="fid" value="{$file.id}">
            <div>
                {cb_msg module='grn.bulletin' key='GRN_BLLT-214' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.bulletin' key='GRN_BLLT-215' replace='true'}
                <input type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-216' replace='true'}">
            </div>
        </form>
        <p>
    {/if}
{elseif $file.locked == 'login'}
    {assign var="form_name" value=$smarty.template|basename}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/command_file_unlock'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="cid" value="{$category_id}">
        <input type="hidden" name="aid" value="{$article_id}">
        <input type="hidden" name="follow_id" value="{$follow_id}">
        <input type="hidden" name="fid" value="{$file.id}">
        <div>
            {cb_msg module='grn.bulletin' key='GRN_BLLT-217' replace='true'}
            <input type="submit" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-218' replace='true'}">
        </div>
    </form>
    <p>
{/if}

{if ! $file.modifiable or ! $file.deletable}
    {assign var="no_restore" value=true}
{/if}
{include file="grn/file_view.tpl" download_page="bulletin/file_download" restore_page="bulletin/file_restore" linkparams=$linkparams name_width=$config.name_width}
{include file="grn/footer.tpl"}
