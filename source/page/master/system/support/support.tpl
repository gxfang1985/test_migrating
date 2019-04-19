{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/support/command_support'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="subject" value="{cb_msg module='grn.system.support' key='GRN_SY_SUP-27' replace='true'}">
{cb_msg module='grn.system.support' key='GRN_SY_SUP-28' replace='true'}

<p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

<p>
<table class="std_form">

<!--
<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_29'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-29' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_29 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_30'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-30' replace='true'}{/capture}{validate form=$form_name field="subject" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_30 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="subject" value=$subject size="50"}
</td>
</tr>
-->

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_31'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-31' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_31 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_32'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-32' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_32 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="name" value=$name size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_33'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-33' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_33 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_34'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-34' replace='true'}{/capture}{validate form=$form_name field="yomi" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_34 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="yomi" value=$yomi size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_35'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-35' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_35 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_36'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-36' replace='true'}{/capture}{validate form=$form_name field="admin_name" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_36 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="admin_name" value=$admin_name size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_37'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-37' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_37 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_38'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-38' replace='true'}{/capture}{validate form=$form_name field="admin_yomi" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_38 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="admin_yomi" value=$admin_yomi size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_39'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-39' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_39 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_40'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-40' replace='true'}{/capture}{validate form=$form_name field="group" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_40 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="group" value=$group size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_41'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-41' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_41 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_42'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-42' replace='true'}{/capture}{validate form=$form_name field="email" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_42 transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="email" value=$email size="50"}
</td>
</tr>

<tr>
<th nowrap>
{capture name='grn_system_support_GRN_SY_SUP_43'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_support_GRN_SY_SUP_43 necessary=TRUE}
</th>
<td>
{capture name='grn_system_support_GRN_SY_SUP_44'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-44' replace='true'}{/capture}{validate form=$form_name field="phone" criteria="notEmpty" message=$smarty.capture.grn_system_support_GRN_SY_SUP_44 transform="cb_trim" append="validation_errors"}
{capture name='grn_system_support_GRN_SY_SUP_45'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-45' replace='true'}{/capture}{validate form=$form_name field="phone" criteria="isRegExp" message=$smarty.capture.grn_system_support_GRN_SY_SUP_45 expression="!^[\d-\+]+$!" transform="cb_trim" append="validation_errors"}
{grn_text necessary=true name="phone" value=$phone size="50"}
</td>
</tr>

<tr>
<td></td>
<td>
{capture name='grn_system_support_GRN_SY_SUP_46'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-46' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_support_GRN_SY_SUP_46}
</td>
</tr>

</table>

{include file='grn/support_footer.tpl'}
