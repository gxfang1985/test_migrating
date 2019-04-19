   {grn_load_javascript file="grn/html/wm.js"}
   <table class="std_form">
<!--
    <tr>
     <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-111' replace='true'}</th>
     <td>
      {capture name='grn_link_system_GRN_LNK_SY_112'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-112' replace='true'}{/capture}{grn_radio name='object' id='object0' value='link' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_112 onclick="changeDisplayRadio('display_link_set','')" checked=1}&nbsp;&nbsp;{capture name='grn_link_system_GRN_LNK_SY_113'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-113' replace='true'}{/capture}{grn_radio name='object' id='object1' value='line' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_113 onclick="changeDisplayRadio('','display_link_set')"}
     </td>
    </tr>
-->
    <tr>
     <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-114' replace='true'}</th>
     <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
    </tr>
<span id="display_link_set">
    <tr>
     <th>{capture name='grn_link_system_GRN_LNK_SY_115'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-115' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_system_GRN_LNK_SY_115 necessary=1}</th>
     <td>{capture name='grn_link_system_GRN_LNK_SY_116'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-116' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_system_GRN_LNK_SY_116 append="validation_errors"}{grn_text name="title" size="50" necessary=1 value=$title}</td>
    </tr>
    <tr>
     <th>{grn_show_input_title title="URL" necessary=1}</th>
     <td>
      {capture name='grn_link_system_GRN_LNK_SY_117'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-117' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_system_GRN_LNK_SY_117 append="validation_errors"}
      {grn_text name="url" size="50" necessary=1 value=$url maxlength="255"}
     </td>
    </tr>
    <tr valign="top">
     <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-118' replace='true'}</th>
     <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
    </tr>
    </tr>
    {if $smarty.const.ON_FOREST !== 1}
    <tr valign="top">
     <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-119' replace='true'}</th>
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
