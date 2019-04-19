{grn_load_javascript file='grn/html/page/mail/_title_3pane.js'}
<table id="mail_navi_index" class="global_navi_title mail_navi_3paine_grn" cellmargin="0" style="padding: 0px; margin-bottom: 0px;" cellpadding="0">
  <tbody>
    <tr>

      <td class="navi_tite_grn nowrap-grn">
        <span>{grn_image image='mail20.gif'}</span><span class="navi_apptite_grn">{$app_name}</span>
        {if count($account_list) > 1}
          <span>{grn_image image='image-common/bg_accountMail.png' class='mRight5 mLeft5'}</span>
          <span class="select_account_grn">
            {if $account_list}
              <span>{cb_msg module='grn.mail' key='GRN_MAIL-419' replace='true'}</span>
              <span class="">
                <span class="mail-listButton-grn">
                  <a href="javascript:void(0);" id="account_select">{$account_list.$account_id.title|escape}<span class="mail-arrowDown-grn"></span></a>
                  <div class="mail-dropdownContents">
                    <ul>
                    {foreach from=$account_list item=account}
                      {if $account.aid != $account_id}
                        <li><a href="{grn_pageurl page='mail/index' aid=$account.aid}">{$account.title|escape}</a></li>
                      {/if}
                    {/foreach}
                    </ul>
                  </div>
                </span>
              </span>
            {/if}
          </span>
        {/if}
      </td>

      {if $no_setting eq '0'}
        <td class="mail-CapacityStatus-grn" nowrap="nowrap" valign="middle" width="">
          <a href="javascript:void(0);">
            <span class="mail-CapacityInfomation-grn" id="mail-CapacityInfomation-grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-417' replace='true'}" onclick="grn.page.mail._title_3pane.show_balloon(this);"></span>
            <div style="display: none;" id="mail-amountDetaiDaialog-grn" class="bubble has-top-prong mail-amountDetaiDaialog-grn">
              <div style="display: true;" id="bubblePromo:e"></div>
              <div class="">
                <table class="mail-amountDetail-grn" cellpadding="0" cellspacing="0">
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
                <div id="narrow_top_mail" class="top-prong">
                  <div class="prong-dk"></div>
                  <div class="prong-lt"></div>
                </div>
              </div>
            </div>
          </a>
          {if $percent_usage >= 0}
            <a href="javascript:void(0);">
              <span class="mail-CapacityBarBase-grn" id="mail-CapacityBarBase-grn" onclick="grn.page.mail._title_3pane.show_balloon(document.getElementById('mail-CapacityInfomation-grn'));">
                {if $width_percent < 38}
                  <div style="width:{$width_percent}px" class="mail-CapacityStatusBar-grn"></div>
                {elseif $width_percent < 48}
                  <div style="width:{$width_percent}px" class="mail-CapacityStatusBarAttention-grn"></div>
                {else}
                  <div style="width:48px" class="mail-CapacityStatusBarAttention-grn"></div>
                {/if}
              </span>
            </a>
          {/if}
          <span class="mail-usage-labelCapacity-grn">{cb_msg module='grn.mail' key='GRN_MAIL-417' replace='true'}</span>
        </td>
      {/if}

    </tr>
  </tbody>
</table>