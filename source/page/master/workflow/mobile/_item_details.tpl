{foreach from=$item_data_list item=item_data_line}
  {if $item_data_line.type == 2}
  <div class="mobile-list-todoDetail-grn">
    <div class="mobile-label-small-grn"></div>
    <div class="mobile_contents_detail_grn"></div>
  </div>
  <div class="mobile-separation-grn"></div>
  {else}
  <div class="mobile-list-todoDetail-grn">
    <div class="mobile-label-small-grn">{$item_data_line.display_name|escape}</div>
    {if $item_data_line.mobile_view_mode == 'edit'}
      <div class="mobile_editable_grn">{cb_msg module='grn.workflow.mobile' key='editinfo' replace='true'}</div>
    {/if}
    {if $item_data_line.foreign_key == 'grn.workflow.file' && $item_data_line.view_mode != 'disable'}
      <div class="mobile_contents_detail_grn">
        {include file='workflow/mobile/_attachment.tpl' item_data_line=$item_data_line}
      </div>
    {else}
      <div class="mobile_contents_detail_grn {if $item_data_line.foreign_key == 'grn.workflow.checkbox'} mobile_wf_checkarea_grn {/if}">
        {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$item_data_line.iid item=$item_data_line display="view" is_mobile=true}
      </div>
    {/if}
    {if $item_data_line.sub_item_data_count > 0}
      {foreach from=$item_data_line.sub_item_data_list item=sub_item_data}
        {if $sub_item_data.mobile_view_mode == 'edit'}
          <div class="mobile_editable_grn">{cb_msg module='grn.workflow.mobile' key='editinfo' replace='true'}</div>
        {/if}
        {if $sub_item_data.foreign_key == 'grn.workflow.file' && $sub_item_data.view_mode != 'disable'}
          <div class="mobile_contents_detail_grn">
            {include file='workflow/mobile/_attachment.tpl' item_data_line=$sub_item_data}
          </div>
        {else}
          <div class="mobile_contents_detail_grn {if $sub_item_data.foreign_key == 'grn.workflow.checkbox'} mobile_wf_checkarea_grn {/if}">
            {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$sub_item_data.iid item=$sub_item_data display="view" is_mobile=true}
          </div>
        {/if}
      {/foreach}
    {/if}
    </div>
  <div class="mobile-separation-grn"></div>
  {/if}
{/foreach}