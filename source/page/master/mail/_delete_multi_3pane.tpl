<div id="mail_delete_multi_content" style="display: none">
  <p>
  {if $category.type neq '4'}
    {if $delete_info_multi.use_garbagebox eq '1'}
      {cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}<br>
    {else}
      {cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}<br>
    {/if}
  {else}
    {cb_msg module='grn.mail' key='GRN_MAIL-213' replace='true'}<br>
  {/if}
  <br>
  {cb_msg module='grn.mail' key='GRN_MAIL-214' replace='true'}<span class="bold">{grn_mail_get_folder_name folder_id=$category.cid}</span><br>
  {cb_msg module='grn.mail' key='GRN_MAIL-215' replace='true'}<span class="bold delete_count"></span><br>
  </p>
  <span style="display: none" id="mail_delete_multi_title">{$delete_info_multi.title}</span>
</div>