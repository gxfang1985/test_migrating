   {grn_load_javascript file="grn/html/wm.js"}
   <table class="std_form">
<!--
    <tr>
     <th>{cb_msg module='grn.link' key='GRN_LNK-90' replace='true'}</th>
     <td>
      {capture name='grn_link_GRN_LNK_91'}{cb_msg module='grn.link' key='GRN_LNK-91' replace='true'}{/capture}{grn_radio name='object' id='object0' value='link' caption=$smarty.capture.grn_link_GRN_LNK_91 onclick="changeDisplayRadio('display_link_set','')" checked=1}&nbsp;&nbsp;{capture name='grn_link_GRN_LNK_92'}{cb_msg module='grn.link' key='GRN_LNK-92' replace='true'}{/capture}{grn_radio name='object' id='object1' value='line' caption=$smarty.capture.grn_link_GRN_LNK_92 onclick="changeDisplayRadio('','display_link_set')"}
     </td>
    </tr>
-->
    <tr>
     <th>{cb_msg module='grn.link' key='GRN_LNK-93' replace='true'}</th>
     <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
    </tr>
<span id="display_link_set">
    <tr>
     <th>{capture name='grn_link_GRN_LNK_94'}{cb_msg module='grn.link' key='GRN_LNK-94' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_94 necessary=1}</th>
     <td>{capture name='grn_link_GRN_LNK_95'}{cb_msg module='grn.link' key='GRN_LNK-95' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_95 append="validation_errors"}{grn_text name="title" size="50" necessary=1 value=$title}</td>
    </tr>
    <tr>
     <th>{grn_show_input_title title="URL" necessary=1}</th>
     <td>
      {capture name='grn_link_GRN_LNK_96'}{cb_msg module='grn.link' key='GRN_LNK-96' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_96 append="validation_errors"}
      {grn_text name="url" size="50" necessary=1 value=$url maxlength="255"}
     </td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link' key='GRN_LNK-97' replace='true'}</th>
     <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
    </tr>
</span>
    <tr>
     <td></td>
     <td>
      {include file="$button_file"}
     </td>
    </tr>
   </table>
<input type="hidden" name="object" value="link">
