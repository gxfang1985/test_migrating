   {grn_load_javascript file="grn/html/wm.js"}
   <table class="std_form">
<!--
    <tr>
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-62' replace='true'}</th>
     <td>
      {capture name='grn_link_operation_GRN_LNK_OP_63'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-63' replace='true'}{/capture}{grn_radio name='object' id='object0' value='link' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_63 onclick="changeDisplayRadio('display_link_set','')" checked=1}&nbsp;&nbsp;{capture name='grn_link_operation_GRN_LNK_OP_64'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-64' replace='true'}{/capture}{grn_radio name='object' id='object1' value='line' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_64 onclick="changeDisplayRadio('','display_link_set')"}
     </td>
    </tr>
-->
    <tr>
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-65' replace='true'}</th>
     <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
    </tr>
<span id="display_link_set">
    <tr>
     <th>{capture name='grn_link_operation_GRN_LNK_OP_66'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-66' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_66 necessary=1}</th>
     <td>{capture name='grn_link_operation_GRN_LNK_OP_67'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-67' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_67 append="validation_errors"}{grn_text name="title" size="50" necessary=1 value=$title}</td>
    </tr>
    <tr>
     <th>{grn_show_input_title title="URL" necessary=1}</th>
     <td>
      {capture name='grn_link_operation_GRN_LNK_OP_68'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-68' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_68 append="validation_errors"}
      {grn_text name="url" size="50" necessary=1 value=$url maxlength="255"}
     </td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-69' replace='true'}</th>
     <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
    </tr>
    {if $smarty.const.ON_FOREST !== 1}
    <tr valign="top">
     <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-70' replace='true'}</th>
     <td> {grn_select name='sid' options=$sso_list}</td>
    </tr>
    {/if}
</span>
    <tr>
     <td></td>
     <td>
      {include file="$button_file"}
     </td>
    </tr>
   </table>
<input type="hidden" name="object" value="link">
