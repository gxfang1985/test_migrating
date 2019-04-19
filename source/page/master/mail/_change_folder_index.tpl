{if $no_account}
    {foreach name=folder_data from=$folder_list.data item=folder}
        {if $folder_list.selected == $folder.aid}
            {grn_mail_select_folders class="selectStandard-grn" select_name=$c_name select_id=$c_id account_id=$folder.aid selected_folder_id=$folder.cid hide_root_folder=$hide_root_folder hide_normal_folder=$hide_normal_folder show_another_account=$show_another_account root_caption_key=$root_caption_key disabled=$disabled exception_value=$exception_value exception_item=$exception_item button_select=$button_select default_selected=$default_selected onchange="if(!grn_is_checked_mail(this.form, '$ids')) return false;cmd.value='move';submit(this.form)"}
        {/if}
    {/foreach}
{/if}