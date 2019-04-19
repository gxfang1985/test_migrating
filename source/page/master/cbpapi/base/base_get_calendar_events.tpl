{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$calendar_events item=event}
        <calendar_event {grn_attr name="date" value=$event.date require=true} {grn_attr name="content" value=$event.content require=true}
         {grn_attr name="type" value=$event.type require=true} />
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}