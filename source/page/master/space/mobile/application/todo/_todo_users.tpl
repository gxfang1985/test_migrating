{*********************************************************
  @ para:$space_member_collection SpaceMemberCollection
**********************************************************}
{foreach from=$space_member_collection item=eachUser name="member"}
  <nobr>{$eachUser->getDisplayName()|escape}{if !$smarty.foreach.member.last},{/if}</nobr>
{/foreach}