{strip}
{capture name='grn_mail_GRN_MAIL_439'}{cb_msg module='grn.mail' key='GRN_MAIL-439' replace='true'}{/capture}
{foreach name=folder_data from=$folder_list.data item=folder}
  {if $folder_list.selected == $folder.aid}
    {grn_mail_select_folders three_pane=1 button_select='true' select_id='menu_dropdown_folder_move' account_id=$folder.aid hide_root_folder='true' show_another_account=$show_another_account exception_item=$smarty.capture.grn_mail_GRN_MAIL_439}
  {/if}
{/foreach}
{/strip}