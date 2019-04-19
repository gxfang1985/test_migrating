{include file="sysapi/header.tpl"}

<admin:AddChildrenOfOrgResponse>
<returns>
  <number_relationships_affected>
    {$affected_child_orgIds|@count}
  </number_relationships_affected>
  <affected_parent_orgId>
    {$affected_parent_orgId}
  </affected_parent_orgId>
  {foreach from=$affected_child_orgIds item=child_orgId}
  <affected_child_orgId>
    {$child_orgId}
  </affected_child_orgId>
  {/foreach}
</returns>
</admin:AddChildrenOfOrgResponse>

{include file="sysapi/footer.tpl"}