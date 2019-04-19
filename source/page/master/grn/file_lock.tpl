<div class="attention">{cb_msg module='grn.grn' key='GRN_GRN-1237' replace='true'}</div>

<table class="std_form">
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-1238' replace='true'}
        </th>
        <td>
            {grn_user_name uid=$login.id name=$login.name}
        </td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-1239' replace='true'}
        </th>
        <td>
            <a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$file.id postfix=$file.filename ticket=$download_ticket}"><nobr></nobr>{$file.filename|escape:"html"}</a>&nbsp;&nbsp;({$file.mime})
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <div class="mTop10">
                {strip}
                    {capture name='grn_grn_GRN_GRN_1240'}{cb_msg module='grn.grn' key='GRN_GRN-1240' replace='true'}{/capture}
                    {capture name='filelock_button_upload_onclick'}
                        jQuery("#button_command").attr({ldelim}name: 'upload', value: '{$smarty.capture.grn_grn_GRN_GRN_1240}'{rdelim}); grn.component.button.util.submit(this);
                    {/capture}
                    {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_grn_GRN_GRN_1240 onclick=$smarty.capture.filelock_button_upload_onclick id="filelock_button_upload"}

                    {capture name='grn_grn_GRN_GRN_1241'}{cb_msg module='grn.grn' key='GRN_GRN-1241' replace='true'}{/capture}
                    {capture name='filelock_button_cancel_onclick'}
                        jQuery("#button_command").attr({ldelim}name: 'cancel', value: '{$smarty.capture.grn_grn_GRN_GRN_1241}'{rdelim}); grn.component.button.util.submit(this);
                    {/capture}
                    {grn_button caption=$smarty.capture.grn_grn_GRN_GRN_1241 onclick=$smarty.capture.filelock_button_cancel_onclick id="filelock_button_cancel"}
                {/strip}
                <input type="hidden" name="" value="" id="button_command">
            </div>
        </td>
    </tr>
</table>

<ol class="process">
    <li>{cb_msg module='grn.grn' key='GRN_GRN-1242' replace='true'}<br>{cb_msg module='grn.grn' key='GRN_GRN-1243' replace='true'}</li>
    <li>{cb_msg module='grn.grn' key='GRN_GRN-1244' replace='true'}<br>{cb_msg module='grn.grn' key='GRN_GRN-1245' replace='true'}</li>
</ol>

<input type="hidden" name="fid" value="{$file.id}">