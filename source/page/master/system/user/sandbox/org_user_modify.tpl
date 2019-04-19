{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{include file="system/user/sandbox/_sandbox_title_label.tpl"}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/sandbox/command_org_user_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="poid" value="{$org_id|escape}">
    <input type="hidden" name="uid" value="{$user_id|escape}">

    <!--menubar-->
    <div class="button_base_top_grn">
        {capture name='grn_system_user_GRN_SY_US_676'}{cb_msg module='grn.system.user' key='GRN_SY_US-676' replace='true'}{/capture}{grn_button_submit class="mRight15" button_type="submit" caption=$smarty.capture.grn_system_user_GRN_SY_US_676}
        {grn_button_cancel page='system/user/sandbox/org_user_view' oid=$org_id uid=$user_id}
    </div>
    <!--menubar_end-->

    {include file="system/user/_user_organization_belong.tpl" dir_name="system/user/sandbox"}
    <div class="explanation"><span class="bold">{grn_user_name uid=$user_id nolink=TRUE is_sandbox_page=TRUE}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-653' replace='true'}</div>
    {include file="grn/show_validation_errors.tpl"}

    <table class="std_form">
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-692' replace='true'}</th>
            {if $bases_param|@count == 1}{assign var='bases_disabled' value=true}{/if}
            <td>{grn_select name="base" options=$bases_param disabled=$bases_disabled}</td>
        </tr>

        <tr valign="top">
            <th nowrap>{capture name='grn_system_user_GRN_SY_US_658'}{cb_msg module='grn.system.user' key='GRN_SY_US-658' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_658}</th>
            <td>
                <table>
                    <tr>
                        <td><div id="select_belong_org">
                                {if $user.group_options}
                                    {foreach from=$user.groups key=item_id item=item}
                                        <div>{$item.path|escape}</div>
                                        <input type="hidden" name="oid[]" value="{$item_id|escape}">
                                    {/foreach}
                                {else}
                                    {cb_msg module='grn.system.user' key='GRN_SY_US-659' replace='true'}
                                {/if}
                            </div></td>
                        <td>
                            <input type="button" value="{cb_msg module='grn.system.user' key='GRN_SY_US-660' replace='true'}" onclick="popupSelectOrg( this.form );">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
        <th nowrap>{capture name='grn_system_user_GRN_SY_US_661'}{cb_msg module='grn.system.user' key='GRN_SY_US-661' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_661}</th>
        <td><div id="select_primary_organization">
                <select name="primary_org">
                    {if $user.group_options}
                        {foreach from=$user.group_options key=item_id item=item}
                            {if $item.selected}
                                <option value="{$item.value|escape}" selected>{$item.label|escape}</option>
                            {else}
                                <option value="{$item.value|escape}">{$item.label|escape}</option>
                            {/if}
                        {/foreach}
                    {else}
                        <option value="">{cb_msg module='grn.system.user' key='GRN_SY_US-662' replace='true'}</option>
                    {/if}
                </select>
            </div>
        </td>
        </tr>

        <tr>
            <th nowrap>{capture name='grn_system_user_GRN_SY_US_663'}{cb_msg module='grn.system.user' key='GRN_SY_US-663' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_663}</th>
            <td>
                {if ! $is_super}
                    {capture name='grn_system_user_GRN_SY_US_664'}{cb_msg module='grn.system.user' key='GRN_SY_US-664' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isInt" message=$smarty.capture.grn_system_user_GRN_SY_US_664 append="validation_errors"}
                    {capture name='grn_system_user_GRN_SY_US_666'}{cb_msg module='grn.system.user' key='GRN_SY_US-666' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isRange" low="0" high=GRN_UUM_USER_MAX_POSITION-1 message=$smarty.capture.grn_system_user_GRN_SY_US_666 append="validation_errors"}
                {/if}
                {if $user.position < GRN_UUM_USER_MAX_POSITION}
                    {capture name='grn_system_user_GRN_SY_US_667'}{cb_msg module='grn.system.user' key='GRN_SY_US-667' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_667 disable_return_key=true value=$user.position disabled=$is_super}<br>
                {else}
                    {capture name='grn_system_user_GRN_SY_US_668'}{cb_msg module='grn.system.user' key='GRN_SY_US-668' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_668 disable_return_key=true}<br>
                {/if}
                <div class="br">&nbsp;</div>
                <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-669' replace='true'} {cb_msg module='grn.system.user' key='GRN_SY_US-670' replace='true'}..{cb_msg module='grn.system.user' key='GRN_SY_US-671' replace='true'}<br>
                    {cb_msg module='grn.system.user' key='GRN_SY_US-672' replace='true'}</div>
            </td>
        </tr>

        {if ! $user.valid}{assign var='invalid' value=1}{/if}
        <tr>
            <th nowrap>{capture name='grn_system_user_GRN_SY_US_673'}{cb_msg module='grn.system.user' key='GRN_SY_US-673' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_673}</th>
            <td>
                {capture name='grn_system_user_GRN_SY_US_674'}{cb_msg module='grn.system.user' key='GRN_SY_US-674' replace='true'}{/capture}{grn_checkbox name='invalid' id='invalid_id' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_674 checked=$invalid disabled=$is_super}<br>
                <div class="br">&nbsp;</div>
                <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-675' replace='true'}</div>
            </td>
        </tr>

    </table>
</form>

<div class="mBottom20">
{strip}
    <div class="mLeft7 mTop7 mBottom10">
    <span class="action_text_grn">
        <a href="javascript:void(0)" id="sandbox_toggle_detail">
            <span class="icon_inline_grn icon_show_element_b_grn"></span>
            <span>{cb_msg module="grn.system.user.sandbox" key="GRN_SY_SANDBOX-ORG-USER-MODIFY-1" replace="true"}</span>
        </a>
    </span>
    </div>
{/strip}

    <p>
<table class="view_table" style="display: none;">
    <!--builtin_items-->
    {*
     {if $item.use && (
        $item_id == 'display_name' ||
        $item_id == 'foreign_key' ||
        $item_id == 'locale' ||
        $item_id == 'base' ||
        $item_id == 'usergroups' ||
        $item_id == 'primary_group'
        )}
     *}
    {foreach from=$builtin_items key=item_id item=item}
        {if $item.use && (
        $item_id == 'display_name' ||
        $item_id == 'foreign_key' ||
        $item_id == 'locale'
        )}
            <tr valign="top">
                <th nowrap>
                    {$item.display_name|escape}
                </th>
                <td>
                    {capture name='body'}{/capture}
                    {include file='grn/_action_item_view_contents.tpl'}
                    {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
                </td>
            </tr>
        {/if}
    {/foreach}
    <!--builtin_items_end-->
    <!--builtin_items-->
    {foreach from=$builtin_items key=item_id item=item}
        {if $item.use && (
        $item_id != 'display_name' &&
        $item_id != 'foreign_key' &&
        $item_id != 'usergroups' &&
        $item_id != 'primary_group' &&
        $item_id != 'attendee' &&
        $item_id != 'locale' &&
        $item_id != 'base' &&
        $item_id != 'display_name_language' &&
        $item_id != 'nickname'
        )}
            <tr valign="top">
                <th nowrap>
                    {$item.display_name|escape}
                </th>
                <td>
                    {capture name='body'}{/capture}
                    {include file='grn/_action_item_view_contents.tpl'}
                    {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
                </td>
            </tr>
        {/if}
    {/foreach}
    <!--builtin_items_end-->
    <!--extended_items-->
    {foreach from=$extended_items key=item_id item=item}
        {if $item.use}
            <tr valign="top">
                <th nowrap>
                    {$item.display_name|escape}
                </th>
                <td>
                    {capture name='body'}{/capture}
                    {include file='grn/_action_item_view_contents.tpl'}
                    {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
                </td>
            </tr>
        {/if}
    {/foreach}
    <!--extended_items_end-->
</table>
</div>

{grn_load_javascript file="grn/html/page/system/user/sandbox/org_user_modify.js"}
{include file='grn/system_footer.tpl'}
