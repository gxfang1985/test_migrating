{grn_space_show_expiration_date_warning space=$this->getSpace()}

{grn_title title=$page_title class=$page_info.parts[0]}
{grn_load_javascript file="grn/html/component/validator.js"}

<div id="errorMessageField"></div>
<form name="space/member_modify" id="space/member_modify" method="post" action="{grn_pageurl page='space/command_member_modify'}" enctype="multipart/form-data">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
    {include file="space/_member_set.tpl" selected_users=$this->getSelectedUserArray() selected_operators=$this->getSelectedOperatorArray() candidate_operators=$this->getSelectedUserArray()}
    <tr>
        <td>
        </td>
    <td>
    <input type="hidden" name="spid" value="{$this->getSpaceId()|escape}">
    <input type="hidden" name="from" value="{$this->getFrom()|escape}">
    <div class="mTop10">
        {strip}
            {capture name="grn_space_modify_space_10"}{cb_msg module="grn.space" key="modify-space-10" replace="true"}{/capture}
            {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_modify_space_10 spacing='normal'}
            {grn_button action='cancel'}
        {/strip}
    </div>
    </td>
    </tr>
</table>
</form>
{include file="space/_prepare_submit_js.tpl" form="space/member_modify"}