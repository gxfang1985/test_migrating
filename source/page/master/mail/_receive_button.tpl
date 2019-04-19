{grn_load_javascript file="grn/html/page/mail/_receive_button.js"}
<script type="text/javascript">
<!--
var _receive_button = grn.page.mail._receive_button;
_receive_button.receive_page = "{grn_pageurl page='mail/command_receive'}";
_receive_button.check_after_receive_page = "{grn_pageurl page='mail/ajax/check_after_receive'}";
_receive_button.index_page = "{grn_pageurl page='mail/index'}";
//-->
</script>
{if ! $account_deleted}
  <form name="receive" id="receive_mail" method="post" action="{grn_pageurl page='mail/command_receive'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="aid" value="{$category.aid}">
    <input type="hidden" name="cid" value="{$category.cid}" id="cid_receive_mail">
    <input type="hidden" name="sid" value="{$status_id}">
    <input type="hidden" name="cmd" id="cmd_receive_mail">
    <input type="hidden" name="pane" id="pane">
    {if $pane_info.pane == 3}
      <input type="hidden" id="use_ajax" name="use_ajax" value="1">
    {/if}
  </form>
  {if $pane_info.pane == 3}
    <div id="tree_container" class="tree_container_grn nowrap-grn" style="overflow:hidden;">
      <div class="nowrap-grn">
        <div id="receive_button" class="mail-receiveButton1-grn">
          {assign var=aid value=$category.aid}
          {if !$cannot_all_receive && count($account_list) > 1}
            {if $account_deleted || $disable_mail || $cannot_send || $size_over}
              <div class="receive_button_disable_grn no_spinner">
                <span class="receiving_one"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></span><span class="receiving_all"><span class="mail-receiveButton1MouseOut-grn"></span></span>
              </div>
            </div>
            {else}
              <div id="receive_link">
                <span style="display:inline-block;"><a class="receiving_one" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt3pane('new_mail');"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></a></span><span style="display:inline-block;"><a class="receiving_all" href="javascript:void(0);" onclick="grn.page.mail._receive_button.showAllReceive();"><span id="button_receive_all_mail" class="mail-receiveButton1MouseOut-grn"></span></a></span>
              </div>
              <div class="receive_button_disable_grn" id="receive_disable" style="display: none;">
                <span class="receiving_one"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></span><span class="receiving_all"><span id="button_receive_all_mail" class="mail-receiveButton1MouseOut-grn"></span></span>
              </div>
            </div>
            <div id="receive_all_mail" class="receive_all_mail" style="display:none;">
              <a id="receive_all_link" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt3pane('new_all_mail');"><span class="pulldown_icon_grn"><span class="icon_receive_all_grn"></span></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-422' replace='true'}</span></a>
              <div id="receive_all_disable" style="display: none;"><span class="pulldown_icon_grn"><span class="icon_spinner_grn"></span></span><span class="vAlignMiddle-grn disable_style_grn">{cb_msg module='grn.mail' key='GRN_MAIL-422' replace='true'}</span></div>
            </div>
            {/if}
          {else}
            {if $account_deleted || $disable_mail || $cannot_send || $size_over}
              <div class="receive_button_disable_grn no_spinner">
                <span class="receiving_one only"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></span>
              </div>
            {else}
              <a id="receive_link" class="receiving_one only" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt3pane('new_mail');"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></a>
              <div class="receive_button_disable_grn" id="receive_disable" style="display: none;">
                <span class="receiving_one only"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$aid.new_mail_count > 0}({$account_list.$aid.new_mail_count}){/if}</span></font></span>
              </div>
            {/if}
          </div>
          {/if}
        <div class="clear_both_0px"></div>
      </div>
    </div>
  {else}
    <div id="receive_button" class="mail-receiveButton-grn">
      {assign var =aid value=$category.aid}
      {if !$cannot_all_receive && count($user_account) > 1}
        {if $cannot_send}
          <a class="receiving_one_disable" href="javascript:void(0);"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></a>
          <a class="receiving_all_disable" href="javascript:void(0);"><span id="button_receive_all_mail" class="mail-receiveButtonMouseOut-grn"></span></a>
        {else}
          <div id="receive_link">
            <a class="receiving_one" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt2pane('new_mail');return false;"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></a>
            <a class="receiving_all" href="javascript:void(0);" onclick="grn.page.mail._receive_button.showAllReceive();"><span id="button_receive_all_mail" class="mail-receiveButtonMouseOut-grn" onmouseover="this.className='mail-receiveButtonMouseOver-grn'" onmouseout="this.className='mail-receiveButtonMouseOut-grn'" onmousedown="this.className='mail-receiveButtonMouseDown-grn'" onmouseup="this.className='mail-receiveButtonMouseUp-grn'"></span></a>
            <div id="receive_all_mail" class="receive_all_mail" style="display:none;">
              <a id="receive_all_link" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt2pane('new_all_mail');return false;"><span class="pulldown_icon_grn"><span class="icon_receive_all_grn"></span></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-422' replace='true'}</span></a>
              <div id="receive_all_disable" style="display: none;"><span class="pulldown_icon_grn"><span class="icon_spinner_grn"></span></span><span class="vAlignMiddle-grn disable_style_grn">{cb_msg module='grn.mail' key='GRN_MAIL-422' replace='true'}</span></div>
            </div>
          </div>
          <div class="receive_button_disable_grn" id="receive_disable" style="display: none;">
            <span class="receiving_one"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></span><span class="receiving_all"><span class="mail-receiveButtonMouseOut-grn" id="button_receive_all_mail"></span></span>
          </div>
        {/if}
      {else}
        {if $cannot_send}
          <a class="receiving_one_disable only" href="javascript:void(0);"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></a>
        {else}
          <a id="receive_link" class="receiving_one only" href="javascript:void(0);" onclick="grn.page.mail._receive_button.receiveAt2pane('new_mail');return false;"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></a>
          <div class="receive_button_disable_grn" id="receive_disable" style="display: none;">
            <span class="receiving_one only"><font><span class="icon-receiveBSmall-grn">{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $user_account.$aid.new_mail > 0}({$user_account.$aid.new_mail}){/if}</span></font></span>
          </div>
        {/if}
      {/if}
    </div>
  {/if}
{/if}
