{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/component/mobile_attach_file.js"}
{if ! $file_div}{assign var='file_div' value=$form_name|cat:'_'|cat:'file'}{/if}
{if ! $attached_name}
  {assign var="attached_name" value="fids[]"}
{/if}
<div id="{$file_div}" class="mobile-attachmentArea-grn mobile-div-title-grn">
  {if $attached_files}
  <div>
    {foreach from=$attached_files key=fid item=file}
      <div id="afdiv{$fid|escape}" class="mobile_attachment_filename_grn">
        <input class="infile" type="hidden" name="{$attached_name}" value="{$fid}">
        <span style="margin:0,0,0,0;"><span class="mobile_images_s_file_grn"></span><span class="mobile_v_middle_grn">{$file.name|escape:"html"}</span></span>&nbsp;
        <a class="mobile_v_middle_grn" href="javascript:void(0);" onclick="grn.component.mobile_attach_file.attachedDelete('afdiv{$fid|escape}')"><span class="mobile_images_s_delete_grn"></span>{cb_msg module='grn.grn' key='GRN_GRN-926' replace='true'}</a>
      </div>
    {/foreach}
  </div>
  {/if}
  <div class="mobile-selectAttachment-grn">
    <span>
      {assign var='file_id' value=$file_div|cat:'_'|cat:'id'}
      <input type="file" id="{$file_id}" name="file_input" value="" class="mobile-buttonSelectAttachment-grn" onChange="grn.component.mobile_attach_file.onSelected(document.forms['{$form_name}'], this)" />
      <input type="hidden" name="upload_ticket" value="{$upload_ticket}" />
      <span class="mobile-contentSubButton-grn">
        <a id="attach_button" href="javascript:void(0);" data-role="button" class="mobile-attachmentButton-add-grn"></a>
      </span>
    </span>
  </div>
</div><!--attachmentArea-->
