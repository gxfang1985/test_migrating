{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{include file="grn/common.tpl"}
{grn_load_javascript file="grn/html/page/mail/personal/automation/automation.js"}
{grn_load_javascript file="grn/html/component/toggle_button/toggle_button.js"}
{grn_load_css file="grn/html/component/toggle_button/toggle_button.css"}
<script type="text/javascript">
    var automation = grn.page.mail.personal.automation;
    automation.accountId = "{$accountId}";
    automation.caption = {literal}{}{/literal};
    automation.caption.yes = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-142' replace='true'}";
    automation.caption.no = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-143' replace='true'}";
    automation.caption.inService = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-270' replace='true'}";
    automation.caption.outOfService = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-268' replace='true'}";
    automation.caption.deleteMessageBoxTitle = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-271' replace='true'}";
    automation.caption.enableService = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-268' replace='true'}";
    automation.caption.disableService = "{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-269' replace='true'}";
    automation.commandAutomationURL = "{grn_pageurl page='mail/personal/automation/ajax/command_automation'}";
</script>
{grn_title title=$page_title}<br/>
{if $no_setting neq '0'}
    {include file='mail/_no_setting.tpl'}
{else}
    <span class="menu_item">
        {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-119' replace='true'}{grn_image image='mailaccount20.gif'}&nbsp;{grn_select name='accountList' options=$accountList onchange="automation.onSelectedAccountChanged();return false;"}
        {if $account.disabled neq '0'}
            <br/>
            <span class="attention">{cb_msg module="grn.mail.personal" key="GRN_MAIL_PE-20" replace="true"}</span>
        {/if}
    </span>
    <div id="main_menu_part">
        <span class="menu_item">
            {capture assign='labelAddAutomaticEvent'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-260' replace='true'}{/capture}
            {grn_link image='write20.gif' caption=$labelAddAutomaticEvent page='mail/personal/automation/register' accountId=$accountId}
        </span>
    </div>
    <table class="admin_list_table" width="100%">
        <tr>
            <th style="width :100px;">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-261' replace='true'}</th>
            <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-262' replace='true'}</th>
            <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-265' replace='true'}</th>
            <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-264' replace='true'}</th>
            <th></th>
        </tr>
        {capture assign="on_msg"}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-270' replace='true'}{/capture}
        {capture assign="off_msg"}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-268' replace='true'}{/capture}
        {foreach from=$events key=eventId item=event}
            {capture assign=eventSummery}eventSummery{$eventId} {if !$event.serviceStatus}gray{/if}{/capture}
            <tr>
                <td class="{$eventSummery}  tAlignCenter-grn">{* service status *}
                   {strip}
                       <span class="vAlignMiddle-grn">
                           {include file="grn/component/toggle_button.tpl" id="serviceStatusToggleButton$eventId" on_msg=$on_msg off_msg=$off_msg button_on=$event.serviceStatus}
                       </span>
                   {/strip}
                </td>

                <td class="{$eventSummery} eventName">{* event name and link to event detail *}
                    {grn_image image="mail20_f.gif"}
                    <span>{$event.eventName}</span>
                </td>
                <td class="{$eventSummery}">
                    <span>
                        {if $event.logicType eq 'AND'}
                            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-70' replace='true'}
                        {elseif $event.logicType eq 'OR'}
                            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-71' replace='true'}
                        {/if}
                    </span>
                    <table class="condition_table_grn">
                        {foreach from=$event.conditions item=condition}
                            <tr>
                                {strip}
                                    <td class="nowrap-grn">
                                        <span class="icon_list_style_grn icon_inline_grn">
                                            {if $condition.evaluationObject eq  'subject'}
                                                {cb_msg module="grn.grn" key="GRN_GRN-1483" replace='true'}
                                            {elseif $condition.evaluationObject eq 'from'}
                                                {cb_msg module="grn.grn" key="GRN_GRN-1484" replace='true'}
                                            {elseif $condition.evaluationObject eq 'to'}
                                                {cb_msg module="grn.grn" key="GRN_GRN-1485" replace='true'}
                                            {elseif $condition.evaluationObject eq 'cc'}
                                                {cb_msg module="grn.grn" key="GRN_GRN-1486" replace='true'}
                                            {/if}
                                        </span>
                                    </td>
                                    <td class="nowrap-grn">
                                        {if $condition.evaluationMethod eq 'contains'}
                                            {cb_msg module="grn.grn" key="GRN_GRN-1489" replace='true'}
                                        {elseif $condition.evaluationMethod eq 'notContains'}
                                            {cb_msg module="grn.grn" key="GRN_GRN-1490" replace='true'}
                                        {elseif $condition.evaluationMethod eq 'equals'}
                                            {cb_msg module="grn.grn" key="GRN_GRN-1491" replace='true'}
                                        {elseif $condition.evaluationMethod eq 'notEquals'}
                                            {cb_msg module="grn.grn" key="GRN_GRN-1492" replace='true'}
                                        {elseif $condition.evaluationMethod eq 'startsWith'}
                                            {cb_msg module="grn.grn" key="GRN_GRN-1493" replace='true'}
                                        {/if}
                                    </td>
                                    <td>{cb_msg module="grn" key="colon" replace='true'}</td>
                                    <td>{$condition.matchData}</td>
                                {/strip}
                            </tr>
                        {/foreach}
                    </table>
                </td>
                <td class="{$eventSummery} ">{* action_summery *}
                    {include file="mail/personal/automation/action_summery.tpl" actions=$event.actions}
                </td>
                <td class="{$eventSummery} nowrap-grn">{* delete modify *}
                    {strip}
                        <span class="menu_item">
                            <a href="{grn_pageurl page='mail/personal/automation/register' accountId=$accountId eventId=$eventId action=modify}">
                                {grn_image image="modify20.gif"}
                                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-267' replace='true'}
                            </a>
                        </span>
                        <span class="menu_item">
                            <a href="javascript:void(0);" onClick="automation.onDeleteClicked('{$eventId}','{$accountId}');return false;">
                                {grn_image image="delete20.gif"}
                                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-266' replace='true'}
                            </a>
                        </span>
                    {/strip}
                </td>
            </tr>
        {/foreach}
    </table>
{/if}

{include file="grn/personal_footer.tpl"}
{* delete message box *}
<div id="delete_automatic_event" style="display:none">
    <span class="event_delete_spinner" style="visibility: hidden">{grn_image image="spinner.gif"}</span><br/>
    {cb_msg module='grn.mail' key='GRN_MAIL-213' replace='true'}<br/><br/>
    <table>
        <tr>
            <td>
                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-31' replace='true'}
            </td>
            <td>
                {cb_msg module="grn" key="colon" replace='true'}
            </td>
            <td>
                <span class="bold">
                    {grn_image image='mailaccount20.gif'}
                    {$account.title}
                </span>
            </td>
        </tr>
        <tr>
            <td>
                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-262' replace='true'}

            </td>
            <td>
                {cb_msg module="grn" key="colon" replace='true'}
            </td>
            <td>
                {grn_image image='mail20_f.gif'}
                <span id="delete_automatic_event_title" class="bold"></span>
            </td>
        </tr>
    </table>
</div>
{include file="grn/error_handler.tpl"}
