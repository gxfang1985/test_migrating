{grn_load_javascript file="grn/html/component/view_subscription.js"}
<span class="button_base_grn {if $need_margin_right}mRight20{/if}">
    <form name="subscription_form" style="display: inline;">
        <input id="subscription" type="hidden" value="{if $has_subscribed == '1'}0{else}1{/if}">
        <span id="subscription_button" class="aButtonStandard-grn{if $disabled} button_disable_filter_grn{/if}">
            <a {if !$disabled}onclick="grn.component.view_subscription.changeSubscriptionStatus();"{/if} href="javascript:void(0);" role="button">
                <span id="subscription_button_text">{if $has_subscribed == '1'}{cb_msg module='grn.common' key='subscription_stop' replace='true'}{else}{cb_msg module='grn.common' key='subscription_start' replace='true'}{/if}</span>
            </a>
        </span>
        <span id="wait_image" class="spinner_s_button_post_grn" style="display: none;"></span>
    </form>
</span>
