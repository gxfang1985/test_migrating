{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/mobile_footer_for_multipage.js"}

<script type="text/javascript" language="javascript">
grn.component.mobile_footer_for_multipage.productTerm = "{$product_term|escape}";
grn.component.mobile_footer_for_multipage.copyright = "{$copyright|escape}";
</script>
<!-- footer -->
<div data-role="footer" class="mobile-footspace-footer-grn" data-theme="{$data_theme}">
    <h6 class="footer_copyright_for_multipage" style="display: inline-table">{$product_term}&nbsp;&nbsp;&nbsp;{$copyright}</h6>
    {if !$is_cybozu_browser}
        <div class="mobile_pc_view_btn_grn">
            <a href="{grn_pageurl page='index'}">{cb_msg module='grn.mobile' key='pcview' replace='true'}</a>
        </div>
        {if $need_margin}
            <div class="mobile_footer_margin_grn"></div>
        {/if}
    {/if}
</div>
<!-- end of footer -->
