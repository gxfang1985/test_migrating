<div class="explanation">{cb_msg module='grn.space.system' key='GRN_SPACE_SY-30' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{assign var="form_name" value="space/system/category_add"}

<form name="space/system/category_add" id="space/system/category_add" method="post" action="{grn_pageurl page='space/system/command_category_add'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="cid" value="{$cid}">
  <input type="hidden" name="filter_id" value="{$filter_id|escape}">
  <table class="std_form">
    <!--category_items-->
    <tr>
      <th>{capture name='grn_space_system_GRN_SPACE_SY_31'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-31' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_31}</th>
      <td>{grn_sentence caption=$parent_name image='category20.gif'}</td>
    </tr>
    <tr>
      <th>{capture name='grn_space_system_GRN_SPACE_SY_32'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-32' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_32 necessary=1}</th>
      <td>
        {capture name='grn_space_system_GRN_SPACE_SY_33'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-33' replace='true'}{/capture}
        {grn_text_multilanguage element_name=$this_getMultilingualSpaceCategoryNameArray.element_name form_name=$this_getMultilingualSpaceCategoryNameArray.form_name error_message=$smarty.capture.grn_space_system_GRN_SPACE_SY_33 values=$this_getMultilingualSpaceCategoryNameArray.values}
      </td>
    </tr>
    <tr valign="top">
      <th>{capture name='grn_space_system_GRN_SPACE_SY_34'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-34' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_34 necessary=1}</th>
      <td>
        {capture name='grn_space_system_GRN_SPACE_SY_35'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-35' replace='true'}{/capture}
        {validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_space_system_GRN_SPACE_SY_35 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="foreign_key" value=$foreign_key size="50" disable_return_key=true}<br>
        <div class="br">&nbsp;</div>
        <div class="sub_explanation">{cb_msg module='grn.space.system' key='GRN_SPACE_SY-36' replace='true'}</div>
      </td>
    </tr>
    <tr valign="top">
      <th>{capture name='grn_space_system_GRN_SPACE_SY_38'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-38' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_38}</th>
      <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
    </tr>
    <tr>
      <td><br></td>
      <td>
      {grn_button_submit class='margin' caption=$submit_caption}
      {grn_button_cancel page=$cancel_page cid=$cid filter_id=$filter_id}
      </td>
    </tr>
  </table>
</form>