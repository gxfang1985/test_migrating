<table id="mail_navi_index" class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;margin-bottom:0"><tbody><tr>
<td width="5%" valign="middle" nowrap>
{assign var =aid value=$category.aid}
{grn_image image="mail20.gif"}<span class="navi_apptite_grn">{$app_name}</span>{if count($user_account) > 1}{grn_image image='image-common/bg_accountMail.png' class='mRight5 mLeft5'}{/if}
</td>

{if count($user_account) > 1}
<td><div id="selected_account" style="float: left">
            <form name="receive" method="post" action="{grn_pageurl page='mail/command_account'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                {if $user_account}
                <span class="mail-labelCapacity-grn" style="float:left">{cb_msg module='grn.mail' key='GRN_MAIL-419' replace='true'}</span>{grn_select class='selectStandard-grn' name='user_account' options=$user_account onchange="this.form.submit()"}
                {/if}
                <input type="hidden" name="aid" value="{$category.aid}">
                <input type="hidden" name="sid" value="{$status_id}">
            </form>
        </div></td>
{/if}
{if $no_setting eq '0'}
<td nowrap="nowrap" valign="middle" width="" class="mail-CapacityStatus-grn">
<a href="javascript:"><span class="mail-CapacityInfomation-grn" id="mail-CapacityInfomation-grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-417' replace='true'}" onclick="show_balloon(this);"></span>
<div style="display:none;" id="mail-amountDetaiDaialog-grn" class="bubble has-top-prong mail-amountDetaiDaialog-grn"><div style="display: true;" id="bubblePromo:e"></div><div class=""><table cellspacing="0" cellpadding="0" class="mail-amountDetail-grn">
    {if $percent_usage >= 0}
  <tr>
    {if $width_percent < 38}
        <td colspan="3" class="mail-amountDetailPercent-grn">{$percent_usage}%</td>
    {else}
        <td colspan="3" class="mail-amountDetailPercent-full-grn">{$percent_usage}%</td>
    {/if}
  </tr>
    {/if}
    
    <tr>
    <td class="mail-amountDetailLabel-grn mail-amountDetailSeparate-grn bold">{cb_msg module='grn.mail' key='GRN_MAIL-413' replace='true'}</td>
    <td class="mail-amountDetailColon-grn mail-amountDetailSeparate-grn bold">:</td>

  {if $percent_usage >= 0}
    <td class="mail-amountDetailNumber-grn bold mail-amountDetailSeparate-grn">{$total_email_usage}/{$mailbox_size}</td>
  {else}
    <td class="mail-amountDetailNumber-grn bold mail-amountDetailSeparate-grn">{$total_email_usage}</td>
  {/if}
  </tr>
  
    {foreach from=$folder_list.data_balloon item=account_mail_info}
        <tr>
            <td class="mail-amountDetailLabel-grn">{$account_mail_info.title}</td>
            <td class="mail-amountDetailColon-grn">:</td>
            <td class="mail-amountDetailNumber-grn">{$account_mail_info.size}</td>
        </tr>
    {/foreach}
</table>
<div id="narrow_top_mail" class="top-prong"><div class="prong-dk"></div><div class="prong-lt"></div></div>
</div></div>
</a>
{if $percent_usage >= 0}
<a href="javascript:"><span class="mail-CapacityBarBase-grn" id="mail-CapacityBarBase-grn" onclick="show_balloon(document.getElementById('mail-CapacityInfomation-grn'));">
{if $width_percent < 38}
<div style="width:{$width_percent}px" class="mail-CapacityStatusBar-grn"></div>
{elseif $width_percent < 48}
<div style="width:{$width_percent}px" class="mail-CapacityStatusBarAttention-grn"></div>
{else}
<div style="width:48px" class="mail-CapacityStatusBarAttention-grn"></div>
{/if}
</span></a>
{/if}
<span class="mail-usage-labelCapacity-grn">{cb_msg module='grn.mail' key='GRN_MAIL-417' replace='true'}</span>
</td>{/if}</tr></tbody></table>
