{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{* show validation errors *}
{foreach item=one_error from=$validation_errors}
<div class="attention"><span class="bold subnotify16">{$one_error|escape|nl2br}</span></div>
{/foreach}
{if count($errorOptions) > 0 }
<div class="attention"><span class="bold subnotify16">
{strip}
  {assign var='empty' value=true}
  
  {foreach from=$errorOptions key=item_id item=item}
    {if $item_id != 'bannedwords'}
      {if $empty}
        {cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_1' replace='true'}
      {else}
        {assign var='empty' value=false}{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_9_SEPERATOR' replace='true'}
      {/if}
      {if     $item_id == 'alpha'     }{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_2_ALPHA' replace='true'}
      {elseif $item_id == 'alphaupper'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_3_ALPHA_UPPER' replace='true'}
      {elseif $item_id == 'alphalower'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_4_ALPHA_LOWER' replace='true'}
      {elseif $item_id == 'numeral'   }{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_5_NUMERAL' replace='true'}
      {elseif $item_id == 'symbol'    }{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_6_SYMBOL' replace='true'}
      {/if}
      {assign var='empty' value=false}
    {else}
      {assign var='bannedwords' value=true}
    {/if}
  {/foreach}

  {if ! $empty}
    {cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_7' replace='true'}
  {/if}

  {if $bannedwords}
    {if ! $empty}<br>{/if}
    {cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_ERR_8_BANNED_WORDS' replace='true'}
  {/if}
{/strip}
</span></div>
{/if}
{*end: show validation errors *}

<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.personal.user' key='GRN_PRS_US-45' replace='true'}<br>
</div>

{if count($optionsArray) > 0}
<p>
<div class="explanation">{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_1' replace='true'}
{foreach from=$optionsArray key=item_id item=item}
{if $item_id== 'alpha'
    && !$optionsArray.alphamix}<br>{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_2_ALPHA' replace='true'}{/if}
{if $item_id== 'alphamix'     }<br>{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_3_ALPHAMIX' replace='true'}{/if}
{if $item_id== 'numeral'      }<br>{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_4_NUMERAL' replace='true'}{/if}
{if $item_id== 'symbol'       }<br>{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_5_SYMBOL' replace='true'}{/if}
{if $item_id== 'bannedwords'  }<br>{cb_msg module='grn.personal.user' key='GRN_PRS_US-PASSWD_EXPLAN_6_BANNED_WORDS' replace='true'}{/if}
{/foreach}
</div>
</p>
{/if}
<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-46' replace='true'}</th>
  <td>
      {capture name='grn_personal_user_GRN_PRS_US_49'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-49' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_personal_user_GRN_PRS_US_49 append="validation_errors"}
      {capture name='grn_personal_user_GRN_PRS_US_50'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-50' replace='true'}{/capture}{capture name='grn_personal_user_GRN_PRS_US_51'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-51' replace='true'}{/capture}{validate form=$form_name field="password" criteria="isLength" min=$password_length max=64 message=$smarty.capture.grn_personal_user_GRN_PRS_US_50|cat:$password_length|cat:$smarty.capture.grn_personal_user_GRN_PRS_US_51 append="validation_errors"}
      {capture name='grn_personal_user_GRN_PRS_US_52'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-52' replace='true'}{/capture}{grn_password name="password" purpose='init' size=50 maxlength=64 title=$smarty.capture.grn_personal_user_GRN_PRS_US_52 disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-53' replace='true'}</th>
  <td>{capture name='grn_personal_user_GRN_PRS_US_54'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-54' replace='true'}{/capture}{grn_password name="retype" purpose='init' size=50 maxlength=64 title=$smarty.capture.grn_personal_user_GRN_PRS_US_54 disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_personal_user_GRN_PRS_US_55'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-55' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_user_GRN_PRS_US_55 id='personal_change_password_submit'}
  {grn_button_cancel page='personal/common_list' id='user' id='personal_change_password_cancel'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
