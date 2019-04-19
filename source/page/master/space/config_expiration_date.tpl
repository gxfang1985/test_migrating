{grn_title title=$page_title class=$page_info.parts[0]}

{grn_load_css file="grn/html/component/overlay.css"}
{grn_load_javascript file="grn/html/space_text_multilanguage.js"}
{* 
  This file is loaded in order to override the objects defined in grn/html/text_multilanguage.js which is loaded at hreader part. 
*}
{grn_load_javascript file="grn/html/component/overlay.js"}
{grn_load_javascript file="grn/html/component/icon.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
<div id="errorMessageField"></div>
<form name="space/config_expiration_date" id="space/config_expiration_date" method="post"
      action="{grn_pageurl page=space/command_config_expiration_date}" enctype="multipart/form-data"><input
            type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        {include file="space/_expiration_date.tpl"}
        <tr>
            <td></td>
            <td>
                <input type="hidden" name="spid" value="{$this->getSpaceId()|escape}">
                <div class="mTop10">
                    {strip}
                        {capture name="grn_space_create_space_10"}{cb_msg module="grn.space" key="modify-space-10" replace="true"}{/capture}
                        {grn_button id='buttonSubmit' ui='main' auto_disable=true caption=$smarty.capture.grn_space_create_space_10 spacing='normal'}
                        {grn_button action='cancel' onclick="grn.page.space._expiration_date.spaceCancel(this, 'history_back')"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
</form>
{grn_load_javascript file="grn/html/page/space/config_expiration_date.js"}