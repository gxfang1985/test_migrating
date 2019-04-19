<nobr>
{if $no_account}
    {foreach name=folder_data from=$folder_list.data item=folder}
        {if $folder_list.selected == $folder.aid}
            {if $detail_mail}
                {grn_mail_select_folders class="selectStandard-grn mLeft10 mRight10" select_name=$c_name select_id=$c_id account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder show_another_account=$show_another_account root_caption_key=$root_caption_key disabled=$disabled exception_value=$exception_value exception_item=$exception_item default_selected=$default_selected onchange="cmd.value='move';submit(this.form)"}
            {else}
                {grn_mail_select_folders class="selectStandard-grn" select_name=$c_name select_id=$c_id account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder show_another_account=$show_another_account root_caption_key=$root_caption_key disabled=$disabled exception_value=$exception_value exception_item=$exception_item default_selected=$default_selected onchange="if(!grn_is_checked_mail(this.form, '$ids')) return false;cmd.value='move';submit(this.form)"}
            {/if}
        {/if}
    {/foreach}
{elseif $change_off}
    <div>
        {grn_image image='mailaccount20.gif'}
        {grn_select name=$a_name options=$user_account onchange="changeAccount2(this,'change_folder_','','said')" disabled=$disabled}
    </div>
    <div>
        {grn_image image="folder20.gif"}
        {foreach name=folder_data from=$folder_list.data item=folder}
            {if $folder_list.selected == $folder.aid}
                <span id="change_folder_{$folder.aid}">{grn_mail_select_folders select_name=$c_name|cat:$folder.aid account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder onchange="changeDataWM(this,'shid')" root_caption_key=$root_caption_key disabled=$disabled}</span>
            {else}
                <span id="change_folder_{$folder.aid}" style="display:none">{grn_mail_select_folders select_name=$c_name|cat:$folder.aid account_id=$folder.aid selected_folder_id=$category.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder onchange="changeDataWM(this,'shid')" root_caption_key=$root_caption_key disabled=$disabled}{if $moveon}{cb_msg module='grn.mail' key='GRN_MAIL-379' replace='true'}{/if}</span>
            {/if}
        {/foreach}
    </div>
    {if $moveon}
        {if $ids}
            {capture name='grn_mail_GRN_MAIL_380'}{cb_msg module='grn.mail' key='GRN_MAIL-380' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_380 onclick="if( ! grn_is_checked( this.form, '$ids' ) ) return false;cmd.value='move';"}
        {else}
            {capture name='grn_mail_GRN_MAIL_381'}{cb_msg module='grn.mail' key='GRN_MAIL-381' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_381 onclick="cmd.value='move';"}
        {/if}
    {/if}
{else}
    <div>
        {grn_image image='mailaccount20.gif'}
        {grn_select name=$a_name options=$user_account onchange="changeAccount(this,'change_folder_','$c_name')" disabled=$disabled}
    </div>
    <div>
        {grn_image image="folder20.gif"}
        {foreach name=folder_data from=$folder_list.data item=folder}
            {if $folder_list.selected == $folder.aid}
                <span id="change_folder_{$smarty.foreach.folder_data.iteration}">{grn_mail_select_folders select_name=$c_name account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder root_caption_key=$root_caption_key disabled=$disabled}{if $moveon}{cb_msg module='grn.mail' key='GRN_MAIL-382' replace='true'}{/if}</span>
            {else}
                <span id="change_folder_{$smarty.foreach.folder_data.iteration}" style="display:none">{grn_mail_select_folders select_name=$c_name|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid selected_folder_id=$category.cid hide_root_folder=$hide_root_folder hide_garbage_folder=$hide_garbage_folder hide_normal_folder=$hide_normal_folder root_caption_key=$root_caption_key disabled=$disabled}{if $moveon}{cb_msg module='grn.mail' key='GRN_MAIL-383' replace='true'}{/if}</span>
            {/if}
        {/foreach}
    </div>
    {if $moveon}
        {if $ids}
            {capture name='grn_mail_GRN_MAIL_384'}{cb_msg module='grn.mail' key='GRN_MAIL-384' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_384 onclick="if( ! grn_is_checked( this.form, '$ids' ) ) return false;cmd.value='move';"}
        {else}
            {capture name='grn_mail_GRN_MAIL_385'}{cb_msg module='grn.mail' key='GRN_MAIL-385' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_385 onclick="cmd.value='move';"}
        {/if}
    {/if}
{/if}
</nobr>
