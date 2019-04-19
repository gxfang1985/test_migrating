{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
   <table class="layout">
    <tr>
    {if $item.attach_file_view == 0 || ($item.attach_file == 0 && $attached_file_count <= 0 )}
     <td nowrap><font color="blue">{cb_msg module='grn.workflow' key='key_21_1' replace='true'}</font></td>
    {else}
         {if $item.br != 1}&nbsp;<td nowrap>{$item.separator|escape}&nbsp;</td>{/if}
        {if $item.option_string_type == 1}<td nowrap>{$item.option_string|escape}&nbsp;</td>{/if}
     <td nowrap>
        {capture name="input_name"}item_{$item.iid}_file{/capture}
        {capture name="box"}item_{$item.iid}_fbox{/capture}
        {capture name="box_prefix"}item_{$item.iid}_fdiv{/capture}
        {capture name="link_name"}item_{$item.iid}_link{/capture}
        {assign var="input_name" value=$smarty.capture.input_name}
        {assign var="box" value=$smarty.capture.box}
        {assign var="box_prefix" value=$smarty.capture.box_prefix}
        {assign var="link_name" value=$smarty.capture.link_name}
        {assign var="max_file_count" value=$settings.max_files}
        {if $item.attach_file == 0}
            {assign var="file_read_only" value=true}
        {else}
            {assign var="file_read_only" value=false}
        {/if}    
        {if $item.required == 1}
            {assign var='required' value=true}
            {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
        {else}
             {assign var='required' value=false}
        {/if}
        {capture name=validate_max_files}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='exceeding_maximum_file_number' replace='true'}{/capture}
        {validate form=$form_name field=$input_name criteria="grn_workflow_isRangeMax" max=$settings.max_files empty=true message=$smarty.capture.validate_max_files append="validation_errors"}
        {include file="workflow/_attach_file.tpl" attached_file_list=$attached_file_list attached_file_count=$attached_file_count disable_return_key=true attach_file_disabled=$attach_file_disabled file_read_only=$file_read_only}
     </td>
        {if $item.option_string_type == 2}<td nowrap>{$item.option_string|escape}</td>{/if}
    {/if}
    </tr>
   </table>
  </td>
{elseif $view_mode == 'print'}

    {if $item.view_mode_print}
        {if $item.view_mode_print == 'disable'}
            <td class="{$item_class}" nowrap>&nbsp;</td>
        {else}
            <td class="{$item_class}">
            {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
            {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
            {if $attached_file_count > 0 || $change_access}
                {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
                {if 'print' == $view_mode}
                    {assign var=image value=null}
                    {assign var=disabled value=true}
                {else}
                    {assign var=image value='disk20.gif'}
                {/if}
                {foreach name='attached_loop' from=$attached_file_list item=attached_file}
                    {if $attached_file.table == GRN_WORKFLOW_TABLE_ITEMDATAFILE}
                        {if $display == 'view'}
                            {if $settings.inline == 1}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled cid=$cid hash=$attached_file.hash}<br>
                            {else}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid image=$image disabled=$disabled cid=$cid}<br>
                            {/if}
                        {elseif $display == 'view-system'}<br>
                            {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                            {if $settings.inline == 1}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                            {else}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                            {/if}
                        {elseif $display == 'view-operation'}<br>
                            {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                            {if $settings.inline == 1}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                            {else}
                                {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                            {/if}
                        {/if}
                    {else}
                        {grn_image image=$file_image}{$attached_file.name|escape:"html"}<br>
                    {/if}
                {/foreach}
            {/if}
            {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
            </td>
        {/if}
    {else}
    <td class="{$item_class}">
    {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {if $attached_file_count > 0 || $change_access}
        {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
        {if 'print' == $view_mode}
            {assign var=image value=null}
            {assign var=disabled value=true}
        {else}
            {assign var=image value='disk20.gif'}
        {/if}
        {foreach name='attached_loop' from=$attached_file_list item=attached_file}
            {if $attached_file.table == GRN_WORKFLOW_TABLE_ITEMDATAFILE}
                {if $display == 'view'}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled cid=$cid hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid image=$image disabled=$disabled cid=$cid}<br>
                    {/if}
                {elseif $display == 'view-system'}<br>
                    {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                    {/if}
                {elseif $display == 'view-operation'}<br>
                    {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                    {/if}
                {/if}
            {else}
                {grn_image image=$file_image}{$attached_file.name|escape:"html"}<br>
            {/if}
        {/foreach}
        {if $change_access}
            {if $change_access.col_view == 1}
                {capture name="input_name"}item_{$item.iid}_file{/capture}
                {capture name="box"}item_{$item.iid}_fbox{/capture}
                {capture name="box_prefix"}item_{$item.iid}_fdiv{/capture}
                {capture name="link_name"}item_{$item.iid}_link{/capture}
                {assign var="input_name" value=$smarty.capture.input_name}
                {assign var="box" value=$smarty.capture.box}
                {assign var="box_prefix" value=$smarty.capture.box_prefix}
                {assign var="link_name" value=$smarty.capture.link_name}
                {assign var="max_file_count" value=$settings.max_files}
                {assign var=attached_file_list value=false}
                {include file="workflow/_attach_file.tpl" attached_file_list=$attached_file_list attached_file_count=$attached_file_count disable_return_key=true}
            {/if}
        {/if}
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
  {/if}
{elseif $display == 'view-confirm'}
    {if $item.attach_file_view == 0 && $item.type != 1}
        <td class="{$item_class}" nowrap><font color="blue">&nbsp;</font></td>
    {else}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $attached_file_count > 0}
            {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
            {assign var=image value='disk20.gif'}
            {foreach name='attached_loop' from=$attached_file_list item=attached_file key=tmp_file_key}
                {grn_attach_file_link_no_view name=$attached_file.name dpage="workflow/file_download" iid= $item.iid tmp_file_key=$tmp_file_key tmp_key=$tmp_key  image=$image disabled=$disabled}<br>
            {/foreach}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
    {/if}
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $attached_file_count > 0}
            {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
            {assign var=image value='disk20.gif'}
            {foreach name='attached_loop' from=$attached_file_list item=attached_file}
                {if $attached_file.table == GRN_WORKFLOW_TABLE_ITEMDATAFILE}
                    {if $display == 'view'}
                        {if $settings.inline == 1}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled cid=$cid hash=$attached_file.hash}<br>
                        {else}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid image=$image disabled=$disabled cid=$cid}<br>
                        {/if}
                    {elseif $display == 'view-system'}<br>
                        {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                        {if $settings.inline == 1}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                        {else}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                        {/if}
                    {elseif $display == 'view-operation'}<br>
                        {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                        {if $settings.inline == 1}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                        {else}
                            {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                        {/if}
                    {/if}
                {else}
                    {grn_image image=$file_image}{$attached_file.name|escape:"html"}<br>
                {/if}
            {/foreach}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
         <table class="layout">
          <tr>
        {if $item.br != 1}&nbsp;<td nowrap>{$item.separator|escape}&nbsp;</td>{/if}
        {if $item.option_string_type == 1}<td nowrap>{$item.option_string|escape}&nbsp;</td>{/if}
          <td nowrap>
        {capture name="input_name"}item_{$item.iid}_file{/capture}
        {capture name="box"}item_{$item.iid}_fbox{/capture}
        {capture name="box_prefix"}item_{$item.iid}_fdiv{/capture}
        {capture name="link_name"}item_{$item.iid}_link{/capture}
        {assign var="input_name" value=$smarty.capture.input_name}
        {assign var="box" value=$smarty.capture.box}
        {assign var="box_prefix" value=$smarty.capture.box_prefix}
        {assign var="link_name" value=$smarty.capture.link_name}
        {assign var="max_file_count" value=$settings.max_files}
        {if $item.required == 1}
        {assign var='required' value=true}
            {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
            {validate form=$form_name field=$input_name criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
        {else}
             {assign var='required' value=false}
        {/if}
        {capture name=validate_max_files}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='exceeding_maximum_file_number' replace='true'}{/capture}
        {validate form=$form_name field=$input_name criteria="grn_workflow_isRangeMax" max=$settings.max_files empty=true message=$smarty.capture.validate_max_files append="validation_errors"}
        {include file="workflow/_attach_file.tpl" attached_file_list=$attached_file_list attached_file_count=$attached_file_count disable_return_key=true isViewable=true}
          </td>
        {if $item.option_string_type == 2}<td nowrap>{$item.option_string|escape}</td>{/if}
          </tr>
         </table>
        </td>
    {elseif $item.view_mode == 'disable'}
        <td class="{$item_class}" nowrap>&nbsp;</td>
    {/if}
{else}
    {if $item.br != 1 || $item.sub_item_data_count > 0}
        {assign var=sub_item_style value='width:auto;'}
    {else}
        {assign var=sub_item_style value=''}
    {/if}
  <td class="{$item_class}">
   <table class="layout">
    <tr>
    {if $item.br != 1 && $item.separator != ''}<td nowrap style="{$sub_item_style}">&nbsp;{$item.separator|escape}&nbsp;</td>{/if}
    {if $item.option_string_type == 1}<td nowrap style="{$sub_item_style}">{$item.option_string|escape}</td>{/if}
    {if $attached_file_count > 0 || $change_access}
     <td nowrap style="{$sub_item_style}">
        {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
        {if 'print' == $view_mode}
            {assign var=image value=null}
            {assign var=disabled value=true}
        {else}
            {assign var=image value='disk20.gif'}
        {/if}
        {foreach name='attached_loop' from=$attached_file_list item=attached_file}
            {if $attached_file.table == GRN_WORKFLOW_TABLE_ITEMDATAFILE}
                {if $display == 'view'}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled cid=$cid hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/file_download" vpage="workflow/file_view" size=$attached_file.size mime=$attached_file.mime fid=$folder_id pid=$petition_id ifid=$attached_file.ifid image=$image disabled=$disabled cid=$cid}<br>
                    {/if}
                {elseif $display == 'view-system'}<br>
                    {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/system/file_download" vpage="workflow/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                    {/if}
                {elseif $display == 'view-operation'}<br>
                    {if $category_id == NULL}{assign var=category_id value=$cid}{/if}
                    {if $settings.inline == 1}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}<br>
                    {else}
                        {grn_attach_file_link name=$attached_file.name dpage="workflow/operation/file_download" vpage="workflow/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id pid=$petition_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}<br>
                    {/if}
                {/if}
            {else}
                {grn_image image=$file_image}{$attached_file.name|escape:"html"}<br>
            {/if}
        {/foreach}
        {if $change_access}
            {if $change_access.col_edit == 1}
                {capture name="input_name"}item_{$item.iid}_file{/capture}
                {capture name="box"}item_{$item.iid}_fbox{/capture}
                {capture name="box_prefix"}item_{$item.iid}_fdiv{/capture}
                {capture name="link_name"}item_{$item.iid}_link{/capture}
                {assign var="input_name" value=$smarty.capture.input_name}
                {assign var="box" value=$smarty.capture.box}
                {assign var="box_prefix" value=$smarty.capture.box_prefix}
                {assign var="link_name" value=$smarty.capture.link_name}
                {assign var="max_file_count" value=$settings.max_files}
                {assign var=attached_file_list value=false}
                {include file="workflow/_attach_file.tpl" attached_file_list=$attached_file_list attached_file_count=$attached_file_count disable_return_key=true}
            {/if}
        {/if}
     </td>
    {/if}
    {if $item.option_string_type == 2}<td nowrap style="{$sub_item_style}">{$item.option_string|escape}</td>{/if}
    </tr>
   </table>
  </td>
{/if}
