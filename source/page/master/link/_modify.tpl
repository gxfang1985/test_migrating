   {grn_load_javascript file="grn/html/wm.js"}
   <p>
   <table class="std_form">
    <tr>
     <th>{cb_msg module='grn.link' key='GRN_LNK-167' replace='true'}</th>
     <td>
      {grn_image image='category20.gif'}{$category.title|escape:"html"}
     </td>
    </tr>
<span id="display_link_set">
    <tr>
     <th>{capture name='grn_link_GRN_LNK_168'}{cb_msg module='grn.link' key='GRN_LNK-168' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_168 necessary=1}</th>
     <td>{capture name='grn_link_GRN_LNK_169'}{cb_msg module='grn.link' key='GRN_LNK-169' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_169 append="validation_errors"}{grn_text name="title" size="30" necessary=1 value=$link.title}</td>
    </tr>
    <tr>
     <th>{grn_show_input_title title="URL" necessary=1}</th>
     <td>
      {capture name='grn_link_GRN_LNK_170'}{cb_msg module='grn.link' key='GRN_LNK-170' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_170 append="validation_errors"}
      {grn_text name="url" size="50" necessary=1 value=$link.url maxlength="255"}
     </td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link' key='GRN_LNK-171' replace='true'}</th>
     <td>{grn_textarea name="memo" rows="9" value=$link.memo}</td>
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
