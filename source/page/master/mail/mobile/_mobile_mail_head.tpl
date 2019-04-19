{grn_load_css file="grn/html/mail.css"}
{grn_load_javascript file="grn/html/component/checkbox_mobile.js"}
{grn_load_javascript file="grn/html/ui.mail.address.js"}
{grn_load_javascript file="grn/html/jquery.fcbkcomplete.js"}
{grn_load_javascript file="grn/html/component/mail/AddressArea.js"}
{grn_load_javascript file="grn/html/page/mail/mobile/send.js"}
<script language="JavaScript" type="text/javascript">
var CK = grn.component.checkbox_mobile;
var G = grn.page.mail.mobile.send;
G.form_name = '{$form_name|escape}';
G.command_page = '{grn_pageurl page=mail/command_`$page_info.last`}';
G.auto_complete_url = {if $incremental_search}'{grn_pageurl page="grn/get_data_auto_complete"}'{else}''{/if};
G.error_message_1 = '{cb_msg module="grn.mail" key="GRN_MAIL-352" replace="true"}';
G.error_message_2 = '{cb_msg module="grn.mail" key="GRN_MAIL-353" replace="true"}';
G.error_message_3 = '{cb_msg module="grn.mail" key="GRN_MAIL-354" replace="true"}';
G.sign_list = {$user_sign|@json_encode}
{if $isNormal}
    G.holder_class = 'mobile_address_area_normal_grn';
{else}
    G.holder_class = 'mobile_address_area_wide_grn';
{/if}
{literal}
$(document).ready( function(){
    {/literal}
    {if $mail.give_open_check}
      CK.check('#give_open_checkbox', true);{else}CK.check('#give_open_checkbox', false);
    {/if}
    {literal}
});
</script>
{/literal}