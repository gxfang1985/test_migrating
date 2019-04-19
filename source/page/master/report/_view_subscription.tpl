{if $report.is_snapshot=='1'}
    {assign var="disabled" value=true}
{else}
    {assign var="disabled" value=false}
{/if}
{include file="grn/component/view_subscription.tpl" has_subscribed=$subscribe disabled=$disabled}

{literal}
<script language="javascript" type="text/javascript">
    grn.component.view_subscription.init({
        "submitPage": "report/command_subscribe",
        "postData": "rid={/literal}{$rid|escape}{literal}"
    });
</script>
{/literal}
