{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/page/mail/mobile/_receive_button.js"}
{if ! $account_deleted}
    <form name="receive" id="receive_mail" method="post" action="{grn_pageurl page='mail/command_receive'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="aid" value="{$account_id}">
        <input type="hidden" name="cid" value="{$category_id}">
        <input type="hidden" name="cmd" id="cmd_receive_mail">
        <input type="hidden" name="terminal" value="mobile">
        <input type="hidden" name="page" value="{$page_info.last}">
    </form>
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_withcheckbox_grn">
        {if $account_deleted || $disable_mail || $cannot_send || $size_over}
            <li data-icon="false" class="mobile_mail_btn_position_grn">
                <div class="mobile_mail_btn_grn">
                    <a id="receive_button" href="javascript:void(0);" class="mobile_base_disable_grn">
                        {cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$account_id.new_mail_count > 0}<span class="mobile_mail_btn_number_grn">{$account_list.$account_id.new_mail_count}</span>{/if}
                    </a>
                </div>
            </li>
        {else}
            <li data-icon="false" class="mobile_mail_btn_position_grn">
                <div class="mobile_mail_btn_grn">
                    <a id="receive_button" href="javascript:void(0);" onclick="grn.page.mail.mobile._receive_button.receive('new_mail');return false;">
                        {cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{if $account_list.$account_id.new_mail_count > 0}<span class="mobile_mail_btn_number_grn">{$account_list.$account_id.new_mail_count}</span>{/if}
                    </a>
                </div>
            </li>
        {/if}
    </ul>
{/if}
