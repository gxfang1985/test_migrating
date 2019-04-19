<div id="mail_delete_all_content" style="display: none">
  <p>
  {if $delete_info_all.category.type eq '4' and $delete_info_all.use_garbagebox eq '0'}
    {cb_msg module='grn.mail' key='GRN_MAIL-405' replace='true'}<br>
  {else}
    {cb_msg module='grn.mail' key='GRN_MAIL-386' replace='true'}<br>
  {/if}
  <br>
  <span class="bold">{grn_mail_get_folder_name folder_id=$delete_info_all.category.cid truncated_caption=$delete_info_all.truncate_len}</span><br>
  {if $delete_info_all.category.child}
    <p>{cb_msg module='grn.mail' key='GRN_MAIL-387' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-388' replace='true'}</p>
    <p>{capture name='grn_mail_GRN_MAIL_389'}{cb_msg module='grn.mail' key='GRN_MAIL-389' replace='true'}{/capture}{grn_checkbox name='subfolder' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_GRN_MAIL_389}</p>
  {/if}
  <span style="display: none" id="mail_delete_all_title">{$delete_info_all.title}</span>
</div>