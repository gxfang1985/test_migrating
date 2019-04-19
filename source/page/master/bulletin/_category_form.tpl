<div class="explanation">{cb_msg module='grn.bulletin' key='GRN_BLLT-473' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
    <!--category_items-->
    <tr>
        <th>{capture name='grn_bulletin_GRN_BLLT_474'}{cb_msg module='grn.bulletin' key='GRN_BLLT-474' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_474}</th>
        <td>{if $parent_name}{grn_sentence caption=$parent_name image='category20.gif'}{else}<br>{/if}</td>
    </tr>
    <tr>
        <th>{capture name='grn_bulletin_GRN_BLLT_475'}{cb_msg module='grn.bulletin' key='GRN_BLLT-475' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_475 necessary=false}</th>
        <td>
            {capture name='grn_bulletin_GRN_BLLT_476'}{cb_msg module='grn.bulletin' key='GRN_BLLT-476' replace='true'}{/capture}
            {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_bulletin_GRN_BLLT_476 values=$multiLanguageInfoArray.values}
        </td>
    </tr>
    <tr valign="top">
        <th>{capture name='grn_bulletin_GRN_BLLT_477'}{cb_msg module='grn.bulletin' key='GRN_BLLT-477' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_477 necessary=1}</th>
        <td>{capture name='grn_bulletin_GRN_BLLT_478'}{cb_msg module='grn.bulletin' key='GRN_BLLT-478' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_bulletin_GRN_BLLT_478 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="foreign_key" value=$foreign_key size="50" disable_return_key=true}<br>
            <div class="br">&nbsp;</div>
            <div class="sub_explanation">{cb_msg module='grn.bulletin' key='GRN_BLLT-479' replace='true'}</div>
        </td>
    </tr>
    <tr valign="top">
        <th>{capture name='grn_bulletin_GRN_BLLT_480'}{cb_msg module='grn.bulletin' key='GRN_BLLT-480' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_GRN_BLLT_480}</th>
        <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
    </tr>
    {if $parent_name}
        <tr>
            <th nowrap="">{cb_msg module='grn.bulletin' key='GRN_BLLT-607' replace='true'}</th>
            <td>
            {include file="grn/_dropdown_copy.tpl" key='access' obj='category' folder_tree=$tree_for_access select=$tree_for_access.root_caption copy_checked=$copy_checked}
            </td>
        </tr>
        <tr>
            <th nowrap="">{cb_msg module='grn.bulletin' key='GRN_BLLT-608' replace='true'}</th>
            <td>
            {include file="grn/_dropdown_copy.tpl" key='notification' obj='category' folder_tree=$tree_for_notification select=$tree_for_notification.root_caption copy_checked=$copy_checked}
            </td>
        </tr>
        {if ! $tree_for_access}
        <tr>
            <td><br></td>
            <td>
                <span style="font-size: 80%">{cb_msg module='grn.bulletin' key='GRN_BLLT-609' replace='true'}</span>
            </td>
        </tr>
        {/if}
    {/if}
    <tr>
        <td><br></td>
        <td>
            {grn_button_submit class='margin' caption=$submit_caption id="bulletin_category_form_submit"}
            {grn_button_cancel page=$cancel_page cid=$category_id id="bulletin_category_form_cancel"}
        </td>
    </tr>
</table>
<input type="hidden" name="cid" value="{$category_id}">
{if $parent_name}
{grn_load_javascript file='grn/html/component/dropdown_copy.js'}
{grn_load_javascript file='grn/html/page/bulletin/category_form.js'}
{/if}