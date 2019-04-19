<script language="javascript" type="text/javascript">
<!--
{literal}
if( typeof grn.browser == "undefined" )
{
    grn.browser = {};
}
{/literal}
{if $browser.type == 'msie'}
    grn.browser.msie = true;
{elseif $browser.type == 'chrome'}
    grn.browser.chrome = true;
{elseif $browser.type == 'opera'}
    grn.browser.opera = true;
{elseif $browser.type == 'firefox'}
    grn.browser.firefox = true;
{elseif $browser.type == 'android'}
    grn.browser.android = true;
{elseif $browser.type == 'mobilesafari'}
    grn.browser.mobilesafari = true;
{elseif $browser.type == 'safari'}
    grn.browser.safari = true;
{/if}
grn.browser.version = {$browser.ver_major};

{literal}
grn.browser.isSupportHTML5 = false;
if( !!window.FormData )
{
    grn.browser.isSupportHTML5 = true;
}
{/literal}
//-->
</script>
