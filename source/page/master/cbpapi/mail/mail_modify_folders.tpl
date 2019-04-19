{include file="cbpapi/header.tpl"}
    <mail:{$action}Response>
        <returns>
          {foreach from=$folders key=folder_id item=folder}
            <folder {grn_attr name="key" value=$folder_id require=true}
                                        {grn_attr name="name" value=$folder.name require=true}
                                        {grn_attr name="order" value=$folder.order}
                                        {grn_attr name="description" value=$folder.description}
                                        {grn_attr name="subscribe" value=$folder.subscribe}
                                        {grn_attr name="account_id" value=$folder.account_id} />
          {/foreach}
        </returns>
    </mail:{$action}Response>
{include file="cbpapi/footer.tpl"}