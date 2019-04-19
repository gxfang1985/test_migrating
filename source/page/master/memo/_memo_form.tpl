{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<table class="std_form">
    <!--category_items-->
    <tr>
        <th>{capture name='grn_memo_GRN_MEM_158'}{cb_msg module='grn.memo' key='GRN_MEM-158' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_158 necessary=1}</th>
        <td>{capture name='grn_memo_GRN_MEM_159'}{cb_msg module='grn.memo' key='GRN_MEM-159' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_memo_GRN_MEM_159 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.memo' key='GRN_MEM-160' replace='true'}</th>
        <td>{include file="memo/_folder_menu.tpl" param_name="pdid"}</td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.memo' key='GRN_MEM-161' replace='true'}</th>
        <td>{include file="grn/richeditor.tpl" html=$html text=$data cols=$config.area_width rows=$config.area_height enable=$config.enable_htmleditor class="form_textarea_grn"}</td>
    </tr>
    {if $config.filesize_limit != 0 }
        <tr>
            <th>{cb_msg module='grn.memo' key='GRN_MEM-162' replace='true'}</th>
            <td>
                {include file="grn/attach_file.tpl" attached_files=$attach_files}
            </td>
        </tr>
    {/if}
    <tr>
        <td></td>
        <td>
            <div class="mTop10">
                {strip}
                    {capture name='submit_onclick'}
                        if (grn.component.button(this).isDisabled()) return false; if ({$config.filesize_limit != 0} && !confirmIfExistFailedFile()) return false; grn.component.button.util.submit(this); grn.component.button(this).showSpinner();
                    {/capture}
                    {grn_button ui="main" spacing="normal" action="submit" caption=$submit_caption onclick=$smarty.capture.submit_onclick id="memo_button_save" auto_disable=false}

                    {grn_button action="cancel" page=$cancel_page page_param_did=$folder_id page_param_iid=$item_id id="memo_button_cancel"}
                {/strip}
            </div>
        </td>
    </tr>
</table>

<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="iid" value="{$item_id}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">

{if $config.filesize_limit == 0 }
    {if ! $attached_name}
        {assign var="attached_name" value="fids[]"}
    {/if}
    {foreach from=$attach_files key=fid item=file}
        <input class="infile" type="hidden" name="{$attached_name}" value="{$fid}">
    {/foreach}
{/if}