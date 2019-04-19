{*
 * this template is toggle button.
 *
 * !!! CAUTION !!!
 * If you want to use this template, you have to load "grn/html/component/toggle_button/toggle_button.js" and
 * "grn/html/component/toggle_button/toggle_button.css".
 *
 * @param id                button id
 * @param button_on         current state of button
 * @param on_msg            Wording of "ON" button. Default is "ON".
 * @param off_msg           Wording of "OFF" button. Default is "OFF".
 *}
{strip}
<span class="button_state_small_grn mRight3 vAlignMiddle-grn" id="{$id}">
    {if $button_on}
    <div class="button_state_on_grn">
        <a href="javascript:void(0);">{if $on_msg}{$on_msg|escape}{else}ON{/if}</a>
    </div>
    {else}
    <div class="button_state_off_grn">
        <a href="javascript:void(0);">{if $off_msg}{$off_msg|escape}{else}OFF{/if}</a>
    </div>
    {/if}
</span>
{/strip}
