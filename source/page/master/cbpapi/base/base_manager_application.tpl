{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>
{foreach from=$app_list item=app}
        <application {grn_attr name="code" value=$app.code require=true} {grn_attr name="status" value=$app.status require=true}/>
{/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}