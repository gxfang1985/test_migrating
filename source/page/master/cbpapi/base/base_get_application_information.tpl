{include file="cbpapi/header.tpl"}
    <base:{$action}Response>
      <returns>
      {foreach from=$app_list item=app}
        <application {grn_attr name="module_id" value=$app.module_id require=true}
                     {grn_attr name="name" value=$app.name require=true}
                     {grn_attr name="url" value=$app.url}
                     {grn_attr name="available_feature" value=$app.available_feature require=true}>
          {foreach from=$app.app_icon item=icon}
            <app_icon {grn_attr name="id" value=$icon.id require=true} {grn_attr name="url" value=$icon.url require=true} />
          {/foreach}
          {foreach from=$app.available_client item=client}
            <available_client {grn_attr name="name" value=$client.name require=true} />
          {/foreach}
        </application>
      {/foreach}
      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}
