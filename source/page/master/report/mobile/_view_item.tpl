{if $item.option_string_type == 1}{$item.option_string|escape}{/if}
{if $item.data_type == 'grn.report.checkbox'}
  {if $item.number == 1}
    <div class="mobile-checkIcon-grn"></div>
  {else}
    &nbsp;
  {/if}
{elseif $item.data_type == 'grn.report.numeric'}
  {$item.number|escape}
{elseif $item.data_type == 'grn.report.date'}
  {if $item.text.year != ''}
    {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-410' replace='true'}
  {else}
    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-411' replace='true'}
  {/if}
  {if $item.text.month != ''}
    {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-412' replace='true'}
  {else}
    &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-413' replace='true'}
  {/if}
  {if $item.text.day != ''}
    {$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-414' replace='true'}
  {else}
    &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-415' replace='true'}
  {/if}
{elseif $item.data_type == 'grn.report.time'}
  {grn_date_format date=$item.time}
{elseif $item.data_type == 'grn.report.file'}
  {if $attached_file_count > 0}
    <div class="mobile-attachmentButton-grn">
      {foreach name='attached_loop' from=$attached_file_list item=attached_file}
        {if $attached_file.table == GRN_REPORT_TABLE_FILERELATION}
          {grn_mobile_attach_file_link name=$attached_file.name dpage="report/mobile/file_download" fid=$attached_file.gfid rid=$report_id iid=$attached_file.iid}
        {else}
          <div style="text-align:center">
            <span class="ui-btn-inner ui-btn-corner-all">
              <span class="ui-btn-text">
                <span class="mobile-icon-attachment-left-grn"></span>
                <span class="mobile-font-normal-grn">{$attached_file.name|escape:"html"}</span>
              </span>
            </span>
          </div>
        {/if}
      {/foreach}
    </div>
  {else}
    &nbsp;
  {/if}
{elseif $item.data_type == 'grn.report.string_multiple'}
    {grn_mobile_format body=$item.text}
{else}
  {$item.text|escape}
{/if}
{if $item.option_string_type == 2}{$item.option_string|escape}{/if}