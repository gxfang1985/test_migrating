{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if ! $remove_footer}
    <!-- footer -->
    <div data-role="footer" class="mobile-footspace-footer-grn" data-theme="{$data_theme}">
        <h6 {if $main_page}id="footer_copyright"{/if} style="display: inline-table">{$product_term}&nbsp;&nbsp;&nbsp;{$copyright}</h6>
        {if !$is_cybozu_browser}
            <div class="mobile_pc_view_btn_grn">
                <a href="{grn_pageurl page='index'}">{cb_msg module='grn.mobile' key='pcview' replace='true'}</a>
            </div>
        {/if}
    </div>
    <!-- end of footer -->
{/if}
{if $footer_bar|@count >= 1}
    {include file='grn/mobile_footer_bar.tpl'}
{/if}

</div>
