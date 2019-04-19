{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{include file="grn/common.tpl"}

{grn_load_javascript file="grn/html/component/mail/AddressArea.js"}
{grn_load_javascript file="grn/html/ui.mail.address.js"}
{grn_load_javascript file="grn/html/jquery.fcbkcomplete.js"}
{grn_title title=$page_title}<br/>
<p>
  <div class="explanation">
      {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-272' replace='true'}
  </div>
</p>
<form name="mail/personal/automation/register" ></form>
<div id="errorMessageField" style="display:none;">
    <div class="attention bold subnotify16">
        {cb_msg module="grn.mail.personal" key="GRN_MAIL_PE-274" replace='true'}
    </div>
</div>
{include file='grn/indispensable.tpl'}
<table class="std_form">
    <tr>
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-31' replace='true'}</th>
        <td>{$account.title}
            {if $account.disabled neq '0'}
                <br/>
                <span class="attention">{cb_msg module="grn.mail.personal" key="GRN_MAIL_PE-20" replace='true'}</span>
            {/if}
        </td>
    </tr>
    <tr>
        <td><span></span></td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-262' replace='true'}
            <span class="attention">*</span>
        </th>
        <td>
            <input type="text" name="eventName" value="{$event.eventName}" size="50" maxlength="100"/>
        </td>
    </tr>
    <tr valign="top">
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-265' replace='true'}</th>
        <td>
            <input type="hidden" value="{$event.eventId}" name="eventId" />
            <input type="hidden" value="{$account.id}" name="accountId" />
            <input type="hidden" value="{if $event.serviceStatus}ON{else}OFF{/if}" name="serviceStatus"/>
            <select name="logicType">
                <option value="AND" {if $event.logicType eq 'AND'}selected{/if}>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-70' replace='true'}
                <option value="OR"  {if $event.logicType eq 'OR'}selected{/if}>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-71' replace='true'}
            </select>
            <div class="margin_top"></div>
            <div class="list_of_conditions">
                {foreach from=$event.conditions item=condition}
                    <div class="condition">
                        <select name="evaluationObject" class="filter_condition_width">
                            <option value="subject" {if $condition.evaluationObject eq 'subject'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1483' replace='true'}
                            </option>
                            <option value="from" {if $condition.evaluationObject eq 'from'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}
                            </option>
                            <option value="to" {if $condition.evaluationObject eq 'to'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}
                            </option>
                            <option value="cc" {if $condition.evaluationObject eq 'cc'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}
                            </option>
                        </select>
                        <select name="evaluationMethod" class="filter_condition_width">
                            <option value="contains"    {if $condition.evaluationMethod eq 'contains'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1489' replace='true'}
                            </option>
                            <option value="notContains" {if $condition.evaluationMethod eq 'notContains'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1490' replace='true'}
                            </option>
                            <option value="equals" {if $condition.evaluationMethod eq 'equals'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1491' replace='true'}
                            </option>
                            <option value="notEquals" {if $condition.evaluationMethod eq 'notEquals'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1492' replace='true'}
                            </option>
                            <option value="startsWith" {if $condition.evaluationMethod eq 'startsWith'}selected{/if}>
                                {cb_msg module='grn.grn' key='GRN_GRN-1493' replace='true'}
                            </option>
                        </select>
                        <input type="text" name="matchData" size="40" value="{$condition.matchData}"/>
                        <input class="buttonMain-grn" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-793' replace='true'}" onClick="register.onDeleteConditionClicked(this);return false;">
                    </div>
                {/foreach}
            </div>
            <div>
                <input class="buttonMain-grn" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-804' replace='true'}" onclick="register.onAddConditionClicked();return false;" >
                <input class="buttonMain-grn" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1482' replace='true'}" onclick="register.onDeleteAllConditionsClicked();return false;" >
            </div>
        </td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-264' replace='true'}</th>
        <td>
            <div class="list_of_actions">
                {foreach from=$event.actions item=action}
                    {if $action.actionName eq 'grn.mail.automatic.forward'}
                        <div class="action">
                            <div style="float:left">
                            <input type="hidden" name="actionName" value="{$action.actionName}" />
                            <select id="forwardTo" name="forwardTo" class="hidden" ></select>
                            <textarea name="forwardTo" class="mail-textareaTo-grn hidden">{","|implode:$action.message.forwardTo}</textarea>
                            </div>
                            {if $allowUsingAddressBook eq true}
                                <div style="float:left;">
                                    <span class="mLeft15">
                                        <input class="buttonMain-grn" type="button" value="{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-273' replace='true'}" onClick="register.onAddressBookPopupClicked();return false;"/>
                                    </span>
                                </div>
                            {/if}
                        </div>
                    {/if}
                {/foreach}
            </div>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            {if $actionName eq "modify"}
                {capture assign="submitButtonLabel"}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-114' replace='true'}{/capture}
            {else}
                {capture assign="submitButtonLabel"}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-154' replace='true'}{/capture}
            {/if}
            <input class="buttonMain-grn" type="button" value="{$submitButtonLabel}" onClick="register.onRegisterEventClicked('{$actionName}');return false;"/>
            {grn_button_cancel class="buttonStandard-grn" page="mail/personal/automation" accountId=$account.id}
        </td>
    </tr>
</table>

<div class="template_of_condition" style="display:none;">
    <div class="condition">
        <select name="evaluationObject" class="filter_condition_width">
            <option value="subject">{cb_msg module='grn.grn' key='GRN_GRN-1483' replace='true'}</option>
            <option value="from">{cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}</option>
            <option value="to">{cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}</option>
            <option value="cc">{cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}</option>
        </select>
        <select name="evaluationMethod" class="filter_condition_width">
            <option value="contains">{cb_msg module='grn.grn' key='GRN_GRN-1489' replace='true'}</option>
            <option value="notContains">{cb_msg module='grn.grn' key='GRN_GRN-1490' replace='true'}</option>
            <option value="equals">{cb_msg module='grn.grn' key='GRN_GRN-1491' replace='true'}</option>
            <option value="notEquals">{cb_msg module='grn.grn' key='GRN_GRN-1492' replace='true'}</option>
            <option value="startsWith">{cb_msg module='grn.grn' key='GRN_GRN-1493' replace='true'}</option>
        </select>
        <input type="text" name="matchData" size="40" value="{$condition.matchData}"/>
        <input class="buttonMain-grn" type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-793' replace='true'}" onClick="register.onDeleteConditionClicked(this);return false;">
    </div>
</div>
{include file='grn/personal_footer.tpl'}
{grn_load_javascript file="grn/html/page/mail/personal/automation/register.js"}
<script type="text/javascript">
    var register = grn.page.mail.personal.automation.register;
    register.commandAutomationURL = "{grn_pageurl page='mail/personal/automation/ajax/command_automation'}";
    register.autoCompleteURL = "{if $useIncrementalSearch}{grn_pageurl page='grn/get_data_auto_complete'}{else}{/if}";
    register.popupAddressUrl = '{grn_pageurl page="mail/popup_address"}';
    {literal}
    (function(){
        jQuery(document).ready(register.setUpAutoComplete.bind(register));
    })();
    {/literal}
</script>
{include file="grn/error_handler.tpl"}