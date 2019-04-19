{strip}

{if ! $accesskey}
    {assign var=accesskey value=1}
{/if}

{grn_cellular_address_group_form method=get page=$page params=$tab.params gid=$group_id
accesskey=$accesskey my_address_groups=$address_mygroups}
{/strip}
