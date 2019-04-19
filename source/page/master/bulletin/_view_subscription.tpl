{include file="grn/component/view_subscription.tpl" has_subscribed=$article.notify.subscribed need_margin_right=true}

{literal}
<script language="javascript" type="text/javascript">
    grn.component.view_subscription.init({
        "submitPage": "bulletin/command_subscribe_article2",
        "postData": "cid={/literal}{$article.cid|escape}{literal}&aid={/literal}{$article.aid|escape}{literal}"
    });
</script>
{/literal}
