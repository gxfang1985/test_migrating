   <table class="std_form">
    <tr>
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-93' replace='true'}</th>
     <td>
      {grn_image image='category20.gif'}{$category.title|escape:"html"}
     </td>
    </tr>
<span id="display_link_set">
    <tr>
     <th>{capture name='grn_link_operation_GRN_LNK_OP_94'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-94' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_94 necessary=1}</th>
     <td>{capture name='grn_link_operation_GRN_LNK_OP_95'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-95' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_95 append="validation_errors"}{grn_text name="title" size="30" necessary=1 value=$link.title}</td>
    </tr>
    <tr>
     <th>{grn_show_input_title title="URL" necessary=1}</th>
     <td>
      {capture name='grn_link_operation_GRN_LNK_OP_96'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-96' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_96 append="validation_errors"}
      {grn_text name="url" size="50" necessary=1 value=$link.url maxlength="255"}
     </td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-97' replace='true'}</th>
     <td>{grn_textarea name="memo" rows="9" value=$link.memo}</td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-98' replace='true'}</th>
     <td> {grn_select name='sid' options=$sso_list}</td>
    </tr>
</span>
    <tr>
     <td></td>
     <td>
      {include file="$button_file"}
     </td>
    </tr>
   </table>
   <input type="hidden" name="objcet" value="{$link.object}">
