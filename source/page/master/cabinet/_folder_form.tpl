<p><div class="explanation">{cb_msg module='grn.cabinet' key='GRN_CAB-176' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
    <!--folder_items-->
    <tr>
        <th>{capture name='grn_cabinet_GRN_CAB_177'}{cb_msg module='grn.cabinet' key='GRN_CAB-177' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_177}</th>
        <td>{if $parent_name}{grn_sentence caption=$parent_name image='folder20.gif'}{else}<br>{/if}</td>
    </tr>
    <tr>
        <th>{capture name='grn_cabinet_GRN_CAB_178'}{cb_msg module='grn.cabinet' key='GRN_CAB-178' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_178 necessary=false}</th>
        <td>
            {capture name='grn_cabinet_GRN_CAB_179'}{cb_msg module='grn.cabinet' key='GRN_CAB-179' replace='true'}{/capture}
            {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_cabinet_GRN_CAB_179 values=$multiLanguageInfoArray.values}
        </td>
    </tr>
    <tr valign="top">
        <th>{capture name='grn_cabinet_GRN_CAB_180'}{cb_msg module='grn.cabinet' key='GRN_CAB-180' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_180 necessary=1}</th>
        <td>{capture name='grn_cabinet_GRN_CAB_181'}{cb_msg module='grn.cabinet' key='GRN_CAB-181' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_cabinet_GRN_CAB_181 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="foreign_key" value=$foreign_key size="50" disable_return_key=true}<br>
            <div class="br">&nbsp;</div>
            <div class="sub_explanation">{cb_msg module='grn.cabinet' key='GRN_CAB-182' replace='true'}</div>
        </td>
    </tr>
    <tr valign="top">
        <th>{capture name='grn_cabinet_GRN_CAB_183'}{cb_msg module='grn.cabinet' key='GRN_CAB-183' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_183}</th>
        <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
    </tr>
    {if $parent_name}
        <tr>
            <th nowrap="">{cb_msg module='grn.cabinet' key='GRN_CAB-299' replace='true'}</th>
            <td>
            {include file="grn/_dropdown_copy.tpl" key='access' obj='folder' folder_tree=$tree_for_access select=$tree_for_access.root_caption copy_checked=$copy_checked}
            </td>
        </tr>
        <tr>
            <th nowrap="">{cb_msg module='grn.cabinet' key='GRN_CAB-300' replace='true'}</th>
            <td>
            {include file="grn/_dropdown_copy.tpl" key='notification' obj='folder' folder_tree=$tree_for_notification select=$tree_for_notification.root_caption  copy_checked=$copy_checked}
            </td>
        </tr>
        {if ! $tree_for_access}
        <tr>
            <td><br></td>
            <td>
                <span style="font-size: 80%">{cb_msg module='grn.cabinet' key='GRN_CAB-301' replace='true'}</span>
            </td>
        </tr>
        {/if}
    {/if}
    <tr>
        <td><br></td>
        <td>
            {grn_button_submit class='margin' caption=$submit_caption}
            {grn_button_cancel page=$cancel_page hid=$folder_id}
        </td>
    </tr>
</table>
<input type="hidden" name="hid" value="{$folder_id}">
{if $parent_name}
{grn_load_javascript file='grn/html/component/dropdown_copy.js'}
{grn_load_javascript file="grn/html/page/cabinet/folder_form.js"}
{/if}