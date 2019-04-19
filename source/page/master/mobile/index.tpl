{strip}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    <div class="mobile_balloon_grn">{cb_msg module='grn.mobile' key='GRN_MOBILE-11' replace='true'}</div>
    <div class="mobile_balloon_down_grn"><div class="mobile_triangle_grn"></div></div>
    <div class="mobile_balloon_icon_grn"><div class="mobile_information_b_grn"></div></div>   
</div>
{/strip}