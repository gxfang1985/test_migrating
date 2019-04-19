{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/license/confirm'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>{cb_msg module='grn.system.license' key='GRN_SY_LI-38' replace='true'}<sup>&reg;</sup> {cb_msg module='grn.system.license' key='GRN_SY_LI-39' replace='true'}<sup></sup> {cb_msg module='grn.system.license' key='GRN_SY_LI-40' replace='true'}</p>
<p>
{cb_msg module='grn.system.license' key='GRN_SY_LI-41' replace='true'}{cb_msg module='grn.system.license' key='GRN_SY_LI-42' replace='true'}{cb_msg module='grn.system.license' key='GRN_SY_LI-43' replace='true'}<br>
{cb_msg module='grn.system.license' key='GRN_SY_LI-44' replace='true'}<br>
{cb_msg module='grn.system.license' key='GRN_SY_LI-45' replace='true'}
</p>

{include file="grn/show_validation_errors.tpl"}
{include file="grn/indispensable.tpl"}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_license_GRN_SY_LI_46'}{cb_msg module='grn.system.license' key='GRN_SY_LI-46' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_license_GRN_SY_LI_46 necessary=TRUE}</th>
  <td>
       {capture name='grn_system_license_GRN_SY_LI_47'}{cb_msg module='grn.system.license' key='GRN_SY_LI-47' replace='true'}{/capture}{validate form=$form_name field="customer" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_47 append="validation_errors"}
       {capture name='grn_system_license_GRN_SY_LI_48'}{cb_msg module='grn.system.license' key='GRN_SY_LI-48' replace='true'}{/capture}{validate form=$form_name field="customer" criteria="isLength" min="6" max="6" message=$smarty.capture.grn_system_license_GRN_SY_LI_48 append="validation_errors"}
       {grn_text necessary=true name="customer" value=$customer size="7" maxlength=6 disable_return_key=true}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_license_GRN_SY_LI_50'}{cb_msg module='grn.system.license' key='GRN_SY_LI-50' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_license_GRN_SY_LI_50 necessary=TRUE}</th>
  <td>
      {capture name='grn_system_license_GRN_SY_LI_51'}{cb_msg module='grn.system.license' key='GRN_SY_LI-51' replace='true'}{/capture}{validate form=$form_name field="license1" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_51 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_52'}{cb_msg module='grn.system.license' key='GRN_SY_LI-52' replace='true'}{/capture}{validate form=$form_name field="license1" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_52 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_54'}{cb_msg module='grn.system.license' key='GRN_SY_LI-54' replace='true'}{/capture}{validate form=$form_name field="license2" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_54 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_55'}{cb_msg module='grn.system.license' key='GRN_SY_LI-55' replace='true'}{/capture}{validate form=$form_name field="license2" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_55 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_57'}{cb_msg module='grn.system.license' key='GRN_SY_LI-57' replace='true'}{/capture}{validate form=$form_name field="license3" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_57 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_58'}{cb_msg module='grn.system.license' key='GRN_SY_LI-58' replace='true'}{/capture}{validate form=$form_name field="license3" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_58 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_60'}{cb_msg module='grn.system.license' key='GRN_SY_LI-60' replace='true'}{/capture}{validate form=$form_name field="license4" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_60 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_61'}{cb_msg module='grn.system.license' key='GRN_SY_LI-61' replace='true'}{/capture}{validate form=$form_name field="license4" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_61 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_63'}{cb_msg module='grn.system.license' key='GRN_SY_LI-63' replace='true'}{/capture}{validate form=$form_name field="license5" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_63 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_64'}{cb_msg module='grn.system.license' key='GRN_SY_LI-64' replace='true'}{/capture}{validate form=$form_name field="license5" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_64 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_66'}{cb_msg module='grn.system.license' key='GRN_SY_LI-66' replace='true'}{/capture}{validate form=$form_name field="license6" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_66 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_67'}{cb_msg module='grn.system.license' key='GRN_SY_LI-67' replace='true'}{/capture}{validate form=$form_name field="license6" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_67 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_69'}{cb_msg module='grn.system.license' key='GRN_SY_LI-69' replace='true'}{/capture}{validate form=$form_name field="license7" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_69 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_70'}{cb_msg module='grn.system.license' key='GRN_SY_LI-70' replace='true'}{/capture}{validate form=$form_name field="license7" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_70 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_72'}{cb_msg module='grn.system.license' key='GRN_SY_LI-72' replace='true'}{/capture}{validate form=$form_name field="license8" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_72 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_73'}{cb_msg module='grn.system.license' key='GRN_SY_LI-73' replace='true'}{/capture}{validate form=$form_name field="license8" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_73 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_75'}{cb_msg module='grn.system.license' key='GRN_SY_LI-75' replace='true'}{/capture}{validate form=$form_name field="license9" criteria="notEmpty" message=$smarty.capture.grn_system_license_GRN_SY_LI_75 append="validation_errors"}
      {capture name='grn_system_license_GRN_SY_LI_76'}{cb_msg module='grn.system.license' key='GRN_SY_LI-76' replace='true'}{/capture}{validate form=$form_name field="license9" criteria="isLength" min="5" max="5" message=$smarty.capture.grn_system_license_GRN_SY_LI_76 append="validation_errors"}

      {grn_text necessary=true name="license1" value=$license1 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license2" value=$license2 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license3" value=$license3 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license4" value=$license4 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license5" value=$license5 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license6" value=$license6 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license7" value=$license7 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license8" value=$license8 size="7" maxlength=5 disable_return_key=true} -
      {grn_text necessary=true name="license9" value=$license9 size="7" maxlength=5 disable_return_key=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_license_GRN_SY_LI_78'}{cb_msg module='grn.system.license' key='GRN_SY_LI-78' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_license_GRN_SY_LI_78}
       {grn_button_cancel page='system/license/admin'}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
