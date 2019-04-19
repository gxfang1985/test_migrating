{include file="cbpapi/header.tpl"}

    <base:{$action}Response>
      <returns>

{foreach from=$groups item=group}
        <organization {grn_attr name="key" value=$group.key require=true} {grn_attr name="name" value=$group.name require=true}
          {grn_attr name="version" value=$group.version require=true}
          {grn_attr name="description" value=$group.description}
          {grn_attr name="order" value=$group.order}
          {grn_attr name="parent_organization" value=$group.parent} >

        {foreach from=$group.child_organization item=orgid}
            <organization {grn_attr name="key" value=$orgid require=true} xmlns="http://schemas.cybozu.co.jp/base/2008"/>
        {/foreach}

          <members xmlns="http://schemas.cybozu.co.jp/base/2008">
            {foreach from=$group.belong_user item=uid}
                <user id="{$uid}" />
            {/foreach}
          </members>

        </organization >
{/foreach}

      </returns>
    </base:{$action}Response>
{include file="cbpapi/footer.tpl"}