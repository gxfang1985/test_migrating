{if $message.is_snapshot=='1'}
    {assign var="disabled" value=true}
{else}
    {assign var="disabled" value=false}
{/if}
{include file="grn/component/view_subscription.tpl" has_subscribed=$message.subscribe disabled=$disabled need_margin_right=true}

{literal}
<script language="javascript" type="text/javascript">
    grn.component.view_subscription.init({
        "submitPage": "message/command_subscribe",
        "postData": "cid={/literal}{$message.cid|escape}{literal}&rid={/literal}{$rid|escape}{literal}&mid={/literal}{$message.mid|escape}{literal}"
    });
</script>
{/literal}
