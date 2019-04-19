{assign var='length' value=$item_data_line.files|@count}
{if $length > 0}
  {foreach from=$item_data_line.files item=attachment}
    <div class="mobile-attachmentButton-grn">
    {if $attachment.table == GRN_WORKFLOW_TABLE_ITEMDATAFILE}
      {grn_mobile_attach_file_link name=$attachment.name dpage='workflow/file_download' fid=$fid pid=$pid ifid=$attachment.ifid}
    {else}
      {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
      {grn_image image=$file_image}{$attachment.name|escape:"html"}
    {/if}
    </div>
  {/foreach}
{/if}