{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

  {capture name='grn_space_system_GRN_SPACE_SY_1'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-1' replace='true'}{/capture}
<div class="explanation">{cb_msg module='grn.space.system' key='GRN_SPACE_SY-4' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{assign var="form_name" value="space/system/category_modify"}

  <form name="space/system/category_modify" id="space/system/category_modify" method="post" action="{grn_pageurl page='space/system/command_category_modify'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$cid}">
    <table class="std_form">
      <!--category_items-->
      <tr>
        <th>{capture name='grn_space_system_GRN_SPACE_SY_16'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_16}</th>
        <td>{if $parent_category}{grn_link page='space/system/category_view' cid=$parent_category->getId() image='category20.gif' caption=$parent_category->getCategoryName()}{/if}<br></td>
      </tr>
      <tr>
        <th>{capture name='grn_space_system_GRN_SPACE_SY_17'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-17' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_17 necessary=1}</th>
        <td>
          {capture name='grn_space_system_GRN_SPACE_SY_29'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-29' replace='true'}{/capture}
          {grn_text_multilanguage element_name=$this_getMultilingualSpaceCategoryNameArray.element_name form_name=$this_getMultilingualSpaceCategoryNameArray.form_name error_message=$smarty.capture.grn_space_system_GRN_SPACE_SY_29 values=$this_getMultilingualSpaceCategoryNameArray.values}
        </td>
      </tr>
      <tr valign="top">
        <th>{capture name='grn_space_system_GRN_SPACE_SY_18'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-18' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_18 necessary=1}</th>
        <td>
          {capture name='grn_space_system_GRN_SPACE_SY_27'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-27' replace='true'}{/capture}
          {validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_space_system_GRN_SPACE_SY_27 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="foreign_key" value=$foreign_key size="50" disable_return_key=true}<br>
          <br>
          <div class="br">&nbsp;</div>
          <div class="sub_explanation">{cb_msg module='grn.space.system' key='GRN_SPACE_SY-28' replace='true'}</div>
        </td>
      </tr>
      <tr valign="top">
        <th>{capture name='grn_space_system_GRN_SPACE_SY_19'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-19' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_system_GRN_SPACE_SY_19}</th>
        <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
      </tr>
      <tr>
        <td><br></td>
        <td>
        {capture name='grn_space_system_GRN_SPACE_SY_11'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-11' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_11}
        {grn_button_cancel page=$cancel_page cid=$cid}
        </td>
      </tr>
    </table>
  </form>

{include file="grn/system_footer.tpl"}
