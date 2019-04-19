{include file="cbpapi/header.tpl"}
    <mail:{$action}Response>
        <returns>
          {foreach from=$signatures item=sign}
            <signature {grn_attr name="account_id" value=$sign.account_id require=true}
                              {grn_attr name="name" value=$sign.name require=true}
                              {grn_attr name="content" value=$sign.data require=true} />
          {/foreach}
        </returns>
    </mail:{$action}Response>
{include file="cbpapi/footer.tpl"}