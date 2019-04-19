{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

{grn_load_javascript file="grn/html/page/space/system/common_set.js"}

{literal}
<script language='JavaScript' type='text/javascript'>
<!--
var __page = grn.page.space.system.common_set;
__page.url = {/literal}"{$url}"{literal};
__page.onForest = {/literal}"{$smarty.const.ON_FOREST}";{literal}
jQuery(document).ready(function(){
    __page.onClickRadio();
});
//-->
</script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_common_set'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tr valign="top">
            <th nowrap>
                {cb_msg module='grn.space.system' key='GRN_SPACE_SY-39' replace='true'}
            </th>
            <td>
                {capture name='grn_space_system_GRN_SPACE_SY_40'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-40' replace='true'}{/capture}
                {grn_radio id="privacy_default_public" name="privacy_default" value="1" caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_40 checked=$privacy_default}

                {assign var="private_checked" value="`$privacy_default-1`"}
                {capture name='grn_space_system_GRN_SPACE_SY_41'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-41' replace='true'}{/capture}
                {grn_radio id="privacy_default_private" name="privacy_default" value="0" caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_41 checked=$private_checked}
            </td>
        </tr>
        <tr valign="top" class="js_period_setting">
            <th nowrap>
                {cb_msg module='grn.space.system' key='GRN_SPACE_SY-42' replace='true'}
            </th>
            <td>
                {capture name='grn_space_system_GRN_SPACE_SY_43'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-43' replace='true'}{/capture}
                {grn_checkbox name='allow_unlimited' id='allow_unlimited' value=1 caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_43 checked=$allow_unlimited}
            </td>
        </tr>
        <tr valign="top" class="js_period_setting">
            <th nowrap>
                {cb_msg module='grn.space.system' key='GRN_SPACE_SY-44' replace='true'}
            </th>
            <td>
                {capture name='grn_space_system_GRN_SPACE_SY_45'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-45' replace='true'}{/capture}
                {grn_radio name="default_expiration_date" id="unlimited" value="1" caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_45 checked=$is_default_unlimited}
                </br>
                {grn_radio name="default_expiration_date" id="limited" value="0"  checked=$is_default_limited}
                {grn_text id="default_public_limited" name="default_public_limited" size="3" disabled=$is_disable_days_after value=$default_public_limited maxlength=5}
                <span>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-46' replace='true'}</span>
                {capture name='GRN_SPACE_SY_47'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-47' replace='true'}{/capture}
                <span style="color: #FF0000;">
                  {validate form=$form_name field="default_public_limited" criteria="isInt"  message=$smarty.capture.GRN_SPACE_SY_47}
                  {validate form=$form_name field="default_public_limited" criteria="isRange" low="0" high="10000" message=$smarty.capture.GRN_SPACE_SY_47}
              </span>
            </td>
        </tr>
        {if !$no_kintone_connector}
        <tr valign="top">
            <th nowrap>
                {cb_msg module='grn.space.system' key='kintone-1' replace='true'}
            </th>
            <td>
                {capture name='tmp'}{cb_msg module='grn.space.system' key='kintone-3' replace='true'}{/capture}
                {grn_radio id="use_kintone_use" name="use_kintone" value="1" caption=$smarty.capture.tmp onclick="__page.onClickRadio()" checked=$available}

                {assign var="checked" value="`$available-1`"}
                {capture name='tmp'}{cb_msg module='grn.space.system' key='kintone-4' replace='true'}{/capture}
                {grn_radio id="use_kintone_no_use" name="use_kintone" value="0" caption=$smarty.capture.tmp onclick="__page.onClickRadio()" checked=$checked}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>
                {cb_msg module='grn.space.system' key='kintone-2' replace='true'}
            </th>
            <td>
                {if $smarty.const.ON_FOREST === 1}
                    {grn_text name="url" id="url" size="80" disable_return_key=true maxlength="255" disabled=true}
                {else}
                    {grn_text name="url" id="url" value=$url size="80" disable_return_key=true maxlength="255"}
                {/if}
                <div class="sub_explanation">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-10' replace='true'}<b>https://xxx.cybozu.com/k/</b></div>
            </td>
        </tr>
        {/if}
        <tr>
            <td></td>
            <td>
                {capture name='tmp'}{cb_msg module='grn.space.system' key='save' replace='true'}{/capture}
                {grn_button_submit class="margin" caption=$smarty.capture.tmp}
                {grn_button_cancel page="system/application_list" app_id="space"}
            </td>
        </tr>
    </table>
</form>
{include file="grn/system_footer.tpl"}