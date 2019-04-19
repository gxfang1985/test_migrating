{include file="cbpapi/header.tpl"}
    <mail:{$action}Response>
        <returns>
          {foreach from=$filters item=filter}
            <filter {grn_attr name="name" value=$filter.name require=true}
                        {grn_attr name="folder" value=$filter.folder_name require=true}
                        {grn_attr name="operation" value=$filter.operation require=true}
                        {grn_attr name="status" value=$filter.status.name require=true}
            >
                {foreach from=$filter.conditions item=condition}
                  {if $condition.expr eq "GE" || $condition.expr eq "LE"}
                    <size {grn_attr name="target" value=$condition.target require=true} {grn_attr name="content" value=$condition.content require=true} {grn_attr name="method" value=$condition.method require=true}
                              xmlns="http://schemas.cybozu.co.jp/mail/2008" />
                  {else}
                    <expr {grn_attr name="target" value=$condition.target require=true} {grn_attr name="content" value=$condition.content require=true} {grn_attr name="method" value=$condition.method require=true}
                              xmlns="http://schemas.cybozu.co.jp/mail/2008" />
                  {/if}
                {/foreach}
            </filter>
          {/foreach}
        </returns>
    </mail:{$action}Response>
{include file="cbpapi/footer.tpl"}