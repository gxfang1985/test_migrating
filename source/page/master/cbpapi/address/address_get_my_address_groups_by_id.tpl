{include file="cbpapi/header.tpl"}

    <address:{$action}Response>
      <returns>
        {foreach from=$mygroups item=mygroup}
            <my_address_group {grn_attr name="id" value=$mygroup.id require=true}
                                            {grn_attr name="name" value=$mygroup.name require=true}
                                            {grn_attr name="version" value=$mygroup.version require=true}
                                            {grn_attr name="description" value=$mygroup.description} >
                {foreach from=$mygroup.users item=user}
                <user {grn_attr name="key" value=$user.id require=true} xmlns="http://schemas.cybozu.co.jp/address/2008" />
                {/foreach}
                {foreach from=$mygroup.cards item=card}
                <card {grn_attr name="key" value=$card.id require=true}
                         {grn_attr name="type" value=$card.type require=true} xmlns="http://schemas.cybozu.co.jp/address/2008" />
                {/foreach}
            </my_address_group>
        {/foreach}
      </returns>
    </address:{$action}Response>
    
{include file="cbpapi/footer.tpl"}